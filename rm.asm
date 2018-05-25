
_rm:     file format elf32-i386


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
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  if(argc < 2){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 43                	jle    57 <main+0x57>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  17:	8d 58 04             	lea    0x4(%eax),%ebx
  1a:	be 01 00 00 00       	mov    $0x1,%esi
  1f:	90                   	nop
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  20:	8b 03                	mov    (%ebx),%eax
  22:	89 04 24             	mov    %eax,(%esp)
  25:	e8 56 02 00 00       	call   280 <unlink>
  2a:	85 c0                	test   %eax,%eax
  2c:	78 0d                	js     3b <main+0x3b>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  2e:	46                   	inc    %esi
  2f:	83 c3 04             	add    $0x4,%ebx
  32:	39 fe                	cmp    %edi,%esi
  34:	75 ea                	jne    20 <main+0x20>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  36:	e8 f5 01 00 00       	call   230 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
      printf(2, "rm: %s failed to delete\n", argv[i]);
  3b:	8b 03                	mov    (%ebx),%eax
  3d:	89 44 24 08          	mov    %eax,0x8(%esp)
  41:	c7 44 24 04 9e 06 00 	movl   $0x69e,0x4(%esp)
  48:	00 
  49:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  50:	e8 0f 03 00 00       	call   364 <printf>
      break;
  55:	eb df                	jmp    36 <main+0x36>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: rm files...\n");
  57:	c7 44 24 04 8a 06 00 	movl   $0x68a,0x4(%esp)
  5e:	00 
  5f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  66:	e8 f9 02 00 00       	call   364 <printf>
    exit();
  6b:	e8 c0 01 00 00       	call   230 <exit>

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	42                   	inc    %edx
  7d:	41                   	inc    %ecx
  7e:	8a 59 ff             	mov    -0x1(%ecx),%bl
  81:	88 5a ff             	mov    %bl,-0x1(%edx)
  84:	84 db                	test   %bl,%bl
  86:	75 f4                	jne    7c <strcpy+0xc>
    ;
  return os;
}
  88:	5b                   	pop    %ebx
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    
  8b:	90                   	nop

0000008c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	53                   	push   %ebx
  90:	8b 55 08             	mov    0x8(%ebp),%edx
  93:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  96:	0f b6 02             	movzbl (%edx),%eax
  99:	84 c0                	test   %al,%al
  9b:	74 27                	je     c4 <strcmp+0x38>
  9d:	8a 19                	mov    (%ecx),%bl
  9f:	38 d8                	cmp    %bl,%al
  a1:	74 0b                	je     ae <strcmp+0x22>
  a3:	eb 26                	jmp    cb <strcmp+0x3f>
  a5:	8d 76 00             	lea    0x0(%esi),%esi
  a8:	38 c8                	cmp    %cl,%al
  aa:	75 13                	jne    bf <strcmp+0x33>
    p++, q++;
  ac:	89 d9                	mov    %ebx,%ecx
  ae:	42                   	inc    %edx
  af:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b2:	0f b6 02             	movzbl (%edx),%eax
  b5:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  b9:	84 c0                	test   %al,%al
  bb:	75 eb                	jne    a8 <strcmp+0x1c>
  bd:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  bf:	29 c8                	sub    %ecx,%eax
}
  c1:	5b                   	pop    %ebx
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    
  c4:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c7:	31 c0                	xor    %eax,%eax
  c9:	eb f4                	jmp    bf <strcmp+0x33>
  cb:	0f b6 cb             	movzbl %bl,%ecx
  ce:	eb ef                	jmp    bf <strcmp+0x33>

000000d0 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 10                	je     eb <strlen+0x1b>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	42                   	inc    %edx
  e1:	89 d0                	mov    %edx,%eax
  e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e7:	75 f7                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  eb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  ed:	5d                   	pop    %ebp
  ee:	c3                   	ret    
  ef:	90                   	nop

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	89 d7                	mov    %edx,%edi
  f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	89 d0                	mov    %edx,%eax
 104:	5f                   	pop    %edi
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	90                   	nop

