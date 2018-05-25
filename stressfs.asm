
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
   f:	be 61 07 00 00       	mov    $0x761,%esi
  14:	b9 0a 00 00 00       	mov    $0xa,%ecx
  19:	8d 7c 24 16          	lea    0x16(%esp),%edi
  1d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  1f:	c7 44 24 04 3e 07 00 	movl   $0x73e,0x4(%esp)
  26:	00 
  27:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2e:	e8 e5 03 00 00       	call   418 <printf>
  memset(data, 'a', sizeof(data));
  33:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  3a:	00 
  3b:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  42:	00 
  43:	8d 74 24 20          	lea    0x20(%esp),%esi
  47:	89 34 24             	mov    %esi,(%esp)
  4a:	e8 55 01 00 00       	call   1a4 <memset>

  for(i = 0; i < 4; i++)
  4f:	31 db                	xor    %ebx,%ebx
    if(fork() > 0)
  51:	e8 86 02 00 00       	call   2dc <fork>
  56:	85 c0                	test   %eax,%eax
  58:	0f 8f bf 00 00 00    	jg     11d <main+0x11d>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  5e:	43                   	inc    %ebx
  5f:	83 fb 04             	cmp    $0x4,%ebx
  62:	75 ed                	jne    51 <main+0x51>
  64:	bf 04 00 00 00       	mov    $0x4,%edi
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  69:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  6d:	c7 44 24 04 51 07 00 	movl   $0x751,0x4(%esp)
  74:	00 
  75:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7c:	e8 97 03 00 00       	call   418 <printf>

  path[8] += i;
  81:	89 f8                	mov    %edi,%eax
  83:	00 44 24 1e          	add    %al,0x1e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  87:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  8e:	00 
  8f:	8d 44 24 16          	lea    0x16(%esp),%eax
  93:	89 04 24             	mov    %eax,(%esp)
  96:	e8 89 02 00 00       	call   324 <open>
  9b:	89 c7                	mov    %eax,%edi
  9d:	bb 14 00 00 00       	mov    $0x14,%ebx
  a2:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  a4:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  ab:	00 
  ac:	89 74 24 04          	mov    %esi,0x4(%esp)
  b0:	89 3c 24             	mov    %edi,(%esp)
  b3:	e8 4c 02 00 00       	call   304 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  b8:	4b                   	dec    %ebx
  b9:	75 e9                	jne    a4 <main+0xa4>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  bb:	89 3c 24             	mov    %edi,(%esp)
  be:	e8 49 02 00 00       	call   30c <close>

  printf(1, "read\n");
  c3:	c7 44 24 04 5b 07 00 	movl   $0x75b,0x4(%esp)
  ca:	00 
  cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d2:	e8 41 03 00 00       	call   418 <printf>

  fd = open(path, O_RDONLY);
  d7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  de:	00 
  df:	8d 44 24 16          	lea    0x16(%esp),%eax
  e3:	89 04 24             	mov    %eax,(%esp)
  e6:	e8 39 02 00 00       	call   324 <open>
  eb:	89 c7                	mov    %eax,%edi
  ed:	bb 14 00 00 00       	mov    $0x14,%ebx
  f2:	66 90                	xchg   %ax,%ax
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  f4:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  fb:	00 
  fc:	89 74 24 04          	mov    %esi,0x4(%esp)
 100:	89 3c 24             	mov    %edi,(%esp)
 103:	e8 f4 01 00 00       	call   2fc <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 108:	4b                   	dec    %ebx
 109:	75 e9                	jne    f4 <main+0xf4>
    read(fd, data, sizeof(data));
  close(fd);
 10b:	89 3c 24             	mov    %edi,(%esp)
 10e:	e8 f9 01 00 00       	call   30c <close>

  wait();
 113:	e8 d4 01 00 00       	call   2ec <wait>

  exit();
 118:	e8 c7 01 00 00       	call   2e4 <exit>
 11d:	89 df                	mov    %ebx,%edi
 11f:	e9 45 ff ff ff       	jmp    69 <main+0x69>

