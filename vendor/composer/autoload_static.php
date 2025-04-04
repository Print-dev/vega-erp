<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit40c6eca273d719e2eb8de80306448b02
{
    public static $prefixLengthsPsr4 = array (
        'R' => 
        array (
            'RobRichards\\XMLSecLibs\\' => 23,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'RobRichards\\XMLSecLibs\\' => 
        array (
            0 => __DIR__ . '/..' . '/robrichards/xmlseclibs/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit40c6eca273d719e2eb8de80306448b02::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit40c6eca273d719e2eb8de80306448b02::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit40c6eca273d719e2eb8de80306448b02::$classMap;

        }, null, ClassLoader::class);
    }
}