00000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	55                   	push   %ebp
 109:	89 e5                	mov    %esp,%ebp
 10b:	53                   	push   %ebx
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 112:	8a 10                	mov    (%eax),%dl
 114:	84 d2                	test   %dl,%dl
 116:	74 13                	je     12b <strchr+0x23>
 118:	88 d9                	mov    %bl,%cl
    if(*s == c)
 11a:	38 da                	cmp    %bl,%dl
 11c:	75 06                	jne    124 <strchr+0x1c>
 11e:	eb 0d                	jmp    12d <strchr+0x25>
 120:	38 ca                	cmp    %cl,%dl
 122:	74 09                	je     12d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 124:	40                   	inc    %eax
 125:	8a 10                	mov    (%eax),%dl
 127:	84 d2                	test   %dl,%dl
 129:	75 f5                	jne    120 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 12b:	31 c0                	xor    %eax,%eax
}
 12d:	5b                   	pop    %ebx
 12e:	5d                   	pop    %ebp
 12f:	c3                   	ret    

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
 136:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 139:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 13b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13e:	eb 30                	jmp    170 <gets+0x40>
    cc = read(0, &c, 1);
 140:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 147:	00 
 148:	89 7c 24 04          	mov    %edi,0x4(%esp)
 14c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 153:	e8 f0 00 00 00       	call   248 <read>
    if(cc < 1)
 158:	85 c0                	test   %eax,%eax
 15a:	7e 1c                	jle    178 <gets+0x48>
      break;
    buf[i++] = c;
 15c:	8a 45 e7             	mov    -0x19(%ebp),%al
 15f:	8b 55 08             	mov    0x8(%ebp),%edx
 162:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 166:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 168:	3c 0a                	cmp    $0xa,%al
 16a:	74 0c                	je     178 <gets+0x48>
 16c:	3c 0d                	cmp    $0xd,%al
 16e:	74 08                	je     178 <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 170:	8d 5e 01             	lea    0x1(%esi),%ebx
 173:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 176:	7c c8                	jl     140 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 17f:	83 c4 2c             	add    $0x2c,%esp
 182:	5b                   	pop    %ebx
 183:	5e                   	pop    %esi
 184:	5f                   	pop    %edi
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop

00000188 <stat>:

int
stat(char *n, struct stat *st)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	56                   	push   %esi
 18c:	53                   	push   %ebx
 18d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 190:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 197:	00 
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	89 04 24             	mov    %eax,(%esp)
 19e:	e8 cd 00 00 00       	call   270 <open>
 1a3:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1a5:	85 c0                	test   %eax,%eax
 1a7:	78 23                	js     1cc <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b0:	89 1c 24             	mov    %ebx,(%esp)
 1b3:	e8 d0 00 00 00       	call   288 <fstat>
 1b8:	89 c6                	mov    %eax,%esi
  close(fd);
 1ba:	89 1c 24             	mov    %ebx,(%esp)
 1bd:	e8 96 00 00 00       	call   258 <close>
  return r;
 1c2:	89 f0                	mov    %esi,%eax
}
 1c4:	83 c4 10             	add    $0x10,%esp
 1c7:	5b                   	pop    %ebx
 1c8:	5e                   	pop    %esi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d1:	eb f1                	jmp    1c4 <stat+0x3c>
 1d3:	90                   	nop

000001d4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	53                   	push   %ebx
 1d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1db:	0f be 11             	movsbl (%ecx),%edx
 1de:	8d 42 d0             	lea    -0x30(%edx),%eax
 1e1:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 1e3:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1e8:	77 15                	ja     1ff <atoi+0x2b>
 1ea:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1ec:	41                   	inc    %ecx
 1ed:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1f0:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f4:	0f be 11             	movsbl (%ecx),%edx
 1f7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1fa:	80 fb 09             	cmp    $0x9,%bl
 1fd:	76 ed                	jbe    1ec <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1ff:	5b                   	pop    %ebx
 200:	5d                   	pop    %ebp
 201:	c3                   	ret    
 202:	66 90                	xchg   %ax,%ax

00000204 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	56                   	push   %esi
 208:	53                   	push   %ebx
 209:	8b 45 08             	mov    0x8(%ebp),%eax
 20c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 20f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 212:	31 d2                	xor    %edx,%edx
 214:	85 f6                	test   %esi,%esi
 216:	7e 0b                	jle    223 <memmove+0x1f>
    *dst++ = *src++;
 218:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 21b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 21e:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 21f:	39 f2                	cmp    %esi,%edx
 221:	75 f5                	jne    218 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 223:	5b                   	pop    %ebx
 224:	5e                   	pop    %esi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	90                   	nop

