class Sms

  DEFAULT_DATA = Settings.sms_zunyuan
  # 消息类型 WORD 2byte
  MSG_TYPE = {
      "heart" => 0,     # 心跳消息
      "calling" => 16,  # 起呼事件
      "ringing" => 17,  # 振铃事件
      "anwser" => 18,   # 呼叫应答
      "over" => 19      # 呼叫结束
  }

  class << self

    def client
      begin
        pp 'client11111111111'
        @client = TCPSocket.new DEFAULT_DATA.host, DEFAULT_DATA.port
        pp 'client2222222222'
      rescue => e
        pp e.message
        pp 'client3333333333'
        sleep DEFAULT_DATA.one_heartbeat_time
        retry
      end


    end

    # 发送振铃信令，因为闪信有一定的延迟，所以在收到起呼消息时就要发送信令给闪信平台，但是发送的消息类型要标记为振铃
    def send_ringing(billing_id, calling_no, callee_no)
      header = msg_sync_header + msg_len(billing_id, calling_no, callee_no) + msg_type("ringing") + msg_seq + msg_time
      body = billing_id + delimiter + calling_no + delimiter + callee_no + delimiter
      begin
        client.write  header + body

        resp = @client.read(24).to_s
        puts resp
      rescue Errno::EPIPE
        @client = nil
        retry
      rescue IOError
        @client = nil
        retry
      end
    end



    #发送心跳消息
    # 发送心跳消息,只有消息头没有消息体
    def send_heartbeat
      begin
        header = msg_sync_header + msg_len + msg_type("heart") + msg_seq + msg_time
        pp header, '1111111111'
        client.write header
        pp '2222222222222'
      rescue Errno::EPIPE
        pp '33333333'
        @client = nil
        retry
      rescue IOError
        pp '4444444444444'
        @client = nil
        retry
      end
    end

    #分隔符
    # 分隔符，在billingid, calling_no, callee_no之后添加
    def delimiter
      [DEFAULT_DATA.delimiter].pack("c*")
    end

    # 消息同步头 BYTE 4byte
    def msg_sync_header
      [0,255,255,0].pack("c*")
    end

    # 消息长度 WORD 2byte; 不包括消息同步头
    # 消息头的长度是固定的12个byte, 加上billing, calling_no, callee_no的长度以及固定的三个分隔符0
    def msg_len(billing_id = nil, calling_no = nil, callee_no = nil)
      if billing_id
        [2 + 2 + 4 + 4 + 3 + billing_id.size + calling_no.size + callee_no.size].pack("s>*")
      else
        [2 + 2 + 4 + 4].pack("s>*")
      end
    end

    def msg_type(type)
      [MSG_TYPE[type]].pack("s>*")
    end


    # 消息序号 DWORD 4byte
    def msg_seq
      [rand(999999999999)].pack("l>*")
    end

    # 消息时间 DWORD 4byte
    def msg_time
      [Time.now.to_i].pack("l>*")
    end

    def keepalive
      while true
        send_heartbeat
        sleep DEFAULT_DATA.one_heartbeat_time
      end
    end

  end

end