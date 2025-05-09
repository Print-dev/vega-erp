<?php
/**
 * This file is part of the Cloudinary PHP package.
 *
 * (c) Cloudinary
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Cloudinary\Transformation;

use Cloudinary\ClassUtils;
use Cloudinary\Transformation\Argument\AngleTrait;
use Cloudinary\Transformation\Argument\Degree;
use Cloudinary\Transformation\Argument\RotationModeTrait;

/**
 * Rotates or flips an image or video by the specified number of degrees, or automatically (images only) according to
 * its orientation or available metadata.
 *
 * **Learn more**:
 * <a href=https://cloudinary.com/documentation/effects_and_artistic_enhancements#rotating_images
 * target="_blank">Rotating images</a> |
 * <a href=https://cloudinary.com/documentation/video_effects_and_enhancements#rotating_videos
 * target="_blank">Rotating videos</a>
 *
 *
 * @api
 */
class Rotate extends BaseAction implements RotationDegreeInterface, RotationModeInterface
{
    use AngleTrait;
    use RotationModeTrait;

    /**
     * Rotate constructor.
     *
     * @param mixed $degree The degrees of the angle.
     */
    public function __construct(...$degree)
    {
        parent::__construct(ClassUtils::verifyVarArgsInstance($degree, Angle::class));
    }
    /**
     * Sets the rotation angle.
     *
     * @param mixed $degree The degrees of the angle.
     */
    public function setAngle(...$degree): void
    {
        $this->addQualifier(Degree::byAngle(...$degree));
    }

    /**
     * Named constructor.
     *
     * @param mixed $degree The degree of the angle.
     *
     */
    public static function createWithDegree(...$degree): static
    {
        return new static(Angle::byAngle(...$degree));
    }

    /**
     * Named constructor.
     *
     * @param mixed $mode The rotation mode.
     *
     */
    public static function createWithMode(...$mode): static
    {
        return new static(Angle::mode(...$mode));
    }
}
