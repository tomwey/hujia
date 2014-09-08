jQuery ->
  new CarrierWaveCropper()

class CarrierWaveCropper
  constructor: ->
    $('#coach_image_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 100, 100]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#coach_image_crop_x').val(coords.x)
    $('#coach_image_crop_y').val(coords.y)
    $('#coach_image_crop_w').val(coords.w)
    $('#coach_image_crop_h').val(coords.h)
    
    $('#crop_x').val(coords.x)
    $('#crop_y').val(coords.y)
    $('#crop_w').val(coords.w)
    $('#crop_h').val(coords.h)
    
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#coach_image_previewbox').css
      width: Math.round(100/coords.w * $('#coach_image_cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#coach_image_cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'

    