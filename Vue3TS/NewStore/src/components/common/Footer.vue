<template>
  <footer id="footer0820">
      <!-- 页脚头部 -->
      <div class="footer-header">
        <div class="footer-logo">
          <svg-logo class="svglogo"/>
        </div>
        <div class="footer-title">东南新闻网</div>
      </div>
      <div class="footer-container">
          <!-- 链接区域 -->
          <div class="link-columns">
              <div class="link-column">
                  <h3>新闻媒体</h3>
                  <ul>
                      <li><a href="http://www.people.com.cn/" target="_blank">人民网</a></li>
                      <li><a href="http://www.xinhuanet.com/" target="_blank">新华网</a></li>
                      <li><a href="http://www.china.com.cn/" target="_blank">中国网</a></li>
                      <li><a href="http://www.cri.cn/" target="_blank">国际在线</a></li>
                      <li><a href="http://www.chinadaily.com.cn/" target="_blank">中国日报网</a></li>
                      <li><a href="http://www.haiwainet.cn/" target="_blank">海外网</a></li>
                  </ul>
              </div>
              <div class="link-column">
                  <h3>综合资讯</h3>
                  <ul>
                      <li><a href="https://www.cctv.com/" target="_blank">央视网</a></li>
                      <li><a href="http://www.youth.cn/" target="_blank">中国青年网</a></li>
                      <li><a href="http://www.ce.cn/" target="_blank">中国经济网</a></li>
                      <li><a href="http://www.taiwan.cn/" target="_blank">中国台湾网</a></li>
                      <li><a href="http://www.tibet.cn/" target="_blank">中国西藏网</a></li>
                  </ul>
              </div>
              <div class="link-column">
                  <h3>其他媒体</h3>
                  <ul>
                      <li><a href="https://www.gmw.cn/" target="_blank">光明网</a></li>
                      <li><a href="http://www.chinanews.com/" target="_blank">中国新闻网</a></li>
                      <li><a href="http://www.cyol.com/" target="_blank">中青在线</a></li>
                      <li><a href="http://www.81.cn/" target="_blank">中国军网</a></li>
                      <li><a href="http://www.legaldaily.com.cn/" target="_blank">法治网</a></li>
                  </ul>
              </div>
          </div>
          <!-- 信息区域 -->
          <div class="info-column">
              <h3>相关信息</h3>
              <ul>
                  <li>违法和不良信息举报电话：010 - 56807188</li>
                  <li><a href="http://www.12377.cn" target="_blank">网上有害信息举报</a></li>
                  <li>新闻热线：400 - 000 - 0000（虚拟）</li>
                  <li><a href="https://www.piyao.org.cn" target="_blank">中国互联网联合辟谣平台</a></li>
                  <li>互联网新闻信息服务许可证 10120210001</li>
                  <li>电子邮箱：zsqgle@seu.edu.com</li>
                  <li>
                      <a href="https://beian.miit.gov.cn" target="_blank">京ICP备2021013708号</a>
                      <a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010602007741" target="_blank">京公网安备11010602007741</a>
                  </li>
                  <li>东南新闻广播电视总台 东广网</li>
                  <li>东南新闻网开发小组&nbsp;&nbsp;版权所有</li>
              </ul>
              <div class="other">
                  <span>
                      <a href="http://bszs.conac.cn/" target="_blank">
                          <img src="https://dcs.conac.cn/image/blue.png" alt="" height="45px">
                      </a>
                      <a href="https://beian.mps.gov.cn/#/query/webSearch" target="_blank">
                          <img src="//www.cnr.cn/2021/images/beian.png" alt="" height="45px">
                      </a>
                      <a href="http://bszs.conac.cn/" target="_blank">
                          <img src="@/assets/imges/dzjg.png" alt="" height="45px">
                      </a>
                  </span>
              </div>
          </div>
          <!-- 合作机构区域 -->
          <div class="link-column">
              <h3>合作机构</h3>
              <ul>
                  <li>
                      <a href="https://www.seu.edu.cn/" target="_blank">
                          <img src="@/assets/imges/seu.png" alt="cnr cxxy logo" height="32">
                          <span>东南大学</span>
                      </a>
                  </li>
                  <li>
                      <a href="http://cxxy.seu.edu.cn/" target="_blank">
                          <img src="@/assets/imges/seu.png" alt="cxxy logo" height="32">
                          <span class="yunting">成贤学院</span>
                      </a>
                  </li>
                  <li>
                      <a href="http://www.moe.gov.cn/" target="_blank">
                          <img src="http://www.moe.gov.cn/images/red.png" alt="EDU logo" height="34">
                          <span>中国教育</span>
                      </a>
                  </li>
                  <li>
                      <a href="https://www.cmgadx.com/" target="_blank">
                          <img src="//www.cnr.cn/2021/images/xwgg.png?v=1" alt="xwgg logo">
                          <span>象舞广告</span>
                      </a>
                  </li>
              </ul>
          </div>
      </div>
      <!-- 新增隐私协议、服务条款、用书手册链接 -->
      <div class="footer-links">
        <router-link :to="`/news/${newsId + 0}`">隐私协议</router-link>
        <span>|</span>
        <router-link :to="`/news/${newsId + 1}`">服务条款</router-link>
        <span>|</span>
        <router-link :to="`/news/${newsId + 2}`">用书手册</router-link>
      </div>
      <!-- 底部版权信息 -->
      <div class="footer-bottom">
          <p>Copyright &copy; 2025 东南新闻网开发小组 版权所有</p>
      </div>
      <div class="horizontal-line">
          <span>这是我的底线</span>
      </div>
  </footer>
