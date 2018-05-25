
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
   6:	e8 31 00 00 00       	call   3c <forktest>
  exit();
   b:	e8 b4 02 00 00       	call   2c4 <exit>

00000010 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	53                   	push   %ebx
  14:	83 ec 14             	sub    $0x14,%esp
  17:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  1a:	89 1c 24             	mov    %ebx,(%esp)
  1d:	e8 42 01 00 00       	call   164 <strlen>
  22:	89 44 24 08          	mov    %eax,0x8(%esp)
  26:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  2a:	8b 45 08             	mov    0x8(%ebp),%eax
  2d:	89 04 24             	mov    %eax,(%esp)
  30:	e8 af 02 00 00       	call   2e4 <write>
}
  35:	83 c4 14             	add    $0x14,%esp
  38:	5b                   	pop    %ebx
  39:	5d                   	pop    %ebp
  3a:	c3                   	ret    
  3b:	90                   	nop

0000003c <forktest>:

void
forktest(void)
{
  3c:	55                   	push   %ebp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	53                   	push   %ebx
  40:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
  43:	c7 44 24 04 64 03 00 	movl   $0x364,0x4(%esp)
  4a:	00 
  4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  52:	e8 b9 ff ff ff       	call   10 <printf>

  for(n=0; n<N; n++){
  57:	31 db                	xor    %ebx,%ebx
  59:	eb 10                	jmp    6b <forktest+0x2f>
  5b:	90                   	nop
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  5c:	0f 84 83 00 00 00    	je     e5 <forktest+0xa9>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  62:	43                   	inc    %ebx
  63:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  69:	74 3d                	je     a8 <forktest+0x6c>
    pid = fork();
  6b:	e8 4c 02 00 00       	call   2bc <fork>
    if(pid < 0)
  70:	85 c0                	test   %eax,%eax
  72:	79 e8                	jns    5c <forktest+0x20>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  74:	85 db                	test   %ebx,%ebx
  76:	74 0c                	je     84 <forktest+0x48>
    if(wait() < 0){
  78:	e8 4f 02 00 00       	call   2cc <wait>
  7d:	85 c0                	test   %eax,%eax
  7f:	78 50                	js     d1 <forktest+0x95>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  81:	4b                   	dec    %ebx
  82:	75 f4                	jne    78 <forktest+0x3c>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
  84:	e8 43 02 00 00       	call   2cc <wait>
  89:	40                   	inc    %eax
  8a:	75 5e                	jne    ea <forktest+0xae>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
  8c:	c7 44 24 04 96 03 00 	movl   $0x396,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 70 ff ff ff       	call   10 <printf>
}
  a0:	83 c4 14             	add    $0x14,%esp
  a3:	5b                   	pop    %ebx
  a4:	5d                   	pop    %ebp
  a5:	c3                   	ret    
  a6:	66 90                	xchg   %ax,%ax
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
  a8:	c7 04 24 a4 03 00 00 	movl   $0x3a4,(%esp)
  af:	e8 b0 00 00 00       	call   164 <strlen>
  b4:	89 44 24 08          	mov    %eax,0x8(%esp)
  b8:	c7 44 24 04 a4 03 00 	movl   $0x3a4,0x4(%esp)
  bf:	00 
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 18 02 00 00       	call   2e4 <write>
      exit();
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  cc:	e8 f3 01 00 00       	call   2c4 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
  d1:	c7 44 24 04 6f 03 00 	movl   $0x36f,0x4(%esp)
  d8:	00 
  d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e0:	e8 2b ff ff ff       	call   10 <printf>
      exit();
  e5:	e8 da 01 00 00       	call   2c4 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
  ea:	c7 44 24 04 83 03 00 	movl   $0x383,0x4(%esp)
  f1:	00 
  f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f9:	e8 12 ff ff ff       	call   10 <printf>
    exit();
  fe:	e8 c1 01 00 00       	call   2c4 <exit>
 103:	90                   	nop

00000104 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	53                   	push   %ebx
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10e:	89 c2                	mov    %eax,%edx
 110:	42                   	inc    %edx
 111:	41                   	inc    %ecx
 112:	8a 59 ff             	mov    -0x1(%ecx),%bl
 115:	88 5a ff             	mov    %bl,-0x1(%edx)
 118:	84 db                	test   %bl,%bl
 11a:	75 f4                	jne    110 <strcpy+0xc>
    ;
  return os;
}
 11c:	5b                   	pop    %ebx
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret    
 11f:	90                   	nop

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	84 c0                	test   %al,%al
 12f:	74 27                	je     158 <strcmp+0x38>
 131:	8a 19                	mov    (%ecx),%bl
 133:	38 d8                	cmp    %bl,%al
 135:	74 0b                	je     142 <strcmp+0x22>
 137:	eb 26                	jmp    15f <strcmp+0x3f>
 139:	8d 76 00             	lea    0x0(%esi),%esi
 13c:	38 c8                	cmp    %cl,%al
 13e:	75 13                	jne    153 <strcmp+0x33>
    p++, q++;
 140:	89 d9                	mov    %ebx,%ecx
 142:	42                   	inc    %edx
 143:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 146:	0f b6 02             	movzbl (%edx),%eax
 149:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 14d:	84 c0                	test   %al,%al
 14f:	75 eb                	jne    13c <strcmp+0x1c>
 151:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 153:	29 c8                	sub    %ecx,%eax
}
 155:	5b                   	pop    %ebx
 156:	5d                   	pop    %ebp
 157:	c3                   	ret    
 158:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15b:	31 c0                	xor    %eax,%eax
 15d:	eb f4                	jmp    153 <strcmp+0x33>
 15f:	0f b6 cb             	movzbl %bl,%ecx
 162:	eb ef                	jmp    153 <strcmp+0x33>

