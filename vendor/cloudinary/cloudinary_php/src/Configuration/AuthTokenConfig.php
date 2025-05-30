<?php
/**
 * This file is part of the Cloudinary PHP package.
 *
 * (c) Cloudinary
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Cloudinary\Configuration;

/**
 * Defines the configuration for delivering token-based authenticated media assets.
 * **Learn more**: <a href=https://cloudinary.com/documentation/control_access_to_media#delivering_token_based_authenticated_media_assets target="_blank">Delivering token based authenticated media assets</a>
 *
 * @api
 */
class AuthTokenConfig extends BaseConfigSection
{
    public const CONFIG_NAME = 'auth_token';

    // Supported parameters
    public const KEY = 'key';
    public const IP  = 'ip';
    public const ACL = 'acl';
    public const START_TIME = 'start_time';
    public const EXPIRATION = 'expiration';
    public const DURATION   = 'duration';

    /**
     * (Required) – the token must be signed with the encryption key received from Cloudinary.
     *
     * @var ?string
     */
    public ?string $key = null;

    /**
     * (Optional) – only this IP address can access the resource.
     *
     * @var ?string
     */
    public ?string $ip = null;

    /**
     * (Optional) – an Access Control List for limiting the allowed URL path to a specified pattern (e.g.,
     * /video/authenticated/*).
     *
     * The pattern can include any of Cloudinary's transformations to also apply to the
     * delivered assets. Note that if you add an overlay (e.g., for a watermark), you should also include the
     * fl_layer_apply flag to ensure the layer cannot be modified. This parameter is useful for generating a token
     * that can be added to a number of different URLs that share a common transformation. Without this parameter,
     * the pattern defaults to the full URL path of the requested asset.
     *
     * @var string|array|null
     */
    public string|array|null $acl = null;

    /**
     * (Optional) – timestamp of the UNIX time when the URL becomes valid. Default value: the current time.
     *
     * @var ?int
     */
    public ?int $startTime = null;

    /**
     * (Optional) – timestamp of the UNIX time when the URL expires.
     *
     * @var ?int
     */
    public ?int $expiration = null;

    /**
     * (Optional) – the duration that the URL is valid in seconds (counted from start_time).
     *
     * @var ?int
     */
    public ?int $duration = null;
}
