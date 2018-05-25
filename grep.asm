
_grep:     file format elf32-i386


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
   c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
   f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  13:	0f 8e 87 00 00 00    	jle    a0 <main+0xa0>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  19:	8b 7b 04             	mov    0x4(%ebx),%edi

  if(argc <= 2){
  1c:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  20:	74 69                	je     8b <main+0x8b>
  22:	83 c3 08             	add    $0x8,%ebx
  25:	be 02 00 00 00       	mov    $0x2,%esi
  2a:	66 90                	xchg   %ax,%ax
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  2c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  33:	00 
  34:	8b 03                	mov    (%ebx),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 8e 04 00 00       	call   4cc <open>
  3e:	85 c0                	test   %eax,%eax
  40:	78 2a                	js     6c <main+0x6c>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  42:	89 44 24 04          	mov    %eax,0x4(%esp)
  46:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4a:	89 3c 24             	mov    %edi,(%esp)
  4d:	e8 86 01 00 00       	call   1d8 <grep>
    close(fd);
  52:	8b 44 24 0c          	mov    0xc(%esp),%eax
  56:	89 04 24             	mov    %eax,(%esp)
  59:	e8 56 04 00 00       	call   4b4 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  5e:	46                   	inc    %esi
  5f:	83 c3 04             	add    $0x4,%ebx
  62:	39 75 08             	cmp    %esi,0x8(%ebp)
  65:	7f c5                	jg     2c <main+0x2c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
  67:	e8 20 04 00 00       	call   48c <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  6c:	8b 03                	mov    (%ebx),%eax
  6e:	89 44 24 08          	mov    %eax,0x8(%esp)
  72:	c7 44 24 04 08 09 00 	movl   $0x908,0x4(%esp)
  79:	00 
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 3a 05 00 00       	call   5c0 <printf>
      exit();
  86:	e8 01 04 00 00       	call   48c <exit>
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  8b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  92:	00 
  93:	89 3c 24             	mov    %edi,(%esp)
  96:	e8 3d 01 00 00       	call   1d8 <grep>
    exit();
  9b:	e8 ec 03 00 00       	call   48c <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  a0:	c7 44 24 04 e8 08 00 	movl   $0x8e8,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  af:	e8 0c 05 00 00       	call   5c0 <printf>
    exit();
  b4:	e8 d3 03 00 00       	call   48c <exit>
  b9:	66 90                	xchg   %ax,%ax
  bb:	90                   	nop

000000bc <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	57                   	push   %edi
  c0:	56                   	push   %esi
  c1:	53                   	push   %ebx
  c2:	83 ec 1c             	sub    $0x1c,%esp
  c5:	8b 75 08             	mov    0x8(%ebp),%esi
  c8:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  ce:	66 90                	xchg   %ax,%ax
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  d4:	89 3c 24             	mov    %edi,(%esp)
  d7:	e8 30 00 00 00       	call   10c <matchhere>
  dc:	85 c0                	test   %eax,%eax
  de:	75 1c                	jne    fc <matchstar+0x40>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  e0:	0f be 13             	movsbl (%ebx),%edx
  e3:	84 d2                	test   %dl,%dl
  e5:	74 0a                	je     f1 <matchstar+0x35>
  e7:	43                   	inc    %ebx
  e8:	39 f2                	cmp    %esi,%edx
  ea:	74 e4                	je     d0 <matchstar+0x14>
  ec:	83 fe 2e             	cmp    $0x2e,%esi
  ef:	74 df                	je     d0 <matchstar+0x14>
  return 0;
}
  f1:	83 c4 1c             	add    $0x1c,%esp
  f4:	5b                   	pop    %ebx
  f5:	5e                   	pop    %esi
  f6:	5f                   	pop    %edi
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d 76 00             	lea    0x0(%esi),%esi
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  fc:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
 101:	83 c4 1c             	add    $0x1c,%esp
 104:	5b                   	pop    %ebx
 105:	5e                   	pop    %esi
 106:	5f                   	pop    %edi
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    
 109:	8d 76 00             	lea    0x0(%esi),%esi

