# auth

实现改进升级版 Auth 权限控制类：

    1.结点权限继承，操作（A）权限优先于控制器（C）权限优先于模块（M）权限
    2.结点权限根据角色规则 id 正负确定结点权限有无
    3.MCA之上非结点权限
    4.控制器（C）结点和操作（A）结点可以相连，如user/index

    安装
    composer require vangxh/auth:dev-main