</template>

<script setup lang="ts">
  import { ref } from 'vue';
  import svgLogo from "@/components/common/svglogo.vue"
  const newsId = ref(14)
</script>

<style scoped lang="scss">
/* 整体页脚样式 */
#footer0820 {
  user-select: none;
  background: linear-gradient(135deg, #174fa9, #6b00bc);
  color: #fff;
  padding: 40px 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* 页脚头部样式 */
.footer-header {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30px;
}

.footer-logo {
  margin-right: 15px;
}

.svglogo{
  height: clamp(30px, 4vw, 50px);
  color: #007bff;
  transition: all 0.3s ease;
  filter: drop-shadow(0 2px 4px rgba(0,123,255,0.2));
}

.footer-title {
  font-size: 24px;
  font-weight: bold;
  color: #ffd700;
}

/* 页脚容器 */
.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 30px;
}

/* 链接列样式 */
.link-column h3 {
  color: #ffd700;
  margin-bottom: 20px;
  font-size: 18px;
  text-transform: uppercase;
  border-bottom: 1px solid #ffffff;
  padding-bottom: 10px;
}

.link-column ul {
  list-style: none;
  padding: 0;
}

.link-column ul li {
  margin-bottom: 15px;
}

.link-column ul li a {
  color: #fff;
  text-decoration: none;
  transition: color 0.3s ease;
  display: inline-flex;
  align-items: center;
  position: relative;
  padding-left: 20px;
}
.link-column ul li a img {
  margin-right: 5px;
}

.link-column ul li a::before {
  content: '>';
  position: absolute;
  left: 0;
  color: #ffd700;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.link-column ul li a:hover {
  color: #ffd700;
  background-color: rgba(21, 215, 105, 0.5);
}

.link-column ul li a:hover::before {
  opacity: 1;
}

/* 信息列样式 */
.info-column h3 {
  color: #ffd700;
  margin-bottom: 20px;
  font-size: 18px;
  text-transform: uppercase;
  border-bottom: 1px solid #ffffff;
  padding-bottom: 10px;
}

.info-column ul {
  list-style: none;
  padding: 0;
}

.info-column ul li {
  margin-bottom: 15px;
}

.info-column ul li a {
  color: #fff;
  text-decoration: none;
  transition: color 0.3s ease;
  position: relative;
  padding-left: 20px;
}

.info-column ul li a::before {
  content: '>';
  position: absolute;
  left: 0;
  color: #ffd700;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.info-column ul li a:hover {
  color: #ffd700;
  background-color: rgba(21, 215, 105, 0.5);
}

.info-column ul li a:hover::before {
  opacity: 1;
}

.info-column ul li a span {
  padding-left: 5px;
}

/* 其他信息样式 */
.other {
  margin-top: 20px;
  display: flex;
  align-items: center;
}

.other img {
  margin-right: 10px;
}

/* 底部版权信息样式 */
.footer-bottom {
  text-align: center;
  padding: 15px 0;
  margin-top: 40px;
  border-top: 1px solid #ffffff;
}

.footer-bottom p {
  margin: 0;
  font-size: 14px;
}

/* 小屏幕适配 */
@media (max-width: 768px) {
  .footer-container {
      grid-template-columns: 1fr;
      text-align: center;
  }

  .link-column ul li a,
  .info-column ul li a {
      padding-left: 0;
  }

  .link-column ul li a::before,
  .info-column ul li a::before {
      display: none;
  }

  .other {
      justify-content: center;
  }
}

/* 新增贯穿线样式 */
.horizontal-line {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 100% 0 0 0;
}

.horizontal-line::before,
.horizontal-line::after {
  content: "";
  flex-grow: 1;
  height: 1px;
  background-color: #fff;
  margin: 0 5px;
}

.horizontal-line span {
  color: #fff;
  font-size: 14px;
  padding: 0 10px;
}

/* 小屏幕适配 */
@media (max-width: 768px) {
  .horizontal-line {
      margin: 999px 0 30px 0;
  }

  .horizontal-line::before,
  .horizontal-line::after {
      margin: 0 10px;
  }

  .horizontal-line span {
      font-size: 13px;
      padding: 0 8px;
  }
}

/* 新增隐私协议、服务条款、用书手册链接样式 */
.footer-links {
  text-align: center;
  margin-top: 20px;
}

.footer-links a {
  color: #fff;
  text-decoration: none;
  margin: 0 10px;
  transition: color 0.3s ease;
}

.footer-links a:hover {
  color: #ffd700;
}

.footer-links span {
  color: #fff;
}
</style>    