
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  for(i = 1; i < argc; i++)
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 56                	jle    6d <main+0x6d>
  17:	bb 01 00 00 00       	mov    $0x1,%ebx
  1c:	eb 26                	jmp    44 <main+0x44>
  1e:	66 90                	xchg   %ax,%ax
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  20:	c7 44 24 0c 8e 06 00 	movl   $0x68e,0xc(%esp)
  27:	00 
  28:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  2c:	89 44 24 08          	mov    %eax,0x8(%esp)
  30:	c7 44 24 04 90 06 00 	movl   $0x690,0x4(%esp)
  37:	00 
  38:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3f:	e8 24 03 00 00       	call   368 <printf>
  44:	43                   	inc    %ebx
  45:	39 f3                	cmp    %esi,%ebx
  47:	75 d7                	jne    20 <main+0x20>
  49:	c7 44 24 0c 95 06 00 	movl   $0x695,0xc(%esp)
  50:	00 
  51:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  55:	89 44 24 08          	mov    %eax,0x8(%esp)
  59:	c7 44 24 04 90 06 00 	movl   $0x690,0x4(%esp)
  60:	00 
  61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  68:	e8 fb 02 00 00       	call   368 <printf>
  exit();
  6d:	e8 c2 01 00 00       	call   234 <exit>
  72:	66 90                	xchg   %ax,%ax

00000074 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	53                   	push   %ebx
  78:	8b 45 08             	mov    0x8(%ebp),%eax
  7b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7e:	89 c2                	mov    %eax,%edx
  80:	42                   	inc    %edx
  81:	41                   	inc    %ecx
  82:	8a 59 ff             	mov    -0x1(%ecx),%bl
  85:	88 5a ff             	mov    %bl,-0x1(%edx)
  88:	84 db                	test   %bl,%bl
  8a:	75 f4                	jne    80 <strcpy+0xc>
    ;
  return os;
}
  8c:	5b                   	pop    %ebx
  8d:	5d                   	pop    %ebp
  8e:	c3                   	ret    
  8f:	90                   	nop

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	74 27                	je     c8 <strcmp+0x38>
  a1:	8a 19                	mov    (%ecx),%bl
  a3:	38 d8                	cmp    %bl,%al
  a5:	74 0b                	je     b2 <strcmp+0x22>
  a7:	eb 26                	jmp    cf <strcmp+0x3f>
  a9:	8d 76 00             	lea    0x0(%esi),%esi
  ac:	38 c8                	cmp    %cl,%al
  ae:	75 13                	jne    c3 <strcmp+0x33>
    p++, q++;
  b0:	89 d9                	mov    %ebx,%ecx
  b2:	42                   	inc    %edx
  b3:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b6:	0f b6 02             	movzbl (%edx),%eax
  b9:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  bd:	84 c0                	test   %al,%al
  bf:	75 eb                	jne    ac <strcmp+0x1c>
  c1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c3:	29 c8                	sub    %ecx,%eax
}
  c5:	5b                   	pop    %ebx
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    
  c8:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  cb:	31 c0                	xor    %eax,%eax
  cd:	eb f4                	jmp    c3 <strcmp+0x33>
  cf:	0f b6 cb             	movzbl %bl,%ecx
  d2:	eb ef                	jmp    c3 <strcmp+0x33>

000000d4 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  da:	80 39 00             	cmpb   $0x0,(%ecx)
  dd:	74 10                	je     ef <strlen+0x1b>
  df:	31 d2                	xor    %edx,%edx
  e1:	8d 76 00             	lea    0x0(%esi),%esi
  e4:	42                   	inc    %edx
  e5:	89 d0                	mov    %edx,%eax
  e7:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  eb:	75 f7                	jne    e4 <strlen+0x10>
    ;
  return n;
}
  ed:	5d                   	pop    %ebp
  ee:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  ef:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	90                   	nop

000000f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	57                   	push   %edi
  f8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  fb:	89 d7                	mov    %edx,%edi
  fd:	8b 4d 10             	mov    0x10(%ebp),%ecx
 100:	8b 45 0c             	mov    0xc(%ebp),%eax
 103:	fc                   	cld    
 104:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 106:	89 d0                	mov    %edx,%eax
 108:	5f                   	pop    %edi
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	90                   	nop

0000010c <strchr>:

