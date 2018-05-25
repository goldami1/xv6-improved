
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  12:	7e 6c                	jle    80 <main+0x80>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  17:	8d 58 04             	lea    0x4(%eax),%ebx
  1a:	be 01 00 00 00       	mov    $0x1,%esi
  1f:	90                   	nop
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 4e 03 00 00       	call   380 <open>
  32:	85 c0                	test   %eax,%eax
  34:	78 2b                	js     61 <main+0x61>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  36:	8b 13                	mov    (%ebx),%edx
  38:	89 54 24 04          	mov    %edx,0x4(%esp)
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  43:	e8 54 00 00 00       	call   9c <wc>
    close(fd);
  48:	8b 44 24 0c          	mov    0xc(%esp),%eax
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 14 03 00 00       	call   368 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  54:	46                   	inc    %esi
  55:	83 c3 04             	add    $0x4,%ebx
  58:	39 fe                	cmp    %edi,%esi
  5a:	75 c4                	jne    20 <main+0x20>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
  5c:	e8 df 02 00 00       	call   340 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
  61:	8b 03                	mov    (%ebx),%eax
  63:	89 44 24 08          	mov    %eax,0x8(%esp)
  67:	c7 44 24 04 bd 07 00 	movl   $0x7bd,0x4(%esp)
  6e:	00 
  6f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  76:	e8 f9 03 00 00       	call   474 <printf>
      exit();
  7b:	e8 c0 02 00 00       	call   340 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  80:	c7 44 24 04 af 07 00 	movl   $0x7af,0x4(%esp)
  87:	00 
  88:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8f:	e8 08 00 00 00       	call   9c <wc>
    exit();
  94:	e8 a7 02 00 00       	call   340 <exit>
  99:	66 90                	xchg   %ax,%ax
  9b:	90                   	nop

0000009c <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  9c:	55                   	push   %ebp
  9d:	89 e5                	mov    %esp,%ebp
  9f:	57                   	push   %edi
  a0:	56                   	push   %esi
  a1:	53                   	push   %ebx
  a2:	83 ec 3c             	sub    $0x3c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  a5:	31 db                	xor    %ebx,%ebx
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  a7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  ae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  bc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  c3:	00 
  c4:	c7 44 24 04 a0 0a 00 	movl   $0xaa0,0x4(%esp)
  cb:	00 
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	89 04 24             	mov    %eax,(%esp)
  d2:	e8 81 02 00 00       	call   358 <read>
  d7:	89 c6                	mov    %eax,%esi
  d9:	83 f8 00             	cmp    $0x0,%eax
  dc:	7e 4d                	jle    12b <wc+0x8f>
  de:	31 ff                	xor    %edi,%edi
  e0:	eb 1d                	jmp    ff <wc+0x63>
  e2:	66 90                	xchg   %ax,%ax
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  e8:	c7 04 24 9a 07 00 00 	movl   $0x79a,(%esp)
  ef:	e8 24 01 00 00       	call   218 <strchr>
  f4:	85 c0                	test   %eax,%eax
  f6:	74 18                	je     110 <wc+0x74>
        inword = 0;
  f8:	31 db                	xor    %ebx,%ebx
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  fa:	47                   	inc    %edi
  fb:	39 f7                	cmp    %esi,%edi
  fd:	74 1f                	je     11e <wc+0x82>
      c++;
      if(buf[i] == '\n')
  ff:	0f be 87 a0 0a 00 00 	movsbl 0xaa0(%edi),%eax
 106:	3c 0a                	cmp    $0xa,%al
 108:	75 da                	jne    e4 <wc+0x48>
        l++;
 10a:	ff 45 e4             	incl   -0x1c(%ebp)
 10d:	eb d5                	jmp    e4 <wc+0x48>
 10f:	90                   	nop
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
 110:	85 db                	test   %ebx,%ebx
 112:	75 10                	jne    124 <wc+0x88>
        w++;
 114:	ff 45 e0             	incl   -0x20(%ebp)
        inword = 1;
 117:	b3 01                	mov    $0x1,%bl
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 119:	47                   	inc    %edi
 11a:	39 f7                	cmp    %esi,%edi
 11c:	75 e1                	jne    ff <wc+0x63>
 11e:	01 7d dc             	add    %edi,-0x24(%ebp)
 121:	eb 99                	jmp    bc <wc+0x20>
 123:	90                   	nop
 124:	bb 01 00 00 00       	mov    $0x1,%ebx
 129:	eb cf                	jmp    fa <wc+0x5e>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 12b:	75 38                	jne    165 <wc+0xc9>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 12d:	8b 45 0c             	mov    0xc(%ebp),%eax
 130:	89 44 24 14          	mov    %eax,0x14(%esp)
 134:	8b 45 dc             	mov    -0x24(%ebp),%eax
 137:	89 44 24 10          	mov    %eax,0x10(%esp)
 13b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 13e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 142:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 145:	89 44 24 08          	mov    %eax,0x8(%esp)
 149:	c7 44 24 04 b0 07 00 	movl   $0x7b0,0x4(%esp)
 150:	00 
 151:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 158:	e8 17 03 00 00       	call   474 <printf>
}
 15d:	83 c4 3c             	add    $0x3c,%esp
 160:	5b                   	pop    %ebx
 161:	5e                   	pop    %esi
 162:	5f                   	pop    %edi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 165:	c7 44 24 04 a0 07 00 	movl   $0x7a0,0x4(%esp)
 16c:	00 
 16d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 174:	e8 fb 02 00 00       	call   474 <printf>
    exit();
 179:	e8 c2 01 00 00       	call   340 <exit>
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	42                   	inc    %edx
 18d:	41                   	inc    %ecx
 18e:	8a 59 ff             	mov    -0x1(%ecx),%bl
 191:	88 5a ff             	mov    %bl,-0x1(%edx)
 194:	84 db                	test   %bl,%bl
 196:	75 f4                	jne    18c <strcpy+0xc>
    ;
  return os;
}
 198:	5b                   	pop    %ebx
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop

