
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  int fd, i;

  if(argc <= 1){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 66                	jle    7a <main+0x7a>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  17:	8d 58 04             	lea    0x4(%eax),%ebx
  1a:	be 01 00 00 00       	mov    $0x1,%esi
  1f:	90                   	nop
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 e2 02 00 00       	call   314 <open>
  32:	85 c0                	test   %eax,%eax
  34:	78 25                	js     5b <main+0x5b>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  36:	89 04 24             	mov    %eax,(%esp)
  39:	89 44 24 0c          	mov    %eax,0xc(%esp)
  3d:	e8 4a 00 00 00       	call   8c <cat>
    close(fd);
  42:	8b 44 24 0c          	mov    0xc(%esp),%eax
  46:	89 04 24             	mov    %eax,(%esp)
  49:	e8 ae 02 00 00       	call   2fc <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  4e:	46                   	inc    %esi
  4f:	83 c3 04             	add    $0x4,%ebx
  52:	39 fe                	cmp    %edi,%esi
  54:	75 ca                	jne    20 <main+0x20>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  56:	e8 79 02 00 00       	call   2d4 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  5b:	8b 03                	mov    (%ebx),%eax
  5d:	89 44 24 08          	mov    %eax,0x8(%esp)
  61:	c7 44 24 04 51 07 00 	movl   $0x751,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	e8 93 03 00 00       	call   408 <printf>
      exit();
  75:	e8 5a 02 00 00       	call   2d4 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  7a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  81:	e8 06 00 00 00       	call   8c <cat>
    exit();
  86:	e8 49 02 00 00       	call   2d4 <exit>
  8b:	90                   	nop

0000008c <cat>:

char buf[512];

void
cat(int fd)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	56                   	push   %esi
  90:	53                   	push   %ebx
  91:	83 ec 10             	sub    $0x10,%esp
  94:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  97:	eb 1f                	jmp    b8 <cat+0x2c>
  99:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  9c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  a0:	c7 44 24 04 40 0a 00 	movl   $0xa40,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  af:	e8 40 02 00 00       	call   2f4 <write>
  b4:	39 d8                	cmp    %ebx,%eax
  b6:	75 28                	jne    e0 <cat+0x54>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  bf:	00 
  c0:	c7 44 24 04 40 0a 00 	movl   $0xa40,0x4(%esp)
  c7:	00 
  c8:	89 34 24             	mov    %esi,(%esp)
  cb:	e8 1c 02 00 00       	call   2ec <read>
  d0:	89 c3                	mov    %eax,%ebx
  d2:	83 f8 00             	cmp    $0x0,%eax
  d5:	7f c5                	jg     9c <cat+0x10>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  if(n < 0){
  d7:	75 20                	jne    f9 <cat+0x6d>
    printf(1, "cat: read error\n");
    exit();
  }
}
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	5b                   	pop    %ebx
  dd:	5e                   	pop    %esi
  de:	5d                   	pop    %ebp
  df:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  e0:	c7 44 24 04 2e 07 00 	movl   $0x72e,0x4(%esp)
  e7:	00 
  e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ef:	e8 14 03 00 00       	call   408 <printf>
      exit();
  f4:	e8 db 01 00 00       	call   2d4 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
  f9:	c7 44 24 04 40 07 00 	movl   $0x740,0x4(%esp)
 100:	00 
 101:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 108:	e8 fb 02 00 00       	call   408 <printf>
    exit();
 10d:	e8 c2 01 00 00       	call   2d4 <exit>
 112:	66 90                	xchg   %ax,%ax