0000010c <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	53                   	push   %ebx
 110:	83 ec 14             	sub    $0x14,%esp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
 119:	0f be 02             	movsbl (%edx),%eax
 11c:	84 c0                	test   %al,%al
 11e:	75 1b                	jne    13b <matchhere+0x2f>
 120:	eb 3a                	jmp    15c <matchhere+0x50>
 122:	66 90                	xchg   %ax,%ax
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 124:	8a 19                	mov    (%ecx),%bl
 126:	84 db                	test   %bl,%bl
 128:	74 2a                	je     154 <matchhere+0x48>
 12a:	3c 2e                	cmp    $0x2e,%al
 12c:	74 04                	je     132 <matchhere+0x26>
 12e:	38 d8                	cmp    %bl,%al
 130:	75 22                	jne    154 <matchhere+0x48>
    return matchhere(re+1, text+1);
 132:	41                   	inc    %ecx
 133:	42                   	inc    %edx
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 134:	0f be 02             	movsbl (%edx),%eax
 137:	84 c0                	test   %al,%al
 139:	74 21                	je     15c <matchhere+0x50>
    return 1;
  if(re[1] == '*')
 13b:	8a 5a 01             	mov    0x1(%edx),%bl
 13e:	80 fb 2a             	cmp    $0x2a,%bl
 141:	74 25                	je     168 <matchhere+0x5c>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 143:	3c 24                	cmp    $0x24,%al
 145:	75 dd                	jne    124 <matchhere+0x18>
 147:	84 db                	test   %bl,%bl
 149:	74 36                	je     181 <matchhere+0x75>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 14b:	8a 19                	mov    (%ecx),%bl
 14d:	84 db                	test   %bl,%bl
 14f:	75 dd                	jne    12e <matchhere+0x22>
 151:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text+1);
  return 0;
 154:	31 c0                	xor    %eax,%eax
}
 156:	83 c4 14             	add    $0x14,%esp
 159:	5b                   	pop    %ebx
 15a:	5d                   	pop    %ebp
 15b:	c3                   	ret    

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
 15c:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 161:	83 c4 14             	add    $0x14,%esp
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	90                   	nop
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
 168:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 16c:	83 c2 02             	add    $0x2,%edx
 16f:	89 54 24 04          	mov    %edx,0x4(%esp)
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 41 ff ff ff       	call   bc <matchstar>
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 17b:	83 c4 14             	add    $0x14,%esp
 17e:	5b                   	pop    %ebx
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 181:	31 c0                	xor    %eax,%eax
 183:	80 39 00             	cmpb   $0x0,(%ecx)
 186:	0f 94 c0             	sete   %al
 189:	eb cb                	jmp    156 <matchhere+0x4a>
 18b:	90                   	nop

0000018c <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	56                   	push   %esi
 190:	53                   	push   %ebx
 191:	83 ec 10             	sub    $0x10,%esp
 194:	8b 75 08             	mov    0x8(%ebp),%esi
 197:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 19a:	80 3e 5e             	cmpb   $0x5e,(%esi)
 19d:	75 0c                	jne    1ab <match+0x1f>
 19f:	eb 26                	jmp    1c7 <match+0x3b>
 1a1:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 1a4:	43                   	inc    %ebx
 1a5:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1a9:	74 15                	je     1c0 <match+0x34>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 1ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 1af:	89 34 24             	mov    %esi,(%esp)
 1b2:	e8 55 ff ff ff       	call   10c <matchhere>
 1b7:	85 c0                	test   %eax,%eax
 1b9:	74 e9                	je     1a4 <match+0x18>
      return 1;
 1bb:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 1c0:	83 c4 10             	add    $0x10,%esp
 1c3:	5b                   	pop    %ebx
 1c4:	5e                   	pop    %esi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1c7:	46                   	inc    %esi
 1c8:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 1cb:	83 c4 10             	add    $0x10,%esp
 1ce:	5b                   	pop    %ebx
 1cf:	5e                   	pop    %esi
 1d0:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1d1:	e9 36 ff ff ff       	jmp    10c <matchhere>
 1d6:	66 90                	xchg   %ax,%ax