00000164 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 16a:	80 39 00             	cmpb   $0x0,(%ecx)
 16d:	74 10                	je     17f <strlen+0x1b>
 16f:	31 d2                	xor    %edx,%edx
 171:	8d 76 00             	lea    0x0(%esi),%esi
 174:	42                   	inc    %edx
 175:	89 d0                	mov    %edx,%eax
 177:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 17b:	75 f7                	jne    174 <strlen+0x10>
    ;
  return n;
}
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 17f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	90                   	nop

00000184 <memset>:

void*
memset(void *dst, int c, uint n)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18b:	89 d7                	mov    %edx,%edi
 18d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 190:	8b 45 0c             	mov    0xc(%ebp),%eax
 193:	fc                   	cld    
 194:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 196:	89 d0                	mov    %edx,%eax
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop

0000019c <strchr>:

char*
strchr(const char *s, char c)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	53                   	push   %ebx
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1a6:	8a 10                	mov    (%eax),%dl
 1a8:	84 d2                	test   %dl,%dl
 1aa:	74 13                	je     1bf <strchr+0x23>
 1ac:	88 d9                	mov    %bl,%cl
    if(*s == c)
 1ae:	38 da                	cmp    %bl,%dl
 1b0:	75 06                	jne    1b8 <strchr+0x1c>
 1b2:	eb 0d                	jmp    1c1 <strchr+0x25>
 1b4:	38 ca                	cmp    %cl,%dl
 1b6:	74 09                	je     1c1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1b8:	40                   	inc    %eax
 1b9:	8a 10                	mov    (%eax),%dl
 1bb:	84 d2                	test   %dl,%dl
 1bd:	75 f5                	jne    1b4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1bf:	31 c0                	xor    %eax,%eax
}
 1c1:	5b                   	pop    %ebx
 1c2:	5d                   	pop    %ebp
 1c3:	c3                   	ret    

000001c4 <gets>:

char*
gets(char *buf, int max)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	57                   	push   %edi
 1c8:	56                   	push   %esi
 1c9:	53                   	push   %ebx
 1ca:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cd:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1cf:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d2:	eb 30                	jmp    204 <gets+0x40>
    cc = read(0, &c, 1);
 1d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1db:	00 
 1dc:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1e7:	e8 f0 00 00 00       	call   2dc <read>
    if(cc < 1)
 1ec:	85 c0                	test   %eax,%eax
 1ee:	7e 1c                	jle    20c <gets+0x48>
      break;
    buf[i++] = c;
 1f0:	8a 45 e7             	mov    -0x19(%ebp),%al
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fa:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	3c 0a                	cmp    $0xa,%al
 1fe:	74 0c                	je     20c <gets+0x48>
 200:	3c 0d                	cmp    $0xd,%al
 202:	74 08                	je     20c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 204:	8d 5e 01             	lea    0x1(%esi),%ebx
 207:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 20a:	7c c8                	jl     1d4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 213:	83 c4 2c             	add    $0x2c,%esp
 216:	5b                   	pop    %ebx
 217:	5e                   	pop    %esi
 218:	5f                   	pop    %edi
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop

0000021c <stat>:

int
stat(char *n, struct stat *st)
{
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	56                   	push   %esi
 220:	53                   	push   %ebx
 221:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 224:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 22b:	00 
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	89 04 24             	mov    %eax,(%esp)
 232:	e8 cd 00 00 00       	call   304 <open>
 237:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 239:	85 c0                	test   %eax,%eax
 23b:	78 23                	js     260 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 23d:	8b 45 0c             	mov    0xc(%ebp),%eax
 240:	89 44 24 04          	mov    %eax,0x4(%esp)
 244:	89 1c 24             	mov    %ebx,(%esp)
 247:	e8 d0 00 00 00       	call   31c <fstat>
 24c:	89 c6                	mov    %eax,%esi
  close(fd);
 24e:	89 1c 24             	mov    %ebx,(%esp)
 251:	e8 96 00 00 00       	call   2ec <close>
  return r;
 256:	89 f0                	mov    %esi,%eax
}
 258:	83 c4 10             	add    $0x10,%esp
 25b:	5b                   	pop    %ebx
 25c:	5e                   	pop    %esi
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret    
 25f:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 260:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 265:	eb f1                	jmp    258 <stat+0x3c>
 267:	90                   	nop

00000268 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	53                   	push   %ebx
 26c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26f:	0f be 11             	movsbl (%ecx),%edx
 272:	8d 42 d0             	lea    -0x30(%edx),%eax
 275:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 277:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 27c:	77 15                	ja     293 <atoi+0x2b>
 27e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 280:	41                   	inc    %ecx
 281:	8d 04 80             	lea    (%eax,%eax,4),%eax
 284:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 288:	0f be 11             	movsbl (%ecx),%edx
 28b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 28e:	80 fb 09             	cmp    $0x9,%bl
 291:	76 ed                	jbe    280 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 293:	5b                   	pop    %ebx
 294:	5d                   	pop    %ebp
 295:	c3                   	ret    
 296:	66 90                	xchg   %ax,%ax

00000298 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	56                   	push   %esi
 29c:	53                   	push   %ebx
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
 2a0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2a3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a6:	31 d2                	xor    %edx,%edx
 2a8:	85 f6                	test   %esi,%esi
 2aa:	7e 0b                	jle    2b7 <memmove+0x1f>
    *dst++ = *src++;
 2ac:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2af:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2b2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b3:	39 f2                	cmp    %esi,%edx
 2b5:	75 f5                	jne    2ac <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2b7:	5b                   	pop    %ebx
 2b8:	5e                   	pop    %esi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret    
 2bb:	90                   	nop

000002bc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bc:	b8 01 00 00 00       	mov    $0x1,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <exit>:
SYSCALL(exit)
 2c4:	b8 02 00 00 00       	mov    $0x2,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <wait>:
SYSCALL(wait)
 2cc:	b8 03 00 00 00       	mov    $0x3,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <pipe>:
SYSCALL(pipe)
 2d4:	b8 04 00 00 00       	mov    $0x4,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <read>:
SYSCALL(read)
 2dc:	b8 05 00 00 00       	mov    $0x5,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <write>:
SYSCALL(write)
 2e4:	b8 10 00 00 00       	mov    $0x10,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <close>:
SYSCALL(close)
 2ec:	b8 15 00 00 00       	mov    $0x15,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <kill>:
SYSCALL(kill)
 2f4:	b8 06 00 00 00       	mov    $0x6,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <exec>:
SYSCALL(exec)
 2fc:	b8 07 00 00 00       	mov    $0x7,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <open>:
SYSCALL(open)
 304:	b8 0f 00 00 00       	mov    $0xf,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <mknod>:
SYSCALL(mknod)
 30c:	b8 11 00 00 00       	mov    $0x11,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <unlink>:
SYSCALL(unlink)
 314:	b8 12 00 00 00       	mov    $0x12,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <fstat>:
SYSCALL(fstat)
 31c:	b8 08 00 00 00       	mov    $0x8,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <link>:
SYSCALL(link)
 324:	b8 13 00 00 00       	mov    $0x13,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <mkdir>:
SYSCALL(mkdir)
 32c:	b8 14 00 00 00       	mov    $0x14,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <chdir>:
SYSCALL(chdir)
 334:	b8 09 00 00 00       	mov    $0x9,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <dup>:
SYSCALL(dup)
 33c:	b8 0a 00 00 00       	mov    $0xa,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <getpid>:
SYSCALL(getpid)
 344:	b8 0b 00 00 00       	mov    $0xb,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <sbrk>:
SYSCALL(sbrk)
 34c:	b8 0c 00 00 00       	mov    $0xc,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <sleep>:
SYSCALL(sleep)
 354:	b8 0d 00 00 00       	mov    $0xd,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <uptime>:
SYSCALL(uptime)
 35c:	b8 0e 00 00 00       	mov    $0xe,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    
