require 'rest-client'
require 'pp'
require 'rails'

class TestBaiWu
    USER_ID = 'sh0263'
    PASSWORD = 'mm0027'
    WORK_CODE = '1069003256009'
    MD5_CODE = '86aecf048631ad300568dd6d4cc3b9b1'
    #短信接口  get/post  response: 0#数字
    # -10       余额不足
    # -11       账号关闭
    # -12       短信内容超过1000字（包括1000字）或为空
    # -13       手机号码超过200个或合法的手机号码为空，或者手机号码与通道代码正则不匹配
    # -14       msg_id超过50个字符或没有传msg_id字段
    # -16       用户名不存在
    # -18       访问ip错误
    # -19       密码错误 或者业务代码错误 或者通道关闭 或者业务关闭
    # -20       小号错误
    MSG_HTTP = "http://sms.cloud.hbsmservice.com:8080/post_sms.do"
    #短信params  ext: 用户自己分配的扩展号
    MSG_PARAMS = {
        id: USER_ID,
        MD5_td_code: MD5_CODE,
        mobile: '13585665936',#13133811659
        msg_content: 'zzzz!test'.encode('GBK', 'UTF-8'),
        msg_id: SecureRandom.uuid,
        ext: '77777'}


    #群发短信接口 post  response: 0#数字
    # 100 余额不足
    # 101 账号关闭
    # 106 用户名不存在
    # 107 密码错误
    # 108 指定访问的IP错误
    # 109 业务不存在
    # 114 接口提交应为POST，不支持GET
    # 115 total_count 与实际短信条数无法匹配，即，实际短信条数与total_count不一致。 如果要返回此参数，则本次提交的所有短信作废，不入库
    # 116 个性化短信提交个数超过200条
    # 9 访问地址不存在
    SMS_HTTP = 'http://sms.cloud.hbsmservice.com:8080/antoSmsSend.do'
    SMS_PARAMS = {
        corp_id: USER_ID,
        crop_pwd: PASSWORD,
        crop_service: WORK_CODE,
        total_count: 2,
        send_param: '13585665936&split&20110608122535001&split&256&split&尊敬的会员张三您好，您的账户余额为20元&group&18516507845&split&2011060812255425003&split&257&樊伟，我测试个东西,zhangxy'.encode('GBK', 'UTF-8')
    }

    #余额balance查询接口 post 2s/次 response: ok#余额
    # 104 访问频率低于2秒
    # 106 用户名不存在
    # 101 用户关闭
    # 107 密码错误
    # 108 指定ip绑定错误
    # 9 访问地址不存在

    BLC_HTTP = 'http://sms.cloud.hbsmservice.com:8080/get_balance.do'
    BLC_PARAMS = {
        id: USER_ID,
        PWD: PASSWORD
    }

    #状态报告post
    # 0 暂时没有数据
    # 9 访问地址不存在
    # -11 账户关闭
    # -16 用户名错误或用户名不存在
    # -17 密码错误
    # -18 不支持客户主动获取
    # -19 用户访问超过我方限制频率（间隔200毫秒访问一次）
    # 108 指定访问IP错误
    # Xml格式字符串 有待推送的状态报告，并且状态报告以xml格式的字符串返回。

    OBTAIN_HTTP = 'http://sms.cloud.hbsmservice.com:8080/post_report.do'
    OBTAIN_PARAMS = {
        corp_id: USER_ID,
        user_id: USER_ID,
        corp_pwd: PASSWORD
    }

    #获取上行信息
    # 0 暂时没有待推送的数据
    # 9 访问地址不存在
    # -11 账户关闭
    # -16 用户名错误或用户名不存在
    # -17 密码错误
    # -18 不支持客户主动获取
    # -19 用户访问超过我方限制频率 （间隔200毫秒访问一次）
    # 108 指定访问IP错误
    # Xml格式字符串  有待推送的上行信息，并且上行信息以xml格式的字符串返回。一条上行xml字符串可包含10个<deliver></deliver>节点

    UP_HTTP = 'http://sms.cloud.hbsmservice.com:8080/post_deliverMsg.do'
    UP_PARAMS = {
        corp_id: USER_ID,
        user_id: USER_ID,
        corp_pwd: PASSWORD
    }





    def self.bw_response url, params
      pp RestClient.post url, params
    end

    private
    # 默认转换为GBK
    def self.bin2hex sm, dc=15, from_encoding='UTF-8'
      to_encoding = case dc
                      when 15 then 'GBK'
                      when 8  then 'UCS-2BE'
                      when 0  then 'ISO8859-1'
                      else raise '短信内容格式错误'
                    end
      sm = sm.encode(to_encoding, from_encoding).unpack('H*').join
    end



  #短信reponse
  #msg_reponse = bw_response MSG_HTTP, MSG_PARAMS
  #群发短信 reponse
  # sms_reponse = bw_response SMS_HTTP, SMS_PARAMS
  # #余额查询 reponse
  # blc_reponse = bw_response BLC_HTTP, BLC_PARAMS
  # #状态报告 reponse
  obtain_reponse = bw_response OBTAIN_HTTP, OBTAIN_PARAMS
  pp Hash.from_xml(obtain_reponse) unless obtain_reponse == "0"
  #pp Hash.from_xml obtain_reponse
  # #上行信息 response
  # up_response = bw_response UP_HTTP, UP_PARAMS





end