000001d8 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	57                   	push   %edi
 1dc:	56                   	push   %esi
 1dd:	53                   	push   %ebx
 1de:	83 ec 1c             	sub    $0x1c,%esp
 1e1:	8b 75 08             	mov    0x8(%ebp),%esi
  int n, m;
  char *p, *q;

  m = 0;
 1e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1eb:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1ec:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 1f4:	29 d0                	sub    %edx,%eax
 1f6:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fa:	89 d0                	mov    %edx,%eax
 1fc:	05 a0 0c 00 00       	add    $0xca0,%eax
 201:	89 44 24 04          	mov    %eax,0x4(%esp)
 205:	8b 45 0c             	mov    0xc(%ebp),%eax
 208:	89 04 24             	mov    %eax,(%esp)
 20b:	e8 94 02 00 00       	call   4a4 <read>
 210:	85 c0                	test   %eax,%eax
 212:	0f 8e ac 00 00 00    	jle    2c4 <grep+0xec>
    m += n;
 218:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
 21b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 21e:	c6 80 a0 0c 00 00 00 	movb   $0x0,0xca0(%eax)
    p = buf;
 225:	bb a0 0c 00 00       	mov    $0xca0,%ebx
 22a:	66 90                	xchg   %ax,%ax
    while((q = strchr(p, '\n')) != 0){
 22c:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
 233:	00 
 234:	89 1c 24             	mov    %ebx,(%esp)
 237:	e8 28 01 00 00       	call   364 <strchr>
 23c:	89 c7                	mov    %eax,%edi
 23e:	85 c0                	test   %eax,%eax
 240:	74 3a                	je     27c <grep+0xa4>
      *q = 0;
 242:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 245:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 249:	89 34 24             	mov    %esi,(%esp)
 24c:	e8 3b ff ff ff       	call   18c <match>
 251:	85 c0                	test   %eax,%eax
 253:	75 07                	jne    25c <grep+0x84>
 255:	8d 5f 01             	lea    0x1(%edi),%ebx
 258:	eb d2                	jmp    22c <grep+0x54>
 25a:	66 90                	xchg   %ax,%ax
        *q = '\n';
 25c:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 25f:	47                   	inc    %edi
 260:	89 f8                	mov    %edi,%eax
 262:	29 d8                	sub    %ebx,%eax
 264:	89 44 24 08          	mov    %eax,0x8(%esp)
 268:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 26c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 273:	e8 34 02 00 00       	call   4ac <write>
 278:	89 fb                	mov    %edi,%ebx
 27a:	eb b0                	jmp    22c <grep+0x54>
      }
      p = q+1;
    }
    if(p == buf)
 27c:	81 fb a0 0c 00 00    	cmp    $0xca0,%ebx
 282:	74 34                	je     2b8 <grep+0xe0>
      m = 0;
    if(m > 0){
 284:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 287:	85 c0                	test   %eax,%eax
 289:	0f 8e 5d ff ff ff    	jle    1ec <grep+0x14>
      m -= p - buf;
 28f:	b8 a0 0c 00 00       	mov    $0xca0,%eax
 294:	29 d8                	sub    %ebx,%eax
 296:	01 45 e4             	add    %eax,-0x1c(%ebp)
      memmove(buf, p, m);
 299:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 29c:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2a4:	c7 04 24 a0 0c 00 00 	movl   $0xca0,(%esp)
 2ab:	e8 b0 01 00 00       	call   460 <memmove>
 2b0:	e9 37 ff ff ff       	jmp    1ec <grep+0x14>
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 2b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 2bf:	e9 28 ff ff ff       	jmp    1ec <grep+0x14>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 2c4:	83 c4 1c             	add    $0x1c,%esp
 2c7:	5b                   	pop    %ebx
 2c8:	5e                   	pop    %esi
 2c9:	5f                   	pop    %edi
 2ca:	5d                   	pop    %ebp
 2cb:	c3                   	ret    

000002cc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	53                   	push   %ebx
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d6:	89 c2                	mov    %eax,%edx
 2d8:	42                   	inc    %edx
 2d9:	41                   	inc    %ecx
 2da:	8a 59 ff             	mov    -0x1(%ecx),%bl
 2dd:	88 5a ff             	mov    %bl,-0x1(%edx)
 2e0:	84 db                	test   %bl,%bl
 2e2:	75 f4                	jne    2d8 <strcpy+0xc>
    ;
  return os;
}
 2e4:	5b                   	pop    %ebx
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	90                   	nop

000002e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e8:	55                   	push   %ebp
 2e9:	89 e5                	mov    %esp,%ebp
 2eb:	53                   	push   %ebx
 2ec:	8b 55 08             	mov    0x8(%ebp),%edx
 2ef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2f2:	0f b6 02             	movzbl (%edx),%eax
 2f5:	84 c0                	test   %al,%al
 2f7:	74 27                	je     320 <strcmp+0x38>
 2f9:	8a 19                	mov    (%ecx),%bl
 2fb:	38 d8                	cmp    %bl,%al
 2fd:	74 0b                	je     30a <strcmp+0x22>
 2ff:	eb 26                	jmp    327 <strcmp+0x3f>
 301:	8d 76 00             	lea    0x0(%esi),%esi
 304:	38 c8                	cmp    %cl,%al
 306:	75 13                	jne    31b <strcmp+0x33>
    p++, q++;
 308:	89 d9                	mov    %ebx,%ecx
 30a:	42                   	inc    %edx
 30b:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 30e:	0f b6 02             	movzbl (%edx),%eax
 311:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 315:	84 c0                	test   %al,%al
 317:	75 eb                	jne    304 <strcmp+0x1c>
 319:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 31b:	29 c8                	sub    %ecx,%eax
}
 31d:	5b                   	pop    %ebx
 31e:	5d                   	pop    %ebp
 31f:	c3                   	ret    
 320:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 323:	31 c0                	xor    %eax,%eax
 325:	eb f4                	jmp    31b <strcmp+0x33>
 327:	0f b6 cb             	movzbl %bl,%ecx
 32a:	eb ef                	jmp    31b <strcmp+0x33>