0000019c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	53                   	push   %ebx
 1a0:	8b 55 08             	mov    0x8(%ebp),%edx
 1a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1a6:	0f b6 02             	movzbl (%edx),%eax
 1a9:	84 c0                	test   %al,%al
 1ab:	74 27                	je     1d4 <strcmp+0x38>
 1ad:	8a 19                	mov    (%ecx),%bl
 1af:	38 d8                	cmp    %bl,%al
 1b1:	74 0b                	je     1be <strcmp+0x22>
 1b3:	eb 26                	jmp    1db <strcmp+0x3f>
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
 1b8:	38 c8                	cmp    %cl,%al
 1ba:	75 13                	jne    1cf <strcmp+0x33>
    p++, q++;
 1bc:	89 d9                	mov    %ebx,%ecx
 1be:	42                   	inc    %edx
 1bf:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c2:	0f b6 02             	movzbl (%edx),%eax
 1c5:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1c9:	84 c0                	test   %al,%al
 1cb:	75 eb                	jne    1b8 <strcmp+0x1c>
 1cd:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1cf:	29 c8                	sub    %ecx,%eax
}
 1d1:	5b                   	pop    %ebx
 1d2:	5d                   	pop    %ebp
 1d3:	c3                   	ret    
 1d4:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d7:	31 c0                	xor    %eax,%eax
 1d9:	eb f4                	jmp    1cf <strcmp+0x33>
 1db:	0f b6 cb             	movzbl %bl,%ecx
 1de:	eb ef                	jmp    1cf <strcmp+0x33>

000001e0 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1e6:	80 39 00             	cmpb   $0x0,(%ecx)
 1e9:	74 10                	je     1fb <strlen+0x1b>
 1eb:	31 d2                	xor    %edx,%edx
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	42                   	inc    %edx
 1f1:	89 d0                	mov    %edx,%eax
 1f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1f7:	75 f7                	jne    1f0 <strlen+0x10>
    ;
  return n;
}
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1fb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    
 1ff:	90                   	nop

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 207:	89 d7                	mov    %edx,%edi
 209:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20c:	8b 45 0c             	mov    0xc(%ebp),%eax
 20f:	fc                   	cld    
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	89 d0                	mov    %edx,%eax
 214:	5f                   	pop    %edi
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	90                   	nop

