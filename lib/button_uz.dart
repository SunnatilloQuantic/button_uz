import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Creates a button based on [Semantics], [Material], and [InkWell]
/// widgets.
///
/// This class does not use the current [Theme] or [ButtonTheme] to
/// compute default values for unspecified parameters. It's intended to
/// be used for custom Material buttons that optionally incorporate defaults
/// from the themes or from app-specific sources.
///
/// on the current [Theme] and [ButtonTheme].
class FlutterButton extends StatefulWidget {
  /// Create a button based on [Semantics], [Material], and [InkWell] widgets.
  ///
  /// The [shape], [elevation], [focusElevation], [hoverElevation],
  /// [highlightElevation], [disabledElevation], [padding], [constraints],
  /// [autofocus], and [clipBehavior] arguments must not be null. Additionally,
  /// [elevation], [focusElevation], [hoverElevation], [highlightElevation], and
  /// [disabledElevation] must be non-negative.
  const FlutterButton({
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation = 0.0,
    this.focusElevation = 4.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 8.0,
    this.disabledElevation = 0.0,
    this.padding = EdgeInsets.zero,
    this.visualDensity = const VisualDensity(),
    this.constraints = const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
    this.shape = const RoundedRectangleBorder(),
    this.animationDuration = kThemeChangeDuration,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    this.child,
    this.enableFeedback = true,
    this.width,
    this.height,
    this.margin,
  })  : materialTapTargetSize =
            materialTapTargetSize ?? MaterialTapTargetSize.padded,
        assert(shape != null),
        assert(elevation != null && elevation >= 0.0),
        assert(focusElevation != null && focusElevation >= 0.0),
        assert(hoverElevation != null && hoverElevation >= 0.0),
        assert(highlightElevation != null && highlightElevation >= 0.0),
        assert(disabledElevation != null && disabledElevation >= 0.0),
        assert(padding != null),
        assert(constraints != null),
        assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(key: key);

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// If this callback and [onPressed] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onLongPress;

  /// Called by the underlying [InkWell] widget's [InkWell.onHighlightChanged]
  /// callback.
  ///
  /// If [onPressed] changes from null to non-null while a gesture is ongoing,
  /// this can fire during the build phase (in which case calling
  /// [State.setState] is not allowed).
  final ValueChanged<bool>? onHighlightChanged;

  /// {@template flutter.material.button.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// button.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.pressed].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  /// {@endtemplate}
  final MouseCursor? mouseCursor;

  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the button's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// The highlight color for the button's [InkWell].
  final Color? highlightColor;

  /// The splash color for the button's [InkWell].
  final Color? splashColor;

  /// The elevation for the button's [Material] when the button
  /// is [enabled] but not pressed.
  ///
  /// Defaults to 2.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [highlightElevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? elevation;

  /// The elevation for the button's [Material] when the button
  /// is [enabled] and a pointer is hovering over it.
  ///
  /// Defaults to 4.0. The value is always non-negative.
  ///
  /// If the button is [enabled], and being pressed (in the highlighted state),
  /// then the [highlightElevation] take precedence over the [hoverElevation].
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? hoverElevation;

  /// The elevation for the button's [Material] when the button
  /// is [enabled] and has the input focus.
  ///
  /// Defaults to 4.0. The value is always non-negative.
  ///
  /// If the button is [enabled], and being pressed (in the highlighted state),
  /// or a mouse cursor is hovering over the button, then the [hoverElevation]
  /// and [highlightElevation] take precedence over the [focusElevation].
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? focusElevation;

  /// The elevation for the button's [Material] when the button
  /// is [enabled] and pressed.
  ///
  /// Defaults to 8.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? highlightElevation;

  /// The elevation for the button's [Material] when the button
  /// is not [enabled].
  ///
  /// Defaults to 0.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? disabledElevation;

  /// The internal padding for the button's [child].
  final EdgeInsetsGeometry? padding;

  /// Defines how compact the button's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all widgets
  ///    within a [Theme].
  final VisualDensity? visualDensity;

  /// Defines the button's size.
  ///
  /// Typically used to constrain the button's minimum size.
  final BoxConstraints? constraints;