00000114 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	53                   	push   %ebx
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11e:	89 c2                	mov    %eax,%edx
 120:	42                   	inc    %edx
 121:	41                   	inc    %ecx
 122:	8a 59 ff             	mov    -0x1(%ecx),%bl
 125:	88 5a ff             	mov    %bl,-0x1(%edx)
 128:	84 db                	test   %bl,%bl
 12a:	75 f4                	jne    120 <strcpy+0xc>
    ;
  return os;
}
 12c:	5b                   	pop    %ebx
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    
 12f:	90                   	nop

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	74 27                	je     168 <strcmp+0x38>
 141:	8a 19                	mov    (%ecx),%bl
 143:	38 d8                	cmp    %bl,%al
 145:	74 0b                	je     152 <strcmp+0x22>
 147:	eb 26                	jmp    16f <strcmp+0x3f>
 149:	8d 76 00             	lea    0x0(%esi),%esi
 14c:	38 c8                	cmp    %cl,%al
 14e:	75 13                	jne    163 <strcmp+0x33>
    p++, q++;
 150:	89 d9                	mov    %ebx,%ecx
 152:	42                   	inc    %edx
 153:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 156:	0f b6 02             	movzbl (%edx),%eax
 159:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 15d:	84 c0                	test   %al,%al
 15f:	75 eb                	jne    14c <strcmp+0x1c>
 161:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 163:	29 c8                	sub    %ecx,%eax
}
 165:	5b                   	pop    %ebx
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    
 168:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 16b:	31 c0                	xor    %eax,%eax
 16d:	eb f4                	jmp    163 <strcmp+0x33>
 16f:	0f b6 cb             	movzbl %bl,%ecx
 172:	eb ef                	jmp    163 <strcmp+0x33>

00000174 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 17a:	80 39 00             	cmpb   $0x0,(%ecx)
 17d:	74 10                	je     18f <strlen+0x1b>
 17f:	31 d2                	xor    %edx,%edx
 181:	8d 76 00             	lea    0x0(%esi),%esi
 184:	42                   	inc    %edx
 185:	89 d0                	mov    %edx,%eax
 187:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 18b:	75 f7                	jne    184 <strlen+0x10>
    ;
  return n;
}
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 18f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	90                   	nop

00000194 <memset>:

void*
memset(void *dst, int c, uint n)
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	57                   	push   %edi
 198:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 19b:	89 d7                	mov    %edx,%edi
 19d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1a0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a3:	fc                   	cld    
 1a4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a6:	89 d0                	mov    %edx,%eax
 1a8:	5f                   	pop    %edi
 1a9:	5d                   	pop    %ebp
 1aa:	c3                   	ret    
 1ab:	90                   	nop

000001ac <strchr>:

char*
strchr(const char *s, char c)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	53                   	push   %ebx
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1b6:	8a 10                	mov    (%eax),%dl
 1b8:	84 d2                	test   %dl,%dl
 1ba:	74 13                	je     1cf <strchr+0x23>
 1bc:	88 d9                	mov    %bl,%cl
    if(*s == c)
 1be:	38 da                	cmp    %bl,%dl
 1c0:	75 06                	jne    1c8 <strchr+0x1c>
 1c2:	eb 0d                	jmp    1d1 <strchr+0x25>
 1c4:	38 ca                	cmp    %cl,%dl
 1c6:	74 09                	je     1d1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1c8:	40                   	inc    %eax
 1c9:	8a 10                	mov    (%eax),%dl
 1cb:	84 d2                	test   %dl,%dl
 1cd:	75 f5                	jne    1c4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1cf:	31 c0                	xor    %eax,%eax
}
 1d1:	5b                   	pop    %ebx
 1d2:	5d                   	pop    %ebp
 1d3:	c3                   	ret    

000001d4 <gets>:

char*
gets(char *buf, int max)
{
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
 1d8:	56                   	push   %esi
 1d9:	53                   	push   %ebx
 1da:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dd:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1df:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e2:	eb 30                	jmp    214 <gets+0x40>
    cc = read(0, &c, 1);
 1e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1eb:	00 
 1ec:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1f7:	e8 f0 00 00 00       	call   2ec <read>
    if(cc < 1)
 1fc:	85 c0                	test   %eax,%eax
 1fe:	7e 1c                	jle    21c <gets+0x48>
      break;
    buf[i++] = c;
 200:	8a 45 e7             	mov    -0x19(%ebp),%al
 203:	8b 55 08             	mov    0x8(%ebp),%edx
 206:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20a:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20c:	3c 0a                	cmp    $0xa,%al
 20e:	74 0c                	je     21c <gets+0x48>
 210:	3c 0d                	cmp    $0xd,%al
 212:	74 08                	je     21c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 214:	8d 5e 01             	lea    0x1(%esi),%ebx
 217:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 21a:	7c c8                	jl     1e4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
 21f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 223:	83 c4 2c             	add    $0x2c,%esp
 226:	5b                   	pop    %ebx
 227:	5e                   	pop    %esi
 228:	5f                   	pop    %edi
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    
 22b:	90                   	nop

0000022c <stat>:

int
stat(char *n, struct stat *st)
{
 22c:	55                   	push   %ebp
 22d:	89 e5                	mov    %esp,%ebp
 22f:	56                   	push   %esi
 230:	53                   	push   %ebx
 231:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 234:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 23b:	00 
 23c:	8b 45 08             	mov    0x8(%ebp),%eax
 23f:	89 04 24             	mov    %eax,(%esp)
 242:	e8 cd 00 00 00       	call   314 <open>
 247:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 249:	85 c0                	test   %eax,%eax
 24b:	78 23                	js     270 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 24d:	8b 45 0c             	mov    0xc(%ebp),%eax
 250:	89 44 24 04          	mov    %eax,0x4(%esp)
 254:	89 1c 24             	mov    %ebx,(%esp)
 257:	e8 d0 00 00 00       	call   32c <fstat>
 25c:	89 c6                	mov    %eax,%esi
  close(fd);
 25e:	89 1c 24             	mov    %ebx,(%esp)
 261:	e8 96 00 00 00       	call   2fc <close>
  return r;
 266:	89 f0                	mov    %esi,%eax
}
 268:	83 c4 10             	add    $0x10,%esp
 26b:	5b                   	pop    %ebx
 26c:	5e                   	pop    %esi
 26d:	5d                   	pop    %ebp
 26e:	c3                   	ret    
 26f:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 275:	eb f1                	jmp    268 <stat+0x3c>
 277:	90                   	nop

00000278 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	53                   	push   %ebx
 27c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27f:	0f be 11             	movsbl (%ecx),%edx
 282:	8d 42 d0             	lea    -0x30(%edx),%eax
 285:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 287:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 28c:	77 15                	ja     2a3 <atoi+0x2b>
 28e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 290:	41                   	inc    %ecx
 291:	8d 04 80             	lea    (%eax,%eax,4),%eax
 294:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 298:	0f be 11             	movsbl (%ecx),%edx
 29b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 29e:	80 fb 09             	cmp    $0x9,%bl
 2a1:	76 ed                	jbe    290 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2a3:	5b                   	pop    %ebx
 2a4:	5d                   	pop    %ebp
 2a5:	c3                   	ret    
 2a6:	66 90                	xchg   %ax,%ax

000002a8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	56                   	push   %esi
 2ac:	53                   	push   %ebx
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2b3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b6:	31 d2                	xor    %edx,%edx
 2b8:	85 f6                	test   %esi,%esi
 2ba:	7e 0b                	jle    2c7 <memmove+0x1f>
    *dst++ = *src++;
 2bc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2bf:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2c2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c3:	39 f2                	cmp    %esi,%edx
 2c5:	75 f5                	jne    2bc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2c7:	5b                   	pop    %ebx
 2c8:	5e                   	pop    %esi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret    
 2cb:	90                   	nop

000002cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cc:	b8 01 00 00 00       	mov    $0x1,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <exit>:
SYSCALL(exit)
 2d4:	b8 02 00 00 00       	mov    $0x2,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <wait>:
SYSCALL(wait)
 2dc:	b8 03 00 00 00       	mov    $0x3,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <pipe>:
SYSCALL(pipe)
 2e4:	b8 04 00 00 00       	mov    $0x4,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <read>:
SYSCALL(read)
 2ec:	b8 05 00 00 00       	mov    $0x5,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <write>:
SYSCALL(write)
 2f4:	b8 10 00 00 00       	mov    $0x10,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <close>:
SYSCALL(close)
 2fc:	b8 15 00 00 00       	mov    $0x15,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <kill>:
SYSCALL(kill)
 304:	b8 06 00 00 00       	mov    $0x6,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <exec>:
SYSCALL(exec)
 30c:	b8 07 00 00 00       	mov    $0x7,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <open>:
SYSCALL(open)
 314:	b8 0f 00 00 00       	mov    $0xf,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <mknod>:
SYSCALL(mknod)
 31c:	b8 11 00 00 00       	mov    $0x11,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <unlink>:
SYSCALL(unlink)
 324:	b8 12 00 00 00       	mov    $0x12,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <fstat>:
SYSCALL(fstat)
 32c:	b8 08 00 00 00       	mov    $0x8,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <link>:
SYSCALL(link)
 334:	b8 13 00 00 00       	mov    $0x13,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <mkdir>:
SYSCALL(mkdir)
 33c:	b8 14 00 00 00       	mov    $0x14,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <chdir>:
SYSCALL(chdir)
 344:	b8 09 00 00 00       	mov    $0x9,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <dup>:
SYSCALL(dup)
 34c:	b8 0a 00 00 00       	mov    $0xa,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <getpid>:
SYSCALL(getpid)
 354:	b8 0b 00 00 00       	mov    $0xb,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <sbrk>:
SYSCALL(sbrk)
 35c:	b8 0c 00 00 00       	mov    $0xc,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <sleep>:
SYSCALL(sleep)
 364:	b8 0d 00 00 00       	mov    $0xd,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <uptime>:
SYSCALL(uptime)
 36c:	b8 0e 00 00 00       	mov    $0xe,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	57                   	push   %edi
 378:	56                   	push   %esi
 379:	53                   	push   %ebx
 37a:	83 ec 4c             	sub    $0x4c,%esp
 37d:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 37f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 381:	8b 5d 08             	mov    0x8(%ebp),%ebx
 384:	85 db                	test   %ebx,%ebx
 386:	74 04                	je     38c <printint+0x18>
 388:	85 d2                	test   %edx,%edx
 38a:	78 70                	js     3fc <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 38c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 393:	31 ff                	xor    %edi,%edi
 395:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 398:	89 75 c0             	mov    %esi,-0x40(%ebp)
 39b:	89 ce                	mov    %ecx,%esi
 39d:	eb 03                	jmp    3a2 <printint+0x2e>
 39f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 3a0:	89 cf                	mov    %ecx,%edi
 3a2:	8d 4f 01             	lea    0x1(%edi),%ecx
 3a5:	31 d2                	xor    %edx,%edx
 3a7:	f7 f6                	div    %esi
 3a9:	8a 92 6d 07 00 00    	mov    0x76d(%edx),%dl
 3af:	88 55 c7             	mov    %dl,-0x39(%ebp)
 3b2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3b5:	85 c0                	test   %eax,%eax
 3b7:	75 e7                	jne    3a0 <printint+0x2c>
 3b9:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3bc:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 3be:	8b 55 bc             	mov    -0x44(%ebp),%edx
 3c1:	85 d2                	test   %edx,%edx
 3c3:	74 08                	je     3cd <printint+0x59>
    buf[i++] = '-';
 3c5:	8d 4f 02             	lea    0x2(%edi),%ecx
 3c8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3cd:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3d0:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 3d4:	88 45 c7             	mov    %al,-0x39(%ebp)
 3d7:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e1:	00 
 3e2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3e6:	89 34 24             	mov    %esi,(%esp)
 3e9:	e8 06 ff ff ff       	call   2f4 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ee:	4f                   	dec    %edi
 3ef:	83 ff ff             	cmp    $0xffffffff,%edi
 3f2:	75 dc                	jne    3d0 <printint+0x5c>
    putc(fd, buf[i]);
}
 3f4:	83 c4 4c             	add    $0x4c,%esp
 3f7:	5b                   	pop    %ebx
 3f8:	5e                   	pop    %esi
 3f9:	5f                   	pop    %edi
 3fa:	5d                   	pop    %ebp
 3fb:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3fc:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3fe:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 405:	eb 8c                	jmp    393 <printint+0x1f>
 407:	90                   	nop

