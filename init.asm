
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  11:	00 
  12:	c7 04 24 1e 07 00 00 	movl   $0x71e,(%esp)
  19:	e8 e6 02 00 00       	call   304 <open>
  1e:	85 c0                	test   %eax,%eax
  20:	0f 88 a7 00 00 00    	js     cd <main+0xcd>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2d:	e8 0a 03 00 00       	call   33c <dup>
  dup(0);  // stderr
  32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  39:	e8 fe 02 00 00       	call   33c <dup>
  3e:	66 90                	xchg   %ax,%ax

  for(;;){
    printf(1, "init: starting sh\n");
  40:	c7 44 24 04 26 07 00 	movl   $0x726,0x4(%esp)
  47:	00 
  48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4f:	e8 a4 03 00 00       	call   3f8 <printf>
    pid = fork();
  54:	e8 63 02 00 00       	call   2bc <fork>
  59:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5b:	85 c0                	test   %eax,%eax
  5d:	78 28                	js     87 <main+0x87>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  5f:	74 3f                	je     a0 <main+0xa0>
  61:	8d 76 00             	lea    0x0(%esi),%esi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  64:	e8 63 02 00 00       	call   2cc <wait>
  69:	85 c0                	test   %eax,%eax
  6b:	78 d3                	js     40 <main+0x40>
  6d:	39 d8                	cmp    %ebx,%eax
  6f:	74 cf                	je     40 <main+0x40>
      printf(1, "zombie!\n");
  71:	c7 44 24 04 65 07 00 	movl   $0x765,0x4(%esp)
  78:	00 
  79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  80:	e8 73 03 00 00       	call   3f8 <printf>
  85:	eb dd                	jmp    64 <main+0x64>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  87:	c7 44 24 04 39 07 00 	movl   $0x739,0x4(%esp)
  8e:	00 
  8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  96:	e8 5d 03 00 00       	call   3f8 <printf>
      exit();
  9b:	e8 24 02 00 00       	call   2c4 <exit>
    }
    if(pid == 0){
      exec("sh", argv);
  a0:	c7 44 24 04 e8 09 00 	movl   $0x9e8,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 4c 07 00 00 	movl   $0x74c,(%esp)
  af:	e8 48 02 00 00       	call   2fc <exec>
      printf(1, "init: exec sh failed\n");
  b4:	c7 44 24 04 4f 07 00 	movl   $0x74f,0x4(%esp)
  bb:	00 
  bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c3:	e8 30 03 00 00       	call   3f8 <printf>
      exit();
  c8:	e8 f7 01 00 00       	call   2c4 <exit>
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
  cd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  d4:	00 
  d5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 1e 07 00 00 	movl   $0x71e,(%esp)
  e4:	e8 23 02 00 00       	call   30c <mknod>
    open("console", O_RDWR);
  e9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  f0:	00 
  f1:	c7 04 24 1e 07 00 00 	movl   $0x71e,(%esp)
  f8:	e8 07 02 00 00       	call   304 <open>
  fd:	e9 24 ff ff ff       	jmp    26 <main+0x26>
 102:	66 90                	xchg   %ax,%ax

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

00000364 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	57                   	push   %edi
 368:	56                   	push   %esi
 369:	53                   	push   %ebx
 36a:	83 ec 4c             	sub    $0x4c,%esp
 36d:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 36f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 371:	8b 5d 08             	mov    0x8(%ebp),%ebx
 374:	85 db                	test   %ebx,%ebx
 376:	74 04                	je     37c <printint+0x18>
 378:	85 d2                	test   %edx,%edx
 37a:	78 70                	js     3ec <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 383:	31 ff                	xor    %edi,%edi
 385:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 388:	89 75 c0             	mov    %esi,-0x40(%ebp)
 38b:	89 ce                	mov    %ecx,%esi
 38d:	eb 03                	jmp    392 <printint+0x2e>
 38f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 390:	89 cf                	mov    %ecx,%edi
 392:	8d 4f 01             	lea    0x1(%edi),%ecx
 395:	31 d2                	xor    %edx,%edx
 397:	f7 f6                	div    %esi
 399:	8a 92 75 07 00 00    	mov    0x775(%edx),%dl
 39f:	88 55 c7             	mov    %dl,-0x39(%ebp)
 3a2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3a5:	85 c0                	test   %eax,%eax
 3a7:	75 e7                	jne    390 <printint+0x2c>
 3a9:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3ac:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 3ae:	8b 55 bc             	mov    -0x44(%ebp),%edx
 3b1:	85 d2                	test   %edx,%edx
 3b3:	74 08                	je     3bd <printint+0x59>
    buf[i++] = '-';
 3b5:	8d 4f 02             	lea    0x2(%edi),%ecx
 3b8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3bd:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3c0:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 3c4:	88 45 c7             	mov    %al,-0x39(%ebp)
 3c7:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d1:	00 
 3d2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3d6:	89 34 24             	mov    %esi,(%esp)
 3d9:	e8 06 ff ff ff       	call   2e4 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3de:	4f                   	dec    %edi
 3df:	83 ff ff             	cmp    $0xffffffff,%edi
 3e2:	75 dc                	jne    3c0 <printint+0x5c>
    putc(fd, buf[i]);
}
 3e4:	83 c4 4c             	add    $0x4c,%esp
 3e7:	5b                   	pop    %ebx
 3e8:	5e                   	pop    %esi
 3e9:	5f                   	pop    %edi
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ec:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3ee:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3f5:	eb 8c                	jmp    383 <printint+0x1f>
 3f7:	90                   	nop