00000124 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	53                   	push   %ebx
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12e:	89 c2                	mov    %eax,%edx
 130:	42                   	inc    %edx
 131:	41                   	inc    %ecx
 132:	8a 59 ff             	mov    -0x1(%ecx),%bl
 135:	88 5a ff             	mov    %bl,-0x1(%edx)
 138:	84 db                	test   %bl,%bl
 13a:	75 f4                	jne    130 <strcpy+0xc>
    ;
  return os;
}
 13c:	5b                   	pop    %ebx
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret    
 13f:	90                   	nop

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	74 27                	je     178 <strcmp+0x38>
 151:	8a 19                	mov    (%ecx),%bl
 153:	38 d8                	cmp    %bl,%al
 155:	74 0b                	je     162 <strcmp+0x22>
 157:	eb 26                	jmp    17f <strcmp+0x3f>
 159:	8d 76 00             	lea    0x0(%esi),%esi
 15c:	38 c8                	cmp    %cl,%al
 15e:	75 13                	jne    173 <strcmp+0x33>
    p++, q++;
 160:	89 d9                	mov    %ebx,%ecx
 162:	42                   	inc    %edx
 163:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 166:	0f b6 02             	movzbl (%edx),%eax
 169:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 16d:	84 c0                	test   %al,%al
 16f:	75 eb                	jne    15c <strcmp+0x1c>
 171:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 173:	29 c8                	sub    %ecx,%eax
}
 175:	5b                   	pop    %ebx
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 17b:	31 c0                	xor    %eax,%eax
 17d:	eb f4                	jmp    173 <strcmp+0x33>
 17f:	0f b6 cb             	movzbl %bl,%ecx
 182:	eb ef                	jmp    173 <strcmp+0x33>

00000184 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 18a:	80 39 00             	cmpb   $0x0,(%ecx)
 18d:	74 10                	je     19f <strlen+0x1b>
 18f:	31 d2                	xor    %edx,%edx
 191:	8d 76 00             	lea    0x0(%esi),%esi
 194:	42                   	inc    %edx
 195:	89 d0                	mov    %edx,%eax
 197:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 19b:	75 f7                	jne    194 <strlen+0x10>
    ;
  return n;
}
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 19f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	90                   	nop

000001a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	57                   	push   %edi
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1ab:	89 d7                	mov    %edx,%edi
 1ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b3:	fc                   	cld    
 1b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b6:	89 d0                	mov    %edx,%eax
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	90                   	nop

000001bc <strchr>:

char*
strchr(const char *s, char c)
{
 1bc:	55                   	push   %ebp
 1bd:	89 e5                	mov    %esp,%ebp
 1bf:	53                   	push   %ebx
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1c6:	8a 10                	mov    (%eax),%dl
 1c8:	84 d2                	test   %dl,%dl
 1ca:	74 13                	je     1df <strchr+0x23>
 1cc:	88 d9                	mov    %bl,%cl
    if(*s == c)
 1ce:	38 da                	cmp    %bl,%dl
 1d0:	75 06                	jne    1d8 <strchr+0x1c>
 1d2:	eb 0d                	jmp    1e1 <strchr+0x25>
 1d4:	38 ca                	cmp    %cl,%dl
 1d6:	74 09                	je     1e1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1d8:	40                   	inc    %eax
 1d9:	8a 10                	mov    (%eax),%dl
 1db:	84 d2                	test   %dl,%dl
 1dd:	75 f5                	jne    1d4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1df:	31 c0                	xor    %eax,%eax
}
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    

000001e4 <gets>:

char*
gets(char *buf, int max)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	57                   	push   %edi
 1e8:	56                   	push   %esi
 1e9:	53                   	push   %ebx
 1ea:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ed:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1ef:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f2:	eb 30                	jmp    224 <gets+0x40>
    cc = read(0, &c, 1);
 1f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1fb:	00 
 1fc:	89 7c 24 04          	mov    %edi,0x4(%esp)
 200:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 207:	e8 f0 00 00 00       	call   2fc <read>
    if(cc < 1)
 20c:	85 c0                	test   %eax,%eax
 20e:	7e 1c                	jle    22c <gets+0x48>
      break;
    buf[i++] = c;
 210:	8a 45 e7             	mov    -0x19(%ebp),%al
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21a:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21c:	3c 0a                	cmp    $0xa,%al
 21e:	74 0c                	je     22c <gets+0x48>
 220:	3c 0d                	cmp    $0xd,%al
 222:	74 08                	je     22c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 224:	8d 5e 01             	lea    0x1(%esi),%ebx
 227:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22a:	7c c8                	jl     1f4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 233:	83 c4 2c             	add    $0x2c,%esp
 236:	5b                   	pop    %ebx
 237:	5e                   	pop    %esi
 238:	5f                   	pop    %edi
 239:	5d                   	pop    %ebp
 23a:	c3                   	ret    
 23b:	90                   	nop

0000023c <stat>:

int
stat(char *n, struct stat *st)
{
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	56                   	push   %esi
 240:	53                   	push   %ebx
 241:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 244:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 24b:	00 
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	89 04 24             	mov    %eax,(%esp)
 252:	e8 cd 00 00 00       	call   324 <open>
 257:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 259:	85 c0                	test   %eax,%eax
 25b:	78 23                	js     280 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 25d:	8b 45 0c             	mov    0xc(%ebp),%eax
 260:	89 44 24 04          	mov    %eax,0x4(%esp)
 264:	89 1c 24             	mov    %ebx,(%esp)
 267:	e8 d0 00 00 00       	call   33c <fstat>
 26c:	89 c6                	mov    %eax,%esi
  close(fd);
 26e:	89 1c 24             	mov    %ebx,(%esp)
 271:	e8 96 00 00 00       	call   30c <close>
  return r;
 276:	89 f0                	mov    %esi,%eax
}
 278:	83 c4 10             	add    $0x10,%esp
 27b:	5b                   	pop    %ebx
 27c:	5e                   	pop    %esi
 27d:	5d                   	pop    %ebp
 27e:	c3                   	ret    
 27f:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 285:	eb f1                	jmp    278 <stat+0x3c>
 287:	90                   	nop

00000288 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 288:	55                   	push   %ebp
 289:	89 e5                	mov    %esp,%ebp
 28b:	53                   	push   %ebx
 28c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28f:	0f be 11             	movsbl (%ecx),%edx
 292:	8d 42 d0             	lea    -0x30(%edx),%eax
 295:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 297:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 29c:	77 15                	ja     2b3 <atoi+0x2b>
 29e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2a0:	41                   	inc    %ecx
 2a1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2a4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a8:	0f be 11             	movsbl (%ecx),%edx
 2ab:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2ae:	80 fb 09             	cmp    $0x9,%bl
 2b1:	76 ed                	jbe    2a0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2b3:	5b                   	pop    %ebx
 2b4:	5d                   	pop    %ebp
 2b5:	c3                   	ret    
 2b6:	66 90                	xchg   %ax,%ax

000002b8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	56                   	push   %esi
 2bc:	53                   	push   %ebx
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2c3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c6:	31 d2                	xor    %edx,%edx
 2c8:	85 f6                	test   %esi,%esi
 2ca:	7e 0b                	jle    2d7 <memmove+0x1f>
    *dst++ = *src++;
 2cc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2cf:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2d2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2d3:	39 f2                	cmp    %esi,%edx
 2d5:	75 f5                	jne    2cc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2d7:	5b                   	pop    %ebx
 2d8:	5e                   	pop    %esi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    
 2db:	90                   	nop

000002dc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2dc:	b8 01 00 00 00       	mov    $0x1,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <exit>:
SYSCALL(exit)
 2e4:	b8 02 00 00 00       	mov    $0x2,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <wait>:
SYSCALL(wait)
 2ec:	b8 03 00 00 00       	mov    $0x3,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <pipe>:
SYSCALL(pipe)
 2f4:	b8 04 00 00 00       	mov    $0x4,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <read>:
SYSCALL(read)
 2fc:	b8 05 00 00 00       	mov    $0x5,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <write>:
SYSCALL(write)
 304:	b8 10 00 00 00       	mov    $0x10,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <close>:
SYSCALL(close)
 30c:	b8 15 00 00 00       	mov    $0x15,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <kill>:
SYSCALL(kill)
 314:	b8 06 00 00 00       	mov    $0x6,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <exec>:
SYSCALL(exec)
 31c:	b8 07 00 00 00       	mov    $0x7,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <open>:
SYSCALL(open)
 324:	b8 0f 00 00 00       	mov    $0xf,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <mknod>:
SYSCALL(mknod)
 32c:	b8 11 00 00 00       	mov    $0x11,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <unlink>:
SYSCALL(unlink)
 334:	b8 12 00 00 00       	mov    $0x12,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <fstat>:
SYSCALL(fstat)
 33c:	b8 08 00 00 00       	mov    $0x8,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <link>:
SYSCALL(link)
 344:	b8 13 00 00 00       	mov    $0x13,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <mkdir>:
SYSCALL(mkdir)
 34c:	b8 14 00 00 00       	mov    $0x14,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <chdir>:
SYSCALL(chdir)
 354:	b8 09 00 00 00       	mov    $0x9,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <dup>:
SYSCALL(dup)
 35c:	b8 0a 00 00 00       	mov    $0xa,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <getpid>:
SYSCALL(getpid)
 364:	b8 0b 00 00 00       	mov    $0xb,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <sbrk>:
SYSCALL(sbrk)
 36c:	b8 0c 00 00 00       	mov    $0xc,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <sleep>:
SYSCALL(sleep)
 374:	b8 0d 00 00 00       	mov    $0xd,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <uptime>:
SYSCALL(uptime)
 37c:	b8 0e 00 00 00       	mov    $0xe,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	57                   	push   %edi
 388:	56                   	push   %esi
 389:	53                   	push   %ebx
 38a:	83 ec 4c             	sub    $0x4c,%esp
 38d:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 38f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 391:	8b 5d 08             	mov    0x8(%ebp),%ebx
 394:	85 db                	test   %ebx,%ebx
 396:	74 04                	je     39c <printint+0x18>
 398:	85 d2                	test   %edx,%edx
 39a:	78 70                	js     40c <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 39c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3a3:	31 ff                	xor    %edi,%edi
 3a5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3a8:	89 75 c0             	mov    %esi,-0x40(%ebp)
 3ab:	89 ce                	mov    %ecx,%esi
 3ad:	eb 03                	jmp    3b2 <printint+0x2e>
 3af:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 3b0:	89 cf                	mov    %ecx,%edi
 3b2:	8d 4f 01             	lea    0x1(%edi),%ecx
 3b5:	31 d2                	xor    %edx,%edx
 3b7:	f7 f6                	div    %esi
 3b9:	8a 92 72 07 00 00    	mov    0x772(%edx),%dl
 3bf:	88 55 c7             	mov    %dl,-0x39(%ebp)
 3c2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3c5:	85 c0                	test   %eax,%eax
 3c7:	75 e7                	jne    3b0 <printint+0x2c>
 3c9:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3cc:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 3ce:	8b 55 bc             	mov    -0x44(%ebp),%edx
 3d1:	85 d2                	test   %edx,%edx
 3d3:	74 08                	je     3dd <printint+0x59>
    buf[i++] = '-';
 3d5:	8d 4f 02             	lea    0x2(%edi),%ecx
 3d8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3dd:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3e0:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 3e4:	88 45 c7             	mov    %al,-0x39(%ebp)
 3e7:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f1:	00 
 3f2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3f6:	89 34 24             	mov    %esi,(%esp)
 3f9:	e8 06 ff ff ff       	call   304 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3fe:	4f                   	dec    %edi
 3ff:	83 ff ff             	cmp    $0xffffffff,%edi
 402:	75 dc                	jne    3e0 <printint+0x5c>
    putc(fd, buf[i]);
}
 404:	83 c4 4c             	add    $0x4c,%esp
 407:	5b                   	pop    %ebx
 408:	5e                   	pop    %esi
 409:	5f                   	pop    %edi
 40a:	5d                   	pop    %ebp
 40b:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 40c:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 40e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 415:	eb 8c                	jmp    3a3 <printint+0x1f>
 417:	90                   	nop