00000228 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 228:	b8 01 00 00 00       	mov    $0x1,%eax
 22d:	cd 40                	int    $0x40
 22f:	c3                   	ret    

00000230 <exit>:
SYSCALL(exit)
 230:	b8 02 00 00 00       	mov    $0x2,%eax
 235:	cd 40                	int    $0x40
 237:	c3                   	ret    

00000238 <wait>:
SYSCALL(wait)
 238:	b8 03 00 00 00       	mov    $0x3,%eax
 23d:	cd 40                	int    $0x40
 23f:	c3                   	ret    

00000240 <pipe>:
SYSCALL(pipe)
 240:	b8 04 00 00 00       	mov    $0x4,%eax
 245:	cd 40                	int    $0x40
 247:	c3                   	ret    

00000248 <read>:
SYSCALL(read)
 248:	b8 05 00 00 00       	mov    $0x5,%eax
 24d:	cd 40                	int    $0x40
 24f:	c3                   	ret    

00000250 <write>:
SYSCALL(write)
 250:	b8 10 00 00 00       	mov    $0x10,%eax
 255:	cd 40                	int    $0x40
 257:	c3                   	ret    

00000258 <close>:
SYSCALL(close)
 258:	b8 15 00 00 00       	mov    $0x15,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <kill>:
SYSCALL(kill)
 260:	b8 06 00 00 00       	mov    $0x6,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <exec>:
SYSCALL(exec)
 268:	b8 07 00 00 00       	mov    $0x7,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <open>:
SYSCALL(open)
 270:	b8 0f 00 00 00       	mov    $0xf,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <mknod>:
SYSCALL(mknod)
 278:	b8 11 00 00 00       	mov    $0x11,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <unlink>:
SYSCALL(unlink)
 280:	b8 12 00 00 00       	mov    $0x12,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <fstat>:
SYSCALL(fstat)
 288:	b8 08 00 00 00       	mov    $0x8,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <link>:
SYSCALL(link)
 290:	b8 13 00 00 00       	mov    $0x13,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <mkdir>:
SYSCALL(mkdir)
 298:	b8 14 00 00 00       	mov    $0x14,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <chdir>:
SYSCALL(chdir)
 2a0:	b8 09 00 00 00       	mov    $0x9,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <dup>:
SYSCALL(dup)
 2a8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <getpid>:
SYSCALL(getpid)
 2b0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <sbrk>:
SYSCALL(sbrk)
 2b8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <sleep>:
SYSCALL(sleep)
 2c0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <uptime>:
SYSCALL(uptime)
 2c8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
 2d5:	53                   	push   %ebx
 2d6:	83 ec 4c             	sub    $0x4c,%esp
 2d9:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2db:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2e0:	85 db                	test   %ebx,%ebx
 2e2:	74 04                	je     2e8 <printint+0x18>
 2e4:	85 d2                	test   %edx,%edx
 2e6:	78 70                	js     358 <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2ef:	31 ff                	xor    %edi,%edi
 2f1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2f4:	89 75 c0             	mov    %esi,-0x40(%ebp)
 2f7:	89 ce                	mov    %ecx,%esi
 2f9:	eb 03                	jmp    2fe <printint+0x2e>
 2fb:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2fc:	89 cf                	mov    %ecx,%edi
 2fe:	8d 4f 01             	lea    0x1(%edi),%ecx
 301:	31 d2                	xor    %edx,%edx
 303:	f7 f6                	div    %esi
 305:	8a 92 be 06 00 00    	mov    0x6be(%edx),%dl
 30b:	88 55 c7             	mov    %dl,-0x39(%ebp)
 30e:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 311:	85 c0                	test   %eax,%eax
 313:	75 e7                	jne    2fc <printint+0x2c>
 315:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 318:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 31a:	8b 55 bc             	mov    -0x44(%ebp),%edx
 31d:	85 d2                	test   %edx,%edx
 31f:	74 08                	je     329 <printint+0x59>
    buf[i++] = '-';
 321:	8d 4f 02             	lea    0x2(%edi),%ecx
 324:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 329:	8d 79 ff             	lea    -0x1(%ecx),%edi
 32c:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 330:	88 45 c7             	mov    %al,-0x39(%ebp)
 333:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 336:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 33d:	00 
 33e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 342:	89 34 24             	mov    %esi,(%esp)
 345:	e8 06 ff ff ff       	call   250 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 34a:	4f                   	dec    %edi
 34b:	83 ff ff             	cmp    $0xffffffff,%edi
 34e:	75 dc                	jne    32c <printint+0x5c>
    putc(fd, buf[i]);
}
 350:	83 c4 4c             	add    $0x4c,%esp
 353:	5b                   	pop    %ebx
 354:	5e                   	pop    %esi
 355:	5f                   	pop    %edi
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 358:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 35a:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 361:	eb 8c                	jmp    2ef <printint+0x1f>
 363:	90                   	nop