000003f8 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	57                   	push   %edi
 3fc:	56                   	push   %esi
 3fd:	53                   	push   %ebx
 3fe:	83 ec 3c             	sub    $0x3c,%esp
 401:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 404:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 407:	0f b6 13             	movzbl (%ebx),%edx
 40a:	84 d2                	test   %dl,%dl
 40c:	0f 84 be 00 00 00    	je     4d0 <printf+0xd8>
 412:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 413:	8d 45 10             	lea    0x10(%ebp),%eax
 416:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 419:	31 ff                	xor    %edi,%edi
 41b:	eb 33                	jmp    450 <printf+0x58>
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 420:	83 fa 25             	cmp    $0x25,%edx
 423:	0f 84 af 00 00 00    	je     4d8 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 429:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 42c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 433:	00 
 434:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 437:	89 44 24 04          	mov    %eax,0x4(%esp)
 43b:	89 34 24             	mov    %esi,(%esp)
 43e:	e8 a1 fe ff ff       	call   2e4 <write>
 443:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 444:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 448:	84 d2                	test   %dl,%dl
 44a:	0f 84 80 00 00 00    	je     4d0 <printf+0xd8>
    c = fmt[i] & 0xff;
 450:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 453:	85 ff                	test   %edi,%edi
 455:	74 c9                	je     420 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 457:	83 ff 25             	cmp    $0x25,%edi
 45a:	75 e7                	jne    443 <printf+0x4b>
      if(c == 'd'){
 45c:	83 fa 64             	cmp    $0x64,%edx
 45f:	0f 84 0f 01 00 00    	je     574 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 465:	25 f7 00 00 00       	and    $0xf7,%eax
 46a:	83 f8 70             	cmp    $0x70,%eax
 46d:	74 75                	je     4e4 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 46f:	83 fa 73             	cmp    $0x73,%edx
 472:	0f 84 90 00 00 00    	je     508 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 478:	83 fa 63             	cmp    $0x63,%edx
 47b:	0f 84 c7 00 00 00    	je     548 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 481:	83 fa 25             	cmp    $0x25,%edx
 484:	0f 84 0e 01 00 00    	je     598 <printf+0x1a0>
 48a:	89 55 d0             	mov    %edx,-0x30(%ebp)
 48d:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 491:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 498:	00 
 499:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 49c:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a0:	89 34 24             	mov    %esi,(%esp)
 4a3:	e8 3c fe ff ff       	call   2e4 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4a8:	8b 55 d0             	mov    -0x30(%ebp),%edx
 4ab:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4b5:	00 
 4b6:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bd:	89 34 24             	mov    %esi,(%esp)
 4c0:	e8 1f fe ff ff       	call   2e4 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c5:	31 ff                	xor    %edi,%edi
 4c7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4cc:	84 d2                	test   %dl,%dl
 4ce:	75 80                	jne    450 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4d0:	83 c4 3c             	add    $0x3c,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4d8:	bf 25 00 00 00       	mov    $0x25,%edi
 4dd:	e9 61 ff ff ff       	jmp    443 <printf+0x4b>
 4e2:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4f3:	8b 10                	mov    (%eax),%edx
 4f5:	89 f0                	mov    %esi,%eax
 4f7:	e8 68 fe ff ff       	call   364 <printint>
        ap++;
 4fc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 500:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 502:	e9 3c ff ff ff       	jmp    443 <printf+0x4b>
 507:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 508:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 50b:	8b 38                	mov    (%eax),%edi
        ap++;
 50d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 511:	85 ff                	test   %edi,%edi
 513:	0f 84 a1 00 00 00    	je     5ba <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 519:	8a 07                	mov    (%edi),%al
 51b:	84 c0                	test   %al,%al
 51d:	74 22                	je     541 <printf+0x149>
 51f:	90                   	nop
 520:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 523:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 52a:	00 
 52b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 52e:	89 44 24 04          	mov    %eax,0x4(%esp)
 532:	89 34 24             	mov    %esi,(%esp)
 535:	e8 aa fd ff ff       	call   2e4 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 53a:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	8a 07                	mov    (%edi),%al
 53d:	84 c0                	test   %al,%al
 53f:	75 df                	jne    520 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 541:	31 ff                	xor    %edi,%edi
 543:	e9 fb fe ff ff       	jmp    443 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 548:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 54b:	8b 00                	mov    (%eax),%eax
 54d:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 550:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 557:	00 
 558:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 55b:	89 44 24 04          	mov    %eax,0x4(%esp)
 55f:	89 34 24             	mov    %esi,(%esp)
 562:	e8 7d fd ff ff       	call   2e4 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 567:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 56b:	31 ff                	xor    %edi,%edi
 56d:	e9 d1 fe ff ff       	jmp    443 <printf+0x4b>
 572:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 574:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 57b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 580:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 583:	8b 10                	mov    (%eax),%edx
 585:	89 f0                	mov    %esi,%eax
 587:	e8 d8 fd ff ff       	call   364 <printint>
        ap++;
 58c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 590:	66 31 ff             	xor    %di,%di
 593:	e9 ab fe ff ff       	jmp    443 <printf+0x4b>
 598:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a3:	00 
 5a4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ab:	89 34 24             	mov    %esi,(%esp)
 5ae:	e8 31 fd ff ff       	call   2e4 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b3:	31 ff                	xor    %edi,%edi
 5b5:	e9 89 fe ff ff       	jmp    443 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 5ba:	bf 6e 07 00 00       	mov    $0x76e,%edi
 5bf:	e9 55 ff ff ff       	jmp    519 <printf+0x121>

000005c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c4:	55                   	push   %ebp
 5c5:	89 e5                	mov    %esp,%ebp
 5c7:	57                   	push   %edi
 5c8:	56                   	push   %esi
 5c9:	53                   	push   %ebx
 5ca:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5cd:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d0:	a1 f0 09 00 00       	mov    0x9f0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d5:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d7:	39 d0                	cmp    %edx,%eax
 5d9:	72 11                	jb     5ec <free+0x28>
 5db:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5dc:	39 c8                	cmp    %ecx,%eax
 5de:	72 04                	jb     5e4 <free+0x20>
 5e0:	39 ca                	cmp    %ecx,%edx
 5e2:	72 10                	jb     5f4 <free+0x30>
 5e4:	89 c8                	mov    %ecx,%eax
 5e6:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e8:	39 d0                	cmp    %edx,%eax
 5ea:	73 f0                	jae    5dc <free+0x18>
 5ec:	39 ca                	cmp    %ecx,%edx
 5ee:	72 04                	jb     5f4 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f0:	39 c8                	cmp    %ecx,%eax
 5f2:	72 f0                	jb     5e4 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5f7:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5fa:	39 cf                	cmp    %ecx,%edi
 5fc:	74 1a                	je     618 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5fe:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 601:	8b 48 04             	mov    0x4(%eax),%ecx
 604:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 607:	39 f2                	cmp    %esi,%edx
 609:	74 24                	je     62f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 60b:	89 10                	mov    %edx,(%eax)
  freep = p;
 60d:	a3 f0 09 00 00       	mov    %eax,0x9f0
}
 612:	5b                   	pop    %ebx
 613:	5e                   	pop    %esi
 614:	5f                   	pop    %edi
 615:	5d                   	pop    %ebp
 616:	c3                   	ret    
 617:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 618:	03 71 04             	add    0x4(%ecx),%esi
 61b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 61e:	8b 08                	mov    (%eax),%ecx
 620:	8b 09                	mov    (%ecx),%ecx
 622:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 625:	8b 48 04             	mov    0x4(%eax),%ecx
 628:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 62b:	39 f2                	cmp    %esi,%edx
 62d:	75 dc                	jne    60b <free+0x47>
    p->s.size += bp->s.size;
 62f:	03 4b fc             	add    -0x4(%ebx),%ecx
 632:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 635:	8b 53 f8             	mov    -0x8(%ebx),%edx
 638:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 63a:	a3 f0 09 00 00       	mov    %eax,0x9f0
}
 63f:	5b                   	pop    %ebx
 640:	5e                   	pop    %esi
 641:	5f                   	pop    %edi
 642:	5d                   	pop    %ebp
 643:	c3                   	ret    