0000032c <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 332:	80 39 00             	cmpb   $0x0,(%ecx)
 335:	74 10                	je     347 <strlen+0x1b>
 337:	31 d2                	xor    %edx,%edx
 339:	8d 76 00             	lea    0x0(%esi),%esi
 33c:	42                   	inc    %edx
 33d:	89 d0                	mov    %edx,%eax
 33f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 343:	75 f7                	jne    33c <strlen+0x10>
    ;
  return n;
}
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 347:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    
 34b:	90                   	nop

0000034c <memset>:

void*
memset(void *dst, int c, uint n)
{
 34c:	55                   	push   %ebp
 34d:	89 e5                	mov    %esp,%ebp
 34f:	57                   	push   %edi
 350:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 353:	89 d7                	mov    %edx,%edi
 355:	8b 4d 10             	mov    0x10(%ebp),%ecx
 358:	8b 45 0c             	mov    0xc(%ebp),%eax
 35b:	fc                   	cld    
 35c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 35e:	89 d0                	mov    %edx,%eax
 360:	5f                   	pop    %edi
 361:	5d                   	pop    %ebp
 362:	c3                   	ret    
 363:	90                   	nop

00000364 <strchr>:

char*
strchr(const char *s, char c)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	53                   	push   %ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 36e:	8a 10                	mov    (%eax),%dl
 370:	84 d2                	test   %dl,%dl
 372:	74 13                	je     387 <strchr+0x23>
 374:	88 d9                	mov    %bl,%cl
    if(*s == c)
 376:	38 da                	cmp    %bl,%dl
 378:	75 06                	jne    380 <strchr+0x1c>
 37a:	eb 0d                	jmp    389 <strchr+0x25>
 37c:	38 ca                	cmp    %cl,%dl
 37e:	74 09                	je     389 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 380:	40                   	inc    %eax
 381:	8a 10                	mov    (%eax),%dl
 383:	84 d2                	test   %dl,%dl
 385:	75 f5                	jne    37c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 387:	31 c0                	xor    %eax,%eax
}
 389:	5b                   	pop    %ebx
 38a:	5d                   	pop    %ebp
 38b:	c3                   	ret    

0000038c <gets>:

char*
gets(char *buf, int max)
{
 38c:	55                   	push   %ebp
 38d:	89 e5                	mov    %esp,%ebp
 38f:	57                   	push   %edi
 390:	56                   	push   %esi
 391:	53                   	push   %ebx
 392:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 395:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 397:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39a:	eb 30                	jmp    3cc <gets+0x40>
    cc = read(0, &c, 1);
 39c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a3:	00 
 3a4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 3a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3af:	e8 f0 00 00 00       	call   4a4 <read>
    if(cc < 1)
 3b4:	85 c0                	test   %eax,%eax
 3b6:	7e 1c                	jle    3d4 <gets+0x48>
      break;
    buf[i++] = c;
 3b8:	8a 45 e7             	mov    -0x19(%ebp),%al
 3bb:	8b 55 08             	mov    0x8(%ebp),%edx
 3be:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c2:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3c4:	3c 0a                	cmp    $0xa,%al
 3c6:	74 0c                	je     3d4 <gets+0x48>
 3c8:	3c 0d                	cmp    $0xd,%al
 3ca:	74 08                	je     3d4 <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3cc:	8d 5e 01             	lea    0x1(%esi),%ebx
 3cf:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3d2:	7c c8                	jl     39c <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3db:	83 c4 2c             	add    $0x2c,%esp
 3de:	5b                   	pop    %ebx
 3df:	5e                   	pop    %esi
 3e0:	5f                   	pop    %edi
 3e1:	5d                   	pop    %ebp
 3e2:	c3                   	ret    
 3e3:	90                   	nop

000003e4 <stat>:

int
stat(char *n, struct stat *st)
{
 3e4:	55                   	push   %ebp
 3e5:	89 e5                	mov    %esp,%ebp
 3e7:	56                   	push   %esi
 3e8:	53                   	push   %ebx
 3e9:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3f3:	00 
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	89 04 24             	mov    %eax,(%esp)
 3fa:	e8 cd 00 00 00       	call   4cc <open>
 3ff:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 401:	85 c0                	test   %eax,%eax
 403:	78 23                	js     428 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 405:	8b 45 0c             	mov    0xc(%ebp),%eax
 408:	89 44 24 04          	mov    %eax,0x4(%esp)
 40c:	89 1c 24             	mov    %ebx,(%esp)
 40f:	e8 d0 00 00 00       	call   4e4 <fstat>
 414:	89 c6                	mov    %eax,%esi
  close(fd);
 416:	89 1c 24             	mov    %ebx,(%esp)
 419:	e8 96 00 00 00       	call   4b4 <close>
  return r;
 41e:	89 f0                	mov    %esi,%eax
}
 420:	83 c4 10             	add    $0x10,%esp
 423:	5b                   	pop    %ebx
 424:	5e                   	pop    %esi
 425:	5d                   	pop    %ebp
 426:	c3                   	ret    
 427:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 42d:	eb f1                	jmp    420 <stat+0x3c>
 42f:	90                   	nop

00000430 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	53                   	push   %ebx
 434:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 437:	0f be 11             	movsbl (%ecx),%edx
 43a:	8d 42 d0             	lea    -0x30(%edx),%eax
 43d:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 43f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 444:	77 15                	ja     45b <atoi+0x2b>
 446:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 448:	41                   	inc    %ecx
 449:	8d 04 80             	lea    (%eax,%eax,4),%eax
 44c:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 450:	0f be 11             	movsbl (%ecx),%edx
 453:	8d 5a d0             	lea    -0x30(%edx),%ebx
 456:	80 fb 09             	cmp    $0x9,%bl
 459:	76 ed                	jbe    448 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 45b:	5b                   	pop    %ebx
 45c:	5d                   	pop    %ebp
 45d:	c3                   	ret    
 45e:	66 90                	xchg   %ax,%ax

00000460 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	56                   	push   %esi
 464:	53                   	push   %ebx
 465:	8b 45 08             	mov    0x8(%ebp),%eax
 468:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 46b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 46e:	31 d2                	xor    %edx,%edx
 470:	85 f6                	test   %esi,%esi
 472:	7e 0b                	jle    47f <memmove+0x1f>
    *dst++ = *src++;
 474:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 477:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 47a:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47b:	39 f2                	cmp    %esi,%edx
 47d:	75 f5                	jne    474 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 47f:	5b                   	pop    %ebx
 480:	5e                   	pop    %esi
 481:	5d                   	pop    %ebp
 482:	c3                   	ret    
 483:	90                   	nop

00000484 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 484:	b8 01 00 00 00       	mov    $0x1,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <exit>:
SYSCALL(exit)
 48c:	b8 02 00 00 00       	mov    $0x2,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <wait>:
SYSCALL(wait)
 494:	b8 03 00 00 00       	mov    $0x3,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <pipe>:
SYSCALL(pipe)
 49c:	b8 04 00 00 00       	mov    $0x4,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <read>:
SYSCALL(read)
 4a4:	b8 05 00 00 00       	mov    $0x5,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <write>:
SYSCALL(write)
 4ac:	b8 10 00 00 00       	mov    $0x10,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <close>:
SYSCALL(close)
 4b4:	b8 15 00 00 00       	mov    $0x15,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <kill>:
SYSCALL(kill)
 4bc:	b8 06 00 00 00       	mov    $0x6,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <exec>:
SYSCALL(exec)
 4c4:	b8 07 00 00 00       	mov    $0x7,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <open>:
SYSCALL(open)
 4cc:	b8 0f 00 00 00       	mov    $0xf,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <mknod>:
SYSCALL(mknod)
 4d4:	b8 11 00 00 00       	mov    $0x11,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <unlink>:
SYSCALL(unlink)
 4dc:	b8 12 00 00 00       	mov    $0x12,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <fstat>:
SYSCALL(fstat)
 4e4:	b8 08 00 00 00       	mov    $0x8,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <link>:
SYSCALL(link)
 4ec:	b8 13 00 00 00       	mov    $0x13,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <mkdir>:
SYSCALL(mkdir)
 4f4:	b8 14 00 00 00       	mov    $0x14,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <chdir>:
SYSCALL(chdir)
 4fc:	b8 09 00 00 00       	mov    $0x9,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <dup>:
SYSCALL(dup)
 504:	b8 0a 00 00 00       	mov    $0xa,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <getpid>:
SYSCALL(getpid)
 50c:	b8 0b 00 00 00       	mov    $0xb,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <sbrk>:
SYSCALL(sbrk)
 514:	b8 0c 00 00 00       	mov    $0xc,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <sleep>:
SYSCALL(sleep)
 51c:	b8 0d 00 00 00       	mov    $0xd,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <uptime>:
SYSCALL(uptime)
 524:	b8 0e 00 00 00       	mov    $0xe,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 52c:	55                   	push   %ebp
 52d:	89 e5                	mov    %esp,%ebp
 52f:	57                   	push   %edi
 530:	56                   	push   %esi
 531:	53                   	push   %ebx
 532:	83 ec 4c             	sub    $0x4c,%esp
 535:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 537:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 539:	8b 5d 08             	mov    0x8(%ebp),%ebx
 53c:	85 db                	test   %ebx,%ebx
 53e:	74 04                	je     544 <printint+0x18>
 540:	85 d2                	test   %edx,%edx
 542:	78 70                	js     5b4 <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 544:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 54b:	31 ff                	xor    %edi,%edi
 54d:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 550:	89 75 c0             	mov    %esi,-0x40(%ebp)
 553:	89 ce                	mov    %ecx,%esi
 555:	eb 03                	jmp    55a <printint+0x2e>
 557:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 558:	89 cf                	mov    %ecx,%edi
 55a:	8d 4f 01             	lea    0x1(%edi),%ecx
 55d:	31 d2                	xor    %edx,%edx
 55f:	f7 f6                	div    %esi
 561:	8a 92 25 09 00 00    	mov    0x925(%edx),%dl
 567:	88 55 c7             	mov    %dl,-0x39(%ebp)
 56a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 56d:	85 c0                	test   %eax,%eax
 56f:	75 e7                	jne    558 <printint+0x2c>
 571:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 574:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 576:	8b 55 bc             	mov    -0x44(%ebp),%edx
 579:	85 d2                	test   %edx,%edx
 57b:	74 08                	je     585 <printint+0x59>
    buf[i++] = '-';
 57d:	8d 4f 02             	lea    0x2(%edi),%ecx
 580:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 585:	8d 79 ff             	lea    -0x1(%ecx),%edi
 588:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 58c:	88 45 c7             	mov    %al,-0x39(%ebp)
 58f:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 592:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 599:	00 
 59a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 59e:	89 34 24             	mov    %esi,(%esp)
 5a1:	e8 06 ff ff ff       	call   4ac <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5a6:	4f                   	dec    %edi
 5a7:	83 ff ff             	cmp    $0xffffffff,%edi
 5aa:	75 dc                	jne    588 <printint+0x5c>
    putc(fd, buf[i]);
}
 5ac:	83 c4 4c             	add    $0x4c,%esp
 5af:	5b                   	pop    %ebx
 5b0:	5e                   	pop    %esi
 5b1:	5f                   	pop    %edi
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5b4:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5b6:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 5bd:	eb 8c                	jmp    54b <printint+0x1f>
 5bf:	90                   	nop