00000408 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 408:	55                   	push   %ebp
 409:	89 e5                	mov    %esp,%ebp
 40b:	57                   	push   %edi
 40c:	56                   	push   %esi
 40d:	53                   	push   %ebx
 40e:	83 ec 3c             	sub    $0x3c,%esp
 411:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 414:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 417:	0f b6 13             	movzbl (%ebx),%edx
 41a:	84 d2                	test   %dl,%dl
 41c:	0f 84 be 00 00 00    	je     4e0 <printf+0xd8>
 422:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 423:	8d 45 10             	lea    0x10(%ebp),%eax
 426:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 429:	31 ff                	xor    %edi,%edi
 42b:	eb 33                	jmp    460 <printf+0x58>
 42d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 430:	83 fa 25             	cmp    $0x25,%edx
 433:	0f 84 af 00 00 00    	je     4e8 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 439:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 43c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 443:	00 
 444:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 447:	89 44 24 04          	mov    %eax,0x4(%esp)
 44b:	89 34 24             	mov    %esi,(%esp)
 44e:	e8 a1 fe ff ff       	call   2f4 <write>
 453:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 454:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 458:	84 d2                	test   %dl,%dl
 45a:	0f 84 80 00 00 00    	je     4e0 <printf+0xd8>
    c = fmt[i] & 0xff;
 460:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 463:	85 ff                	test   %edi,%edi
 465:	74 c9                	je     430 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 467:	83 ff 25             	cmp    $0x25,%edi
 46a:	75 e7                	jne    453 <printf+0x4b>
      if(c == 'd'){
 46c:	83 fa 64             	cmp    $0x64,%edx
 46f:	0f 84 0f 01 00 00    	je     584 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 475:	25 f7 00 00 00       	and    $0xf7,%eax
 47a:	83 f8 70             	cmp    $0x70,%eax
 47d:	74 75                	je     4f4 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 47f:	83 fa 73             	cmp    $0x73,%edx
 482:	0f 84 90 00 00 00    	je     518 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 488:	83 fa 63             	cmp    $0x63,%edx
 48b:	0f 84 c7 00 00 00    	je     558 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 491:	83 fa 25             	cmp    $0x25,%edx
 494:	0f 84 0e 01 00 00    	je     5a8 <printf+0x1a0>
 49a:	89 55 d0             	mov    %edx,-0x30(%ebp)
 49d:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a8:	00 
 4a9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b0:	89 34 24             	mov    %esi,(%esp)
 4b3:	e8 3c fe ff ff       	call   2f4 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4b8:	8b 55 d0             	mov    -0x30(%ebp),%edx
 4bb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4be:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c5:	00 
 4c6:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cd:	89 34 24             	mov    %esi,(%esp)
 4d0:	e8 1f fe ff ff       	call   2f4 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d5:	31 ff                	xor    %edi,%edi
 4d7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4dc:	84 d2                	test   %dl,%dl
 4de:	75 80                	jne    460 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4e0:	83 c4 3c             	add    $0x3c,%esp
 4e3:	5b                   	pop    %ebx
 4e4:	5e                   	pop    %esi
 4e5:	5f                   	pop    %edi
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4e8:	bf 25 00 00 00       	mov    $0x25,%edi
 4ed:	e9 61 ff ff ff       	jmp    453 <printf+0x4b>
 4f2:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 500:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 503:	8b 10                	mov    (%eax),%edx
 505:	89 f0                	mov    %esi,%eax
 507:	e8 68 fe ff ff       	call   374 <printint>
        ap++;
 50c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 510:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 512:	e9 3c ff ff ff       	jmp    453 <printf+0x4b>
 517:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 518:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 51b:	8b 38                	mov    (%eax),%edi
        ap++;
 51d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 521:	85 ff                	test   %edi,%edi
 523:	0f 84 a1 00 00 00    	je     5ca <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 529:	8a 07                	mov    (%edi),%al
 52b:	84 c0                	test   %al,%al
 52d:	74 22                	je     551 <printf+0x149>
 52f:	90                   	nop
 530:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 533:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53a:	00 
 53b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 53e:	89 44 24 04          	mov    %eax,0x4(%esp)
 542:	89 34 24             	mov    %esi,(%esp)
 545:	e8 aa fd ff ff       	call   2f4 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 54a:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 54b:	8a 07                	mov    (%edi),%al
 54d:	84 c0                	test   %al,%al
 54f:	75 df                	jne    530 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 551:	31 ff                	xor    %edi,%edi
 553:	e9 fb fe ff ff       	jmp    453 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 558:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 55b:	8b 00                	mov    (%eax),%eax
 55d:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 560:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 567:	00 
 568:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 56b:	89 44 24 04          	mov    %eax,0x4(%esp)
 56f:	89 34 24             	mov    %esi,(%esp)
 572:	e8 7d fd ff ff       	call   2f4 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 577:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 57b:	31 ff                	xor    %edi,%edi
 57d:	e9 d1 fe ff ff       	jmp    453 <printf+0x4b>
 582:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 584:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 58b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 590:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 593:	8b 10                	mov    (%eax),%edx
 595:	89 f0                	mov    %esi,%eax
 597:	e8 d8 fd ff ff       	call   374 <printint>
        ap++;
 59c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a0:	66 31 ff             	xor    %di,%di
 5a3:	e9 ab fe ff ff       	jmp    453 <printf+0x4b>
 5a8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ac:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b3:	00 
 5b4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bb:	89 34 24             	mov    %esi,(%esp)
 5be:	e8 31 fd ff ff       	call   2f4 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5c3:	31 ff                	xor    %edi,%edi
 5c5:	e9 89 fe ff ff       	jmp    453 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 5ca:	bf 66 07 00 00       	mov    $0x766,%edi
 5cf:	e9 55 ff ff ff       	jmp    529 <printf+0x121>

000005d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	57                   	push   %edi
 5d8:	56                   	push   %esi
 5d9:	53                   	push   %ebx
 5da:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5dd:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e0:	a1 20 0a 00 00       	mov    0xa20,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e5:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e7:	39 d0                	cmp    %edx,%eax
 5e9:	72 11                	jb     5fc <free+0x28>
 5eb:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ec:	39 c8                	cmp    %ecx,%eax
 5ee:	72 04                	jb     5f4 <free+0x20>
 5f0:	39 ca                	cmp    %ecx,%edx
 5f2:	72 10                	jb     604 <free+0x30>
 5f4:	89 c8                	mov    %ecx,%eax
 5f6:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f8:	39 d0                	cmp    %edx,%eax
 5fa:	73 f0                	jae    5ec <free+0x18>
 5fc:	39 ca                	cmp    %ecx,%edx
 5fe:	72 04                	jb     604 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 600:	39 c8                	cmp    %ecx,%eax
 602:	72 f0                	jb     5f4 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 604:	8b 73 fc             	mov    -0x4(%ebx),%esi
 607:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 60a:	39 cf                	cmp    %ecx,%edi
 60c:	74 1a                	je     628 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 60e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 611:	8b 48 04             	mov    0x4(%eax),%ecx
 614:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 617:	39 f2                	cmp    %esi,%edx
 619:	74 24                	je     63f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 61b:	89 10                	mov    %edx,(%eax)
  freep = p;
 61d:	a3 20 0a 00 00       	mov    %eax,0xa20
}
 622:	5b                   	pop    %ebx
 623:	5e                   	pop    %esi
 624:	5f                   	pop    %edi
 625:	5d                   	pop    %ebp
 626:	c3                   	ret    
 627:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 628:	03 71 04             	add    0x4(%ecx),%esi
 62b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 62e:	8b 08                	mov    (%eax),%ecx
 630:	8b 09                	mov    (%ecx),%ecx
 632:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 635:	8b 48 04             	mov    0x4(%eax),%ecx
 638:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 63b:	39 f2                	cmp    %esi,%edx
 63d:	75 dc                	jne    61b <free+0x47>
    p->s.size += bp->s.size;
 63f:	03 4b fc             	add    -0x4(%ebx),%ecx
 642:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 645:	8b 53 f8             	mov    -0x8(%ebx),%edx
 648:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 64a:	a3 20 0a 00 00       	mov    %eax,0xa20
}
 64f:	5b                   	pop    %ebx
 650:	5e                   	pop    %esi
 651:	5f                   	pop    %edi
 652:	5d                   	pop    %ebp
 653:	c3                   	ret    

