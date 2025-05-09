<?php
/**
 * This file is part of the Cloudinary PHP package.
 *
 * (c) Cloudinary
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Cloudinary;

use ReflectionClass;
use ReflectionException;

/**
 * Class ClassUtils
 *
 * @internal
 */
class ClassUtils
{
    /**
     * Gets class name from the instance object.
     *
     * @param object $instance The instance object
     *
     */
    public static function getClassName(object $instance): string
    {
        return self::getBaseName($instance::class);
    }

    /**
     * Gets class base name from fully qualified class name.
     *
     * @param string $className The fully qualified class name.
     *
     * @return string class base name
     */
    public static function getBaseName(string $className): string
    {
        $pos = strrpos($className, '\\');
        if ($pos) {
            return substr($className, $pos + 1);
        }

        return $className;
    }

    /**
     * Gets class constants.
     *
     * @param object|class-string $instance   The instance object.
     * @param array               $exclusions The list of constants to exclude.
     *
     * @return array of class constants
     */
    public static function getConstants(object|string $instance, array $exclusions = []): array
    {
        $constants = [];

        try {
            $reflectionClass = new ReflectionClass($instance);
            $constants       = array_values($reflectionClass->getConstants());
        } catch (ReflectionException) {
            //TODO: log it?
        }

        return array_diff($constants, $exclusions);
    }

    /**
     * Verifies that provided object is an instance of the $baseClass.
     *
     * If not, the new instance of the $instanceClass is created (with fallback to the $baseClass, if not provided)
     * Additional $params can be passed to the constructor as well.
     *
     * Example: $t = ClassUtils::verifyInstance($notSureIfT, CommonTransformation::class, Transformation::class)
     *
     * If $notSureIfT is a string, then $t will be a new Transformation initialized with the value of $notSureIfT.
     * In case $notSureIfT is already an instance of CommonTransformation, it is returned as is.
     *
     * @param mixed       $object         The value to verify
     * @param string      $baseClass      Base class name
     * @param string|null $instanceClass  Instance class to create in case $object is not derivative of the $baseClass.
     *                                    $baseClass is used in case it is not provided.
     * @param array       $params         Additional parameters for the constructor
     *
     */
    public static function forceInstance(
        mixed $object,
        string $baseClass,
        ?string $instanceClass = null,
        ...$params
    ): mixed {
        if (! $object instanceof $baseClass) {
            $instanceClass = $instanceClass ?: $baseClass;
            $object        = new $instanceClass($object, ...$params);
        }

        return $object;
    }

    /**
     * Similar to ClassUtils::forceInstance, but does not propagate null values.
     *
     * @param object|mixed $object        The value to verify
     * @param string       $baseClass     Base class name
     * @param string|null  $instanceClass Instance class to create in case $object is not derivative of the $baseClass.
     *                                    $baseClass is used in case it is not provided.
     * @param array        $params        Additional parameters for the constructor
     *
     *
     * @see ClassUtils::forceInstance
     */
    public static function verifyInstance(
        mixed $object,
        string $baseClass,
        ?string $instanceClass = null,
        ...$params
    ): mixed {
        if ($object === null) { // no propagation of null objects
            return null;
        }

        return self::forceInstance($object, $baseClass, $instanceClass, ...$params);
    }

    /**
     * Variable arguments version of the ClassUtils::forceInstance.
     *
     * @param mixed       $varArgs       Arguments to verify
     * @param string      $baseClass     Base class name
     * @param string|null $instanceClass Instance class to create in case $object is not derivative of the $baseClass.
     *                                   $baseClass is used in case it is not provided.
     *
     *
     * @see ClassUtils::verifyInstance
     */
    public static function forceVarArgsInstance(mixed $varArgs, string $baseClass, ?string $instanceClass = null): mixed
    {
        $varArgs = ArrayUtils::build($varArgs);

        // When passing array instead of varargs, unwrap it and proceed
        if (count($varArgs) === 1 && is_array($varArgs[0])) {
            $varArgs = $varArgs[0];
        }

        if (count($varArgs) === 1) {
            return self::verifyInstance($varArgs[0], $baseClass, $instanceClass);
        }

        // At this point we create a new instance of a desired class and pass all args to it,
        // hopefully it'll know what to do with them :)

        $instanceClass = $instanceClass ?: $baseClass;

        return new $instanceClass(...$varArgs);
    }

    /**
     * Variable arguments version of the ClassUtils::verifyInstance.
     *
     * @param mixed       $varArgs       Arguments to verify
     * @param string      $baseClass     Base class name
     * @param string|null $instanceClass Instance class to create in case $object is not derivative of the $baseClass.
     *                                   $baseClass is used in case it is not provided.
     *
     *
     * @see ClassUtils::verifyInstance
     */
    public static function verifyVarArgsInstance(
        mixed $varArgs,
        string $baseClass,
        ?string $instanceClass = null
    ): mixed {
        // No args, nothing to verify
        if (empty($varArgs)) {
            return null;
        }

        return self::forceVarArgsInstance($varArgs, $baseClass, $instanceClass);
    }
}