000005c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	83 ec 3c             	sub    $0x3c,%esp
 5c9:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5cf:	0f b6 13             	movzbl (%ebx),%edx
 5d2:	84 d2                	test   %dl,%dl
 5d4:	0f 84 be 00 00 00    	je     698 <printf+0xd8>
 5da:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5db:	8d 45 10             	lea    0x10(%ebp),%eax
 5de:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5e1:	31 ff                	xor    %edi,%edi
 5e3:	eb 33                	jmp    618 <printf+0x58>
 5e5:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e8:	83 fa 25             	cmp    $0x25,%edx
 5eb:	0f 84 af 00 00 00    	je     6a0 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 5f1:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5fb:	00 
 5fc:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 603:	89 34 24             	mov    %esi,(%esp)
 606:	e8 a1 fe ff ff       	call   4ac <write>
 60b:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 60c:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 610:	84 d2                	test   %dl,%dl
 612:	0f 84 80 00 00 00    	je     698 <printf+0xd8>
    c = fmt[i] & 0xff;
 618:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 61b:	85 ff                	test   %edi,%edi
 61d:	74 c9                	je     5e8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 61f:	83 ff 25             	cmp    $0x25,%edi
 622:	75 e7                	jne    60b <printf+0x4b>
      if(c == 'd'){
 624:	83 fa 64             	cmp    $0x64,%edx
 627:	0f 84 0f 01 00 00    	je     73c <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 62d:	25 f7 00 00 00       	and    $0xf7,%eax
 632:	83 f8 70             	cmp    $0x70,%eax
 635:	74 75                	je     6ac <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 637:	83 fa 73             	cmp    $0x73,%edx
 63a:	0f 84 90 00 00 00    	je     6d0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 640:	83 fa 63             	cmp    $0x63,%edx
 643:	0f 84 c7 00 00 00    	je     710 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 649:	83 fa 25             	cmp    $0x25,%edx
 64c:	0f 84 0e 01 00 00    	je     760 <printf+0x1a0>
 652:	89 55 d0             	mov    %edx,-0x30(%ebp)
 655:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 659:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 660:	00 
 661:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 664:	89 44 24 04          	mov    %eax,0x4(%esp)
 668:	89 34 24             	mov    %esi,(%esp)
 66b:	e8 3c fe ff ff       	call   4ac <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 670:	8b 55 d0             	mov    -0x30(%ebp),%edx
 673:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 676:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 67d:	00 
 67e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 681:	89 44 24 04          	mov    %eax,0x4(%esp)
 685:	89 34 24             	mov    %esi,(%esp)
 688:	e8 1f fe ff ff       	call   4ac <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 68d:	31 ff                	xor    %edi,%edi
 68f:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 690:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 694:	84 d2                	test   %dl,%dl
 696:	75 80                	jne    618 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 698:	83 c4 3c             	add    $0x3c,%esp
 69b:	5b                   	pop    %ebx
 69c:	5e                   	pop    %esi
 69d:	5f                   	pop    %edi
 69e:	5d                   	pop    %ebp
 69f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6a0:	bf 25 00 00 00       	mov    $0x25,%edi
 6a5:	e9 61 ff ff ff       	jmp    60b <printf+0x4b>
 6aa:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6bb:	8b 10                	mov    (%eax),%edx
 6bd:	89 f0                	mov    %esi,%eax
 6bf:	e8 68 fe ff ff       	call   52c <printint>
        ap++;
 6c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6c8:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6ca:	e9 3c ff ff ff       	jmp    60b <printf+0x4b>
 6cf:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 6d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6d3:	8b 38                	mov    (%eax),%edi
        ap++;
 6d5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 6d9:	85 ff                	test   %edi,%edi
 6db:	0f 84 a1 00 00 00    	je     782 <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 6e1:	8a 07                	mov    (%edi),%al
 6e3:	84 c0                	test   %al,%al
 6e5:	74 22                	je     709 <printf+0x149>
 6e7:	90                   	nop
 6e8:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6eb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6f2:	00 
 6f3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6fa:	89 34 24             	mov    %esi,(%esp)
 6fd:	e8 aa fd ff ff       	call   4ac <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 702:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 703:	8a 07                	mov    (%edi),%al
 705:	84 c0                	test   %al,%al
 707:	75 df                	jne    6e8 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 709:	31 ff                	xor    %edi,%edi
 70b:	e9 fb fe ff ff       	jmp    60b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 710:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 713:	8b 00                	mov    (%eax),%eax
 715:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 718:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 71f:	00 
 720:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 723:	89 44 24 04          	mov    %eax,0x4(%esp)
 727:	89 34 24             	mov    %esi,(%esp)
 72a:	e8 7d fd ff ff       	call   4ac <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 72f:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 733:	31 ff                	xor    %edi,%edi
 735:	e9 d1 fe ff ff       	jmp    60b <printf+0x4b>
 73a:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 73c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 743:	b9 0a 00 00 00       	mov    $0xa,%ecx
 748:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 74b:	8b 10                	mov    (%eax),%edx
 74d:	89 f0                	mov    %esi,%eax
 74f:	e8 d8 fd ff ff       	call   52c <printint>
        ap++;
 754:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 758:	66 31 ff             	xor    %di,%di
 75b:	e9 ab fe ff ff       	jmp    60b <printf+0x4b>
 760:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 764:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 76b:	00 
 76c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 76f:	89 44 24 04          	mov    %eax,0x4(%esp)
 773:	89 34 24             	mov    %esi,(%esp)
 776:	e8 31 fd ff ff       	call   4ac <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 77b:	31 ff                	xor    %edi,%edi
 77d:	e9 89 fe ff ff       	jmp    60b <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 782:	bf 1e 09 00 00       	mov    $0x91e,%edi
 787:	e9 55 ff ff ff       	jmp    6e1 <printf+0x121>

0000078c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 78c:	55                   	push   %ebp
 78d:	89 e5                	mov    %esp,%ebp
 78f:	57                   	push   %edi
 790:	56                   	push   %esi
 791:	53                   	push   %ebx
 792:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 795:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 798:	a1 80 0c 00 00       	mov    0xc80,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79d:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79f:	39 d0                	cmp    %edx,%eax
 7a1:	72 11                	jb     7b4 <free+0x28>
 7a3:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	39 c8                	cmp    %ecx,%eax
 7a6:	72 04                	jb     7ac <free+0x20>
 7a8:	39 ca                	cmp    %ecx,%edx
 7aa:	72 10                	jb     7bc <free+0x30>
 7ac:	89 c8                	mov    %ecx,%eax
 7ae:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	39 d0                	cmp    %edx,%eax
 7b2:	73 f0                	jae    7a4 <free+0x18>
 7b4:	39 ca                	cmp    %ecx,%edx
 7b6:	72 04                	jb     7bc <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	39 c8                	cmp    %ecx,%eax
 7ba:	72 f0                	jb     7ac <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7bc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7bf:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 7c2:	39 cf                	cmp    %ecx,%edi
 7c4:	74 1a                	je     7e0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7c6:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7c9:	8b 48 04             	mov    0x4(%eax),%ecx
 7cc:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7cf:	39 f2                	cmp    %esi,%edx
 7d1:	74 24                	je     7f7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7d3:	89 10                	mov    %edx,(%eax)
  freep = p;
 7d5:	a3 80 0c 00 00       	mov    %eax,0xc80
}
 7da:	5b                   	pop    %ebx
 7db:	5e                   	pop    %esi
 7dc:	5f                   	pop    %edi
 7dd:	5d                   	pop    %ebp
 7de:	c3                   	ret    
 7df:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e0:	03 71 04             	add    0x4(%ecx),%esi
 7e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e6:	8b 08                	mov    (%eax),%ecx
 7e8:	8b 09                	mov    (%ecx),%ecx
 7ea:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7ed:	8b 48 04             	mov    0x4(%eax),%ecx
 7f0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7f3:	39 f2                	cmp    %esi,%edx
 7f5:	75 dc                	jne    7d3 <free+0x47>
    p->s.size += bp->s.size;
 7f7:	03 4b fc             	add    -0x4(%ebx),%ecx
 7fa:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fd:	8b 53 f8             	mov    -0x8(%ebx),%edx
 800:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 802:	a3 80 0c 00 00       	mov    %eax,0xc80
}
 807:	5b                   	pop    %ebx
 808:	5e                   	pop    %esi
 809:	5f                   	pop    %edi
 80a:	5d                   	pop    %ebp
 80b:	c3                   	ret    