char*
strchr(const char *s, char c)
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	53                   	push   %ebx
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 116:	8a 10                	mov    (%eax),%dl
 118:	84 d2                	test   %dl,%dl
 11a:	74 13                	je     12f <strchr+0x23>
 11c:	88 d9                	mov    %bl,%cl
    if(*s == c)
 11e:	38 da                	cmp    %bl,%dl
 120:	75 06                	jne    128 <strchr+0x1c>
 122:	eb 0d                	jmp    131 <strchr+0x25>
 124:	38 ca                	cmp    %cl,%dl
 126:	74 09                	je     131 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 128:	40                   	inc    %eax
 129:	8a 10                	mov    (%eax),%dl
 12b:	84 d2                	test   %dl,%dl
 12d:	75 f5                	jne    124 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 12f:	31 c0                	xor    %eax,%eax
}
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    

00000134 <gets>:

char*
gets(char *buf, int max)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	57                   	push   %edi
 138:	56                   	push   %esi
 139:	53                   	push   %ebx
 13a:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13d:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 13f:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 142:	eb 30                	jmp    174 <gets+0x40>
    cc = read(0, &c, 1);
 144:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 14b:	00 
 14c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 150:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 157:	e8 f0 00 00 00       	call   24c <read>
    if(cc < 1)
 15c:	85 c0                	test   %eax,%eax
 15e:	7e 1c                	jle    17c <gets+0x48>
      break;
    buf[i++] = c;
 160:	8a 45 e7             	mov    -0x19(%ebp),%al
 163:	8b 55 08             	mov    0x8(%ebp),%edx
 166:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16a:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16c:	3c 0a                	cmp    $0xa,%al
 16e:	74 0c                	je     17c <gets+0x48>
 170:	3c 0d                	cmp    $0xd,%al
 172:	74 08                	je     17c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	8d 5e 01             	lea    0x1(%esi),%ebx
 177:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 17a:	7c c8                	jl     144 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 183:	83 c4 2c             	add    $0x2c,%esp
 186:	5b                   	pop    %ebx
 187:	5e                   	pop    %esi
 188:	5f                   	pop    %edi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	90                   	nop

0000018c <stat>:

int
stat(char *n, struct stat *st)
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	56                   	push   %esi
 190:	53                   	push   %ebx
 191:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 19b:	00 
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	89 04 24             	mov    %eax,(%esp)
 1a2:	e8 cd 00 00 00       	call   274 <open>
 1a7:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1a9:	85 c0                	test   %eax,%eax
 1ab:	78 23                	js     1d0 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b4:	89 1c 24             	mov    %ebx,(%esp)
 1b7:	e8 d0 00 00 00       	call   28c <fstat>
 1bc:	89 c6                	mov    %eax,%esi
  close(fd);
 1be:	89 1c 24             	mov    %ebx,(%esp)
 1c1:	e8 96 00 00 00       	call   25c <close>
  return r;
 1c6:	89 f0                	mov    %esi,%eax
}
 1c8:	83 c4 10             	add    $0x10,%esp
 1cb:	5b                   	pop    %ebx
 1cc:	5e                   	pop    %esi
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d5:	eb f1                	jmp    1c8 <stat+0x3c>
 1d7:	90                   	nop

000001d8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	53                   	push   %ebx
 1dc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1df:	0f be 11             	movsbl (%ecx),%edx
 1e2:	8d 42 d0             	lea    -0x30(%edx),%eax
 1e5:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 1e7:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1ec:	77 15                	ja     203 <atoi+0x2b>
 1ee:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1f0:	41                   	inc    %ecx
 1f1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1f4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f8:	0f be 11             	movsbl (%ecx),%edx
 1fb:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1fe:	80 fb 09             	cmp    $0x9,%bl
 201:	76 ed                	jbe    1f0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 203:	5b                   	pop    %ebx
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    
 206:	66 90                	xchg   %ax,%ax

00000208 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
 20b:	56                   	push   %esi
 20c:	53                   	push   %ebx
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 213:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 216:	31 d2                	xor    %edx,%edx
 218:	85 f6                	test   %esi,%esi
 21a:	7e 0b                	jle    227 <memmove+0x1f>
    *dst++ = *src++;
 21c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 21f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 222:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 223:	39 f2                	cmp    %esi,%edx
 225:	75 f5                	jne    21c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 227:	5b                   	pop    %ebx
 228:	5e                   	pop    %esi
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    
 22b:	90                   	nop