00000644 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 644:	55                   	push   %ebp
 645:	89 e5                	mov    %esp,%ebp
 647:	57                   	push   %edi
 648:	56                   	push   %esi
 649:	53                   	push   %ebx
 64a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
 650:	8d 70 07             	lea    0x7(%eax),%esi
 653:	c1 ee 03             	shr    $0x3,%esi
 656:	46                   	inc    %esi
  if((prevp = freep) == 0){
 657:	8b 1d f0 09 00 00    	mov    0x9f0,%ebx
 65d:	85 db                	test   %ebx,%ebx
 65f:	0f 84 91 00 00 00    	je     6f6 <malloc+0xb2>
 665:	8b 13                	mov    (%ebx),%edx
 667:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 66a:	39 ce                	cmp    %ecx,%esi
 66c:	76 52                	jbe    6c0 <malloc+0x7c>
 66e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 675:	eb 0c                	jmp    683 <malloc+0x3f>
 677:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 678:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 67a:	8b 48 04             	mov    0x4(%eax),%ecx
 67d:	39 ce                	cmp    %ecx,%esi
 67f:	76 43                	jbe    6c4 <malloc+0x80>
 681:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 683:	3b 15 f0 09 00 00    	cmp    0x9f0,%edx
 689:	75 ed                	jne    678 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 68b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 691:	76 51                	jbe    6e4 <malloc+0xa0>
 693:	89 d8                	mov    %ebx,%eax
 695:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 697:	89 04 24             	mov    %eax,(%esp)
 69a:	e8 ad fc ff ff       	call   34c <sbrk>
  if(p == (char*)-1)
 69f:	83 f8 ff             	cmp    $0xffffffff,%eax
 6a2:	74 18                	je     6bc <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6a4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6a7:	83 c0 08             	add    $0x8,%eax
 6aa:	89 04 24             	mov    %eax,(%esp)
 6ad:	e8 12 ff ff ff       	call   5c4 <free>
  return freep;
 6b2:	8b 15 f0 09 00 00    	mov    0x9f0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6b8:	85 d2                	test   %edx,%edx
 6ba:	75 bc                	jne    678 <malloc+0x34>
        return 0;
 6bc:	31 c0                	xor    %eax,%eax
 6be:	eb 1c                	jmp    6dc <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c0:	89 d0                	mov    %edx,%eax
 6c2:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 6c4:	39 ce                	cmp    %ecx,%esi
 6c6:	74 28                	je     6f0 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6c8:	29 f1                	sub    %esi,%ecx
 6ca:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6cd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6d0:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 6d3:	89 15 f0 09 00 00    	mov    %edx,0x9f0
      return (void*)(p + 1);
 6d9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6dc:	83 c4 1c             	add    $0x1c,%esp
 6df:	5b                   	pop    %ebx
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6e4:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 6e9:	bf 00 10 00 00       	mov    $0x1000,%edi
 6ee:	eb a7                	jmp    697 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6f0:	8b 08                	mov    (%eax),%ecx
 6f2:	89 0a                	mov    %ecx,(%edx)
 6f4:	eb dd                	jmp    6d3 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6f6:	c7 05 f0 09 00 00 f4 	movl   $0x9f4,0x9f0
 6fd:	09 00 00 
 700:	c7 05 f4 09 00 00 f4 	movl   $0x9f4,0x9f4
 707:	09 00 00 
    base.s.size = 0;
 70a:	c7 05 f8 09 00 00 00 	movl   $0x0,0x9f8
 711:	00 00 00 
 714:	ba f4 09 00 00       	mov    $0x9f4,%edx
 719:	e9 50 ff ff ff       	jmp    66e <malloc+0x2a>