00000418 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 418:	55                   	push   %ebp
 419:	89 e5                	mov    %esp,%ebp
 41b:	57                   	push   %edi
 41c:	56                   	push   %esi
 41d:	53                   	push   %ebx
 41e:	83 ec 3c             	sub    $0x3c,%esp
 421:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 424:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 427:	0f b6 13             	movzbl (%ebx),%edx
 42a:	84 d2                	test   %dl,%dl
 42c:	0f 84 be 00 00 00    	je     4f0 <printf+0xd8>
 432:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 433:	8d 45 10             	lea    0x10(%ebp),%eax
 436:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 439:	31 ff                	xor    %edi,%edi
 43b:	eb 33                	jmp    470 <printf+0x58>
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 440:	83 fa 25             	cmp    $0x25,%edx
 443:	0f 84 af 00 00 00    	je     4f8 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 449:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 44c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 453:	00 
 454:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 457:	89 44 24 04          	mov    %eax,0x4(%esp)
 45b:	89 34 24             	mov    %esi,(%esp)
 45e:	e8 a1 fe ff ff       	call   304 <write>
 463:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 464:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 468:	84 d2                	test   %dl,%dl
 46a:	0f 84 80 00 00 00    	je     4f0 <printf+0xd8>
    c = fmt[i] & 0xff;
 470:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 473:	85 ff                	test   %edi,%edi
 475:	74 c9                	je     440 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 477:	83 ff 25             	cmp    $0x25,%edi
 47a:	75 e7                	jne    463 <printf+0x4b>
      if(c == 'd'){
 47c:	83 fa 64             	cmp    $0x64,%edx
 47f:	0f 84 0f 01 00 00    	je     594 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 485:	25 f7 00 00 00       	and    $0xf7,%eax
 48a:	83 f8 70             	cmp    $0x70,%eax
 48d:	74 75                	je     504 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 48f:	83 fa 73             	cmp    $0x73,%edx
 492:	0f 84 90 00 00 00    	je     528 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 498:	83 fa 63             	cmp    $0x63,%edx
 49b:	0f 84 c7 00 00 00    	je     568 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a1:	83 fa 25             	cmp    $0x25,%edx
 4a4:	0f 84 0e 01 00 00    	je     5b8 <printf+0x1a0>
 4aa:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4ad:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4b8:	00 
 4b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c0:	89 34 24             	mov    %esi,(%esp)
 4c3:	e8 3c fe ff ff       	call   304 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4c8:	8b 55 d0             	mov    -0x30(%ebp),%edx
 4cb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ce:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d5:	00 
 4d6:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dd:	89 34 24             	mov    %esi,(%esp)
 4e0:	e8 1f fe ff ff       	call   304 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e5:	31 ff                	xor    %edi,%edi
 4e7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4ec:	84 d2                	test   %dl,%dl
 4ee:	75 80                	jne    470 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4f0:	83 c4 3c             	add    $0x3c,%esp
 4f3:	5b                   	pop    %ebx
 4f4:	5e                   	pop    %esi
 4f5:	5f                   	pop    %edi
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4f8:	bf 25 00 00 00       	mov    $0x25,%edi
 4fd:	e9 61 ff ff ff       	jmp    463 <printf+0x4b>
 502:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 504:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 50b:	b9 10 00 00 00       	mov    $0x10,%ecx
 510:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 513:	8b 10                	mov    (%eax),%edx
 515:	89 f0                	mov    %esi,%eax
 517:	e8 68 fe ff ff       	call   384 <printint>
        ap++;
 51c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 520:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 522:	e9 3c ff ff ff       	jmp    463 <printf+0x4b>
 527:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 528:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 52b:	8b 38                	mov    (%eax),%edi
        ap++;
 52d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 531:	85 ff                	test   %edi,%edi
 533:	0f 84 a1 00 00 00    	je     5da <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 539:	8a 07                	mov    (%edi),%al
 53b:	84 c0                	test   %al,%al
 53d:	74 22                	je     561 <printf+0x149>
 53f:	90                   	nop
 540:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 543:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 54a:	00 
 54b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 54e:	89 44 24 04          	mov    %eax,0x4(%esp)
 552:	89 34 24             	mov    %esi,(%esp)
 555:	e8 aa fd ff ff       	call   304 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 55a:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 55b:	8a 07                	mov    (%edi),%al
 55d:	84 c0                	test   %al,%al
 55f:	75 df                	jne    540 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 561:	31 ff                	xor    %edi,%edi
 563:	e9 fb fe ff ff       	jmp    463 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 568:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 56b:	8b 00                	mov    (%eax),%eax
 56d:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 570:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 577:	00 
 578:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 57b:	89 44 24 04          	mov    %eax,0x4(%esp)
 57f:	89 34 24             	mov    %esi,(%esp)
 582:	e8 7d fd ff ff       	call   304 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 587:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 58b:	31 ff                	xor    %edi,%edi
 58d:	e9 d1 fe ff ff       	jmp    463 <printf+0x4b>
 592:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 594:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 59b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5a3:	8b 10                	mov    (%eax),%edx
 5a5:	89 f0                	mov    %esi,%eax
 5a7:	e8 d8 fd ff ff       	call   384 <printint>
        ap++;
 5ac:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b0:	66 31 ff             	xor    %di,%di
 5b3:	e9 ab fe ff ff       	jmp    463 <printf+0x4b>
 5b8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c3:	00 
 5c4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cb:	89 34 24             	mov    %esi,(%esp)
 5ce:	e8 31 fd ff ff       	call   304 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5d3:	31 ff                	xor    %edi,%edi
 5d5:	e9 89 fe ff ff       	jmp    463 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 5da:	bf 6b 07 00 00       	mov    $0x76b,%edi
 5df:	e9 55 ff ff ff       	jmp    539 <printf+0x121>

000005e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e4:	55                   	push   %ebp
 5e5:	89 e5                	mov    %esp,%ebp
 5e7:	57                   	push   %edi
 5e8:	56                   	push   %esi
 5e9:	53                   	push   %ebx
 5ea:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5ed:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f0:	a1 e8 09 00 00       	mov    0x9e8,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f5:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f7:	39 d0                	cmp    %edx,%eax
 5f9:	72 11                	jb     60c <free+0x28>
 5fb:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fc:	39 c8                	cmp    %ecx,%eax
 5fe:	72 04                	jb     604 <free+0x20>
 600:	39 ca                	cmp    %ecx,%edx
 602:	72 10                	jb     614 <free+0x30>
 604:	89 c8                	mov    %ecx,%eax
 606:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 608:	39 d0                	cmp    %edx,%eax
 60a:	73 f0                	jae    5fc <free+0x18>
 60c:	39 ca                	cmp    %ecx,%edx
 60e:	72 04                	jb     614 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 610:	39 c8                	cmp    %ecx,%eax
 612:	72 f0                	jb     604 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 614:	8b 73 fc             	mov    -0x4(%ebx),%esi
 617:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 61a:	39 cf                	cmp    %ecx,%edi
 61c:	74 1a                	je     638 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 61e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 621:	8b 48 04             	mov    0x4(%eax),%ecx
 624:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 627:	39 f2                	cmp    %esi,%edx
 629:	74 24                	je     64f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 62b:	89 10                	mov    %edx,(%eax)
  freep = p;
 62d:	a3 e8 09 00 00       	mov    %eax,0x9e8
}
 632:	5b                   	pop    %ebx
 633:	5e                   	pop    %esi
 634:	5f                   	pop    %edi
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 638:	03 71 04             	add    0x4(%ecx),%esi
 63b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 63e:	8b 08                	mov    (%eax),%ecx
 640:	8b 09                	mov    (%ecx),%ecx
 642:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 645:	8b 48 04             	mov    0x4(%eax),%ecx
 648:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 64b:	39 f2                	cmp    %esi,%edx
 64d:	75 dc                	jne    62b <free+0x47>
    p->s.size += bp->s.size;
 64f:	03 4b fc             	add    -0x4(%ebx),%ecx
 652:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 655:	8b 53 f8             	mov    -0x8(%ebx),%edx
 658:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 65a:	a3 e8 09 00 00       	mov    %eax,0x9e8
}
 65f:	5b                   	pop    %ebx
 660:	5e                   	pop    %esi
 661:	5f                   	pop    %edi
 662:	5d                   	pop    %ebp
 663:	c3                   	ret    

