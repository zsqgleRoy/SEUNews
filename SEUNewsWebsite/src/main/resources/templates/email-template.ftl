<!DOCTYPE html>
<html>

<head>
    <style>
        body {
            font-family: 'PingFang SC', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        table.body-wrap {
            width: 100%;
            min-height: 100vh;
            background-color: #f5f7fa;
        }

        .container {
            max-width: 600px;
            width: 90%;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border: none;
            padding: 40px;
            box-sizing: border-box;
            margin-top: 5vh;
        }

        h1 {
            color: #2d3748;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        p {
            color: #4a5568;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .code {
            display: none;
            background-color: #edf2f7;
            color: #2d3748;
            padding: 15px 20px;
            border-radius: 8px;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            letter-spacing: 2px;
            margin: 20px 0;
        }

        #showCode {
            display: none;
        }

        #showCode:checked~.code {
            display: block;
        }

        #showCode:checked~.btn {
            display: none;
        }

        .image-container {
            margin-bottom: 25px;
            text-align: center;
        }

        .image-container img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
        }

        .signature {
            text-align: right;
            color: #718096;
            font-style: italic;
            margin-top: 30px;
        }

        .tip {
            color: #a0aec0;
            font-size: 14px;
            margin-top: 30px;
            text-align: center;
        }

        .btn {
            font-family: 'PingFang SC', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            min-width: 200px;
            box-sizing: border-box;
            color: #ffffff;
            text-decoration: none;
            line-height: 46px;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            display: inline-block;
            text-transform: capitalize;
            margin: 0 auto;
            border-radius: 8px;
            height: 48px;
            background-color: #4299e1;
            border: none;
            transition: background-color 0.3s ease;
            display: block;
        }

        .btn:hover {
            background-color: #3182ce;
        }
    </style>
    <title></title>
</head>

<body>
<table class="body-wrap" width="100%" bgcolor="#f5f7fa">
    <tbody>
    <tr>
        <td class="container" width="600">
            <div class="content">
                <div class="image-container">
                    <img src="https://gimg3.baidu.com/search/src=https%3A%2F%2Fstatic-data.gaokao.cn%2Fupload%2Flogo%2F109.jpg%3Ft%3D1744646422&refer=http%3A%2F%2Fwww.baidu.com&app=2021&size=w931&n=0&g=0n&er=404&q=75&fmt=auto&maxorilen2heic=2000000?sec=1744995600&t=ebeb98094194a4c0ebf5b94db76659bc" alt="东南新闻" width="30px" height="30px">
                    <h1>[邮箱验证码]</h1>
                </div>
                <p>尊敬的用户，您好！</p>
                <p>您正在进行邮箱验证，您的验证码是：</p>

                <input type="checkbox" id="showCode">
                <label for="showCode" class="btn">点击查看验证码</label>
                <p class="code">${code}</p>

                <p>该验证码有效期为 5 分钟，请尽快完成验证。</p>
                <p class="signature">东南新闻项目组</p>
                <p class="tip">请勿回复此邮件</p>
            </div>
        </td>
    </tr>
    </tbody>
</table>
</body>

</html>