require 'savon'
class Nav
  # 供应商短信内容更新接口
  class << self
    def client
      @client ||= Savon.client wsdl: Settings.sms_zunyuan.wsdl
      # 查看webservice方法
      # @client.operations
    end

    def mm
      client.operations
    end

  end




end