00000664 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 664:	55                   	push   %ebp
 665:	89 e5                	mov    %esp,%ebp
 667:	57                   	push   %edi
 668:	56                   	push   %esi
 669:	53                   	push   %ebx
 66a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
 670:	8d 70 07             	lea    0x7(%eax),%esi
 673:	c1 ee 03             	shr    $0x3,%esi
 676:	46                   	inc    %esi
  if((prevp = freep) == 0){
 677:	8b 1d e8 09 00 00    	mov    0x9e8,%ebx
 67d:	85 db                	test   %ebx,%ebx
 67f:	0f 84 91 00 00 00    	je     716 <malloc+0xb2>
 685:	8b 13                	mov    (%ebx),%edx
 687:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 68a:	39 ce                	cmp    %ecx,%esi
 68c:	76 52                	jbe    6e0 <malloc+0x7c>
 68e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 695:	eb 0c                	jmp    6a3 <malloc+0x3f>
 697:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 698:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 69a:	8b 48 04             	mov    0x4(%eax),%ecx
 69d:	39 ce                	cmp    %ecx,%esi
 69f:	76 43                	jbe    6e4 <malloc+0x80>
 6a1:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6a3:	3b 15 e8 09 00 00    	cmp    0x9e8,%edx
 6a9:	75 ed                	jne    698 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6ab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 6b1:	76 51                	jbe    704 <malloc+0xa0>
 6b3:	89 d8                	mov    %ebx,%eax
 6b5:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6b7:	89 04 24             	mov    %eax,(%esp)
 6ba:	e8 ad fc ff ff       	call   36c <sbrk>
  if(p == (char*)-1)
 6bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 6c2:	74 18                	je     6dc <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6c4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6c7:	83 c0 08             	add    $0x8,%eax
 6ca:	89 04 24             	mov    %eax,(%esp)
 6cd:	e8 12 ff ff ff       	call   5e4 <free>
  return freep;
 6d2:	8b 15 e8 09 00 00    	mov    0x9e8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6d8:	85 d2                	test   %edx,%edx
 6da:	75 bc                	jne    698 <malloc+0x34>
        return 0;
 6dc:	31 c0                	xor    %eax,%eax
 6de:	eb 1c                	jmp    6fc <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e0:	89 d0                	mov    %edx,%eax
 6e2:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 6e4:	39 ce                	cmp    %ecx,%esi
 6e6:	74 28                	je     710 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6e8:	29 f1                	sub    %esi,%ecx
 6ea:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6ed:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6f0:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 6f3:	89 15 e8 09 00 00    	mov    %edx,0x9e8
      return (void*)(p + 1);
 6f9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6fc:	83 c4 1c             	add    $0x1c,%esp
 6ff:	5b                   	pop    %ebx
 700:	5e                   	pop    %esi
 701:	5f                   	pop    %edi
 702:	5d                   	pop    %ebp
 703:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 704:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 709:	bf 00 10 00 00       	mov    $0x1000,%edi
 70e:	eb a7                	jmp    6b7 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 710:	8b 08                	mov    (%eax),%ecx
 712:	89 0a                	mov    %ecx,(%edx)
 714:	eb dd                	jmp    6f3 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 716:	c7 05 e8 09 00 00 ec 	movl   $0x9ec,0x9e8
 71d:	09 00 00 
 720:	c7 05 ec 09 00 00 ec 	movl   $0x9ec,0x9ec
 727:	09 00 00 
    base.s.size = 0;
 72a:	c7 05 f0 09 00 00 00 	movl   $0x0,0x9f0
 731:	00 00 00 
 734:	ba ec 09 00 00       	mov    $0x9ec,%edx
 739:	e9 50 ff ff ff       	jmp    68e <malloc+0x2a>
