<?php
/**
+-------------------------------------------------------------------
- Auth     权限控制类
+-------------------------------------------------------------------
- @author  携心楼主 <vangxh@gmail.com>
+-------------------------------------------------------------------
**/
namespace Vangxh;

use think\facade\Db;
use think\facade\Cache;

class Auth
{
	// 权限数据
	protected static $priv = [];

	// 权限检测
	public static function check($uid, $name, $type = 1)
	{
		$name = strtolower($name);
		if ($type === 0) {
			// 规则检测
			is_array($name) || $name = explode('/', $name);
			// 设置模块
			$module = $name[0];
		} else {
			$module = null;
		}
		// 获取全局权限
		$priv = self::getPriv($uid, $module);
		// 权限验证
		return $type === 1
			? self::chkRule($name, $priv[1])
			: self::chkNode($name, $priv[0]);
	}

	// 结点检测
	public static function chkNode($node, $priv = [])
	{
		// 模块结点权限
		foreach ($priv as $k => $v) {
			if ($v['pid'] == 0) {
				if ($node[0] == strtolower($v['name'])) {
					$m_priv = $v['tof'];
					$g_id = $v['id'];
					break;
				}
				unset($priv[$k]);
			}
		}
		if (!isset($m_priv)) {
			return false;
		}
		// 控制器结点权限
		foreach ($priv as $k => $v) {
			if ($v['pid'] == $g_id) {
				$v['name'] = strtolower($v['name']);
				if ($node[1] .'/'. $node[2] == $v['name']) {
					return $v['tof'] == 1;
				}
				if ($node[1] == $v['name']) {
					$c_priv = $v['tof'];
					$m_id = $v['id'];
					break;
				}
				unset($priv[$k]);
			}
		}
		if (!isset($c_priv)) {
			return $m_priv == 1;
		}
		// 若无操作结点 - 主要用于菜单显示
		if (!isset($node[2])) {
			return $c_priv == 1;
		}
		// 操作结点权限
		foreach ($priv as $v) {
			if ($v['pid'] == $m_id && $node[2] == strtolower($v['name'])) {
				$a_priv = $v['tof'];
				break;
			}
		}
		if (!isset($a_priv)) {
			return $c_priv == 1;
		}

		return $a_priv == 1;
	}

	// 规则权限验证
	public static function chkRule($name, $priv = [], $relation = 'OR')
	{
		$rule = [];
		// 有权限的name
		foreach ($priv as $val) {
			in_array($val, $name) && $rule[] = $val;
		}
		// 权限或
		if ($relation == 'OR' && !empty($rule)) {
			return true;
		}
		// 权限与
		$diff = array_diff($name, $rule);
		if ($relation == 'AND' && empty($diff)) {
			return true;
		}
		return false;
	}

	// 获得权限列表
	public static function getPriv($uid, $module = null)
	{
		$key = 'u'. $uid;
		if (isset(self::$priv[$key])) {
			return self::$priv[$key];
		}
		// 获取缓存
		$cache = Cache::get($key) ?: [];
		// 获取权限
		if (isset($cache['_auth'])) {
			return $cache['_auth'];
		}
		// 读取用户所属角色组
		$role = self::getRole($uid, $module);
		$id = [];
		$tp = [];
		foreach ($role as $g) {
			$g['rules'] = empty($g['rules']) ? [] : explode(',', $g['rules']);
			empty($g['rule']) || $g['rules'] = array_merge($g['rules'], explode(',', $g['rule']));
			// 多角色权限id
			array_push($tp, array_unique($g['rules']));
			$id = array_merge($id, array_map('abs', $g['rules']));
		}
		// 读取用户组所有权限规则
		$rules = Db::name('auth_priv')
					->whereIn('id', array_unique($id))
					->field('id,name,pid')
					->order('pid ASC')
					->select();
		// 权限数组初始化
		$priv = [[], []];
		// 权限数组赋值
		foreach ($rules as $r) {
			if ($r['pid'] >= 0) {
				$r['tof'] = 0;
				foreach ($tp as $vo) {
					if (in_array($r['id'], $vo) || (in_array($r['pid'], $vo) && !in_array(-$r['id'], $vo))) {
						$r['tof'] = 1;
						break;
					}
				}
				$priv[0][] = $r;
			} else {
				$priv[1][] = $r['name'];
			}
		}
		// 缓存权限数据
		self::$priv[$key] = $cache['_auth'] = $priv;
		Cache::set($key, $cache);
		// 返回权限数据
		return $priv;
	}

	// 获得用户组
	protected static function getRole($uid, $module = null)
	{
		if (!isset($module)) {
			return [];
		}
		// 游客
		if ($uid == 0) {
			$role = Db::name('auth_role')->where(['module'=>$module, 'type'=>1])->field('rules')->select()->toArray();
		} else {
			// 公共角色
			$comm = Db::name('auth_role')->where(['module'=>$module, 'type'=>2])->field('rules')->select()->toArray();
			// 用户角色
			$role = Db::name('auth_role_user')
						->alias('ARU')
						->join('auth_role AR', 'ARU.gid = AR.id', 'LEFT')
						->where(['ARU.uid'=>$uid, 'AR.type'=>0, 'AR.status'=>0, 'AR.module'=>$module])
						->field('ARU.rule,AR.rules')
						->select()
						->toArray();
			$role = array_merge($comm, $role);
		}
		return $role;
	}
}