0000080c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 80c:	55                   	push   %ebp
 80d:	89 e5                	mov    %esp,%ebp
 80f:	57                   	push   %edi
 810:	56                   	push   %esi
 811:	53                   	push   %ebx
 812:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 815:	8b 45 08             	mov    0x8(%ebp),%eax
 818:	8d 70 07             	lea    0x7(%eax),%esi
 81b:	c1 ee 03             	shr    $0x3,%esi
 81e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 81f:	8b 1d 80 0c 00 00    	mov    0xc80,%ebx
 825:	85 db                	test   %ebx,%ebx
 827:	0f 84 91 00 00 00    	je     8be <malloc+0xb2>
 82d:	8b 13                	mov    (%ebx),%edx
 82f:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 832:	39 ce                	cmp    %ecx,%esi
 834:	76 52                	jbe    888 <malloc+0x7c>
 836:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 83d:	eb 0c                	jmp    84b <malloc+0x3f>
 83f:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 840:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 842:	8b 48 04             	mov    0x4(%eax),%ecx
 845:	39 ce                	cmp    %ecx,%esi
 847:	76 43                	jbe    88c <malloc+0x80>
 849:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 84b:	3b 15 80 0c 00 00    	cmp    0xc80,%edx
 851:	75 ed                	jne    840 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 853:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 859:	76 51                	jbe    8ac <malloc+0xa0>
 85b:	89 d8                	mov    %ebx,%eax
 85d:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 85f:	89 04 24             	mov    %eax,(%esp)
 862:	e8 ad fc ff ff       	call   514 <sbrk>
  if(p == (char*)-1)
 867:	83 f8 ff             	cmp    $0xffffffff,%eax
 86a:	74 18                	je     884 <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 86c:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 86f:	83 c0 08             	add    $0x8,%eax
 872:	89 04 24             	mov    %eax,(%esp)
 875:	e8 12 ff ff ff       	call   78c <free>
  return freep;
 87a:	8b 15 80 0c 00 00    	mov    0xc80,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 880:	85 d2                	test   %edx,%edx
 882:	75 bc                	jne    840 <malloc+0x34>
        return 0;
 884:	31 c0                	xor    %eax,%eax
 886:	eb 1c                	jmp    8a4 <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 888:	89 d0                	mov    %edx,%eax
 88a:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 88c:	39 ce                	cmp    %ecx,%esi
 88e:	74 28                	je     8b8 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 890:	29 f1                	sub    %esi,%ecx
 892:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 895:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 898:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 89b:	89 15 80 0c 00 00    	mov    %edx,0xc80
      return (void*)(p + 1);
 8a1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8a4:	83 c4 1c             	add    $0x1c,%esp
 8a7:	5b                   	pop    %ebx
 8a8:	5e                   	pop    %esi
 8a9:	5f                   	pop    %edi
 8aa:	5d                   	pop    %ebp
 8ab:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 8ac:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 8b1:	bf 00 10 00 00       	mov    $0x1000,%edi
 8b6:	eb a7                	jmp    85f <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8b8:	8b 08                	mov    (%eax),%ecx
 8ba:	89 0a                	mov    %ecx,(%edx)
 8bc:	eb dd                	jmp    89b <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8be:	c7 05 80 0c 00 00 84 	movl   $0xc84,0xc80
 8c5:	0c 00 00 
 8c8:	c7 05 84 0c 00 00 84 	movl   $0xc84,0xc84
 8cf:	0c 00 00 
    base.s.size = 0;
 8d2:	c7 05 88 0c 00 00 00 	movl   $0x0,0xc88
 8d9:	00 00 00 
 8dc:	ba 84 0c 00 00       	mov    $0xc84,%edx
 8e1:	e9 50 ff ff ff       	jmp    836 <malloc+0x2a>