00000218 <strchr>:

char*
strchr(const char *s, char c)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	53                   	push   %ebx
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
 21f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 222:	8a 10                	mov    (%eax),%dl
 224:	84 d2                	test   %dl,%dl
 226:	74 13                	je     23b <strchr+0x23>
 228:	88 d9                	mov    %bl,%cl
    if(*s == c)
 22a:	38 da                	cmp    %bl,%dl
 22c:	75 06                	jne    234 <strchr+0x1c>
 22e:	eb 0d                	jmp    23d <strchr+0x25>
 230:	38 ca                	cmp    %cl,%dl
 232:	74 09                	je     23d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 234:	40                   	inc    %eax
 235:	8a 10                	mov    (%eax),%dl
 237:	84 d2                	test   %dl,%dl
 239:	75 f5                	jne    230 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 23b:	31 c0                	xor    %eax,%eax
}
 23d:	5b                   	pop    %ebx
 23e:	5d                   	pop    %ebp
 23f:	c3                   	ret    

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	53                   	push   %ebx
 246:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 249:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 24b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	eb 30                	jmp    280 <gets+0x40>
    cc = read(0, &c, 1);
 250:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 257:	00 
 258:	89 7c 24 04          	mov    %edi,0x4(%esp)
 25c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 263:	e8 f0 00 00 00       	call   358 <read>
    if(cc < 1)
 268:	85 c0                	test   %eax,%eax
 26a:	7e 1c                	jle    288 <gets+0x48>
      break;
    buf[i++] = c;
 26c:	8a 45 e7             	mov    -0x19(%ebp),%al
 26f:	8b 55 08             	mov    0x8(%ebp),%edx
 272:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 276:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 278:	3c 0a                	cmp    $0xa,%al
 27a:	74 0c                	je     288 <gets+0x48>
 27c:	3c 0d                	cmp    $0xd,%al
 27e:	74 08                	je     288 <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 280:	8d 5e 01             	lea    0x1(%esi),%ebx
 283:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 286:	7c c8                	jl     250 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 28f:	83 c4 2c             	add    $0x2c,%esp
 292:	5b                   	pop    %ebx
 293:	5e                   	pop    %esi
 294:	5f                   	pop    %edi
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	90                   	nop

00000298 <stat>:

int
stat(char *n, struct stat *st)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	56                   	push   %esi
 29c:	53                   	push   %ebx
 29d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a7:	00 
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 04 24             	mov    %eax,(%esp)
 2ae:	e8 cd 00 00 00       	call   380 <open>
 2b3:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 23                	js     2dc <stat+0x44>
    return -1;
  r = fstat(fd, st);
 2b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c0:	89 1c 24             	mov    %ebx,(%esp)
 2c3:	e8 d0 00 00 00       	call   398 <fstat>
 2c8:	89 c6                	mov    %eax,%esi
  close(fd);
 2ca:	89 1c 24             	mov    %ebx,(%esp)
 2cd:	e8 96 00 00 00       	call   368 <close>
  return r;
 2d2:	89 f0                	mov    %esi,%eax
}
 2d4:	83 c4 10             	add    $0x10,%esp
 2d7:	5b                   	pop    %ebx
 2d8:	5e                   	pop    %esi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    
 2db:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2e1:	eb f1                	jmp    2d4 <stat+0x3c>
 2e3:	90                   	nop

000002e4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	53                   	push   %ebx
 2e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2eb:	0f be 11             	movsbl (%ecx),%edx
 2ee:	8d 42 d0             	lea    -0x30(%edx),%eax
 2f1:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 2f3:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2f8:	77 15                	ja     30f <atoi+0x2b>
 2fa:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2fc:	41                   	inc    %ecx
 2fd:	8d 04 80             	lea    (%eax,%eax,4),%eax
 300:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 304:	0f be 11             	movsbl (%ecx),%edx
 307:	8d 5a d0             	lea    -0x30(%edx),%ebx
 30a:	80 fb 09             	cmp    $0x9,%bl
 30d:	76 ed                	jbe    2fc <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 30f:	5b                   	pop    %ebx
 310:	5d                   	pop    %ebp
 311:	c3                   	ret    
 312:	66 90                	xchg   %ax,%ax