0000022c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 22c:	b8 01 00 00 00       	mov    $0x1,%eax
 231:	cd 40                	int    $0x40
 233:	c3                   	ret    

00000234 <exit>:
SYSCALL(exit)
 234:	b8 02 00 00 00       	mov    $0x2,%eax
 239:	cd 40                	int    $0x40
 23b:	c3                   	ret    

0000023c <wait>:
SYSCALL(wait)
 23c:	b8 03 00 00 00       	mov    $0x3,%eax
 241:	cd 40                	int    $0x40
 243:	c3                   	ret    

00000244 <pipe>:
SYSCALL(pipe)
 244:	b8 04 00 00 00       	mov    $0x4,%eax
 249:	cd 40                	int    $0x40
 24b:	c3                   	ret    

0000024c <read>:
SYSCALL(read)
 24c:	b8 05 00 00 00       	mov    $0x5,%eax
 251:	cd 40                	int    $0x40
 253:	c3                   	ret    

00000254 <write>:
SYSCALL(write)
 254:	b8 10 00 00 00       	mov    $0x10,%eax
 259:	cd 40                	int    $0x40
 25b:	c3                   	ret    

0000025c <close>:
SYSCALL(close)
 25c:	b8 15 00 00 00       	mov    $0x15,%eax
 261:	cd 40                	int    $0x40
 263:	c3                   	ret    

00000264 <kill>:
SYSCALL(kill)
 264:	b8 06 00 00 00       	mov    $0x6,%eax
 269:	cd 40                	int    $0x40
 26b:	c3                   	ret    

0000026c <exec>:
SYSCALL(exec)
 26c:	b8 07 00 00 00       	mov    $0x7,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <open>:
SYSCALL(open)
 274:	b8 0f 00 00 00       	mov    $0xf,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <mknod>:
SYSCALL(mknod)
 27c:	b8 11 00 00 00       	mov    $0x11,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <unlink>:
SYSCALL(unlink)
 284:	b8 12 00 00 00       	mov    $0x12,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <fstat>:
SYSCALL(fstat)
 28c:	b8 08 00 00 00       	mov    $0x8,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <link>:
SYSCALL(link)
 294:	b8 13 00 00 00       	mov    $0x13,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <mkdir>:
SYSCALL(mkdir)
 29c:	b8 14 00 00 00       	mov    $0x14,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <chdir>:
SYSCALL(chdir)
 2a4:	b8 09 00 00 00       	mov    $0x9,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <dup>:
SYSCALL(dup)
 2ac:	b8 0a 00 00 00       	mov    $0xa,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <getpid>:
SYSCALL(getpid)
 2b4:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <sbrk>:
SYSCALL(sbrk)
 2bc:	b8 0c 00 00 00       	mov    $0xc,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <sleep>:
SYSCALL(sleep)
 2c4:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <uptime>:
SYSCALL(uptime)
 2cc:	b8 0e 00 00 00       	mov    $0xe,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	57                   	push   %edi
 2d8:	56                   	push   %esi
 2d9:	53                   	push   %ebx
 2da:	83 ec 4c             	sub    $0x4c,%esp
 2dd:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2df:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2e4:	85 db                	test   %ebx,%ebx
 2e6:	74 04                	je     2ec <printint+0x18>
 2e8:	85 d2                	test   %edx,%edx
 2ea:	78 70                	js     35c <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2ec:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2f3:	31 ff                	xor    %edi,%edi
 2f5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2f8:	89 75 c0             	mov    %esi,-0x40(%ebp)
 2fb:	89 ce                	mov    %ecx,%esi
 2fd:	eb 03                	jmp    302 <printint+0x2e>
 2ff:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 300:	89 cf                	mov    %ecx,%edi
 302:	8d 4f 01             	lea    0x1(%edi),%ecx
 305:	31 d2                	xor    %edx,%edx
 307:	f7 f6                	div    %esi
 309:	8a 92 9e 06 00 00    	mov    0x69e(%edx),%dl
 30f:	88 55 c7             	mov    %dl,-0x39(%ebp)
 312:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 315:	85 c0                	test   %eax,%eax
 317:	75 e7                	jne    300 <printint+0x2c>
 319:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 31c:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 31e:	8b 55 bc             	mov    -0x44(%ebp),%edx
 321:	85 d2                	test   %edx,%edx
 323:	74 08                	je     32d <printint+0x59>
    buf[i++] = '-';
 325:	8d 4f 02             	lea    0x2(%edi),%ecx
 328:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 32d:	8d 79 ff             	lea    -0x1(%ecx),%edi
 330:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 334:	88 45 c7             	mov    %al,-0x39(%ebp)
 337:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 33a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 341:	00 
 342:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 346:	89 34 24             	mov    %esi,(%esp)
 349:	e8 06 ff ff ff       	call   254 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 34e:	4f                   	dec    %edi
 34f:	83 ff ff             	cmp    $0xffffffff,%edi
 352:	75 dc                	jne    330 <printint+0x5c>
    putc(fd, buf[i]);
}
 354:	83 c4 4c             	add    $0x4c,%esp
 357:	5b                   	pop    %ebx
 358:	5e                   	pop    %esi
 359:	5f                   	pop    %edi
 35a:	5d                   	pop    %ebp
 35b:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 35c:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 35e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 365:	eb 8c                	jmp    2f3 <printint+0x1f>
 367:	90                   	nop

