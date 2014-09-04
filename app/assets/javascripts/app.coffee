window.App = 
  
  # 警告信息显示
  alert: (msg, to) ->
    $(to).before("<div data-alert class='alert-message'><a class='close' href='#'>X</a>#{msg}</div>")
  appointable: (el) ->
    appointable_type = $(el).data("type")
    appointable_id = $(el).data("id")
    if $(el).data("state") != "appointed"
      $.ajax
        url: "/appointments"
        type: "POST"
        data:
          type: appointable_type
          id: appointable_id 
        success: (re) ->
          if re == "1"
            $(el).data("state", "appointed").attr("class", "btn btn-danger").attr("title", "取消报名").text("取消报名")
          else
            App.alert("抱歉，系统异常，提交失败。")
    else
      $.ajax
        url: "/appointments/#{appointable_id}"
        type: "DELETE"
        data:
          type: appointable_type
        success: (re) ->
          if re == "1"
            $(el).data("state", "").attr("class", "btn btn-primary").attr("title", "立即报名").text("立即报名")
          else
            App.alert("抱歉，系统异常，提交失败。")
    false
    
  getCoupon: (el) ->
      # alert("123")
    uid = $(el).data("user-id")
    cid = $(el).data("coupon-id")
    $.ajax
      url: "/coupons/#{cid}/user/#{uid}"
      type: "PUT"
      success: (re) ->
        if re == "1"
          $(el).parent().html('<span class="label label-success">已领取</span>')
        else
          App.alert("抱歉，系统异常，提交失败。")
    false
  
  unselect: (el) ->
    key = $(el).data("key")
    $.ajax
      url: $(el).href
      type: "GET"
      