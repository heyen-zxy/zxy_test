require 'bindata'

module DecodeBW
  class MessageHeader < BinData::Record
    endian :big

    uint32 :length
    uint32 :message_type
    uint32 :message_id

    def format_hash
      {
          data: {
              length: length,
              message_type: message_type,
              message_id: message_id
          }
      }

    end


  end

  #
  #connect请求 request
  class RequestConnect < BinData::Record
    endian :big

    string :sp_id, length: 6 #企业id
    string :authenticator_source, length: 16 #源地址
    uint8 :version #版本号
    uint32 :request_time #时间戳



  end

  #connect 返回 reponse
  class ReponseConnect < BinData::Record
    endian :big

    uint8 :status #状态 0：正确 1：消息结构错 2：非法源地址 3：认证错 4：版本太高 5~ ：其他错误
    string :authenticator_ISMG, length: 16
    uint8 :version #服务器支持的最高版本

    def format_hash
      {
          data: {
            status: status,
            authenticator_ISMG: authenticator_ISMG,
            version: version
          }
      }
    end


  end

  #提交信息 request
  class RequestSubmitMsg < BinData::Record
    endian :big

    uint64 :msg_id   #短信id
    unit8 :pk_total #相同的msg_id 数量
    uint8 :ok_number #msg_id 序列号
    uint8 :registered_delivery #是否要求返回状态确认报告 0：不需要 1：需要 2：产生SMC话单
    uint8 :msg_level #短信级别
    string :service_id, length: 10 #业务类型
    uint8 :fee_user_type #计费用户类型 0：对目的终端MSISDN计费； 1：对源终端MSISDN计费； 2：对SP计费; 3：表示本字段无效，对谁计费参见Fee_terminal_Id字段。
    string :fee_terminal_Id, length: 21 #被计费用户的号码（如本字节填空，则表示本字段无效，对谁计费参见Fee_UserType字段，本字段与Fee_UserType字段互斥）
    uint8 :tp_pid
    uint8 :tpudhi
    uint8 :msg_format #信息格式  0：ASCII串 3：短信写卡操作 4：二进制信息 8：UCS2编码 15：含GB汉字

  end

end