00000368 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	57                   	push   %edi
 36c:	56                   	push   %esi
 36d:	53                   	push   %ebx
 36e:	83 ec 3c             	sub    $0x3c,%esp
 371:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 374:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 377:	0f b6 13             	movzbl (%ebx),%edx
 37a:	84 d2                	test   %dl,%dl
 37c:	0f 84 be 00 00 00    	je     440 <printf+0xd8>
 382:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 383:	8d 45 10             	lea    0x10(%ebp),%eax
 386:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 389:	31 ff                	xor    %edi,%edi
 38b:	eb 33                	jmp    3c0 <printf+0x58>
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 390:	83 fa 25             	cmp    $0x25,%edx
 393:	0f 84 af 00 00 00    	je     448 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 399:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 39c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a3:	00 
 3a4:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ab:	89 34 24             	mov    %esi,(%esp)
 3ae:	e8 a1 fe ff ff       	call   254 <write>
 3b3:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 3b8:	84 d2                	test   %dl,%dl
 3ba:	0f 84 80 00 00 00    	je     440 <printf+0xd8>
    c = fmt[i] & 0xff;
 3c0:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 3c3:	85 ff                	test   %edi,%edi
 3c5:	74 c9                	je     390 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3c7:	83 ff 25             	cmp    $0x25,%edi
 3ca:	75 e7                	jne    3b3 <printf+0x4b>
      if(c == 'd'){
 3cc:	83 fa 64             	cmp    $0x64,%edx
 3cf:	0f 84 0f 01 00 00    	je     4e4 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3d5:	25 f7 00 00 00       	and    $0xf7,%eax
 3da:	83 f8 70             	cmp    $0x70,%eax
 3dd:	74 75                	je     454 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3df:	83 fa 73             	cmp    $0x73,%edx
 3e2:	0f 84 90 00 00 00    	je     478 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3e8:	83 fa 63             	cmp    $0x63,%edx
 3eb:	0f 84 c7 00 00 00    	je     4b8 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3f1:	83 fa 25             	cmp    $0x25,%edx
 3f4:	0f 84 0e 01 00 00    	je     508 <printf+0x1a0>
 3fa:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3fd:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 401:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 408:	00 
 409:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 40c:	89 44 24 04          	mov    %eax,0x4(%esp)
 410:	89 34 24             	mov    %esi,(%esp)
 413:	e8 3c fe ff ff       	call   254 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 418:	8b 55 d0             	mov    -0x30(%ebp),%edx
 41b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 41e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 425:	00 
 426:	8d 45 e7             	lea    -0x19(%ebp),%eax
 429:	89 44 24 04          	mov    %eax,0x4(%esp)
 42d:	89 34 24             	mov    %esi,(%esp)
 430:	e8 1f fe ff ff       	call   254 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 435:	31 ff                	xor    %edi,%edi
 437:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 438:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 43c:	84 d2                	test   %dl,%dl
 43e:	75 80                	jne    3c0 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 440:	83 c4 3c             	add    $0x3c,%esp
 443:	5b                   	pop    %ebx
 444:	5e                   	pop    %esi
 445:	5f                   	pop    %edi
 446:	5d                   	pop    %ebp
 447:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 448:	bf 25 00 00 00       	mov    $0x25,%edi
 44d:	e9 61 ff ff ff       	jmp    3b3 <printf+0x4b>
 452:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 454:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 45b:	b9 10 00 00 00       	mov    $0x10,%ecx
 460:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 463:	8b 10                	mov    (%eax),%edx
 465:	89 f0                	mov    %esi,%eax
 467:	e8 68 fe ff ff       	call   2d4 <printint>
        ap++;
 46c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 470:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 472:	e9 3c ff ff ff       	jmp    3b3 <printf+0x4b>
 477:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 478:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 47b:	8b 38                	mov    (%eax),%edi
        ap++;
 47d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 481:	85 ff                	test   %edi,%edi
 483:	0f 84 a1 00 00 00    	je     52a <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 489:	8a 07                	mov    (%edi),%al
 48b:	84 c0                	test   %al,%al
 48d:	74 22                	je     4b1 <printf+0x149>
 48f:	90                   	nop
 490:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 493:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 49a:	00 
 49b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 49e:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a2:	89 34 24             	mov    %esi,(%esp)
 4a5:	e8 aa fd ff ff       	call   254 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4aa:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4ab:	8a 07                	mov    (%edi),%al
 4ad:	84 c0                	test   %al,%al
 4af:	75 df                	jne    490 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4b1:	31 ff                	xor    %edi,%edi
 4b3:	e9 fb fe ff ff       	jmp    3b3 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4bb:	8b 00                	mov    (%eax),%eax
 4bd:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4c0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c7:	00 
 4c8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cf:	89 34 24             	mov    %esi,(%esp)
 4d2:	e8 7d fd ff ff       	call   254 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 4d7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4db:	31 ff                	xor    %edi,%edi
 4dd:	e9 d1 fe ff ff       	jmp    3b3 <printf+0x4b>
 4e2:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4eb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4f3:	8b 10                	mov    (%eax),%edx
 4f5:	89 f0                	mov    %esi,%eax
 4f7:	e8 d8 fd ff ff       	call   2d4 <printint>
        ap++;
 4fc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 500:	66 31 ff             	xor    %di,%di
 503:	e9 ab fe ff ff       	jmp    3b3 <printf+0x4b>
 508:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 50c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 513:	00 
 514:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 517:	89 44 24 04          	mov    %eax,0x4(%esp)
 51b:	89 34 24             	mov    %esi,(%esp)
 51e:	e8 31 fd ff ff       	call   254 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 523:	31 ff                	xor    %edi,%edi
 525:	e9 89 fe ff ff       	jmp    3b3 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 52a:	bf 97 06 00 00       	mov    $0x697,%edi
 52f:	e9 55 ff ff ff       	jmp    489 <printf+0x121>

00000534 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 534:	55                   	push   %ebp
 535:	89 e5                	mov    %esp,%ebp
 537:	57                   	push   %edi
 538:	56                   	push   %esi
 539:	53                   	push   %ebx
 53a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 53d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 540:	a1 14 09 00 00       	mov    0x914,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 545:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 547:	39 d0                	cmp    %edx,%eax
 549:	72 11                	jb     55c <free+0x28>
 54b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 54c:	39 c8                	cmp    %ecx,%eax
 54e:	72 04                	jb     554 <free+0x20>
 550:	39 ca                	cmp    %ecx,%edx
 552:	72 10                	jb     564 <free+0x30>
 554:	89 c8                	mov    %ecx,%eax
 556:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 558:	39 d0                	cmp    %edx,%eax
 55a:	73 f0                	jae    54c <free+0x18>
 55c:	39 ca                	cmp    %ecx,%edx
 55e:	72 04                	jb     564 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 560:	39 c8                	cmp    %ecx,%eax
 562:	72 f0                	jb     554 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 564:	8b 73 fc             	mov    -0x4(%ebx),%esi
 567:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 56a:	39 cf                	cmp    %ecx,%edi
 56c:	74 1a                	je     588 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 56e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 571:	8b 48 04             	mov    0x4(%eax),%ecx
 574:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 577:	39 f2                	cmp    %esi,%edx
 579:	74 24                	je     59f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 57b:	89 10                	mov    %edx,(%eax)
  freep = p;
 57d:	a3 14 09 00 00       	mov    %eax,0x914
}
 582:	5b                   	pop    %ebx
 583:	5e                   	pop    %esi
 584:	5f                   	pop    %edi
 585:	5d                   	pop    %ebp
 586:	c3                   	ret    
 587:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 588:	03 71 04             	add    0x4(%ecx),%esi
 58b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 58e:	8b 08                	mov    (%eax),%ecx
 590:	8b 09                	mov    (%ecx),%ecx
 592:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 595:	8b 48 04             	mov    0x4(%eax),%ecx
 598:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 59b:	39 f2                	cmp    %esi,%edx
 59d:	75 dc                	jne    57b <free+0x47>
    p->s.size += bp->s.size;
 59f:	03 4b fc             	add    -0x4(%ebx),%ecx
 5a2:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5a5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5a8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5aa:	a3 14 09 00 00       	mov    %eax,0x914
}
 5af:	5b                   	pop    %ebx
 5b0:	5e                   	pop    %esi
 5b1:	5f                   	pop    %edi
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    

