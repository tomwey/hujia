window.App = 
  
  # 警告信息显示
  alert: (msg, to) ->
    $(to).before("<div data-alert class='alert-message'><a class='close' href='#'>X</a>#{msg}</div>")
  
  # 收藏本站
  addToFavorite: (el, url) ->
    

  # 删除评论
  deleteComment: (el) ->
    id = $(el).data("id")
    tr = $("#comment_tr_#{id}")
    $.ajax
      url: "/cpanel/comments/#{id}"
      type: "DELETE"
      success: (re) -> 
        if re == "1"
          tr.remove()
        else
          App.alert("抱歉，系统异常，提交失败。")
    false
    
  # 删除教练
  deleteCoach: (el) ->
    id = $(el).data("id")
    tr = $("#coach_tr_#{id}")
    $.ajax
      url: "/cpanel/coaches/#{id}"
      type: "DELETE"
      success: (re) -> 
        if re == "1"
          tr.remove()
        else
          App.alert("抱歉，系统异常，提交失败。")
    false
    
  # 删除领取的代金券
  deleteVouching: (el) ->
    result = confirm("你确定吗")
    if !result 
      return false
    id = $(el).data("id")
    tr_header = $("#tr_header_#{id}")
    tr_item   = $("#tr_item_#{id}")
    $.ajax
      url: "/vouchings/#{id}"
      type: "DELETE"
      success: (re) ->
        if re == "1"
          tr_header.remove()
          tr_item.remove()
        else
          App.alert("抱歉，系统异常，提交失败。", $(el))
    false
    
  # 删除预约
  deleteAppointable: (el) ->
    result = confirm("你确定吗")
    if !result 
      return false
     
    id = $(el).data("id")
    div = $("#appointment_item_#{id}")
    $.ajax
      url: "/appointments/#{id}"
      type: "DELETE"
      success: (re) ->
        if re == "1"
          div.remove()
        else
          App.alert("抱歉，系统异常，提交失败。")
    false

  bindUserProfile: ->
    name = $("#user_customer_real_name").val()
    mobile = $("#user_customer_mobile").val()
    if mobile.length == 0
      alert("手机内容为空")
      return false
    $.ajax
      url: "/users/bind"
      type: "put"
      data:
        name: "#{name}"
        mobile: "#{mobile}"
      # success: (re) ->
      #   if re == "1"
      #     $("#login").remove()
      #   else
      #     $("#bind-result").html(re)
    false
    
  appointable: (el) ->
    appointable_type = $(el).data("type")
    appointable_id = $(el).data("id")
    # if $(el).data("state") != "appointed"
    $.ajax
      url: "/appointments"
      type: "POST"
      data:
        type: appointable_type
        id: appointable_id 
      success: (re) ->
        if re == "-1"
          App.alert("抱歉，系统异常，提交失败。")
        else
          $.getScript("/appointments", "GET")
            # body...
          # if re == "1"
          #   $(el).data("state", "appointed").attr("class", "btn btn-danger").attr("title", "取消报名").text("取消报名")
          # else
          #   App.alert("抱歉，系统异常，提交失败。")
    # else
    #   $.ajax
    #     url: "/appointments/#{appointable_id}"
    #     type: "DELETE"
    #     data:
    #       type: appointable_type
    #     success: (re) ->
    #       if re == "1"
    #         $(el).data("state", "").attr("class", "btn btn-primary").attr("title", "立即报名").text("立即报名")
    #       else
    #         App.alert("抱歉，系统异常，提交失败。")
    # false
    
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
  
  getCities: (el) ->
    $("#user_cities").html('<option value="">-- 请选择城市 --</option>')
    $("#user_customer_college").html('<option value="">-- 请选择大学校区 --</option>')
    code = $(el).val()
    $.ajax
      url: "/cities/#{code}"
      type: "GET"
    false
  
  getColleges: (el) ->
    $("#user_customer_college").html('<option value="">-- 请选择大学校区 --</option>')
    code = $(el).val()
    $.ajax
      url: "/colleges/#{code}"
      type: "GET"
    false
      