00000654 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 654:	55                   	push   %ebp
 655:	89 e5                	mov    %esp,%ebp
 657:	57                   	push   %edi
 658:	56                   	push   %esi
 659:	53                   	push   %ebx
 65a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
 660:	8d 70 07             	lea    0x7(%eax),%esi
 663:	c1 ee 03             	shr    $0x3,%esi
 666:	46                   	inc    %esi
  if((prevp = freep) == 0){
 667:	8b 1d 20 0a 00 00    	mov    0xa20,%ebx
 66d:	85 db                	test   %ebx,%ebx
 66f:	0f 84 91 00 00 00    	je     706 <malloc+0xb2>
 675:	8b 13                	mov    (%ebx),%edx
 677:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 67a:	39 ce                	cmp    %ecx,%esi
 67c:	76 52                	jbe    6d0 <malloc+0x7c>
 67e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 685:	eb 0c                	jmp    693 <malloc+0x3f>
 687:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 688:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 68a:	8b 48 04             	mov    0x4(%eax),%ecx
 68d:	39 ce                	cmp    %ecx,%esi
 68f:	76 43                	jbe    6d4 <malloc+0x80>
 691:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 693:	3b 15 20 0a 00 00    	cmp    0xa20,%edx
 699:	75 ed                	jne    688 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 69b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 6a1:	76 51                	jbe    6f4 <malloc+0xa0>
 6a3:	89 d8                	mov    %ebx,%eax
 6a5:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6a7:	89 04 24             	mov    %eax,(%esp)
 6aa:	e8 ad fc ff ff       	call   35c <sbrk>
  if(p == (char*)-1)
 6af:	83 f8 ff             	cmp    $0xffffffff,%eax
 6b2:	74 18                	je     6cc <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6b4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6b7:	83 c0 08             	add    $0x8,%eax
 6ba:	89 04 24             	mov    %eax,(%esp)
 6bd:	e8 12 ff ff ff       	call   5d4 <free>
  return freep;
 6c2:	8b 15 20 0a 00 00    	mov    0xa20,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6c8:	85 d2                	test   %edx,%edx
 6ca:	75 bc                	jne    688 <malloc+0x34>
        return 0;
 6cc:	31 c0                	xor    %eax,%eax
 6ce:	eb 1c                	jmp    6ec <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6d0:	89 d0                	mov    %edx,%eax
 6d2:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 6d4:	39 ce                	cmp    %ecx,%esi
 6d6:	74 28                	je     700 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6d8:	29 f1                	sub    %esi,%ecx
 6da:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6dd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6e0:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 6e3:	89 15 20 0a 00 00    	mov    %edx,0xa20
      return (void*)(p + 1);
 6e9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6ec:	83 c4 1c             	add    $0x1c,%esp
 6ef:	5b                   	pop    %ebx
 6f0:	5e                   	pop    %esi
 6f1:	5f                   	pop    %edi
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6f4:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 6f9:	bf 00 10 00 00       	mov    $0x1000,%edi
 6fe:	eb a7                	jmp    6a7 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 700:	8b 08                	mov    (%eax),%ecx
 702:	89 0a                	mov    %ecx,(%edx)
 704:	eb dd                	jmp    6e3 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 706:	c7 05 20 0a 00 00 24 	movl   $0xa24,0xa20
 70d:	0a 00 00 
 710:	c7 05 24 0a 00 00 24 	movl   $0xa24,0xa24
 717:	0a 00 00 
    base.s.size = 0;
 71a:	c7 05 28 0a 00 00 00 	movl   $0x0,0xa28
 721:	00 00 00 
 724:	ba 24 0a 00 00       	mov    $0xa24,%edx
 729:	e9 50 ff ff ff       	jmp    67e <malloc+0x2a>