00000314 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 31f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 322:	31 d2                	xor    %edx,%edx
 324:	85 f6                	test   %esi,%esi
 326:	7e 0b                	jle    333 <memmove+0x1f>
    *dst++ = *src++;
 328:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 32b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32e:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32f:	39 f2                	cmp    %esi,%edx
 331:	75 f5                	jne    328 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 333:	5b                   	pop    %ebx
 334:	5e                   	pop    %esi
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	90                   	nop

00000338 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 338:	b8 01 00 00 00       	mov    $0x1,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <exit>:
SYSCALL(exit)
 340:	b8 02 00 00 00       	mov    $0x2,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <wait>:
SYSCALL(wait)
 348:	b8 03 00 00 00       	mov    $0x3,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <pipe>:
SYSCALL(pipe)
 350:	b8 04 00 00 00       	mov    $0x4,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <read>:
SYSCALL(read)
 358:	b8 05 00 00 00       	mov    $0x5,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <write>:
SYSCALL(write)
 360:	b8 10 00 00 00       	mov    $0x10,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <close>:
SYSCALL(close)
 368:	b8 15 00 00 00       	mov    $0x15,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <kill>:
SYSCALL(kill)
 370:	b8 06 00 00 00       	mov    $0x6,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exec>:
SYSCALL(exec)
 378:	b8 07 00 00 00       	mov    $0x7,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <open>:
SYSCALL(open)
 380:	b8 0f 00 00 00       	mov    $0xf,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <mknod>:
SYSCALL(mknod)
 388:	b8 11 00 00 00       	mov    $0x11,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <unlink>:
SYSCALL(unlink)
 390:	b8 12 00 00 00       	mov    $0x12,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <fstat>:
SYSCALL(fstat)
 398:	b8 08 00 00 00       	mov    $0x8,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <link>:
SYSCALL(link)
 3a0:	b8 13 00 00 00       	mov    $0x13,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <mkdir>:
SYSCALL(mkdir)
 3a8:	b8 14 00 00 00       	mov    $0x14,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <chdir>:
SYSCALL(chdir)
 3b0:	b8 09 00 00 00       	mov    $0x9,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <dup>:
SYSCALL(dup)
 3b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <getpid>:
SYSCALL(getpid)
 3c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <sbrk>:
SYSCALL(sbrk)
 3c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <sleep>:
SYSCALL(sleep)
 3d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <uptime>:
SYSCALL(uptime)
 3d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 4c             	sub    $0x4c,%esp
 3e9:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3eb:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3f0:	85 db                	test   %ebx,%ebx
 3f2:	74 04                	je     3f8 <printint+0x18>
 3f4:	85 d2                	test   %edx,%edx
 3f6:	78 70                	js     468 <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3ff:	31 ff                	xor    %edi,%edi
 401:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 404:	89 75 c0             	mov    %esi,-0x40(%ebp)
 407:	89 ce                	mov    %ecx,%esi
 409:	eb 03                	jmp    40e <printint+0x2e>
 40b:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 40c:	89 cf                	mov    %ecx,%edi
 40e:	8d 4f 01             	lea    0x1(%edi),%ecx
 411:	31 d2                	xor    %edx,%edx
 413:	f7 f6                	div    %esi
 415:	8a 92 d8 07 00 00    	mov    0x7d8(%edx),%dl
 41b:	88 55 c7             	mov    %dl,-0x39(%ebp)
 41e:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 421:	85 c0                	test   %eax,%eax
 423:	75 e7                	jne    40c <printint+0x2c>
 425:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 428:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 42a:	8b 55 bc             	mov    -0x44(%ebp),%edx
 42d:	85 d2                	test   %edx,%edx
 42f:	74 08                	je     439 <printint+0x59>
    buf[i++] = '-';
 431:	8d 4f 02             	lea    0x2(%edi),%ecx
 434:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 439:	8d 79 ff             	lea    -0x1(%ecx),%edi
 43c:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 440:	88 45 c7             	mov    %al,-0x39(%ebp)
 443:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 446:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 44d:	00 
 44e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 452:	89 34 24             	mov    %esi,(%esp)
 455:	e8 06 ff ff ff       	call   360 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 45a:	4f                   	dec    %edi
 45b:	83 ff ff             	cmp    $0xffffffff,%edi
 45e:	75 dc                	jne    43c <printint+0x5c>
    putc(fd, buf[i]);
}
 460:	83 c4 4c             	add    $0x4c,%esp
 463:	5b                   	pop    %ebx
 464:	5e                   	pop    %esi
 465:	5f                   	pop    %edi
 466:	5d                   	pop    %ebp
 467:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 468:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 46a:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 471:	eb 8c                	jmp    3ff <printint+0x1f>
 473:	90                   	nop

