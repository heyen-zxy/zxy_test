require 'rest-client'
require 'pp'

class TestHttp

  class << self
    def con
      RestClient.get 'http://www.baidu.com/s?wd=aa'
    end

    def codes
      con.code
    end

    def cook
      con.cookies
    end

    def header
      con.headers
    end

    def str
      con.to_str
    end

    def test_post
      RestClient.post 'http://0.0.0.0:3000/users.json', user: {name: 'cc', age: '33'}
    end





  end


  pp codes, '-----------'

  pp cook, '------------'

  pp header, '-----------'

  pp str, '-----------'

  pp test_post



end