00000364 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	57                   	push   %edi
 368:	56                   	push   %esi
 369:	53                   	push   %ebx
 36a:	83 ec 3c             	sub    $0x3c,%esp
 36d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 370:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 373:	0f b6 13             	movzbl (%ebx),%edx
 376:	84 d2                	test   %dl,%dl
 378:	0f 84 be 00 00 00    	je     43c <printf+0xd8>
 37e:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 37f:	8d 45 10             	lea    0x10(%ebp),%eax
 382:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 385:	31 ff                	xor    %edi,%edi
 387:	eb 33                	jmp    3bc <printf+0x58>
 389:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 38c:	83 fa 25             	cmp    $0x25,%edx
 38f:	0f 84 af 00 00 00    	je     444 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 395:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 398:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 39f:	00 
 3a0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a7:	89 34 24             	mov    %esi,(%esp)
 3aa:	e8 a1 fe ff ff       	call   250 <write>
 3af:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b0:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 3b4:	84 d2                	test   %dl,%dl
 3b6:	0f 84 80 00 00 00    	je     43c <printf+0xd8>
    c = fmt[i] & 0xff;
 3bc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 3bf:	85 ff                	test   %edi,%edi
 3c1:	74 c9                	je     38c <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3c3:	83 ff 25             	cmp    $0x25,%edi
 3c6:	75 e7                	jne    3af <printf+0x4b>
      if(c == 'd'){
 3c8:	83 fa 64             	cmp    $0x64,%edx
 3cb:	0f 84 0f 01 00 00    	je     4e0 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3d1:	25 f7 00 00 00       	and    $0xf7,%eax
 3d6:	83 f8 70             	cmp    $0x70,%eax
 3d9:	74 75                	je     450 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3db:	83 fa 73             	cmp    $0x73,%edx
 3de:	0f 84 90 00 00 00    	je     474 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3e4:	83 fa 63             	cmp    $0x63,%edx
 3e7:	0f 84 c7 00 00 00    	je     4b4 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3ed:	83 fa 25             	cmp    $0x25,%edx
 3f0:	0f 84 0e 01 00 00    	je     504 <printf+0x1a0>
 3f6:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3f9:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3fd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 404:	00 
 405:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 408:	89 44 24 04          	mov    %eax,0x4(%esp)
 40c:	89 34 24             	mov    %esi,(%esp)
 40f:	e8 3c fe ff ff       	call   250 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 414:	8b 55 d0             	mov    -0x30(%ebp),%edx
 417:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 41a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 421:	00 
 422:	8d 45 e7             	lea    -0x19(%ebp),%eax
 425:	89 44 24 04          	mov    %eax,0x4(%esp)
 429:	89 34 24             	mov    %esi,(%esp)
 42c:	e8 1f fe ff ff       	call   250 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 431:	31 ff                	xor    %edi,%edi
 433:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 434:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 438:	84 d2                	test   %dl,%dl
 43a:	75 80                	jne    3bc <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 43c:	83 c4 3c             	add    $0x3c,%esp
 43f:	5b                   	pop    %ebx
 440:	5e                   	pop    %esi
 441:	5f                   	pop    %edi
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 444:	bf 25 00 00 00       	mov    $0x25,%edi
 449:	e9 61 ff ff ff       	jmp    3af <printf+0x4b>
 44e:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 450:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 457:	b9 10 00 00 00       	mov    $0x10,%ecx
 45c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 45f:	8b 10                	mov    (%eax),%edx
 461:	89 f0                	mov    %esi,%eax
 463:	e8 68 fe ff ff       	call   2d0 <printint>
        ap++;
 468:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 46c:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 46e:	e9 3c ff ff ff       	jmp    3af <printf+0x4b>
 473:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 474:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 477:	8b 38                	mov    (%eax),%edi
        ap++;
 479:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 47d:	85 ff                	test   %edi,%edi
 47f:	0f 84 a1 00 00 00    	je     526 <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 485:	8a 07                	mov    (%edi),%al
 487:	84 c0                	test   %al,%al
 489:	74 22                	je     4ad <printf+0x149>
 48b:	90                   	nop
 48c:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 48f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 496:	00 
 497:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 49a:	89 44 24 04          	mov    %eax,0x4(%esp)
 49e:	89 34 24             	mov    %esi,(%esp)
 4a1:	e8 aa fd ff ff       	call   250 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4a6:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4a7:	8a 07                	mov    (%edi),%al
 4a9:	84 c0                	test   %al,%al
 4ab:	75 df                	jne    48c <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ad:	31 ff                	xor    %edi,%edi
 4af:	e9 fb fe ff ff       	jmp    3af <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4b4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4b7:	8b 00                	mov    (%eax),%eax
 4b9:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c3:	00 
 4c4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cb:	89 34 24             	mov    %esi,(%esp)
 4ce:	e8 7d fd ff ff       	call   250 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 4d3:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d7:	31 ff                	xor    %edi,%edi
 4d9:	e9 d1 fe ff ff       	jmp    3af <printf+0x4b>
 4de:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4e7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4ec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4ef:	8b 10                	mov    (%eax),%edx
 4f1:	89 f0                	mov    %esi,%eax
 4f3:	e8 d8 fd ff ff       	call   2d0 <printint>
        ap++;
 4f8:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4fc:	66 31 ff             	xor    %di,%di
 4ff:	e9 ab fe ff ff       	jmp    3af <printf+0x4b>
 504:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 508:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50f:	00 
 510:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 513:	89 44 24 04          	mov    %eax,0x4(%esp)
 517:	89 34 24             	mov    %esi,(%esp)
 51a:	e8 31 fd ff ff       	call   250 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51f:	31 ff                	xor    %edi,%edi
 521:	e9 89 fe ff ff       	jmp    3af <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 526:	bf b7 06 00 00       	mov    $0x6b7,%edi
 52b:	e9 55 ff ff ff       	jmp    485 <printf+0x121>

00000530 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 539:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 53c:	a1 34 09 00 00       	mov    0x934,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 541:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 543:	39 d0                	cmp    %edx,%eax
 545:	72 11                	jb     558 <free+0x28>
 547:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 548:	39 c8                	cmp    %ecx,%eax
 54a:	72 04                	jb     550 <free+0x20>
 54c:	39 ca                	cmp    %ecx,%edx
 54e:	72 10                	jb     560 <free+0x30>
 550:	89 c8                	mov    %ecx,%eax
 552:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 554:	39 d0                	cmp    %edx,%eax
 556:	73 f0                	jae    548 <free+0x18>
 558:	39 ca                	cmp    %ecx,%edx
 55a:	72 04                	jb     560 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55c:	39 c8                	cmp    %ecx,%eax
 55e:	72 f0                	jb     550 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 560:	8b 73 fc             	mov    -0x4(%ebx),%esi
 563:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 566:	39 cf                	cmp    %ecx,%edi
 568:	74 1a                	je     584 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 56a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 56d:	8b 48 04             	mov    0x4(%eax),%ecx
 570:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 573:	39 f2                	cmp    %esi,%edx
 575:	74 24                	je     59b <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 577:	89 10                	mov    %edx,(%eax)
  freep = p;
 579:	a3 34 09 00 00       	mov    %eax,0x934
}
 57e:	5b                   	pop    %ebx
 57f:	5e                   	pop    %esi
 580:	5f                   	pop    %edi
 581:	5d                   	pop    %ebp
 582:	c3                   	ret    
 583:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 584:	03 71 04             	add    0x4(%ecx),%esi
 587:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 58a:	8b 08                	mov    (%eax),%ecx
 58c:	8b 09                	mov    (%ecx),%ecx
 58e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 591:	8b 48 04             	mov    0x4(%eax),%ecx
 594:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 597:	39 f2                	cmp    %esi,%edx
 599:	75 dc                	jne    577 <free+0x47>
    p->s.size += bp->s.size;
 59b:	03 4b fc             	add    -0x4(%ebx),%ecx
 59e:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5a1:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5a4:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5a6:	a3 34 09 00 00       	mov    %eax,0x934
}
 5ab:	5b                   	pop    %ebx
 5ac:	5e                   	pop    %esi
 5ad:	5f                   	pop    %edi
 5ae:	5d                   	pop    %ebp
 5af:	c3                   	ret    

