// particles.ts
export function initParticles(selector: string) {
  const canvas = document.querySelector(selector) as HTMLCanvasElement
  const ctx = canvas.getContext('2d')!

  // 使用固定定位避免布局干扰
  canvas.style.position = 'fixed'
  canvas.style.top = '0'
  canvas.style.left = '0'
  canvas.style.width = '100vw'
  canvas.style.height = '100vh'
  canvas.style.pointerEvents = 'none'

  let animationFrameId: number
  let resizeTimer: number

  const updateSize = () => {
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
  }

  const particles: Particle[] = []
  const particleCount = 100

  class Particle {
    x: number
    y: number
    size: number
    speedX: number
    speedY: number

    constructor() {
      this.x = Math.random() * canvas.width
      this.y = Math.random() * canvas.height
      this.size = Math.random() * 2 + 1
      this.speedX = Math.random() * 3 - 1.5
      this.speedY = Math.random() * 3 - 1.5
    }

    update() {
      this.x += this.speedX
      this.y += this.speedY

      if (this.x > canvas.width) this.x = 0
      if (this.x < 0) this.x = canvas.width
      if (this.y > canvas.height) this.y = 0
      if (this.y < 0) this.y = canvas.height
    }

    draw() {
      ctx.fillStyle = 'rgba(255, 255, 255, 0.8)'
      ctx.beginPath()
      ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  function animate() {
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    
    particles.forEach(particle => {
      particle.update()
      particle.draw()
    })
    
    animationFrameId = requestAnimationFrame(animate)
  }

  function handleResize() {
    clearTimeout(resizeTimer)
    resizeTimer = window.setTimeout(updateSize, 200)
  }

  // 初始化
  updateSize()
  window.addEventListener('resize', handleResize)

  for (let i = 0; i < particleCount; i++) {
    particles.push(new Particle())
  }

  animate()

  // 返回清理函数
  return () => {
    window.removeEventListener('resize', handleResize)
    cancelAnimationFrame(animationFrameId)
  }
}