  /// The shape of the button's [Material].
  ///
  /// The button's highlight and splash are clipped to this shape. If the
  /// button has an elevation, then its drop shadow is defined by this shape.
  ///
  /// If [shape] is a [MaterialStateProperty<ShapeBorder>], [MaterialStateProperty.resolve]
  /// is used for the following [MaterialState]s:
  ///
  /// * [MaterialState.pressed].
  /// * [MaterialState.hovered].
  /// * [MaterialState.focused].
  /// * [MaterialState.disabled].
  final ShapeBorder? shape;

  /// Defines the duration of animated changes for [shape] and [elevation].
  ///
  /// The default value is [kThemeChangeDuration].
  final Duration? animationDuration;

  /// Typically the button's label.
  final Widget? child;

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed]
  /// or [onLongPress] properties to a non-null value.
  bool get enabled => onPressed != null || onLongPress != null;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [MaterialTapTargetSize.padded].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool? autofocus;

  /// {@macro flutter.widgets.Clip}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip? clipBehavior;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  /// The color of the button's [Material].
  final Color? color;

  @override
  _FlutterButtonState createState() => _FlutterButtonState();
}

class _FlutterButtonState extends State<FlutterButton> {
  final Set<MaterialState> _states = <MaterialState>{};

  bool get _hovered => _states.contains(MaterialState.hovered);
  bool get _focused => _states.contains(MaterialState.focused);
  bool get _pressed => _states.contains(MaterialState.pressed);
  bool get _disabled => _states.contains(MaterialState.disabled);

  void _updateState(MaterialState state, bool value) {
    value ? _states.add(state) : _states.remove(state);
  }

  void _handleHighlightChanged(bool value) {
    if (_pressed != value) {
      setState(() {
        _updateState(MaterialState.pressed, value);
        if (widget.onHighlightChanged != null) {
          widget.onHighlightChanged!(value);
        }
      });
    }
  }

  void _handleHoveredChanged(bool value) {
    if (_hovered != value) {
      setState(() {
        _updateState(MaterialState.hovered, value);
      });
    }
  }

  void _handleFocusedChanged(bool value) {
    if (_focused != value) {
      setState(() {
        _updateState(MaterialState.focused, value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateState(MaterialState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(FlutterButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateState(MaterialState.disabled, !widget.enabled);
    if (_disabled && _pressed) {
      _handleHighlightChanged(false);
    }
  }

  double get _effectiveElevation {
    if (_disabled) {
      return widget.disabledElevation!;
    }
    if (_pressed) {
      return widget.highlightElevation!;
    }
    if (_hovered) {
      return widget.hoverElevation!;
    }
    if (_focused) {
      return widget.focusElevation!;
    }
    return widget.elevation!;
  }

  @override
  Widget build(BuildContext context) {
    final ShapeBorder effectiveShape =
        MaterialStateProperty.resolveAs<ShapeBorder>(widget.shape!, _states);
    final Offset densityAdjustment = widget.visualDensity!.baseSizeAdjustment;
    final BoxConstraints effectiveConstraints =
        widget.visualDensity!.effectiveConstraints(widget.constraints!);
    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      _states,
    );
    final EdgeInsetsGeometry padding = widget.padding!
        .add(
          EdgeInsets.only(
            left: densityAdjustment.dx,
            top: densityAdjustment.dy,
            right: densityAdjustment.dx,
            bottom: densityAdjustment.dy,
          ),
        )
        .clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity);

    final Widget result = ConstrainedBox(
      constraints: effectiveConstraints,
      child: Container(
        margin: widget.margin,
        child: Material(
          elevation: _effectiveElevation,
          shape: effectiveShape,
          color: widget.color,
          type: widget.color == null
              ? MaterialType.transparency
              : MaterialType.button,
          animationDuration: widget.animationDuration!,
          clipBehavior: widget.clipBehavior!,
          child: InkWell(
            focusNode: widget.focusNode,
            canRequestFocus: widget.enabled,
            onFocusChange: _handleFocusedChanged,
            autofocus: widget.autofocus!,
            onHighlightChanged: _handleHighlightChanged,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            onHover: _handleHoveredChanged,
            onTap: widget.onPressed,
            onLongPress: widget.onLongPress,
            enableFeedback: widget.enableFeedback,
            customBorder: effectiveShape,
            mouseCursor: effectiveMouseCursor,
            child: Container(
              padding: padding,
              width: widget.width,
              height: widget.height,
              child: Center(
                heightFactor: 1.0,
                widthFactor: 1.0,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: result,
    );
  }
}
