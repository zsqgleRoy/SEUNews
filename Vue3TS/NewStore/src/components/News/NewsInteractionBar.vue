<template>
    <div class="cyber-interaction">
      <!-- 互动图标组 -->
      <div class="icon-group">
        <div 
          v-for="(btn, index) in cyberButtons" 
          :key="index" 
          :class="btn.activeClass" 
          @click="btn.action"
          class="interaction-item"
        >
          <span class="icon-frame">
            <!-- 统一图标处理 -->
            <img
              v-if="isImageIcon(btn.icon)"
              :src="btn.icon"
              :alt="btn.text"
              class="neon-icon"
            />
            <component
              v-else
              :is="btn.icon"
              class="neon-icon"
            />
          </span>
          <!-- 带缓存的数字显示 -->
          <span class="data-display">
            {{ formattedData[btn.dataKey] }}
          </span>
        </div>
      </div>
    </div>
</template>
  
<script setup lang="ts">
  import { ref, computed, type Component, onMounted } from 'vue'
  import { Coin, Star, MoreFilled } from '@element-plus/icons-vue'
  import likeImage from '@/assets/imges/like.png'
  import shareImage from '@/assets/imges/share.png'
  import { useArticleLikeService } from '@/api/articleLikeService'
  import { useArticleCoinService } from '@/api/articleCoinService'
  import { useArticleFavoriteService } from '@/api/articleFavoriteService'
  import { useArticleShareService } from '@/api/articleShareService'
import userCache from '@/cache/userCache'
import { ElMessage } from 'element-plus'

  // 类型定义
  type InteractionType = 'likes' | 'coins' | 'star' | 'forwards'
  type IconType = string | Component
  
  interface InteractionButton {
    icon: IconType
    text: string
    dataKey: InteractionType | 'more'
    action: () => void
    activeClass: string
  }
  
  interface InteractionState {
    count: number
    active: boolean
  }
  
  const props = defineProps<{
    article_id: number;
  }>();

  const likeService = useArticleLikeService()
  const coinService = useArticleCoinService()
  const favoriteService = useArticleFavoriteService()
  const shareService = useArticleShareService()

  // 响应式数据
  const interactionState = ref<Record<InteractionType, InteractionState>>({
    likes: { count: 20, active: false },
    coins: { count: 999999999, active: false },
    star: { count: 999999999, active: false },
    forwards: { count: 202999999, active: false }
  })
  
  // 格式化后的数据（自动更新）
  const formattedData = computed(() => ({
    likes: formatNumber(interactionState.value.likes.count),
    coins: formatNumber(interactionState.value.coins.count),
    star: formatNumber(interactionState.value.star.count),
    forwards: formatNumber(interactionState.value.forwards.count),
    more: '' // Fallback for "more" key
  }))
  
  // 图标类型检查
  const isImageIcon = (icon: IconType): icon is string => {
    return typeof icon === 'string'
  }
  

  const loadLikes = async () => {
    try {
        const count = await likeService.getLikeNumByArticleId(props.article_id) || 0
            interactionState.value.likes = {
            count,
            active: await likeService.isCurrentUserLiked(props.article_id)
        }
    } catch (error) {
        console.error('加载点赞数据失败:', error)
    }
    }

    const loadCoins = async () => {
    try {
        const count = await coinService.getTotalCoinsForArticle(props.article_id)
        interactionState.value.coins.count = count
    } catch (error) {
        console.error('加载投币数据失败:', error)
    }
    }

    const loadFavorites = async () => {
        try {
            const count = await favoriteService.getTotalFavoritesForArticle(props.article_id)
            interactionState.value.star = {
                count,
                active: await favoriteService.isCurrentUserFavorited(props.article_id)
            }
        } catch (error) {
            console.error('加载收藏数据失败:', error)
        }
    }
    const loadShare = async () => {
        try {
            const count = await shareService.getShareNumByArticleId(props.article_id) || 0
            interactionState.value.forwards = {
                count,
                active: await favoriteService.isCurrentUserFavorited(props.article_id)
            }
        } catch (error) {
            console.error('加载收藏数据失败:', error)
        }
    }


  // 优化的数字格式化
  const formatNumber = (num: number): string => {
    const formatWithUnit = (value: number, divisor: number, unit: string) => {
        // 判断是否刚好是单位的整数倍
        const isExact = num % divisor === 0
        
        // 当数值是整数倍时直接显示单位
        if (isExact) {
            return `${value}${unit}`
        }
        
        // 计算截断到十分位的值
        const truncated = Math.floor((num / divisor) * 10) / 10
        
        // 处理小数点后的零
        return `${truncated.toFixed(1)}${unit}`
    }

    if (num >= 1e9) return formatWithUnit(num / 1e9, 1e9, 'B')
    if (num >= 1e6) return formatWithUnit(num / 1e6, 1e6, 'M')
    if (num >= 1e3) return formatWithUnit(num / 1e3, 1e3, 'K')
    return num.toString()
 }
  
  // 统一交互处理方法
  const handleInteraction = (type: InteractionType) => {
    const state = interactionState.value[type]
    if (!userCache.getUserCache() && type !== 'forwards'){
        ElMessage.warning('请您先登录')
        return
    }
    switch(type) {
      case 'likes':
        state.active = !state.active
        state.count += state.active ? 1 : -1
        break
      case 'coins':
        state.count += state.active ? -1 : 1
        state.active = !state.active
        break
      case 'star':
        state.count += state.active ? -2 : 2
        state.active = !state.active
        break
      case 'forwards':
        state.count += 1
        break
    }
  }
  
  onMounted(async () => {
    await Promise.all([
      loadLikes(),
      loadCoins(),
      loadFavorites(),
      loadShare(),
      // loadForwards()
    ])
  })

  // 按钮配置
  const cyberButtons = computed<InteractionButton[]>(() => [
    {
      icon: likeImage,
      text: '量子点赞赋能',
      dataKey: 'likes',
      action: () => handleInteraction('likes'),
      activeClass: interactionState.value.likes.active ? 'pulse-active' : ''
    },
    {
      icon: Coin,
      text: '能量币投送',
      dataKey: 'coins',
      action: () => handleInteraction('coins'),
      activeClass: interactionState.value.coins.active ? 'coin-active' : ''
    },
    {
      icon: Star,
      text: interactionState.value.star.active ? '数据已归档' : '核心数据收藏',
      dataKey: 'star',
      action: () => handleInteraction('star'),
      activeClass: interactionState.value.star.active ? 'storage-active' : ''
    },
    {
      icon: shareImage,
      text: '超维信息转发',
      dataKey: 'forwards',
      action: () => handleInteraction('forwards'),
      activeClass: 'forward-active'
    },
    {
      icon: MoreFilled,
      text: '上报问题',
      dataKey: 'more',
      action: () => console.log('启动自检程序'),
      activeClass: 'diagnose-active'
    }
  ])