00000474 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	57                   	push   %edi
 478:	56                   	push   %esi
 479:	53                   	push   %ebx
 47a:	83 ec 3c             	sub    $0x3c,%esp
 47d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 480:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 483:	0f b6 13             	movzbl (%ebx),%edx
 486:	84 d2                	test   %dl,%dl
 488:	0f 84 be 00 00 00    	je     54c <printf+0xd8>
 48e:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 48f:	8d 45 10             	lea    0x10(%ebp),%eax
 492:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 495:	31 ff                	xor    %edi,%edi
 497:	eb 33                	jmp    4cc <printf+0x58>
 499:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 49c:	83 fa 25             	cmp    $0x25,%edx
 49f:	0f 84 af 00 00 00    	je     554 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 4a5:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4af:	00 
 4b0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b7:	89 34 24             	mov    %esi,(%esp)
 4ba:	e8 a1 fe ff ff       	call   360 <write>
 4bf:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c0:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c4:	84 d2                	test   %dl,%dl
 4c6:	0f 84 80 00 00 00    	je     54c <printf+0xd8>
    c = fmt[i] & 0xff;
 4cc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 4cf:	85 ff                	test   %edi,%edi
 4d1:	74 c9                	je     49c <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4d3:	83 ff 25             	cmp    $0x25,%edi
 4d6:	75 e7                	jne    4bf <printf+0x4b>
      if(c == 'd'){
 4d8:	83 fa 64             	cmp    $0x64,%edx
 4db:	0f 84 0f 01 00 00    	je     5f0 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4e1:	25 f7 00 00 00       	and    $0xf7,%eax
 4e6:	83 f8 70             	cmp    $0x70,%eax
 4e9:	74 75                	je     560 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4eb:	83 fa 73             	cmp    $0x73,%edx
 4ee:	0f 84 90 00 00 00    	je     584 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4f4:	83 fa 63             	cmp    $0x63,%edx
 4f7:	0f 84 c7 00 00 00    	je     5c4 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4fd:	83 fa 25             	cmp    $0x25,%edx
 500:	0f 84 0e 01 00 00    	je     614 <printf+0x1a0>
 506:	89 55 d0             	mov    %edx,-0x30(%ebp)
 509:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 50d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 514:	00 
 515:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 518:	89 44 24 04          	mov    %eax,0x4(%esp)
 51c:	89 34 24             	mov    %esi,(%esp)
 51f:	e8 3c fe ff ff       	call   360 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 524:	8b 55 d0             	mov    -0x30(%ebp),%edx
 527:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 531:	00 
 532:	8d 45 e7             	lea    -0x19(%ebp),%eax
 535:	89 44 24 04          	mov    %eax,0x4(%esp)
 539:	89 34 24             	mov    %esi,(%esp)
 53c:	e8 1f fe ff ff       	call   360 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 541:	31 ff                	xor    %edi,%edi
 543:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 544:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 548:	84 d2                	test   %dl,%dl
 54a:	75 80                	jne    4cc <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 54c:	83 c4 3c             	add    $0x3c,%esp
 54f:	5b                   	pop    %ebx
 550:	5e                   	pop    %esi
 551:	5f                   	pop    %edi
 552:	5d                   	pop    %ebp
 553:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 554:	bf 25 00 00 00       	mov    $0x25,%edi
 559:	e9 61 ff ff ff       	jmp    4bf <printf+0x4b>
 55e:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 560:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 567:	b9 10 00 00 00       	mov    $0x10,%ecx
 56c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 56f:	8b 10                	mov    (%eax),%edx
 571:	89 f0                	mov    %esi,%eax
 573:	e8 68 fe ff ff       	call   3e0 <printint>
        ap++;
 578:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 57c:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 57e:	e9 3c ff ff ff       	jmp    4bf <printf+0x4b>
 583:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 584:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 587:	8b 38                	mov    (%eax),%edi
        ap++;
 589:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 58d:	85 ff                	test   %edi,%edi
 58f:	0f 84 a1 00 00 00    	je     636 <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 595:	8a 07                	mov    (%edi),%al
 597:	84 c0                	test   %al,%al
 599:	74 22                	je     5bd <printf+0x149>
 59b:	90                   	nop
 59c:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a6:	00 
 5a7:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5aa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ae:	89 34 24             	mov    %esi,(%esp)
 5b1:	e8 aa fd ff ff       	call   360 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5b6:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b7:	8a 07                	mov    (%edi),%al
 5b9:	84 c0                	test   %al,%al
 5bb:	75 df                	jne    59c <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5bd:	31 ff                	xor    %edi,%edi
 5bf:	e9 fb fe ff ff       	jmp    4bf <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5c7:	8b 00                	mov    (%eax),%eax
 5c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5d3:	00 
 5d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5db:	89 34 24             	mov    %esi,(%esp)
 5de:	e8 7d fd ff ff       	call   360 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5e3:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e7:	31 ff                	xor    %edi,%edi
 5e9:	e9 d1 fe ff ff       	jmp    4bf <printf+0x4b>
 5ee:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5f7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5fc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5ff:	8b 10                	mov    (%eax),%edx
 601:	89 f0                	mov    %esi,%eax
 603:	e8 d8 fd ff ff       	call   3e0 <printint>
        ap++;
 608:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 60c:	66 31 ff             	xor    %di,%di
 60f:	e9 ab fe ff ff       	jmp    4bf <printf+0x4b>
 614:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 618:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 61f:	00 
 620:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 623:	89 44 24 04          	mov    %eax,0x4(%esp)
 627:	89 34 24             	mov    %esi,(%esp)
 62a:	e8 31 fd ff ff       	call   360 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62f:	31 ff                	xor    %edi,%edi
 631:	e9 89 fe ff ff       	jmp    4bf <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 636:	bf d1 07 00 00       	mov    $0x7d1,%edi
 63b:	e9 55 ff ff ff       	jmp    595 <printf+0x121>

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 649:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64c:	a1 80 0a 00 00       	mov    0xa80,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 651:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 653:	39 d0                	cmp    %edx,%eax
 655:	72 11                	jb     668 <free+0x28>
 657:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 658:	39 c8                	cmp    %ecx,%eax
 65a:	72 04                	jb     660 <free+0x20>
 65c:	39 ca                	cmp    %ecx,%edx
 65e:	72 10                	jb     670 <free+0x30>
 660:	89 c8                	mov    %ecx,%eax
 662:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 664:	39 d0                	cmp    %edx,%eax
 666:	73 f0                	jae    658 <free+0x18>
 668:	39 ca                	cmp    %ecx,%edx
 66a:	72 04                	jb     670 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	39 c8                	cmp    %ecx,%eax
 66e:	72 f0                	jb     660 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 676:	39 cf                	cmp    %ecx,%edi
 678:	74 1a                	je     694 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 67a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 48 04             	mov    0x4(%eax),%ecx
 680:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 683:	39 f2                	cmp    %esi,%edx
 685:	74 24                	je     6ab <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 687:	89 10                	mov    %edx,(%eax)
  freep = p;
 689:	a3 80 0a 00 00       	mov    %eax,0xa80
}
 68e:	5b                   	pop    %ebx
 68f:	5e                   	pop    %esi
 690:	5f                   	pop    %edi
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 694:	03 71 04             	add    0x4(%ecx),%esi
 697:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 69a:	8b 08                	mov    (%eax),%ecx
 69c:	8b 09                	mov    (%ecx),%ecx
 69e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6a1:	8b 48 04             	mov    0x4(%eax),%ecx
 6a4:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6a7:	39 f2                	cmp    %esi,%edx
 6a9:	75 dc                	jne    687 <free+0x47>
    p->s.size += bp->s.size;
 6ab:	03 4b fc             	add    -0x4(%ebx),%ecx
 6ae:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b1:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6b4:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 6b6:	a3 80 0a 00 00       	mov    %eax,0xa80
}
 6bb:	5b                   	pop    %ebx
 6bc:	5e                   	pop    %esi
 6bd:	5f                   	pop    %edi
 6be:	5d                   	pop    %ebp
 6bf:	c3                   	ret    

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
 6cc:	8d 70 07             	lea    0x7(%eax),%esi
 6cf:	c1 ee 03             	shr    $0x3,%esi
 6d2:	46                   	inc    %esi
  if((prevp = freep) == 0){
 6d3:	8b 1d 80 0a 00 00    	mov    0xa80,%ebx
 6d9:	85 db                	test   %ebx,%ebx
 6db:	0f 84 91 00 00 00    	je     772 <malloc+0xb2>
 6e1:	8b 13                	mov    (%ebx),%edx
 6e3:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e6:	39 ce                	cmp    %ecx,%esi
 6e8:	76 52                	jbe    73c <malloc+0x7c>
 6ea:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 6f1:	eb 0c                	jmp    6ff <malloc+0x3f>
 6f3:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f4:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f6:	8b 48 04             	mov    0x4(%eax),%ecx
 6f9:	39 ce                	cmp    %ecx,%esi
 6fb:	76 43                	jbe    740 <malloc+0x80>
 6fd:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6ff:	3b 15 80 0a 00 00    	cmp    0xa80,%edx
 705:	75 ed                	jne    6f4 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 707:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 70d:	76 51                	jbe    760 <malloc+0xa0>
 70f:	89 d8                	mov    %ebx,%eax
 711:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 713:	89 04 24             	mov    %eax,(%esp)
 716:	e8 ad fc ff ff       	call   3c8 <sbrk>
  if(p == (char*)-1)
 71b:	83 f8 ff             	cmp    $0xffffffff,%eax
 71e:	74 18                	je     738 <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 720:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 723:	83 c0 08             	add    $0x8,%eax
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 12 ff ff ff       	call   640 <free>
  return freep;
 72e:	8b 15 80 0a 00 00    	mov    0xa80,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 734:	85 d2                	test   %edx,%edx
 736:	75 bc                	jne    6f4 <malloc+0x34>
        return 0;
 738:	31 c0                	xor    %eax,%eax
 73a:	eb 1c                	jmp    758 <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 73c:	89 d0                	mov    %edx,%eax
 73e:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 740:	39 ce                	cmp    %ecx,%esi
 742:	74 28                	je     76c <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 744:	29 f1                	sub    %esi,%ecx
 746:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 749:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 74c:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 74f:	89 15 80 0a 00 00    	mov    %edx,0xa80
      return (void*)(p + 1);
 755:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 758:	83 c4 1c             	add    $0x1c,%esp
 75b:	5b                   	pop    %ebx
 75c:	5e                   	pop    %esi
 75d:	5f                   	pop    %edi
 75e:	5d                   	pop    %ebp
 75f:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 760:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 765:	bf 00 10 00 00       	mov    $0x1000,%edi
 76a:	eb a7                	jmp    713 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 76c:	8b 08                	mov    (%eax),%ecx
 76e:	89 0a                	mov    %ecx,(%edx)
 770:	eb dd                	jmp    74f <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 772:	c7 05 80 0a 00 00 84 	movl   $0xa84,0xa80
 779:	0a 00 00 
 77c:	c7 05 84 0a 00 00 84 	movl   $0xa84,0xa84
 783:	0a 00 00 
    base.s.size = 0;
 786:	c7 05 88 0a 00 00 00 	movl   $0x0,0xa88
 78d:	00 00 00 
 790:	ba 84 0a 00 00       	mov    $0xa84,%edx
 795:	e9 50 ff ff ff       	jmp    6ea <malloc+0x2a>