000005b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5b9:	8b 45 08             	mov    0x8(%ebp),%eax
 5bc:	8d 70 07             	lea    0x7(%eax),%esi
 5bf:	c1 ee 03             	shr    $0x3,%esi
 5c2:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5c3:	8b 1d 34 09 00 00    	mov    0x934,%ebx
 5c9:	85 db                	test   %ebx,%ebx
 5cb:	0f 84 91 00 00 00    	je     662 <malloc+0xb2>
 5d1:	8b 13                	mov    (%ebx),%edx
 5d3:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5d6:	39 ce                	cmp    %ecx,%esi
 5d8:	76 52                	jbe    62c <malloc+0x7c>
 5da:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5e1:	eb 0c                	jmp    5ef <malloc+0x3f>
 5e3:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e4:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5e6:	8b 48 04             	mov    0x4(%eax),%ecx
 5e9:	39 ce                	cmp    %ecx,%esi
 5eb:	76 43                	jbe    630 <malloc+0x80>
 5ed:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5ef:	3b 15 34 09 00 00    	cmp    0x934,%edx
 5f5:	75 ed                	jne    5e4 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5f7:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5fd:	76 51                	jbe    650 <malloc+0xa0>
 5ff:	89 d8                	mov    %ebx,%eax
 601:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 603:	89 04 24             	mov    %eax,(%esp)
 606:	e8 ad fc ff ff       	call   2b8 <sbrk>
  if(p == (char*)-1)
 60b:	83 f8 ff             	cmp    $0xffffffff,%eax
 60e:	74 18                	je     628 <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 610:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 613:	83 c0 08             	add    $0x8,%eax
 616:	89 04 24             	mov    %eax,(%esp)
 619:	e8 12 ff ff ff       	call   530 <free>
  return freep;
 61e:	8b 15 34 09 00 00    	mov    0x934,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 624:	85 d2                	test   %edx,%edx
 626:	75 bc                	jne    5e4 <malloc+0x34>
        return 0;
 628:	31 c0                	xor    %eax,%eax
 62a:	eb 1c                	jmp    648 <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 62c:	89 d0                	mov    %edx,%eax
 62e:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 630:	39 ce                	cmp    %ecx,%esi
 632:	74 28                	je     65c <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 634:	29 f1                	sub    %esi,%ecx
 636:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 639:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 63c:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 63f:	89 15 34 09 00 00    	mov    %edx,0x934
      return (void*)(p + 1);
 645:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 648:	83 c4 1c             	add    $0x1c,%esp
 64b:	5b                   	pop    %ebx
 64c:	5e                   	pop    %esi
 64d:	5f                   	pop    %edi
 64e:	5d                   	pop    %ebp
 64f:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 650:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 655:	bf 00 10 00 00       	mov    $0x1000,%edi
 65a:	eb a7                	jmp    603 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 65c:	8b 08                	mov    (%eax),%ecx
 65e:	89 0a                	mov    %ecx,(%edx)
 660:	eb dd                	jmp    63f <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 662:	c7 05 34 09 00 00 38 	movl   $0x938,0x934
 669:	09 00 00 
 66c:	c7 05 38 09 00 00 38 	movl   $0x938,0x938
 673:	09 00 00 
    base.s.size = 0;
 676:	c7 05 3c 09 00 00 00 	movl   $0x0,0x93c
 67d:	00 00 00 
 680:	ba 38 09 00 00       	mov    $0x938,%edx
 685:	e9 50 ff ff ff       	jmp    5da <malloc+0x2a>