</script>
  
<style scoped lang="scss">
  /* 变量定义 */
  $cyber-purple: #000000;
  $cyber-yellow: #ffff00;
  $mobile-breakpoint: 768px;
  
  .cyber-interaction {
    margin: 30px auto;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 10px;
    max-width: 100vw;
  }
  
  .icon-group {
    display: flex;
    gap: 2rem;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .interaction-item {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    flex-direction: row;
    gap: 0.5rem;
    padding: 0;
    border-radius: 8px;
    transition: all 0.3s ease;
    position: relative;
    width: clamp(100px, 15vw, 150px);
    min-width: 115px;
    box-sizing: border-box;
    cursor: pointer;
    
    &:hover {
      filter: brightness(1.2);
    }
  }
  
  .icon-frame {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 2.5rem;
    height: 2.5rem;
    position: relative;
    
    &::after {
      content: '';
      position: absolute;
      inset: -2px;
      border: 1px solid $cyber-yellow;
      border-radius: 50%;
      opacity: 0;
      transition: opacity 0.3s ease;
    }
    
    &:hover::after {
      opacity: 0.6;
    }
  }
  
  .neon-icon {
    width: 1.8em;
    height: 1.8em;
    object-fit: contain;
    vertical-align: middle;
    color: $cyber-purple;
    transition: transform 0.3s ease;
    
    path {
      fill: currentColor;
    }
  }
  
  .data-display {
    font-family: 'Courier New', monospace;
    font-size: 1.2em;
    color: $cyber-purple;
    line-height: 1;
    min-width: 3em;
    text-align: center;
  }
  
  @keyframes pulse-glow {
    0%, 100% { transform: scale(1) }
    50% { transform: scale(1.15) }
  }
  
  @keyframes shake {
    0% { transform: rotate(0deg); }
    25% { transform: rotate(5deg); }
    50% { transform: rotate(0deg); }
    75% { transform: rotate(-5deg); }
    100% { transform: rotate(0deg); }
  }
  
  @media (max-width: $mobile-breakpoint) {
    .icon-group {
      gap: 0.5rem;
    }
  
    .interaction-item {
      flex-direction: column;
      width: 80px;
      min-width: auto;
      padding: 0.2rem;
      gap: 0.2rem;
    }
  
    .icon-frame {
      width: 2rem;
      height: 2rem;
    }
  
    .data-display {
      font-size: 0.75rem;
    }
  }
</style>