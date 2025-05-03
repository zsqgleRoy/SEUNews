<template>
  <div class="main">
    <!-- 悬浮标题容器 -->
    <div class="sticky-header">
      <BackButton />
      <div class="title-section">
        <h1>关于我们</h1>
        <svglogo class="header-logo"></svglogo>
      </div>
    </div>

    <div class="about-us-container">
      <!-- 内容部分 -->
      <div class="content-section">
        <p>
          东南新闻网是一家专注于提供高质量新闻资讯的综合性新闻网站。我们致力于为广大用户提供及时、准确、客观的新闻报道，涵盖政治、经济、文化、科技、娱乐等多个领域。
        </p>
        <p>
          自成立以来，我们始终坚持以用户为中心，不断提升服务质量和内容水平。通过与众多权威媒体和机构的合作，我们汇聚了丰富的新闻资源，为用户打造了一个全方位、多层次的新闻信息平台。
        </p>
        <p>
          我们的团队由一群经验丰富、充满激情的新闻工作者组成，他们秉持着专业、敬业、创新的精神，为每一篇新闻报道付出辛勤的努力。我们相信，只有通过不断的努力和创新，才能为用户带来更好的新闻体验。
        </p>
        <p>
          在未来的发展中，东南新闻网将继续秉承“传播正能量，服务大众”的宗旨，不断拓展业务领域，提升品牌影响力，为推动新闻事业的发展做出更大的贡献。
        </p>
      </div>

      <!-- 联系我们部分 -->
      <div class="contact-section">
        <h2>联系我们</h2>
        <p>如果您有任何问题、建议或合作意向，请随时联系我们：</p>
        <ul>
          <li>
            <svg class="contact-svg" viewBox="0 0 24 24">
              <path
                fill="currentColor"
                d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H4V8l8 5 8-5v10z"
              />
            </svg>
            <span>邮箱：info@dongnannews.com</span>
          </li>
          <li>
            <svg class="contact-svg" viewBox="0 0 24 24">
              <path
                fill="currentColor"
                d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H6l-2 2V4h16v12z"
              />
            </svg>
            <span>电话：010 - 12345678</span>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import svglogo from '@/components/common/svglogo.vue';
import { useRouter } from 'vue-router';
import BackButton from '@/components/common/BackButton.vue';
const router = useRouter();

</script>

<style scoped lang="scss">
.main{
  width: 100vw;
}
.sticky-header {
  position: sticky;
  width: 100vw;
  top: 0;
  z-index: 100;
  background: linear-gradient(145deg, #ffffff, #f8f9fa);
  box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;

  .title-section {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 1rem 0;
    max-width: 100vw;
    margin: 0 auto;

    h1 {
      font-size: clamp(1.5rem, 4vw, 2.5rem);
      margin-right: 1.5rem;
      color: #2c3e50;
      font-weight: 600;
      letter-spacing: -0.05em;
      transition: font-size 0.3s ease;
    }

    .header-logo {
      height: clamp(30px, 4vw, 50px);
      color: #007bff;
      transition: all 0.3s ease;
      filter: drop-shadow(0 2px 4px rgba(0,123,255,0.2));
    }
  }

  @media (max-width: 768px) {
    padding: 0 5rem;
    
    .title-section {
      justify-content: flex-start;
      padding: 0.8rem 0;
      
      h1 {
        margin-right: 1rem;
      }
    }
  }
}

.about-us-container {
  font-family: system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
  padding: 2rem clamp(1rem, 5vw, 4rem);
  max-width: 100vw;
  margin: 0 auto;

  .content-section {
    line-height: 1.7;
    font-size: clamp(1rem, 1.1vw, 1.1rem);
    color: #4a5568;

    p {
      text-indent: 2em;
      margin-bottom: 1.5rem;
      &:last-child {
        margin-bottom: 0;
      }
    }
  }

  .contact-section {
    background: rgba(241, 245, 249, 0.6);
    border-radius: 12px;
    padding: 2rem;
    margin-top: 2rem;

    h2 {
      font-size: clamp(1.3rem, 2vw, 1.8rem);
      color: #2c3e50;
      margin-bottom: 1.5rem;
      position: relative;
      padding-left: 1.5rem;

      &::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 6px;
        height: 70%;
        background: #007bff;
        border-radius: 3px;
      }
    }

    ul {
      li {
        display: flex;
        align-items: center;
        padding: 0.8rem 1rem;
        background: white;
        border-radius: 8px;
        margin-bottom: 1rem;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        transition: transform 0.2s ease;

        &:hover {
          transform: translateX(10px);
        }

        .contact-svg {
          width: 1.5rem;
          height: 1.5rem;
          margin-right: 1rem;
          flex-shrink: 0;
        }

        span {
          font-size: clamp(0.9rem, 1.1vw, 1.05rem);
          color: #4a5568;
        }
      }
    }
  }

  @media (max-width: 768px) {
    .content-section {
      font-size: 1rem;
    }

    .contact-section {
      padding: 1.5rem;
      
      ul li {
        padding: 0.7rem;
      }
    }
  }
}
</style>