000005b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	57                   	push   %edi
 5b8:	56                   	push   %esi
 5b9:	53                   	push   %ebx
 5ba:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5bd:	8b 45 08             	mov    0x8(%ebp),%eax
 5c0:	8d 70 07             	lea    0x7(%eax),%esi
 5c3:	c1 ee 03             	shr    $0x3,%esi
 5c6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5c7:	8b 1d 14 09 00 00    	mov    0x914,%ebx
 5cd:	85 db                	test   %ebx,%ebx
 5cf:	0f 84 91 00 00 00    	je     666 <malloc+0xb2>
 5d5:	8b 13                	mov    (%ebx),%edx
 5d7:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5da:	39 ce                	cmp    %ecx,%esi
 5dc:	76 52                	jbe    630 <malloc+0x7c>
 5de:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5e5:	eb 0c                	jmp    5f3 <malloc+0x3f>
 5e7:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5ea:	8b 48 04             	mov    0x4(%eax),%ecx
 5ed:	39 ce                	cmp    %ecx,%esi
 5ef:	76 43                	jbe    634 <malloc+0x80>
 5f1:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5f3:	3b 15 14 09 00 00    	cmp    0x914,%edx
 5f9:	75 ed                	jne    5e8 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5fb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 601:	76 51                	jbe    654 <malloc+0xa0>
 603:	89 d8                	mov    %ebx,%eax
 605:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 607:	89 04 24             	mov    %eax,(%esp)
 60a:	e8 ad fc ff ff       	call   2bc <sbrk>
  if(p == (char*)-1)
 60f:	83 f8 ff             	cmp    $0xffffffff,%eax
 612:	74 18                	je     62c <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 614:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 617:	83 c0 08             	add    $0x8,%eax
 61a:	89 04 24             	mov    %eax,(%esp)
 61d:	e8 12 ff ff ff       	call   534 <free>
  return freep;
 622:	8b 15 14 09 00 00    	mov    0x914,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 628:	85 d2                	test   %edx,%edx
 62a:	75 bc                	jne    5e8 <malloc+0x34>
        return 0;
 62c:	31 c0                	xor    %eax,%eax
 62e:	eb 1c                	jmp    64c <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 630:	89 d0                	mov    %edx,%eax
 632:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 634:	39 ce                	cmp    %ecx,%esi
 636:	74 28                	je     660 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 638:	29 f1                	sub    %esi,%ecx
 63a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 63d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 640:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 643:	89 15 14 09 00 00    	mov    %edx,0x914
      return (void*)(p + 1);
 649:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 64c:	83 c4 1c             	add    $0x1c,%esp
 64f:	5b                   	pop    %ebx
 650:	5e                   	pop    %esi
 651:	5f                   	pop    %edi
 652:	5d                   	pop    %ebp
 653:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 654:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 659:	bf 00 10 00 00       	mov    $0x1000,%edi
 65e:	eb a7                	jmp    607 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 660:	8b 08                	mov    (%eax),%ecx
 662:	89 0a                	mov    %ecx,(%edx)
 664:	eb dd                	jmp    643 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 666:	c7 05 14 09 00 00 18 	movl   $0x918,0x914
 66d:	09 00 00 
 670:	c7 05 18 09 00 00 18 	movl   $0x918,0x918
 677:	09 00 00 
    base.s.size = 0;
 67a:	c7 05 1c 09 00 00 00 	movl   $0x0,0x91c
 681:	00 00 00 
 684:	ba 18 09 00 00       	mov    $0x918,%edx
 689:	e9 50 ff ff ff       	jmp    5de <malloc+0x2a>
