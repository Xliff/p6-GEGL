use v6.c;

use GLib::Raw::Enums;

use GEGL::Buffer;
use GEGL::Color;

use GEGL::Roles::Metadata;

our %operations is export;

INIT {
  %operations = (

    add => { 
        value => 'double'
    },
    'alien-map' => { 
        color_model => 'enum',
        cpn_1_frequency => 'double',
        cpn_2_frequency => 'double',
        cpn_3_frequency => 'double',
        cpn_1_phaseshift => 'double',
        cpn_2_phaseshift => 'double',
        cpn_3_phaseshift => 'double',
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
    'apply-lens' => { 
        refraction_index => 'double',
        keep_surroundings => 'boolean',
        background_color => Pair.new('object', GEGL::Color.get_type)
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
    'bilateral-filter-fast' => { 
        r_sigma => 'double',
        s_sigma => 'int'
    },
    'bilateral-filter' => { 
        blur_radius => 'double',
        edge_preservation => 'double'
    },
    bloom => { 
        threshold => 'double',
        softness => 'double',
        radius => 'double',
        strength => 'double',
        limit_exposure => 'boolean'
    },
    'border-align' => { 
        x => 'double',
        y => 'double',
        horizontal_margin => 'double',
        vertical_margin => 'double',
        snap_integer => 'boolean'
    },
    'box-blur' => { 
        radius => 'int'
    },
    'boxblur-1d' => { 
        radius => 'int',
        orientation => 'enum'
    },
    boxblur => { 
        radius => 'int'
    },
    'brightness-contrast' => { 
        contrast => 'double',
        brightness => 'double'
    },
    'buffer-sink' => { 
        buffer => 'pointer',
        format => 'pointer'
    },
    'buffer-source' => { 
        buffer => Pair.new('object', GEGL::Buffer.get_type)
    },
    'bump-map' => { 
        type => 'enum',
        compensate => 'boolean',
        invert => 'boolean',
        tiled => 'boolean',
        azimuth => 'double',
        elevation => 'double',
        depth => 'int',
        offset_x => 'int',
        offset_y => 'int',
        waterlevel => 'double',
        ambient => 'double'
    },
    c2g => { 
        radius => 'int',
        samples => 'int',
        iterations => 'int',
        enhance_shadows => 'boolean',
        rgamma => 'double'
    },
    cache => { 
        cache => False
    },
    cartoon => { 
        mask_radius => 'double',
        pct_black => 'double'
    },
    'cast-format' => { 
        input_format => 'format',
        output_format => 'format'
    },
    'cast-space' => { 
        space_name => 'string',
        pointer => 'format',
        path => 'string'
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
    checkerboard => { 
        x => 'int',
        y => 'int',
        x_offset => 'int',
        y_offset => 'int',
        color1 => Pair.new('object', GEGL::Color.get_type),
        color2 => Pair.new('object', GEGL::Color.get_type),
        format => 'format'
    },
    clear => { 
        srgb => 'boolean'
    },
    clone => { 
        ref => 'string'
    },
    'color-assimilation-grid' => { 
        grid_size => 'double',
        saturation => 'double',
        angle => 'double',
        line_thickness => 'double'
    },
    'color-burn' => { 
        srgb => 'boolean'
    },
    'color-dodge' => { 
        srgb => 'boolean'
    },
    'color-exchange' => { 
        from_color => Pair.new('object', GEGL::Color.get_type),
        to_color => Pair.new('object', GEGL::Color.get_type),
        red_threshold => 'double',
        green_threshold => 'double',
        blue_threshold => 'double'
    },
    'color-overlay' => { 
        value => Pair.new('object', GEGL::Color.get_type),
        srgb => 'boolean'
    },
    'color-rotate' => { 
        src_clockwise => 'boolean',
        src_from => 'double',
        src_to => 'double',
        dest_clockwise => 'boolean',
        dest_from => 'double',
        dest_to => 'double',
        threshold => 'double',
        gray_mode => 'enum',
        hue => 'double',
        saturation => 'double'
    },
    'color-temperature' => { 
        original_temperature => 'double',
        intended_temperature => 'double'
    },
    'color-to-alpha' => { 
        color => Pair.new('object', GEGL::Color.get_type),
        transparency_threshold => 'double',
        opacity_threshold => 'double'
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
    color => { 
        value => Pair.new('object', GEGL::Color.get_type),
        format => 'format'
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
    'connected-components' => { 
        separator => Pair.new('object', GEGL::Color.get_type),
        invert => 'boolean',
        base => 'double',
        step => 'double',
        normalize => 'boolean',
        linear => 'boolean'
    },
    'contrast-curve' => { 
        sampling_points => 'int',
        curve => 'curve'
    },
    'convert-format' => { 
        format => 'format'
    },
    'convert-space' => { 
        space_name => 'string',
        pointer => 'format',
        path => 'string'
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
    'copy-buffer' => { 
        buffer => Pair.new('object', GEGL::Buffer.get_type)
    },
    crop => { 
        x => 'double',
        y => 'double',
        width => 'double',
        height => 'double',
        reset_origin => 'boolean'
    },
    cubism => { 
        tile_size => 'double',
        tile_saturation => 'double',
        bg_color => Pair.new('object', GEGL::Color.get_type),
        seed => 'seed'
    },
    darken => { 
        srgb => 'boolean'
    },
    deinterlace => { 
        keep => 'enum',
        orientation => 'enum',
        size => 'int',
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
    'demosaic-bimedian' => { 
        pattern => 'int'
    },
    'demosaic-simple' => { 
        pattern => 'int'
    },
    'difference-of-gaussians' => { 
        radius1 => 'double',
        radius2 => 'double'
    },
    difference => { 
        srgb => 'boolean'
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
        polarization => 'double',
        width => 'int',
        height => 'int'
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
    display => { 
        window_title => 'string'
    },
    dither => { 
        red_levels => 'int',
        green_levels => 'int',
        blue_levels => 'int',
        alpha_levels => 'int',
        dither_method => 'enum',
        seed => 'seed'
    },
    ditto => { 
        sampler_type => 'enum'
    },
    divide => { 
        value => 'double'
    },
    'domain-transform' => { 
        n_iterations => 'int',
        spatial_factor => 'double',
        edge_preservation => 'double'
    },
    dropshadow => { 
        x => 'double',
        y => 'double',
        radius => 'double',
        grow_shape => 'enum',
        grow_radius => 'double',
        color => Pair.new('object', GEGL::Color.get_type),
        opacity => 'double'
    },
    'dst-atop' => { 
        srgb => 'boolean'
    },
    'dst-in' => { 
        srgb => 'boolean'
    },
    'dst-out' => { 
        srgb => 'boolean'
    },
    'dst-over' => { 
        srgb => 'boolean'
    },
    dst => { 
        srgb => 'boolean'
    },
    'edge-neon' => { 
        radius => 'double',
        amount => 'double'
    },
    'edge-sobel' => { 
        horizontal => 'boolean',
        vertical => 'boolean',
        keep_sign => 'boolean'
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
    engrave => { 
        row_height => 'int',
        limit => 'boolean'
    },
    exclusion => { 
        srgb => 'boolean'
    },
    'exp-combine' => { 
        exposures => 'string',
        steps => 'int',
        sigma => 'double'
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
        ncolors => 'int',
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
    'fractal-trace' => { 
        fractal => 'enum',
        X1 => 'double',
        X2 => 'double',
        Y1 => 'double',
        Y2 => 'double',
        JX => 'double',
        JY => 'double',
        depth => 'int',
        bailout => 'double',
        abyss_policy => 'enum',
        fractal => [
          'string',
          <
            mandelbrot
            julia
          >
        ]
    },
    gamma => { 
        value => 'double'
    },
    'gaussian-blur-selective' => { 
        blur_radius => 'double',
        max_delta => 'double'
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
    gcr => { 
        inklimit => 'double',
        amount => 'double'
    },
    'gegl-buffer-load-op' => { 
        path => 'string'
    },
    'gegl-buffer-save-op' => { 
        path => 'string'
    },
    gegl => { 
        string => 'string',
        error => 'string'
    },
    'gif-load' => { 
        path => 'string',
        frame => 'int',
        frames => 'int',
        frame_delay => 'int'
    },
    gluas => { 
        script => 'string',
        error => 'string',
        file => 'string',
        user_value => 'double'
    },
    'gradient-map' => { 
        color1 => Pair.new('object', GEGL::Color.get_type),
        stop1 => 'double',
        color2 => Pair.new('object', GEGL::Color.get_type),
        stop2 => 'double',
        color3 => Pair.new('object', GEGL::Color.get_type),
        stop3 => 'double',
        color4 => Pair.new('object', GEGL::Color.get_type),
        stop4 => 'double',
        color5 => Pair.new('object', GEGL::Color.get_type),
        stop5 => 'double',
        srgb => 'boolean'
    },
    grid => { 
        x => 'int',
        y => 'int',
        x_offset => 'int',
        y_offset => 'int',
        line_width => 'int',
        line_height => 'int',
        line_color => Pair.new('object', GEGL::Color.get_type)
    },
    'hard-light' => { 
        srgb => 'boolean'
    },
    'high-pass' => { 
        std_dev => 'double',
        contrast => 'double'
    },
    'hue-chroma' => { 
        hue => 'double',
        chroma => 'double',
        lightness => 'double'
    },
    'icc-load' => { 
        path => 'string'
    },
    'icc-save' => { 
        path => 'string'
    },
    illusion => { 
        division => 'int',
        illusion_type => 'enum',
        illusion_type => [
          'string',
          <
            type1
            type2
          >
        ]
    },
    'image-compare' => { 
        wrong_pixels => 'int',
        max_diff => 'double',
        avg_diff_wrong => 'double',
        avg_diff_total => 'double'
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
    'integral-image' => { 
        squared => 'boolean'
    },
    introspect => { 
        node => False
    },
    'jp2-load' => { 
        path => 'string',
        uri => 'uri'
    },
    'jpg-load' => { 
        path => 'string',
        uri => 'uri'
    },
    'jpg-save' => { 
        path => 'string',
        quality => 'int',
        smoothing => 'int',
        optimize => 'boolean',
        progressive => 'boolean',
        grayscale => 'boolean',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    json => { 
        gchar => 'target_new',
        PropertyTarget => 'target_free',
        g_strdup => 'target_new'
    },
    layer => { 
        composite_op => 'string',
        opacity => 'double',
        x => 'double',
        y => 'double',
        scale => 'double',
        src => 'string'
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
    'lens-distortion' => { 
        main => 'double',
        edge => 'double',
        zoom => 'double',
        x_shift => 'double',
        y_shift => 'double',
        brighten => 'double',
        background => Pair.new('object', GEGL::Color.get_type)
    },
    'lens-flare' => { 
        pos_x => 'double',
        pos_y => 'double'
    },
    levels => { 
        in_low => 'double',
        in_high => 'double',
        out_low => 'double',
        out_high => 'double'
    },
    lighten => { 
        srgb => 'boolean'
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
    'linear-gradient' => { 
        start_x => 'double',
        start_y => 'double',
        end_x => 'double',
        end_y => 'double',
        start_color => Pair.new('object', GEGL::Color.get_type),
        end_color => Pair.new('object', GEGL::Color.get_type)
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
    'little-planet' => { 
        pan => 'double',
        tilt => 'double',
        spin => 'double',
        zoom => 'double',
        width => 'int',
        height => 'int',
        inverse => 'boolean',
        sampler_type => 'enum'
    },
    load => { 
        path => 'string',
        uri => 'uri',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
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
    'magick-load' => { 
        path => 'string'
    },
    mantiuk06 => { 
        contrast => 'double',
        saturation => 'double',
        detail => 'double'
    },
    'map-absolute' => { 
        sampler_type => 'enum',
        abyss_policy => 'enum'
    },
    'map-relative' => { 
        scaling => 'double',
        sampler_type => 'enum',
        abyss_policy => 'enum'
    },
    'matting-global' => { 
        iterations => 'int',
        seed => 'seed'
    },
    'matting-levin' => { 
        epsilon => 'int',
        radius => 'int',
        threshold => 'double',
        lambda => 'double',
        levels => 'int',
        active_levels => 'int'
    },
    maze => { 
        x => 'int',
        y => 'int',
        algorithm_type => 'enum',
        tileable => 'boolean',
        seed => 'seed',
        fg_color => Pair.new('object', GEGL::Color.get_type),
        bg_color => Pair.new('object', GEGL::Color.get_type),
        algorithm_type => [
          'string',
          <
            depth-first
            prim
          >
        ]
    },
    mblur => { 
        dampness => 'double'
    },
    'mean-curvature-blur' => { 
        iterations => 'int'
    },
    'median-blur' => { 
        neighborhood => 'enum',
        radius => 'int',
        percentile => 'double',
        alpha_percentile => 'double',
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
    mirrors => { 
        m_angle => 'double',
        r_angle => 'double',
        n_segs => 'int',
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
    mix => { 
        ratio => 'double'
    },
    'mono-mixer' => { 
        preserve_luminosity => 'boolean',
        red => 'double',
        green => 'double',
        blue => 'double'
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
    'motion-blur-circular' => { 
        center_x => 'double',
        center_y => 'double',
        angle => 'double'
    },
    'motion-blur-linear' => { 
        length => 'double',
        angle => 'double'
    },
    'motion-blur-zoom' => { 
        center_x => 'double',
        center_y => 'double',
        factor => 'double'
    },
    multiply => { 
        value => 'double'
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
        aa_samples => 'int',
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
    'noise-cell' => { 
        scale => 'double',
        shape => 'double',
        rank => 'int',
        iterations => 'int',
        palettize => 'boolean',
        seed => 'seed'
    },
    'noise-cie-lch' => { 
        holdness => 'int',
        lightness_distance => 'double',
        chroma_distance => 'double',
        hue_distance => 'double',
        seed => 'seed'
    },
    'noise-hsv' => { 
        holdness => 'int',
        hue_distance => 'double',
        saturation_distance => 'double',
        value_distance => 'double',
        seed => 'seed'
    },
    'noise-hurl' => { 
        pct_random => 'double',
        repeat => 'int',
        seed => 'seed'
    },
    'noise-perlin' => { 
        alpha => 'double',
        scale => 'double',
        zoff => 'double',
        n => 'int'
    },
    'noise-pick' => { 
        pct_random => 'double',
        repeat => 'int',
        seed => 'seed'
    },
    'noise-reduction' => { 
        iterations => 'int'
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
    'noise-simplex' => { 
        scale => 'double',
        iterations => 'int',
        seed => 'seed'
    },
    'noise-slur' => { 
        pct_random => 'double',
        repeat => 'int',
        seed => 'seed'
    },
    'noise-solid' => { 
        x_size => 'double',
        y_size => 'double',
        detail => 'int',
        tileable => 'boolean',
        turbulent => 'boolean',
        seed => 'seed',
        width => 'int',
        height => 'int'
    },
    'noise-spread' => { 
        amount_x => 'int',
        amount_y => 'int',
        seed => 'seed'
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
    npd => { 
        model => 'pointer',
        square_size => 'int',
        rigidity => 'int',
        asap_deformation => 'boolean',
        mls_weights => 'boolean',
        mls_weights_alpha => 'double',
        preserve_model => 'boolean',
        sampler_type => 'enum'
    },
    'npy-save' => { 
        path => 'string'
    },
    oilify => { 
        mask_radius => 'int',
        exponent => 'int',
        intensities => 'int',
        use_inten => 'boolean'
    },
    opacity => { 
        value => 'double'
    },
    'open-buffer' => { 
        path => 'string'
    },
    over => { 
        srgb => 'boolean'
    },
    overlay => { 
        srgb => 'boolean'
    },
    pack => { 
        gap => 'double',
        align => 'double',
        orientation => 'enum'
    },
    'panorama-projection' => { 
        pan => 'double',
        tilt => 'double',
        spin => 'double',
        zoom => 'double',
        width => 'int',
        height => 'int',
        inverse => 'boolean',
        sampler_type => 'enum'
    },
    path => { 
        fill => Pair.new('object', GEGL::Color.get_type),
        stroke => Pair.new('object', GEGL::Color.get_type),
        stroke_width => 'double',
        stroke_opacity => 'double',
        stroke_hardness => 'double',
        fill_rule => 'string',
        transform => 'string',
        fill_opacity => 'double',
        d => 'path'
    },
    'pdf-load' => { 
        path => 'string',
        uri => 'uri',
        page => 'int',
        pages => 'int',
        ppi => 'double',
        password => 'string'
    },
    photocopy => { 
        mask_radius => 'double',
        sharpness => 'double',
        black => 'double',
        white => 'double'
    },
    pixbuf => { 
        pixbuf => False
    },
    pixelize => { 
        norm => 'enum',
        size_x => 'int',
        size_y => 'int',
        offset_x => 'int',
        offset_y => 'int',
        ratio_x => 'double',
        ratio_y => 'double',
        background => Pair.new('object', GEGL::Color.get_type)
    },
    plasma => { 
        turbulence => 'double',
        x => 'int',
        y => 'int',
        width => 'int',
        height => 'int',
        seed => 'seed'
    },
    plus => { 
        srgb => 'boolean'
    },
    'png-load' => { 
        path => 'string',
        uri => 'uri',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'png-save' => { 
        path => 'string',
        compression => 'int',
        bitdepth => 'int',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'polar-coordinates' => { 
        depth => 'double',
        angle => 'double',
        bw => 'boolean',
        top => 'boolean',
        polar => 'boolean',
        pole_x => 'int',
        pole_y => 'int',
        middle => 'boolean'
    },
    posterize => { 
        levels => 'int'
    },
    'ppm-load' => { 
        path => 'string',
        uri => 'string'
    },
    'ppm-save' => { 
        path => 'string',
        rawformat => 'boolean',
        bitdepth => 'int'
    },
    'radial-gradient' => { 
        start_x => 'double',
        start_y => 'double',
        end_x => 'double',
        end_y => 'double',
        start_color => Pair.new('object', GEGL::Color.get_type),
        end_color => Pair.new('object', GEGL::Color.get_type)
    },
    'raw-load' => { 
        path => 'string',
        image_num => 'int',
        color_space => 'enum',
        quality => 'int'
    },
    'rawbayer-load' => { 
        path => 'string'
    },
    rectangle => { 
        x => 'double',
        y => 'double',
        width => 'double',
        height => 'double',
        color => Pair.new('object', GEGL::Color.get_type)
    },
    'recursive-transform' => { 
        transform => 'string',
        first_iteration => 'int',
        iterations => 'int',
        fade_color => Pair.new('object', GEGL::Color.get_type),
        fade_opacity => 'double',
        paste_below => 'boolean',
        sampler_type => 'enum'
    },
    'red-eye-removal' => { 
        threshold => 'double'
    },
    reflect => { 
        x => 'double',
        y => 'double'
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
    'rgbe-load' => { 
        path => 'string'
    },
    'rgbe-save' => { 
        path => 'string'
    },
    ripple => { 
        amplitude => 'double',
        period => 'double',
        phi => 'double',
        angle => 'double',
        sampler_type => 'enum',
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
    'rotate-on-center' => { 
        degrees => 'double',
        origin_x => 'double',
        origin_y => 'double'
    },
    rotate => { 
        degrees => 'double'
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
    'save-pixbuf' => { 
        pixbuf => False
    },
    save => { 
        path => 'string',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'scale-ratio' => { 
        x => 'double',
        y => 'double'
    },
    'scale-size-keepaspect' => { 
        x => 'double',
        y => 'double'
    },
    'scale-size' => { 
        x => 'double',
        y => 'double'
    },
    screen => { 
        srgb => 'boolean'
    },
    'sdl-display' => { 
        window_title => 'string',
        icon_title => 'string'
    },
    'sdl2-display' => { 
        window_title => 'string'
    },
    'seamless-clone-compose' => { 
        max_refine_scale => 'int',
        xoff => 'int',
        yoff => 'int',
        error_msg => 'string'
    },
    'seamless-clone' => { 
        max_refine_scale => 'int',
        xoff => 'int',
        yoff => 'int',
        error_msg => 'string'
    },
    'segment-kmeans' => { 
        n_clusters => 'int',
        max_iterations => 'int',
        seed => 'seed'
    },
    'selective-hue-saturation' => { 
        hue_sel_center => 'double',
        hue_sel_width => 'double',
        hue => 'double',
        saturation => 'double',
        lightness => 'double'
    },
    sepia => { 
        scale => 'double',
        srgb => 'boolean'
    },
    'shadows-highlights-correction' => { 
        shadows => 'double',
        highlights => 'double',
        whitepoint => 'double',
        compress => 'double',
        shadows_ccorrect => 'double',
        highlights_ccorrect => 'double'
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
    shear => { 
        x => 'double',
        y => 'double'
    },
    shift => { 
        shift => 'int',
        direction => 'enum',
        seed => 'seed'
    },
    sinus => { 
        x_scale => 'double',
        y_scale => 'double',
        complexity => 'double',
        seed => 'seed',
        tiling => 'boolean',
        perturbation => 'boolean',
        color1 => Pair.new('object', GEGL::Color.get_type),
        color2 => Pair.new('object', GEGL::Color.get_type),
        blend_mode => 'enum',
        blend_power => 'double',
        width => 'int',
        height => 'int',
        blend_mode => [
          'string',
          <
            linear
            bilinear
            sinusoidal
          >
        ]
    },
    slic => { 
        cluster_size => 'int',
        compactness => 'int',
        iterations => 'int'
    },
    'snn-mean' => { 
        radius => 'int',
        pairs => 'int'
    },
    'soft-light' => { 
        srgb => 'boolean'
    },
    softglow => { 
        glow_radius => 'double',
        brightness => 'double',
        sharpness => 'double'
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
    spiral => { 
        type => 'enum',
        x => 'double',
        y => 'double',
        radius => 'double',
        base => 'double',
        balance => 'double',
        rotation => 'double',
        direction => 'enum',
        color1 => Pair.new('object', GEGL::Color.get_type),
        color2 => Pair.new('object', GEGL::Color.get_type),
        width => 'int',
        height => 'int',
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
    spyrograph => { 
        curve_type => 'enum',
        fixed_gear_teeth => 'int',
        moving_gear_teeth => 'int',
        hole_percent => 'double',
        x => 'double',
        y => 'double',
        radius => 'double',
        rotation => 'double',
        stroke => Pair.new('object', GEGL::Color.get_type),
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
    },
    'src-atop' => { 
        srgb => 'boolean'
    },
    'src-in' => { 
        srgb => 'boolean'
    },
    'src-out' => { 
        srgb => 'boolean'
    },
    src => { 
        srgb => 'boolean'
    },
    stress => { 
        radius => 'int',
        samples => 'int',
        iterations => 'int',
        enhance_shadows => 'boolean',
        rgamma => 'double'
    },
    'stretch-contrast' => { 
        keep_colors => 'boolean',
        perceptual => 'boolean'
    },
    subtract => { 
        value => 'double'
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
    'svg-huerotate' => { 
        values => 'string'
    },
    'svg-load' => { 
        path => 'string',
        uri => 'uri',
        width => 'int',
        height => 'int'
    },
    'svg-matrix' => { 
        values => 'string'
    },
    'svg-saturate' => { 
        values => 'string'
    },
    text => { 
        string => 'string',
        font => 'string',
        size => 'double',
        color => Pair.new('object', GEGL::Color.get_type),
        wrap => 'int',
        vertical_wrap => 'int',
        alignment => 'int',
        vertical_alignment => 'int',
        width => 'int',
        height => 'int'
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
    threshold => { 
        value => 'double'
    },
    'tiff-load' => { 
        path => 'string',
        uri => 'uri',
        directory => 'int',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'tiff-save' => { 
        path => 'string',
        bitdepth => 'int',
        fp => 'int',
        metadata => Pair.new('object', GEGL::Metadata.get_type)
    },
    'tile-glass' => { 
        tile_width => 'int',
        tile_height => 'int'
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
    tile => { 
        offset_x => 'int',
        offset_y => 'int'
    },
    transform => { 
        transform => 'string'
    },
    translate => { 
        x => 'double',
        y => 'double'
    },
    'unsharp-mask' => { 
        std_dev => 'double',
        scale => 'double',
        threshold => 'double'
    },
    v4l => { 
        path => 'string',
        width => 'int',
        height => 'int',
        frame => 'int',
        fps => 'int'
    },
    v4l2 => { 
        path => 'string',
        width => 'int',
        height => 'int',
        frame => 'int',
        fps => 'int'
    },
    'value-propagate' => { 
        mode => 'enum',
        lower_threshold => 'double',
        upper_threshold => 'double',
        rate => 'double',
        color => Pair.new('object', GEGL::Color.get_type),
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
    'variable-blur' => { 
        radius => 'double',
        linear_mask => 'boolean',
        levels => 'int',
        gamma => 'double',
        high_quality => 'boolean'
    },
    'vector-fill' => { 
        color => Pair.new('object', GEGL::Color.get_type),
        opacity => 'double',
        fill_rule => 'string',
        transform => 'string',
        d => 'path'
    },
    'vector-stroke' => { 
        color => Pair.new('object', GEGL::Color.get_type),
        width => 'double',
        opacity => 'double',
        transform => 'string',
        d => 'path'
    },
    'video-degradation' => { 
        pattern => 'enum',
        additive => 'boolean',
        rotated => 'boolean'
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
    'watershed-transform' => { 
        flag_component => 'int',
        flag => 'format'
    },
    'wavelet-blur-1d' => { 
        radius => 'double',
        orientation => 'enum'
    },
    'wavelet-blur' => { 
        radius => 'double'
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
    'webp-load' => { 
        path => 'string',
        uri => 'uri'
    },
    'webp-save' => { 
        path => 'string',
        quality => 'int'
    },
    'whirl-pinch' => { 
        whirl => 'double',
        pinch => 'double',
        radius => 'double'
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
    'write-buffer' => { 
        buffer => Pair.new('object', GEGL::Buffer.get_type)
    },
    xor => { 
        srgb => 'boolean'
    }
  );
}
