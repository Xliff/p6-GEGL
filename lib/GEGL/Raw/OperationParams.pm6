use v6.c;

use GLib::Raw::Enums;

use GEGL::Buffer;
use GEGL::Color;

use GEGL::Roles::Metadata;

our %operations is export;

INIT {
  %operations = (

    'convert-space' => { 
        space_name => 'string',
        pointer => 'format',
        path => 'string'
    },
    'cast-space' => { 
        space_name => 'string',
        pointer => 'format',
        path => 'string'
    },
    crop => { 
        x => 'double',
        y => 'double',
        width => 'double',
        height => 'double',
        reset_origin => 'boolean'
    },
    'convert-format' => { 
        format => 'format'
    },
    clone => { 
        ref => 'string'
    },
    cache => { 
        cache => False
    },
    load => { 
        path => 'string',
        uri => 'uri',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'cast-format' => { 
        input_format => 'format',
        output_format => 'format'
    },
    'variable-blur' => { 
        radius => 'double',
        linear_mask => 'boolean',
        levels => 'int',
        gamma => 'double',
        high_quality => 'boolean'
    },
    'focus-blur' => { 
        blur_type => 'enum',
        blur_radius => 'double',
        highlight_factor => 'double',
        highlight_threshold_low => 'double',
        highlight_threshold_high => 'double',
        shape => 'enum',
        x => 'double',
        y => 'double',
        radius => 'double',
        focus => 'double',
        midpoint => 'double',
        aspect_ratio => 'double',
        rotation => 'double',
        blur_levels => 'int',
        blur_gamma => 'double',
        high_quality => 'boolean',
        blur_type => [
          'string',
          <
            gaussian
            lens
          >
        ],
        shape => [
          'string',
          <
            circle
            square
            diamond
            horizontal
            vertical
          >
        ]
    },
    'png-save' => { 
        path => 'string',
        compression => 'int',
        bitdepth => 'int'
    },
    'raw-load' => { 
        path => 'string',
        image_num => 'int',
        color_space => 'enum',
        quality => 'int'
    },
    'sdl-display' => { 
        window_title => 'string',
        icon_title => 'string'
    },
    'webp-save' => { 
        path => 'string',
        quality => 'int'
    },
    'ppm-save' => { 
        rawformat => 'boolean'
    },
    'save-pixbuf' => { 
        pixbuf => False
    },
    'tiff-load' => { 
        path => 'string',
        uri => 'uri'
    },
    'sdl2-display' => { 
        window_title => 'string'
    },
    'ff-save' => { 
        path => 'string',
        audio => 'audio_fragment',
        audio_codec => 'string',
        audio_sample_rate => 'int',
        audio_bit_rate => 'int',
        frame_rate => 'double',
        video_codec => 'string',
        video_bit_rate => 'int',
        video_bufsize => 'int',
        container_format => 'string',
        global_quality => 'int',
        noise_reduction => 'int',
        scenechange_threshold => 'int',
        video_bit_rate_min => 'int',
        video_bit_rate_max => 'int',
        video_bit_rate_tolerance => 'int',
        keyint_min => 'int',
        trellis => 'int',
        qmin => 'int',
        qmax => 'int',
        max_qdiff => 'int',
        me_range => 'int',
        max_b_frames => 'int',
        gop_size => 'int',
        qcompress => 'double',
        qblur => 'double',
        i_quant_factor => 'double',
        i_quant_offset => 'double',
        me_subpel_quality => 'int'
    },
    'rgbe-load' => { 
        path => 'string'
    },
    'lcms-from-profile' => { 
        src_profile => 'pointer',
        intent => 'enum',
        black_point_compensation => 'boolean',
        intent => [
          'string',
          <
            perceptual
            relative-colorimetric
            saturation
            absolute-colorimetric
          >
        ]
    },
    'svg-load' => { 
        path => 'string',
        uri => 'uri',
        width => 'int',
        height => 'int'
    },
    'rgbe-save' => { 
        path => 'string'
    },
    'vector-stroke' => { 
        width => 'double',
        opacity => 'double',
        transform => 'string'
    },
    'jpg-save' => { 
        path => 'string',
        quality => 'int',
        smoothing => 'int',
        optimize => 'boolean',
        progressive => 'boolean',
        grayscale => 'boolean'
    },
    'matting-levin' => { 
        threshold => 'double',
        lambda => 'double'
    },
    'jpg-load' => { 
        path => 'string',
        uri => 'uri'
    },
    text => { 
        string => 'string',
        font => 'string',
        size => 'double',
        width => 'int'
    },
    pixbuf => { 
        pixbuf => False
    },
    path => { 
        stroke_width => 'double',
        stroke_opacity => 'double',
        stroke_hardness => 'double',
        fill_rule => 'string',
        transform => 'string',
        fill_opacity => 'double',
        d => 'path'
    },
    'ppm-load' => { 
        path => 'string',
        uri => 'string'
    },
    'pdf-load' => { 
        path => 'string',
        uri => 'uri',
        ppi => 'double',
        password => 'string'
    },
    v4l => { 
        path => 'string'
    },
    'gif-load' => { 
        path => 'string',
        frame => 'int',
        frames => 'int',
        frame_delay => 'int'
    },
    'webp-load' => { 
        path => 'string',
        uri => 'uri'
    },
    'jp2-load' => { 
        path => 'string',
        uri => 'uri'
    },
    'ff-load' => { 
        path => 'string',
        frame => 'int',
        frames => 'int',
        audio_sample_rate => 'int',
        audio_channels => 'int',
        frame_rate => 'double',
        video_codec => 'string',
        audio_codec => 'string',
        audio => 'audio_fragment'
    },
    'png-load' => { 
        path => 'string',
        uri => 'uri',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'npy-save' => { 
        path => 'string'
    },
    'tiff-save' => { 
        path => 'string',
        bitdepth => 'int',
        fp => 'int'
    },
    npd => { 
        model => 'pointer',
        rigidity => 'int',
        asap_deformation => 'boolean',
        mls_weights => 'boolean',
        preserve_model => 'boolean',
        sampler_type => 'enum'
    },
    difference => { 
        srgb => 'boolean'
    },
    'src-out' => { 
        srgb => 'boolean'
    },
    'dst-atop' => { 
        srgb => 'boolean'
    },
    subtract => { 
        value => 'double'
    },
    'color-burn' => { 
        srgb => 'boolean'
    },
    'src-in' => { 
        srgb => 'boolean'
    },
    'dst-over' => { 
        srgb => 'boolean'
    },
    multiply => { 
        value => 'double'
    },
    plus => { 
        srgb => 'boolean'
    },
    overlay => { 
        srgb => 'boolean'
    },
    'color-dodge' => { 
        srgb => 'boolean'
    },
    xor => { 
        srgb => 'boolean'
    },
    lighten => { 
        srgb => 'boolean'
    },
    add => { 
        value => 'double'
    },
    'dst-in' => { 
        srgb => 'boolean'
    },
    darken => { 
        srgb => 'boolean'
    },
    screen => { 
        srgb => 'boolean'
    },
    'soft-light' => { 
        srgb => 'boolean'
    },
    dst => { 
        srgb => 'boolean'
    },
    'src-atop' => { 
        srgb => 'boolean'
    },
    gamma => { 
        value => 'double'
    },
    exclusion => { 
        srgb => 'boolean'
    },
    src => { 
        srgb => 'boolean'
    },
    clear => { 
        srgb => 'boolean'
    },
    divide => { 
        value => 'double'
    },
    'hard-light' => { 
        srgb => 'boolean'
    },
    'dst-out' => { 
        srgb => 'boolean'
    },
    'tile-glass' => { 
        tile_width => 'int',
        tile_height => 'int'
    },
    cubism => { 
        tile_size => 'double',
        tile_saturation => 'double',
        seed => 'seed'
    },
    'fractal-trace' => { 
        fractal => 'enum',
        X1 => 'double',
        X2 => 'double',
        Y1 => 'double',
        Y2 => 'double',
        JX => 'double',
        JY => 'double',
        bailout => 'double',
        fractal => [
          'string',
          <
            mandelbrot
            julia
          >
        ]
    },
    mosaic => { 
        tile_type => 'enum',
        tile_size => 'double',
        tile_height => 'double',
        tile_neatness => 'double',
        color_variation => 'double',
        color_averaging => 'boolean',
        tile_surface => 'boolean',
        tile_allow_split => 'boolean',
        tile_spacing => 'double',
        joints_color => Pair.new('object', GEGL::Color.get_type),
        light_color => Pair.new('object', GEGL::Color.get_type),
        light_dir => 'double',
        antialiasing => 'boolean',
        seed => 'seed',
        tile_type => [
          'string',
          <
            squares
            hexagons
            octagons
            triangles
          >
        ]
    },
    ripple => { 
        amplitude => 'double',
        period => 'double',
        phi => 'double',
        angle => 'double',
        wave_type => 'enum',
        abyss_policy => 'enum',
        tileable => 'boolean',
        wave_type => [
          'string',
          <
            sine
            triangle
            sawtooth
          >
        ],
        abyss_policy => [
          'uint',
          (
            0,
            1,
            2,
            3,
            4,
            16,
            32,
            48
          )
        ]
    },
    waves => { 
        x => 'double',
        y => 'double',
        amplitude => 'double',
        period => 'double',
        phi => 'double',
        aspect => 'double',
        sampler_type => 'enum',
        clamp => 'boolean'
    },
    'tile-paper' => { 
        tile_width => 'int',
        tile_height => 'int',
        move_rate => 'double',
        wrap_around => 'boolean',
        fractional_type => 'enum',
        centering => 'boolean',
        background_type => 'enum',
        bg_color => Pair.new('object', GEGL::Color.get_type),
        seed => 'seed',
        fractional_type => [
          'string',
          <
            background
            ignore
            force
          >
        ],
        background_type => [
          'string',
          <
            transparent
            invert
            image
            color
          >
        ]
    },
    'shadows-highlights-correction' => { 
        shadows => 'double',
        highlights => 'double',
        whitepoint => 'double',
        compress => 'double',
        shadows_ccorrect => 'double',
        highlights_ccorrect => 'double'
    },
    spiral => { 
        type => 'enum',
        x => 'double',
        y => 'double',
        radius => 'double',
        base => 'double',
        balance => 'double',
        rotation => 'double',
        direction => 'enum',
        type => [
          'string',
          <
            linear
            logarithmic
          >
        ],
        direction => [
          'string',
          <
            cw
            ccw
          >
        ]
    },
    oilify => { 
        intensities => 'int',
        use_inten => 'boolean'
    },
    'linear-sinusoid' => { 
        x_period => 'double',
        y_period => 'double',
        x_amplitude => 'double',
        y_amplitude => 'double',
        x_phase => 'double',
        y_phase => 'double',
        angle => 'double',
        offset => 'double',
        exponent => 'double',
        x_offset => 'double',
        y_offset => 'double',
        rotation => 'double',
        supersampling => 'int'
    },
    'motion-blur-circular' => { 
        center_x => 'double',
        center_y => 'double',
        angle => 'double'
    },
    illusion => { 
        illusion_type => 'enum',
        illusion_type => [
          'string',
          <
            type1
            type2
          >
        ]
    },
    'whirl-pinch' => { 
        whirl => 'double',
        pinch => 'double',
        radius => 'double'
    },
    'bayer-matrix' => { 
        subdivisions => 'int',
        x_scale => 'int',
        y_scale => 'int',
        rotation => 'enum',
        reflect => 'boolean',
        amplitude => 'double',
        offset => 'double',
        exponent => 'double',
        x_offset => 'int',
        y_offset => 'int',
        rotation => [
          'string',
          <
            0
            90
            180
            270
          >
        ]
    },
    softglow => { 
        glow_radius => 'double',
        brightness => 'double',
        sharpness => 'double'
    },
    edge => { 
        algorithm => 'enum',
        amount => 'double',
        border_behavior => 'enum',
        algorithm => [
          'string',
          <
            sobel
            prewitt
            gradient
            roberts
            differential
            laplace
          >
        ],
        border_behavior => [
          'uint',
          (
            0,
            1,
            2,
            3,
            4,
            16,
            32,
            48
          )
        ]
    },
    emboss => { 
        type => 'enum',
        azimuth => 'double',
        elevation => 'double',
        depth => 'int',
        type => [
          'string',
          <
            emboss
            bumpmap
          >
        ]
    },
    'red-eye-removal' => { 
        threshold => 'double'
    },
    'shadows-highlights' => { 
        shadows => 'double',
        highlights => 'double',
        whitepoint => 'double',
        radius => 'double',
        compress => 'double',
        shadows_ccorrect => 'double',
        highlights_ccorrect => 'double'
    },
    'noise-solid' => { 
        x_size => 'double',
        y_size => 'double',
        tileable => 'boolean',
        turbulent => 'boolean',
        seed => 'seed',
        height => 'int'
    },
    maze => { 
        algorithm_type => 'enum',
        tileable => 'boolean',
        seed => 'seed',
        algorithm_type => [
          'string',
          <
            depth-first
            prim
          >
        ]
    },
    sinus => { 
        x_scale => 'double',
        y_scale => 'double',
        complexity => 'double',
        seed => 'seed',
        tiling => 'boolean',
        perturbation => 'boolean',
        blend_mode => 'enum',
        blend_power => 'double',
        blend_mode => [
          'string',
          <
            linear
            bilinear
            sinusoidal
          >
        ]
    },
    'motion-blur-zoom' => { 
        center_x => 'double',
        center_y => 'double',
        factor => 'double'
    },
    'value-propagate' => { 
        mode => 'enum',
        lower_threshold => 'double',
        upper_threshold => 'double',
        rate => 'double',
        top => 'boolean',
        left => 'boolean',
        right => 'boolean',
        bottom => 'boolean',
        value => 'boolean',
        alpha => 'boolean',
        mode => [
          'string',
          <
            white
            black
            middle
            color-peak
            color
            opaque
            transparent
          >
        ]
    },
    deinterlace => { 
        keep => 'enum',
        orientation => 'enum',
        keep => [
          'string',
          <
            even
            odd
          >
        ],
        orientation => [
          'uint',
          (
            0,
            1
          )
        ]
    },
    cartoon => { 
        mask_radius => 'double',
        pct_black => 'double'
    },
    shift => { 
        direction => 'enum',
        seed => 'seed'
    },
    'gaussian-blur-selective' => { 
        blur_radius => 'double',
        max_delta => 'double'
    },
    'lens-flare' => { 
        pos_x => 'double',
        pos_y => 'double'
    },
    plasma => { 
        turbulence => 'double',
        height => 'int',
        seed => 'seed'
    },
    'bump-map' => { 
        type => 'enum',
        compensate => 'boolean',
        invert => 'boolean',
        tiled => 'boolean'
    },
    'video-degradation' => { 
        pattern => 'enum',
        additive => 'boolean',
        rotated => 'boolean'
    },
    'texturize-canvas' => { 
        direction => 'enum',
        depth => 'int',
        direction => [
          'string',
          <
            top-right
            top-left
            bottom-left
            bottom-right
          >
        ]
    },
    engrave => { 
        row_height => 'int',
        limit => 'boolean'
    },
    supernova => { 
        center_x => 'double',
        center_y => 'double',
        radius => 'int',
        spokes_count => 'int',
        random_hue => 'int',
        color => Pair.new('object', GEGL::Color.get_type),
        seed => 'seed'
    },
    'channel-mixer' => { 
        preserve_luminosity => 'boolean',
        rr_gain => 'double',
        rg_gain => 'double',
        rb_gain => 'double',
        gr_gain => 'double',
        gg_gain => 'double',
        gb_gain => 'double',
        br_gain => 'double',
        bg_gain => 'double',
        bb_gain => 'double'
    },
    'diffraction-patterns' => { 
        red_frequency => 'double',
        green_frequency => 'double',
        blue_frequency => 'double',
        red_contours => 'double',
        green_contours => 'double',
        blue_contours => 'double',
        red_sedges => 'double',
        green_sedges => 'double',
        blue_sedges => 'double',
        brightness => 'double',
        scattering => 'double',
        polarization => 'double'
    },
    'fractal-explorer' => { 
        fractaltype => 'enum',
        iter => 'int',
        zoom => 'double',
        shiftx => 'double',
        shifty => 'double',
        cx => 'double',
        cy => 'double',
        redstretch => 'double',
        greenstretch => 'double',
        bluestretch => 'double',
        redmode => 'enum',
        greenmode => 'enum',
        bluemode => 'enum',
        redinvert => 'boolean',
        greeninvert => 'boolean',
        blueinvert => 'boolean',
        useloglog => 'boolean',
        fractaltype => [
          'string',
          <
            mandelbrot
            julia
            barnsley-1
            barnsley-2
            barnsley-3
            spider
            man-o-war
            lambda
            sierpinski
          >
        ],
        redmode => [
          'string',
          <
            sine
            cosine
            none
          >
        ],
        greenmode => [
          'string',
          <
            sine
            cosine
            none
          >
        ],
        bluemode => [
          'string',
          <
            sine
            cosine
            none
          >
        ]
    },
    'noise-slur' => { 
        pct_random => 'double',
        seed => 'seed'
    },
    'color-to-alpha' => { 
        color => Pair.new('object', GEGL::Color.get_type),
        transparency_threshold => 'double',
        opacity_threshold => 'double'
    },
    wind => { 
        style => 'enum',
        direction => 'enum',
        edge => 'enum',
        threshold => 'int',
        strength => 'int',
        seed => 'seed',
        style => [
          'string',
          <
            wind
            blast
          >
        ],
        direction => [
          'string',
          <
            left
            right
            top
            bottom
          >
        ],
        edge => [
          'string',
          <
            both
            leading
            trailing
          >
        ]
    },
    'apply-lens' => { 
        refraction_index => 'double',
        keep_surroundings => 'boolean',
        background_color => Pair.new('object', GEGL::Color.get_type)
    },
    'color-exchange' => { 
        from_color => Pair.new('object', GEGL::Color.get_type),
        to_color => Pair.new('object', GEGL::Color.get_type),
        red_threshold => 'double',
        green_threshold => 'double',
        blue_threshold => 'double'
    },
    displace => { 
        displace_mode => 'enum',
        sampler_type => 'enum',
        abyss_policy => 'enum',
        amount_x => 'double',
        amount_y => 'double',
        center => 'boolean',
        center_x => 'double',
        center_y => 'double',
        displace_mode => [
          'string',
          <
            cartesian
            polar
          >
        ],
        sampler_type => [
          'uint',
          (
            0,
            1,
            2,
            3,
            4
          )
        ],
        abyss_policy => [
          'uint',
          (
            0,
            1,
            2,
            3,
            4,
            16,
            32,
            48
          )
        ]
    },
    'lens-distortion' => { 
        main => 'double',
        edge => 'double',
        zoom => 'double',
        x_shift => 'double',
        y_shift => 'double',
        brighten => 'double'
    },
    'polar-coordinates' => { 
        depth => 'double',
        angle => 'double',
        bw => 'boolean',
        top => 'boolean',
        polar => 'boolean',
        middle => 'boolean'
    },
    photocopy => { 
        mask_radius => 'double',
        sharpness => 'double',
        black => 'double',
        white => 'double'
    },
    'rotate-on-center' => { 
        degrees => 'double',
        origin_x => 'double',
        origin_y => 'double'
    },
    'scale-size' => { 
        x => 'double',
        y => 'double'
    },
    translate => { 
        x => 'double',
        y => 'double'
    },
    'border-align' => { 
        x => 'double',
        y => 'double',
        horizontal_margin => 'double',
        vertical_margin => 'double',
        snap_integer => 'boolean'
    },
    shear => { 
        x => 'double',
        y => 'double'
    },
    rotate => { 
        degrees => 'double'
    },
    reflect => { 
        x => 'double',
        y => 'double'
    },
    transform => { 
        transform => 'string'
    },
    'scale-size-keepaspect' => { 
        x => 'double',
        y => 'double'
    },
    'scale-ratio' => { 
        x => 'double',
        y => 'double'
    },
    'noise-rgb' => { 
        correlated => 'boolean',
        independent => 'boolean',
        linear => 'boolean',
        gaussian => 'boolean',
        red => 'double',
        green => 'double',
        blue => 'double',
        alpha => 'double',
        seed => 'seed'
    },
    sepia => { 
        scale => 'double',
        srgb => 'boolean'
    },
    'high-pass' => { 
        std_dev => 'double',
        contrast => 'double'
    },
    reinhard05 => { 
        brightness => 'double',
        chromatic => 'double',
        light => 'double'
    },
    'rgb-clip' => { 
        clip_low => 'boolean',
        low_limit => 'double',
        clip_high => 'boolean',
        high_limit => 'double'
    },
    'difference-of-gaussians' => { 
        radius1 => 'double',
        radius2 => 'double'
    },
    mix => { 
        ratio => 'double'
    },
    'convolution-matrix' => { 
        a1 => 'double',
        a2 => 'double',
        a3 => 'double',
        a4 => 'double',
        a5 => 'double',
        b1 => 'double',
        b2 => 'double',
        b3 => 'double',
        b4 => 'double',
        b5 => 'double',
        c1 => 'double',
        c2 => 'double',
        c3 => 'double',
        c4 => 'double',
        c5 => 'double',
        d1 => 'double',
        d2 => 'double',
        d3 => 'double',
        d4 => 'double',
        d5 => 'double',
        e1 => 'double',
        e2 => 'double',
        e3 => 'double',
        e4 => 'double',
        e5 => 'double',
        divisor => 'double',
        offset => 'double',
        red => 'boolean',
        green => 'boolean',
        blue => 'boolean',
        alpha => 'boolean',
        normalize => 'boolean',
        alpha_weight => 'boolean',
        border => 'enum'
    },
    newsprint => { 
        color_model => 'enum',
        pattern2 => 'enum',
        period2 => 'double',
        angle2 => 'double',
        pattern3 => 'enum',
        period3 => 'double',
        angle3 => 'double',
        pattern4 => 'enum',
        period4 => 'double',
        angle4 => 'double',
        pattern => 'enum',
        period => 'double',
        angle => 'double',
        black_pullout => 'double',
        turbulence => 'double',
        blocksize => 'double',
        angleboost => 'double',
        color_model => [
          'string',
          <
            white-on-black
            black-on-white
            rgb
            cmyk
          >
        ],
        pattern2 => [
          'string',
          <
            line
            circle
            diamond
            pssquare
            cross
          >
        ],
        pattern3 => [
          'string',
          <
            line
            circle
            diamond
            pssquare
            cross
          >
        ],
        pattern4 => [
          'string',
          <
            line
            circle
            diamond
            pssquare
            cross
          >
        ],
        pattern => [
          'string',
          <
            line
            circle
            diamond
            pssquare
            cross
          >
        ]
    },
    'icc-load' => { 
        path => 'string'
    },
    'linear-gradient' => { 
        start_x => 'double',
        start_y => 'double',
        end_x => 'double',
        end_y => 'double',
        start_color => Pair.new('object', GEGL::Color.get_type)
    },
    'svg-huerotate' => { 
        values => 'string'
    },
    'component-extract' => { 
        component => 'enum',
        invert => 'boolean',
        linear => 'boolean',
        component => [
          'string',
          <
            rgb-r
            rgb-g
            rgb-b
            hue
            hsv-s
            hsv-v
            hsl-s
            hsl-l
            cmyk-c
            cmyk-m
            cmyk-y
            cmyk-k
            ycbcr-y
            ycbcr-cb
            ycbcr-cr
            lab-l
            lab-a
            lab-b
            lch-c
            lch-h
            alpha
          >
        ]
    },
    'color-warp' => { 
        from_0 => Pair.new('object', GEGL::Color.get_type),
        to_0 => Pair.new('object', GEGL::Color.get_type),
        weight_0 => 'double',
        from_1 => Pair.new('object', GEGL::Color.get_type),
        to_1 => Pair.new('object', GEGL::Color.get_type),
        weight_1 => 'double',
        from_2 => Pair.new('object', GEGL::Color.get_type),
        to_2 => Pair.new('object', GEGL::Color.get_type),
        weight_2 => 'double',
        from_3 => Pair.new('object', GEGL::Color.get_type),
        to_3 => Pair.new('object', GEGL::Color.get_type),
        weight_3 => 'double',
        from_4 => Pair.new('object', GEGL::Color.get_type),
        to_4 => Pair.new('object', GEGL::Color.get_type),
        weight_4 => 'double',
        from_5 => Pair.new('object', GEGL::Color.get_type),
        to_5 => Pair.new('object', GEGL::Color.get_type),
        weight_5 => 'double',
        from_6 => Pair.new('object', GEGL::Color.get_type),
        to_6 => Pair.new('object', GEGL::Color.get_type),
        weight_6 => 'double',
        from_7 => Pair.new('object', GEGL::Color.get_type),
        to_7 => Pair.new('object', GEGL::Color.get_type),
        weight_7 => 'double',
        weight => 'double',
        amount => 'double'
    },
    'noise-hsv' => { 
        hue_distance => 'double',
        saturation_distance => 'double',
        value_distance => 'double'
    },
    waterpixels => { 
        size => 'int',
        smoothness => 'double',
        regularization => 'int',
        fill => 'enum',
        fill => [
          'string',
          <
            average
            random
          >
        ]
    },
    'snn-mean' => { 
        radius => 'int',
        pairs => 'int'
    },
    vignette => { 
        shape => 'enum',
        color => Pair.new('object', GEGL::Color.get_type),
        radius => 'double',
        softness => 'double',
        gamma => 'double',
        proportion => 'double',
        squeeze => 'double',
        x => 'double',
        y => 'double',
        rotation => 'double',
        shape => [
          'string',
          <
            circle
            square
            diamond
            horizontal
            vertical
          >
        ]
    },
    'noise-spread' => { 
        seed => 'seed'
    },
    'color-overlay' => { 
        value => Pair.new('object', GEGL::Color.get_type),
        srgb => 'boolean'
    },
    'map-absolute' => { 
        sampler_type => 'enum',
        abyss_policy => 'enum'
    },
    mantiuk06 => { 
        contrast => 'double',
        saturation => 'double',
        detail => 'double'
    },
    'brightness-contrast' => { 
        contrast => 'double',
        brightness => 'double'
    },
    'icc-save' => { 
        path => 'string'
    },
    'mono-mixer' => { 
        preserve_luminosity => 'boolean',
        red => 'double',
        green => 'double',
        blue => 'double'
    },
    'copy-buffer' => { 
        buffer => Pair.new('object', GEGL::Buffer.get_type)
    },
    'exp-combine' => { 
        steps => 'int',
        sigma => 'double'
    },
    'normal-map' => { 
        scale => 'double',
        x_component => 'enum',
        y_component => 'enum',
        flip_x => 'boolean',
        flip_y => 'boolean',
        full_z => 'boolean',
        tileable => 'boolean',
        x_component => [
          'string',
          <
            red
            green
            blue
          >
        ],
        y_component => [
          'string',
          <
            red
            green
            blue
          >
        ]
    },
    grid => { 
        line_color => Pair.new('object', GEGL::Color.get_type)
    },
    pixelize => { 
        ratio_x => 'double',
        ratio_y => 'double'
    },
    'write-buffer' => { 
        buffer => Pair.new('object', GEGL::Buffer.get_type)
    },
    'matting-global' => { 
        iterations => 'int',
        seed => 'seed'
    },
    'bilateral-filter' => { 
        blur_radius => 'double',
        edge_preservation => 'double'
    },
    'color-rotate' => { 
        src_clockwise => 'boolean',
        src_from => 'double',
        src_to => 'double',
        dest_clockwise => 'boolean',
        dest_from => 'double',
        dest_to => 'double',
        threshold => 'double',
        hue => 'double',
        saturation => 'double'
    },
    'color-assimilation-grid' => { 
        grid_size => 'double',
        saturation => 'double',
        angle => 'double',
        line_thickness => 'double'
    },
    'noise-hurl' => { 
        pct_random => 'double',
        seed => 'seed'
    },
    exposure => { 
        black_level => 'double',
        exposure => 'double'
    },
    fattal02 => { 
        alpha => 'double',
        beta => 'double',
        saturation => 'double',
        noise => 'double'
    },
    save => { 
        path => 'string',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'map-relative' => { 
        scaling => 'double',
        sampler_type => 'enum',
        abyss_policy => 'enum'
    },
    spherize => { 
        mode => 'enum',
        angle_of_view => 'double',
        curvature => 'double',
        amount => 'double',
        sampler_type => 'enum',
        mode => [
          'string',
          <
            radial
            horizontal
            vertical
          >
        ],
        sampler_type => [
          'uint',
          (
            0,
            1,
            2,
            3,
            4
          )
        ]
    },
    'median-blur' => { 
        neighborhood => 'enum',
        abyss_policy => 'enum',
        high_precision => 'boolean',
        neighborhood => [
          'string',
          <
            square
            circle
            diamond
          >
        ]
    },
    'vector-fill' => { 
        opacity => 'double',
        fill_rule => 'string',
        transform => 'string',
        d => 'path'
    },
    'wavelet-blur' => { 
        radius => 'double'
    },
    'recursive-transform' => { 
        fade_color => Pair.new('object', GEGL::Color.get_type),
        paste_below => 'boolean'
    },
    dither => { 
        dither_method => 'enum',
        seed => 'seed'
    },
    'magick-load' => { 
        path => 'string'
    },
    'noise-pick' => { 
        pct_random => 'double',
        seed => 'seed'
    },
    'image-compare' => { 
        wrong_pixels => 'int',
        max_diff => 'double',
        avg_diff_wrong => 'double',
        avg_diff_total => 'double'
    },
    mirrors => { 
        m_angle => 'double',
        r_angle => 'double',
        c_x => 'double',
        c_y => 'double',
        o_x => 'double',
        o_y => 'double',
        trim_x => 'double',
        trim_y => 'double',
        input_scale => 'double',
        output_scale => 'double',
        clip => 'boolean',
        warp => 'boolean'
    },
    'image-gradient' => { 
        output_mode => 'enum',
        output_mode => [
          'string',
          <
            magnitude
            direction
            both
          >
        ]
    },
    'noise-cell' => { 
        palettize => 'boolean'
    },
    levels => { 
        in_low => 'double',
        in_high => 'double',
        out_low => 'double',
        out_high => 'double'
    },
    gegl => { 
        string => 'string',
        error => 'string'
    },
    'unsharp-mask' => { 
        std_dev => 'double',
        scale => 'double',
        threshold => 'double'
    },
    'gblur-1d' => { 
        std_dev => 'double',
        orientation => 'enum',
        filter => 'enum',
        abyss_policy => 'enum',
        clip_extent => 'boolean',
        orientation => [
          'uint',
          (
            0,
            1
          )
        ],
        filter => [
          'string',
          <
            auto
            fir
            iir
          >
        ]
    },
    'alien-map' => { 
        color_model => 'enum',
        cpn_1_frequency => 'double',
        cpn_1_keep => 'boolean',
        cpn_2_keep => 'boolean',
        cpn_3_keep => 'boolean',
        color_model => [
          'string',
          <
            rgb
            hsl
          >
        ]
    },
    opacity => { 
        value => 'double'
    },
    'domain-transform' => { 
        n_iterations => 'int',
        spatial_factor => 'double',
        edge_preservation => 'double'
    },
    'svg-saturate' => { 
        values => 'string'
    },
    'edge-sobel' => { 
        horizontal => 'boolean',
        vertical => 'boolean',
        keep_sign => 'boolean'
    },
    'svg-matrix' => { 
        values => 'string'
    },
    dropshadow => { 
        x => 'double',
        y => 'double',
        radius => 'double',
        grow_radius => 'double',
        opacity => 'double'
    },
    checkerboard => { 
        x => 'int',
        y => 'int',
        x_offset => 'int',
        y_offset => 'int',
        format => 'format'
    },
    'contrast-curve' => { 
        sampling_points => 'int',
        curve => 'curve'
    },
    saturation => { 
        scale => 'double',
        colorspace => 'enum',
        colorspace => [
          'string',
          <
            Native
            CIE-Lab
            CIE-Yuv
          >
        ]
    },
    'noise-perlin' => { 
        alpha => 'double',
        scale => 'double',
        zoff => 'double',
        n => 'int'
    },
    'open-buffer' => { 
        path => 'string'
    },
    over => { 
        srgb => 'boolean'
    },
    'gaussian-blur' => { 
        std_dev_x => 'double',
        std_dev_y => 'double',
        filter => 'enum',
        abyss_policy => 'enum',
        clip_extent => 'boolean',
        filter => [
          'string',
          <
            auto
            fir
            iir
          >
        ]
    },
    'box-blur' => { 
        radius => 'int'
    },
    bloom => { 
        threshold => 'double',
        softness => 'double',
        radius => 'double',
        strength => 'double',
        limit_exposure => 'boolean'
    },
    'wavelet-blur-1d' => { 
        radius => 'double',
        orientation => 'enum'
    },
    'stretch-contrast' => { 
        keep_colors => 'boolean',
        perceptual => 'boolean'
    },
    'gegl-buffer-save-op' => { 
        path => 'string'
    },
    stress => { 
        radius => 'int',
        samples => 'int',
        iterations => 'int',
        enhance_shadows => 'boolean',
        rgamma => 'double'
    },
    'noise-cie-lch' => { 
        lightness_distance => 'double',
        chroma_distance => 'double',
        hue_distance => 'double'
    },
    threshold => { 
        value => 'double'
    },
    pack => { 
        orientation => 'enum'
    },
    'panorama-projection' => { 
        pan => 'double',
        tilt => 'double',
        spin => 'double',
        zoom => 'double'
    },
    'edge-neon' => { 
        radius => 'double',
        amount => 'double'
    },
    'radial-gradient' => { 
        start_x => 'double',
        start_y => 'double',
        end_x => 'double',
        end_y => 'double'
    },
    'gegl-buffer-load-op' => { 
        path => 'string'
    },
    mblur => { 
        dampness => 'double'
    },
    'negative-darkroom' => { 
        curve => 'enum',
        exposure => 'double',
        expC => 'double',
        expM => 'double',
        expY => 'double',
        clip => 'boolean',
        boost => 'double',
        contrast => 'double',
        dodge => 'double',
        preflash => 'boolean',
        flashC => 'double',
        flashM => 'double',
        flashY => 'double',
        illum => 'boolean',
        illumX => 'double',
        illumZ => 'double'
    },
    c2g => { 
        radius => 'int',
        iterations => 'int',
        enhance_shadows => 'boolean',
        rgamma => 'double'
    },
    'little-planet' => { 
        pan => 'double',
        tilt => 'double',
        spin => 'double',
        zoom => 'double'
    },
    'color-temperature' => { 
        original_temperature => 'double',
        intended_temperature => 'double'
    },
    'buffer-sink' => { 
        buffer => 'pointer',
        format => 'pointer'
    },
    slic => { 
        cluster_size => 'int',
        compactness => 'int',
        iterations => 'int'
    },
    'motion-blur-linear' => { 
        length => 'double',
        angle => 'double'
    },
    'noise-simplex' => { 
        scale => 'double'
    },
    tile => { 
        offset_x => 'int',
        offset_y => 'int'
    },
    'hue-chroma' => { 
        hue => 'double',
        chroma => 'double',
        lightness => 'double'
    },
    'watershed-transform' => { 
        flag_component => 'int',
        flag => 'format'
    },
    color => { 
        value => Pair.new('object', GEGL::Color.get_type),
        format => 'format'
    },
    'buffer-source' => { 
        buffer => Pair.new('object', GEGL::Buffer.get_type)
    },
    rectangle => { 
        x => 'double',
        y => 'double',
        width => 'double',
        height => 'double'
    },
    'long-shadow' => { 
        style => 'enum',
        angle => 'double',
        length => 'double',
        midpoint => 'double',
        midpoint_rel => 'double',
        color => Pair.new('object', GEGL::Color.get_type),
        composition => 'enum',
        style => [
          'string',
          <
            finite
            infinite
            fading
            fading-fixed-length
            fading-fixed-rate
            
          >
        ],
        composition => [
          'string',
          <
            shadow-plus-image
            shadow-only
            shadow-minus-image
          >
        ]
    },
    'rawbayer-load' => { 
        path => 'string'
    },
    'selective-hue-saturation' => { 
        hue_sel_center => 'double',
        hue_sel_width => 'double',
        hue => 'double',
        saturation => 'double',
        lightness => 'double'
    },
    gcr => { 
        inklimit => 'double',
        amount => 'double'
    },
    'segment-kmeans' => { 
        n_clusters => 'int',
        max_iterations => 'int',
        seed => 'seed'
    },
    'demosaic-bimedian' => { 
        pattern => 'int'
    },
    'band-tune' => { 
        radius1 => 'double',
        scale1 => 'double',
        bw1 => 'double',
        radius2 => 'double',
        scale2 => 'double',
        bw2 => 'double',
        show_mask => 'boolean'
    },
    ditto => { 
        sampler_type => 'enum'
    },
    'connected-components' => { 
        separator => Pair.new('object', GEGL::Color.get_type),
        invert => 'boolean',
        base => 'double',
        step => 'double',
        normalize => 'boolean',
        linear => 'boolean'
    },
    'bilateral-filter-fast' => { 
        r_sigma => 'double',
        s_sigma => 'int'
    },
    boxblur => { 
        radius => 'int'
    },
    'boxblur-1d' => { 
        radius => 'int',
        orientation => 'enum'
    },
    'demosaic-simple' => { 
        pattern => 'int'
    },
    'alpha-inpaint' => { 
        seek_distance => 'int',
        seek_reduction => 'double',
        min_iter => 'int',
        min_neighbors => 'int',
        max_iter => 'int',
        iterations => 'int',
        histogram => 'double',
        ring_gap1 => 'double',
        ring_gap2 => 'double',
        ring_gap3 => 'double',
        ring_gap4 => 'double',
        scale_needles => 'int',
        rounds => 'int',
        chance_try => 'double',
        chance_retry => 'double',
        chance_neighbor => 'double',
        metric_dist_powk => 'double',
        metric_empty_hay_score => 'double',
        metric_empty_needle_score => 'double',
        metric_cohesion => 'double',
        ring_twist => 'double',
        direction_invariant => 'boolean',
        source_neighbors => 'int'
    },
    'integral-image' => { 
        squared => 'boolean'
    },
    'seamless-clone' => { 
        max_refine_scale => 'int',
        xoff => 'int',
        yoff => 'int',
        error_msg => 'string'
    },
    'seamless-clone-compose' => { 
        max_refine_scale => 'int',
        xoff => 'int',
        yoff => 'int',
        error_msg => 'string'
    },
    gluas => { 
        script => 'string',
        error => 'string',
        file => 'string',
        user_value => 'double'
    },
    'lens-correct' => { 
        maker => 'string',
        Camera => 'string',
        Lens => 'string',
        focal => 'double',
        center => 'boolean',
        cx => 'int',
        cy => 'int',
        rscale => 'double',
        correct => 'boolean',
        red_a => 'double',
        red_b => 'double',
        red_c => 'double',
        red_d => 'double',
        green_a => 'double',
        green_b => 'double',
        green_c => 'double',
        green_d => 'double',
        blue_a => 'double',
        blue_b => 'double',
        blue_c => 'double',
        blue_d => 'double',
        alpha_a => 'double',
        alpha_b => 'double',
        alpha_c => 'double',
        alpha_d => 'double'
    },
    'line-profile' => { 
        x0 => 'int',
        x1 => 'int',
        y0 => 'int',
        y1 => 'int',
        width => 'int',
        height => 'int',
        min => 'double',
        max => 'double'
    },
    v4l2 => { 
        path => 'string'
    },
    spyrograph => { 
        curve_type => 'enum',
        hole_percent => 'double',
        x => 'double',
        y => 'double',
        radius => 'double',
        rotation => 'double',
        stroke_width => 'double',
        stroke_opacity => 'double',
        stroke_hardness => 'double',
        curve_type => [
          'string',
          <
            spyrograph
            epitrochoid
          >
        ]
    }
  );
}
