
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 1a                	jle    31 <main+0x31>
  17:	bb 01 00 00 00       	mov    $0x1,%ebx
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  1c:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 b9 00 00 00       	call   e0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  27:	43                   	inc    %ebx
  28:	39 f3                	cmp    %esi,%ebx
  2a:	75 f0                	jne    1c <main+0x1c>
    ls(argv[i]);
  exit();
  2c:	e8 df 04 00 00       	call   510 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
  31:	c7 04 24 b2 09 00 00 	movl   $0x9b2,(%esp)
  38:	e8 a3 00 00 00       	call   e0 <ls>
    exit();
  3d:	e8 ce 04 00 00       	call   510 <exit>
  42:	66 90                	xchg   %ax,%ax

00000044 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
  44:	55                   	push   %ebp
  45:	89 e5                	mov    %esp,%ebp
  47:	56                   	push   %esi
  48:	53                   	push   %ebx
  49:	83 ec 10             	sub    $0x10,%esp
  4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  4f:	89 1c 24             	mov    %ebx,(%esp)
  52:	e8 59 03 00 00       	call   3b0 <strlen>
  57:	01 d8                	add    %ebx,%eax
  59:	73 0a                	jae    65 <fmtname+0x21>
  5b:	eb 0d                	jmp    6a <fmtname+0x26>
  5d:	8d 76 00             	lea    0x0(%esi),%esi
  60:	48                   	dec    %eax
  61:	39 c3                	cmp    %eax,%ebx
  63:	77 05                	ja     6a <fmtname+0x26>
  65:	80 38 2f             	cmpb   $0x2f,(%eax)
  68:	75 f6                	jne    60 <fmtname+0x1c>
    ;
  p++;
  6a:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  6d:	89 1c 24             	mov    %ebx,(%esp)
  70:	e8 3b 03 00 00       	call   3b0 <strlen>
  75:	83 f8 0d             	cmp    $0xd,%eax
  78:	76 0a                	jbe    84 <fmtname+0x40>
    return p;
  7a:	89 d8                	mov    %ebx,%eax
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	5b                   	pop    %ebx
  80:	5e                   	pop    %esi
  81:	5d                   	pop    %ebp
  82:	c3                   	ret    
  83:	90                   	nop
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  84:	89 1c 24             	mov    %ebx,(%esp)
  87:	e8 24 03 00 00       	call   3b0 <strlen>
  8c:	89 44 24 08          	mov    %eax,0x8(%esp)
  90:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  94:	c7 04 24 a4 0c 00 00 	movl   $0xca4,(%esp)
  9b:	e8 44 04 00 00       	call   4e4 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a0:	89 1c 24             	mov    %ebx,(%esp)
  a3:	e8 08 03 00 00       	call   3b0 <strlen>
  a8:	89 c6                	mov    %eax,%esi
  aa:	89 1c 24             	mov    %ebx,(%esp)
  ad:	e8 fe 02 00 00       	call   3b0 <strlen>
  b2:	ba 0e 00 00 00       	mov    $0xe,%edx
  b7:	29 f2                	sub    %esi,%edx
  b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  bd:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  c4:	00 
  c5:	05 a4 0c 00 00       	add    $0xca4,%eax
  ca:	89 04 24             	mov    %eax,(%esp)
  cd:	e8 fe 02 00 00       	call   3d0 <memset>
  return buf;
  d2:	b8 a4 0c 00 00       	mov    $0xca4,%eax
}
  d7:	83 c4 10             	add    $0x10,%esp
  da:	5b                   	pop    %ebx
  db:	5e                   	pop    %esi
  dc:	5d                   	pop    %ebp
  dd:	c3                   	ret    
  de:	66 90                	xchg   %ax,%ax

000000e0 <ls>:

void
ls(char *path)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	56                   	push   %esi
  e5:	53                   	push   %ebx
  e6:	81 ec 6c 02 00 00    	sub    $0x26c,%esp
  ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  ef:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  f6:	00 
  f7:	89 3c 24             	mov    %edi,(%esp)
  fa:	e8 51 04 00 00       	call   550 <open>
  ff:	89 c3                	mov    %eax,%ebx
 101:	85 c0                	test   %eax,%eax
 103:	0f 88 bb 01 00 00    	js     2c4 <ls+0x1e4>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 109:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 10f:	89 74 24 04          	mov    %esi,0x4(%esp)
 113:	89 04 24             	mov    %eax,(%esp)
 116:	e8 4d 04 00 00       	call   568 <fstat>
 11b:	85 c0                	test   %eax,%eax
 11d:	0f 88 e1 01 00 00    	js     304 <ls+0x224>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 123:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
 129:	66 83 f8 01          	cmp    $0x1,%ax
 12d:	74 61                	je     190 <ls+0xb0>
 12f:	66 83 f8 02          	cmp    $0x2,%ax
 133:	75 48                	jne    17d <ls+0x9d>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 135:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 13b:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 141:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 147:	89 3c 24             	mov    %edi,(%esp)
 14a:	e8 f5 fe ff ff       	call   44 <fmtname>
 14f:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 155:	89 54 24 14          	mov    %edx,0x14(%esp)
 159:	89 74 24 10          	mov    %esi,0x10(%esp)
 15d:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 164:	00 
 165:	89 44 24 08          	mov    %eax,0x8(%esp)
 169:	c7 44 24 04 92 09 00 	movl   $0x992,0x4(%esp)
 170:	00 
 171:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 178:	e8 c7 04 00 00       	call   644 <printf>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 17d:	89 1c 24             	mov    %ebx,(%esp)
 180:	e8 b3 03 00 00       	call   538 <close>
}
 185:	81 c4 6c 02 00 00    	add    $0x26c,%esp
 18b:	5b                   	pop    %ebx
 18c:	5e                   	pop    %esi
 18d:	5f                   	pop    %edi
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret    
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 190:	89 3c 24             	mov    %edi,(%esp)
 193:	e8 18 02 00 00       	call   3b0 <strlen>
 198:	83 c0 10             	add    $0x10,%eax
 19b:	3d 00 02 00 00       	cmp    $0x200,%eax
 1a0:	0f 87 42 01 00 00    	ja     2e8 <ls+0x208>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 1a6:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1aa:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1b0:	89 04 24             	mov    %eax,(%esp)
 1b3:	e8 98 01 00 00       	call   350 <strcpy>
    p = buf+strlen(buf);
 1b8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1be:	89 04 24             	mov    %eax,(%esp)
 1c1:	e8 ea 01 00 00       	call   3b0 <strlen>
 1c6:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 1cc:	01 c8                	add    %ecx,%eax
 1ce:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1d4:	8d 48 01             	lea    0x1(%eax),%ecx
 1d7:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1dd:	c6 00 2f             	movb   $0x2f,(%eax)
 1e0:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1e6:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1ef:	00 
 1f0:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1f4:	89 1c 24             	mov    %ebx,(%esp)
 1f7:	e8 2c 03 00 00       	call   528 <read>
 1fc:	83 f8 10             	cmp    $0x10,%eax
 1ff:	0f 85 78 ff ff ff    	jne    17d <ls+0x9d>
      if(de.inum == 0)
 205:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 20c:	00 
 20d:	74 d9                	je     1e8 <ls+0x108>
        continue;
      memmove(p, de.name, DIRSIZ);
 20f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 216:	00 
 217:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 21d:	89 44 24 04          	mov    %eax,0x4(%esp)
 221:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 227:	89 04 24             	mov    %eax,(%esp)
 22a:	e8 b5 02 00 00       	call   4e4 <memmove>
      p[DIRSIZ] = 0;
 22f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 235:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 239:	89 74 24 04          	mov    %esi,0x4(%esp)
 23d:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 243:	89 04 24             	mov    %eax,(%esp)
 246:	e8 1d 02 00 00       	call   468 <stat>
 24b:	85 c0                	test   %eax,%eax
 24d:	0f 88 d9 00 00 00    	js     32c <ls+0x24c>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 253:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 259:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 25f:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
 265:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 26b:	0f bf 95 d4 fd ff ff 	movswl -0x22c(%ebp),%edx
 272:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 278:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 27e:	89 14 24             	mov    %edx,(%esp)
 281:	e8 be fd ff ff       	call   44 <fmtname>
 286:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 28c:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 290:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 296:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 29a:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 2a0:	89 54 24 0c          	mov    %edx,0xc(%esp)
 2a4:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a8:	c7 44 24 04 92 09 00 	movl   $0x992,0x4(%esp)
 2af:	00 
 2b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2b7:	e8 88 03 00 00       	call   644 <printf>
 2bc:	e9 27 ff ff ff       	jmp    1e8 <ls+0x108>
 2c1:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 2c4:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2c8:	c7 44 24 04 6a 09 00 	movl   $0x96a,0x4(%esp)
 2cf:	00 
 2d0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2d7:	e8 68 03 00 00       	call   644 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2dc:	81 c4 6c 02 00 00    	add    $0x26c,%esp
 2e2:	5b                   	pop    %ebx
 2e3:	5e                   	pop    %esi
 2e4:	5f                   	pop    %edi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	90                   	nop
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 2e8:	c7 44 24 04 9f 09 00 	movl   $0x99f,0x4(%esp)
 2ef:	00 
 2f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f7:	e8 48 03 00 00       	call   644 <printf>
      break;
 2fc:	e9 7c fe ff ff       	jmp    17d <ls+0x9d>
 301:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 304:	89 7c 24 08          	mov    %edi,0x8(%esp)
 308:	c7 44 24 04 7e 09 00 	movl   $0x97e,0x4(%esp)
 30f:	00 
 310:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 317:	e8 28 03 00 00       	call   644 <printf>
    close(fd);
 31c:	89 1c 24             	mov    %ebx,(%esp)
 31f:	e8 14 02 00 00       	call   538 <close>
    return;
 324:	e9 5c fe ff ff       	jmp    185 <ls+0xa5>
 329:	8d 76 00             	lea    0x0(%esi),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 32c:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 332:	89 44 24 08          	mov    %eax,0x8(%esp)
 336:	c7 44 24 04 7e 09 00 	movl   $0x97e,0x4(%esp)
 33d:	00 
 33e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 345:	e8 fa 02 00 00       	call   644 <printf>
        continue;
 34a:	e9 99 fe ff ff       	jmp    1e8 <ls+0x108>
 34f:	90                   	nop

00000350 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 35a:	89 c2                	mov    %eax,%edx
 35c:	42                   	inc    %edx
 35d:	41                   	inc    %ecx
 35e:	8a 59 ff             	mov    -0x1(%ecx),%bl
 361:	88 5a ff             	mov    %bl,-0x1(%edx)
 364:	84 db                	test   %bl,%bl
 366:	75 f4                	jne    35c <strcpy+0xc>
    ;
  return os;
}
 368:	5b                   	pop    %ebx
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    
 36b:	90                   	nop

0000036c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	53                   	push   %ebx
 370:	8b 55 08             	mov    0x8(%ebp),%edx
 373:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 376:	0f b6 02             	movzbl (%edx),%eax
 379:	84 c0                	test   %al,%al
 37b:	74 27                	je     3a4 <strcmp+0x38>
 37d:	8a 19                	mov    (%ecx),%bl
 37f:	38 d8                	cmp    %bl,%al
 381:	74 0b                	je     38e <strcmp+0x22>
 383:	eb 26                	jmp    3ab <strcmp+0x3f>
 385:	8d 76 00             	lea    0x0(%esi),%esi
 388:	38 c8                	cmp    %cl,%al
 38a:	75 13                	jne    39f <strcmp+0x33>
    p++, q++;
 38c:	89 d9                	mov    %ebx,%ecx
 38e:	42                   	inc    %edx
 38f:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 392:	0f b6 02             	movzbl (%edx),%eax
 395:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 399:	84 c0                	test   %al,%al
 39b:	75 eb                	jne    388 <strcmp+0x1c>
 39d:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 39f:	29 c8                	sub    %ecx,%eax
}
 3a1:	5b                   	pop    %ebx
 3a2:	5d                   	pop    %ebp
 3a3:	c3                   	ret    
 3a4:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a7:	31 c0                	xor    %eax,%eax
 3a9:	eb f4                	jmp    39f <strcmp+0x33>
 3ab:	0f b6 cb             	movzbl %bl,%ecx
 3ae:	eb ef                	jmp    39f <strcmp+0x33>

000003b0 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 39 00             	cmpb   $0x0,(%ecx)
 3b9:	74 10                	je     3cb <strlen+0x1b>
 3bb:	31 d2                	xor    %edx,%edx
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	42                   	inc    %edx
 3c1:	89 d0                	mov    %edx,%eax
 3c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3c7:	75 f7                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 3cb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 3cd:	5d                   	pop    %ebp
 3ce:	c3                   	ret    
 3cf:	90                   	nop

000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3d7:	89 d7                	mov    %edx,%edi
 3d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	90                   	nop

000003e8 <strchr>:

char*
strchr(const char *s, char c)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	53                   	push   %ebx
 3ec:	8b 45 08             	mov    0x8(%ebp),%eax
 3ef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3f2:	8a 10                	mov    (%eax),%dl
 3f4:	84 d2                	test   %dl,%dl
 3f6:	74 13                	je     40b <strchr+0x23>
 3f8:	88 d9                	mov    %bl,%cl
    if(*s == c)
 3fa:	38 da                	cmp    %bl,%dl
 3fc:	75 06                	jne    404 <strchr+0x1c>
 3fe:	eb 0d                	jmp    40d <strchr+0x25>
 400:	38 ca                	cmp    %cl,%dl
 402:	74 09                	je     40d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 404:	40                   	inc    %eax
 405:	8a 10                	mov    (%eax),%dl
 407:	84 d2                	test   %dl,%dl
 409:	75 f5                	jne    400 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 40b:	31 c0                	xor    %eax,%eax
}
 40d:	5b                   	pop    %ebx
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    

00000410 <gets>:

char*
gets(char *buf, int max)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 419:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 41b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41e:	eb 30                	jmp    450 <gets+0x40>
    cc = read(0, &c, 1);
 420:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 427:	00 
 428:	89 7c 24 04          	mov    %edi,0x4(%esp)
 42c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 433:	e8 f0 00 00 00       	call   528 <read>
    if(cc < 1)
 438:	85 c0                	test   %eax,%eax
 43a:	7e 1c                	jle    458 <gets+0x48>
      break;
    buf[i++] = c;
 43c:	8a 45 e7             	mov    -0x19(%ebp),%al
 43f:	8b 55 08             	mov    0x8(%ebp),%edx
 442:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 446:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 448:	3c 0a                	cmp    $0xa,%al
 44a:	74 0c                	je     458 <gets+0x48>
 44c:	3c 0d                	cmp    $0xd,%al
 44e:	74 08                	je     458 <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 450:	8d 5e 01             	lea    0x1(%esi),%ebx
 453:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 456:	7c c8                	jl     420 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 458:	8b 45 08             	mov    0x8(%ebp),%eax
 45b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 45f:	83 c4 2c             	add    $0x2c,%esp
 462:	5b                   	pop    %ebx
 463:	5e                   	pop    %esi
 464:	5f                   	pop    %edi
 465:	5d                   	pop    %ebp
 466:	c3                   	ret    
 467:	90                   	nop

00000468 <stat>:

int
stat(char *n, struct stat *st)
{
 468:	55                   	push   %ebp
 469:	89 e5                	mov    %esp,%ebp
 46b:	56                   	push   %esi
 46c:	53                   	push   %ebx
 46d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 470:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 477:	00 
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	89 04 24             	mov    %eax,(%esp)
 47e:	e8 cd 00 00 00       	call   550 <open>
 483:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 485:	85 c0                	test   %eax,%eax
 487:	78 23                	js     4ac <stat+0x44>
    return -1;
  r = fstat(fd, st);
 489:	8b 45 0c             	mov    0xc(%ebp),%eax
 48c:	89 44 24 04          	mov    %eax,0x4(%esp)
 490:	89 1c 24             	mov    %ebx,(%esp)
 493:	e8 d0 00 00 00       	call   568 <fstat>
 498:	89 c6                	mov    %eax,%esi
  close(fd);
 49a:	89 1c 24             	mov    %ebx,(%esp)
 49d:	e8 96 00 00 00       	call   538 <close>
  return r;
 4a2:	89 f0                	mov    %esi,%eax
}
 4a4:	83 c4 10             	add    $0x10,%esp
 4a7:	5b                   	pop    %ebx
 4a8:	5e                   	pop    %esi
 4a9:	5d                   	pop    %ebp
 4aa:	c3                   	ret    
 4ab:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4b1:	eb f1                	jmp    4a4 <stat+0x3c>
 4b3:	90                   	nop

000004b4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	53                   	push   %ebx
 4b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4bb:	0f be 11             	movsbl (%ecx),%edx
 4be:	8d 42 d0             	lea    -0x30(%edx),%eax
 4c1:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 4c3:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 4c8:	77 15                	ja     4df <atoi+0x2b>
 4ca:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 4cc:	41                   	inc    %ecx
 4cd:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4d0:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4d4:	0f be 11             	movsbl (%ecx),%edx
 4d7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4da:	80 fb 09             	cmp    $0x9,%bl
 4dd:	76 ed                	jbe    4cc <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 4df:	5b                   	pop    %ebx
 4e0:	5d                   	pop    %ebp
 4e1:	c3                   	ret    
 4e2:	66 90                	xchg   %ax,%ax

000004e4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	56                   	push   %esi
 4e8:	53                   	push   %ebx
 4e9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ef:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	85 f6                	test   %esi,%esi
 4f6:	7e 0b                	jle    503 <memmove+0x1f>
    *dst++ = *src++;
 4f8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 4fb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4fe:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ff:	39 f2                	cmp    %esi,%edx
 501:	75 f5                	jne    4f8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 503:	5b                   	pop    %ebx
 504:	5e                   	pop    %esi
 505:	5d                   	pop    %ebp
 506:	c3                   	ret    
 507:	90                   	nop

00000508 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 508:	b8 01 00 00 00       	mov    $0x1,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <exit>:
SYSCALL(exit)
 510:	b8 02 00 00 00       	mov    $0x2,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <wait>:
SYSCALL(wait)
 518:	b8 03 00 00 00       	mov    $0x3,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <pipe>:
SYSCALL(pipe)
 520:	b8 04 00 00 00       	mov    $0x4,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <read>:
SYSCALL(read)
 528:	b8 05 00 00 00       	mov    $0x5,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <write>:
SYSCALL(write)
 530:	b8 10 00 00 00       	mov    $0x10,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <close>:
SYSCALL(close)
 538:	b8 15 00 00 00       	mov    $0x15,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <kill>:
SYSCALL(kill)
 540:	b8 06 00 00 00       	mov    $0x6,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <exec>:
SYSCALL(exec)
 548:	b8 07 00 00 00       	mov    $0x7,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <open>:
SYSCALL(open)
 550:	b8 0f 00 00 00       	mov    $0xf,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <mknod>:
SYSCALL(mknod)
 558:	b8 11 00 00 00       	mov    $0x11,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <unlink>:
SYSCALL(unlink)
 560:	b8 12 00 00 00       	mov    $0x12,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <fstat>:
SYSCALL(fstat)
 568:	b8 08 00 00 00       	mov    $0x8,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <link>:
SYSCALL(link)
 570:	b8 13 00 00 00       	mov    $0x13,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <mkdir>:
SYSCALL(mkdir)
 578:	b8 14 00 00 00       	mov    $0x14,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <chdir>:
SYSCALL(chdir)
 580:	b8 09 00 00 00       	mov    $0x9,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <dup>:
SYSCALL(dup)
 588:	b8 0a 00 00 00       	mov    $0xa,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <getpid>:
SYSCALL(getpid)
 590:	b8 0b 00 00 00       	mov    $0xb,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <sbrk>:
SYSCALL(sbrk)
 598:	b8 0c 00 00 00       	mov    $0xc,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <sleep>:
SYSCALL(sleep)
 5a0:	b8 0d 00 00 00       	mov    $0xd,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <uptime>:
SYSCALL(uptime)
 5a8:	b8 0e 00 00 00       	mov    $0xe,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 4c             	sub    $0x4c,%esp
 5b9:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5bb:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5c0:	85 db                	test   %ebx,%ebx
 5c2:	74 04                	je     5c8 <printint+0x18>
 5c4:	85 d2                	test   %edx,%edx
 5c6:	78 70                	js     638 <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5cf:	31 ff                	xor    %edi,%edi
 5d1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5d4:	89 75 c0             	mov    %esi,-0x40(%ebp)
 5d7:	89 ce                	mov    %ecx,%esi
 5d9:	eb 03                	jmp    5de <printint+0x2e>
 5db:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 5dc:	89 cf                	mov    %ecx,%edi
 5de:	8d 4f 01             	lea    0x1(%edi),%ecx
 5e1:	31 d2                	xor    %edx,%edx
 5e3:	f7 f6                	div    %esi
 5e5:	8a 92 bb 09 00 00    	mov    0x9bb(%edx),%dl
 5eb:	88 55 c7             	mov    %dl,-0x39(%ebp)
 5ee:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5f1:	85 c0                	test   %eax,%eax
 5f3:	75 e7                	jne    5dc <printint+0x2c>
 5f5:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5f8:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 5fa:	8b 55 bc             	mov    -0x44(%ebp),%edx
 5fd:	85 d2                	test   %edx,%edx
 5ff:	74 08                	je     609 <printint+0x59>
    buf[i++] = '-';
 601:	8d 4f 02             	lea    0x2(%edi),%ecx
 604:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 609:	8d 79 ff             	lea    -0x1(%ecx),%edi
 60c:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 610:	88 45 c7             	mov    %al,-0x39(%ebp)
 613:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 616:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 61d:	00 
 61e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 622:	89 34 24             	mov    %esi,(%esp)
 625:	e8 06 ff ff ff       	call   530 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 62a:	4f                   	dec    %edi
 62b:	83 ff ff             	cmp    $0xffffffff,%edi
 62e:	75 dc                	jne    60c <printint+0x5c>
    putc(fd, buf[i]);
}
 630:	83 c4 4c             	add    $0x4c,%esp
 633:	5b                   	pop    %ebx
 634:	5e                   	pop    %esi
 635:	5f                   	pop    %edi
 636:	5d                   	pop    %ebp
 637:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 638:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 63a:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 641:	eb 8c                	jmp    5cf <printint+0x1f>
 643:	90                   	nop

00000644 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 644:	55                   	push   %ebp
 645:	89 e5                	mov    %esp,%ebp
 647:	57                   	push   %edi
 648:	56                   	push   %esi
 649:	53                   	push   %ebx
 64a:	83 ec 3c             	sub    $0x3c,%esp
 64d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 650:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 653:	0f b6 13             	movzbl (%ebx),%edx
 656:	84 d2                	test   %dl,%dl
 658:	0f 84 be 00 00 00    	je     71c <printf+0xd8>
 65e:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 65f:	8d 45 10             	lea    0x10(%ebp),%eax
 662:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 665:	31 ff                	xor    %edi,%edi
 667:	eb 33                	jmp    69c <printf+0x58>
 669:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 66c:	83 fa 25             	cmp    $0x25,%edx
 66f:	0f 84 af 00 00 00    	je     724 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 675:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 678:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 67f:	00 
 680:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 683:	89 44 24 04          	mov    %eax,0x4(%esp)
 687:	89 34 24             	mov    %esi,(%esp)
 68a:	e8 a1 fe ff ff       	call   530 <write>
 68f:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 690:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 694:	84 d2                	test   %dl,%dl
 696:	0f 84 80 00 00 00    	je     71c <printf+0xd8>
    c = fmt[i] & 0xff;
 69c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 69f:	85 ff                	test   %edi,%edi
 6a1:	74 c9                	je     66c <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6a3:	83 ff 25             	cmp    $0x25,%edi
 6a6:	75 e7                	jne    68f <printf+0x4b>
      if(c == 'd'){
 6a8:	83 fa 64             	cmp    $0x64,%edx
 6ab:	0f 84 0f 01 00 00    	je     7c0 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6b1:	25 f7 00 00 00       	and    $0xf7,%eax
 6b6:	83 f8 70             	cmp    $0x70,%eax
 6b9:	74 75                	je     730 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6bb:	83 fa 73             	cmp    $0x73,%edx
 6be:	0f 84 90 00 00 00    	je     754 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6c4:	83 fa 63             	cmp    $0x63,%edx
 6c7:	0f 84 c7 00 00 00    	je     794 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6cd:	83 fa 25             	cmp    $0x25,%edx
 6d0:	0f 84 0e 01 00 00    	je     7e4 <printf+0x1a0>
 6d6:	89 55 d0             	mov    %edx,-0x30(%ebp)
 6d9:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6dd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6e4:	00 
 6e5:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ec:	89 34 24             	mov    %esi,(%esp)
 6ef:	e8 3c fe ff ff       	call   530 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6f4:	8b 55 d0             	mov    -0x30(%ebp),%edx
 6f7:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 701:	00 
 702:	8d 45 e7             	lea    -0x19(%ebp),%eax
 705:	89 44 24 04          	mov    %eax,0x4(%esp)
 709:	89 34 24             	mov    %esi,(%esp)
 70c:	e8 1f fe ff ff       	call   530 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 711:	31 ff                	xor    %edi,%edi
 713:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 714:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 718:	84 d2                	test   %dl,%dl
 71a:	75 80                	jne    69c <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 71c:	83 c4 3c             	add    $0x3c,%esp
 71f:	5b                   	pop    %ebx
 720:	5e                   	pop    %esi
 721:	5f                   	pop    %edi
 722:	5d                   	pop    %ebp
 723:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 724:	bf 25 00 00 00       	mov    $0x25,%edi
 729:	e9 61 ff ff ff       	jmp    68f <printf+0x4b>
 72e:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 730:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 737:	b9 10 00 00 00       	mov    $0x10,%ecx
 73c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 73f:	8b 10                	mov    (%eax),%edx
 741:	89 f0                	mov    %esi,%eax
 743:	e8 68 fe ff ff       	call   5b0 <printint>
        ap++;
 748:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74c:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 74e:	e9 3c ff ff ff       	jmp    68f <printf+0x4b>
 753:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 754:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 757:	8b 38                	mov    (%eax),%edi
        ap++;
 759:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 75d:	85 ff                	test   %edi,%edi
 75f:	0f 84 a1 00 00 00    	je     806 <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 765:	8a 07                	mov    (%edi),%al
 767:	84 c0                	test   %al,%al
 769:	74 22                	je     78d <printf+0x149>
 76b:	90                   	nop
 76c:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 76f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 776:	00 
 777:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 77a:	89 44 24 04          	mov    %eax,0x4(%esp)
 77e:	89 34 24             	mov    %esi,(%esp)
 781:	e8 aa fd ff ff       	call   530 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 786:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 787:	8a 07                	mov    (%edi),%al
 789:	84 c0                	test   %al,%al
 78b:	75 df                	jne    76c <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 78d:	31 ff                	xor    %edi,%edi
 78f:	e9 fb fe ff ff       	jmp    68f <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 794:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 797:	8b 00                	mov    (%eax),%eax
 799:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 79c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7a3:	00 
 7a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ab:	89 34 24             	mov    %esi,(%esp)
 7ae:	e8 7d fd ff ff       	call   530 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 7b3:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7b7:	31 ff                	xor    %edi,%edi
 7b9:	e9 d1 fe ff ff       	jmp    68f <printf+0x4b>
 7be:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7c7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7cc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7cf:	8b 10                	mov    (%eax),%edx
 7d1:	89 f0                	mov    %esi,%eax
 7d3:	e8 d8 fd ff ff       	call   5b0 <printint>
        ap++;
 7d8:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7dc:	66 31 ff             	xor    %di,%di
 7df:	e9 ab fe ff ff       	jmp    68f <printf+0x4b>
 7e4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7ef:	00 
 7f0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f7:	89 34 24             	mov    %esi,(%esp)
 7fa:	e8 31 fd ff ff       	call   530 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ff:	31 ff                	xor    %edi,%edi
 801:	e9 89 fe ff ff       	jmp    68f <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 806:	bf b4 09 00 00       	mov    $0x9b4,%edi
 80b:	e9 55 ff ff ff       	jmp    765 <printf+0x121>

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 819:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81c:	a1 b4 0c 00 00       	mov    0xcb4,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 821:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 823:	39 d0                	cmp    %edx,%eax
 825:	72 11                	jb     838 <free+0x28>
 827:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 828:	39 c8                	cmp    %ecx,%eax
 82a:	72 04                	jb     830 <free+0x20>
 82c:	39 ca                	cmp    %ecx,%edx
 82e:	72 10                	jb     840 <free+0x30>
 830:	89 c8                	mov    %ecx,%eax
 832:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 834:	39 d0                	cmp    %edx,%eax
 836:	73 f0                	jae    828 <free+0x18>
 838:	39 ca                	cmp    %ecx,%edx
 83a:	72 04                	jb     840 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	39 c8                	cmp    %ecx,%eax
 83e:	72 f0                	jb     830 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 840:	8b 73 fc             	mov    -0x4(%ebx),%esi
 843:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 846:	39 cf                	cmp    %ecx,%edi
 848:	74 1a                	je     864 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 84a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 84d:	8b 48 04             	mov    0x4(%eax),%ecx
 850:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 853:	39 f2                	cmp    %esi,%edx
 855:	74 24                	je     87b <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 857:	89 10                	mov    %edx,(%eax)
  freep = p;
 859:	a3 b4 0c 00 00       	mov    %eax,0xcb4
}
 85e:	5b                   	pop    %ebx
 85f:	5e                   	pop    %esi
 860:	5f                   	pop    %edi
 861:	5d                   	pop    %ebp
 862:	c3                   	ret    
 863:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 864:	03 71 04             	add    0x4(%ecx),%esi
 867:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 86a:	8b 08                	mov    (%eax),%ecx
 86c:	8b 09                	mov    (%ecx),%ecx
 86e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 871:	8b 48 04             	mov    0x4(%eax),%ecx
 874:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 877:	39 f2                	cmp    %esi,%edx
 879:	75 dc                	jne    857 <free+0x47>
    p->s.size += bp->s.size;
 87b:	03 4b fc             	add    -0x4(%ebx),%ecx
 87e:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 881:	8b 53 f8             	mov    -0x8(%ebx),%edx
 884:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 886:	a3 b4 0c 00 00       	mov    %eax,0xcb4
}
 88b:	5b                   	pop    %ebx
 88c:	5e                   	pop    %esi
 88d:	5f                   	pop    %edi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret    

00000890 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
 894:	56                   	push   %esi
 895:	53                   	push   %ebx
 896:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 899:	8b 45 08             	mov    0x8(%ebp),%eax
 89c:	8d 70 07             	lea    0x7(%eax),%esi
 89f:	c1 ee 03             	shr    $0x3,%esi
 8a2:	46                   	inc    %esi
  if((prevp = freep) == 0){
 8a3:	8b 1d b4 0c 00 00    	mov    0xcb4,%ebx
 8a9:	85 db                	test   %ebx,%ebx
 8ab:	0f 84 91 00 00 00    	je     942 <malloc+0xb2>
 8b1:	8b 13                	mov    (%ebx),%edx
 8b3:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8b6:	39 ce                	cmp    %ecx,%esi
 8b8:	76 52                	jbe    90c <malloc+0x7c>
 8ba:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 8c1:	eb 0c                	jmp    8cf <malloc+0x3f>
 8c3:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c4:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8c6:	8b 48 04             	mov    0x4(%eax),%ecx
 8c9:	39 ce                	cmp    %ecx,%esi
 8cb:	76 43                	jbe    910 <malloc+0x80>
 8cd:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8cf:	3b 15 b4 0c 00 00    	cmp    0xcb4,%edx
 8d5:	75 ed                	jne    8c4 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 8d7:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 8dd:	76 51                	jbe    930 <malloc+0xa0>
 8df:	89 d8                	mov    %ebx,%eax
 8e1:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8e3:	89 04 24             	mov    %eax,(%esp)
 8e6:	e8 ad fc ff ff       	call   598 <sbrk>
  if(p == (char*)-1)
 8eb:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ee:	74 18                	je     908 <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8f0:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8f3:	83 c0 08             	add    $0x8,%eax
 8f6:	89 04 24             	mov    %eax,(%esp)
 8f9:	e8 12 ff ff ff       	call   810 <free>
  return freep;
 8fe:	8b 15 b4 0c 00 00    	mov    0xcb4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 904:	85 d2                	test   %edx,%edx
 906:	75 bc                	jne    8c4 <malloc+0x34>
        return 0;
 908:	31 c0                	xor    %eax,%eax
 90a:	eb 1c                	jmp    928 <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 90c:	89 d0                	mov    %edx,%eax
 90e:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 910:	39 ce                	cmp    %ecx,%esi
 912:	74 28                	je     93c <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 914:	29 f1                	sub    %esi,%ecx
 916:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 919:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 91c:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 91f:	89 15 b4 0c 00 00    	mov    %edx,0xcb4
      return (void*)(p + 1);
 925:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 928:	83 c4 1c             	add    $0x1c,%esp
 92b:	5b                   	pop    %ebx
 92c:	5e                   	pop    %esi
 92d:	5f                   	pop    %edi
 92e:	5d                   	pop    %ebp
 92f:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 930:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 935:	bf 00 10 00 00       	mov    $0x1000,%edi
 93a:	eb a7                	jmp    8e3 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 93c:	8b 08                	mov    (%eax),%ecx
 93e:	89 0a                	mov    %ecx,(%edx)
 940:	eb dd                	jmp    91f <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 942:	c7 05 b4 0c 00 00 b8 	movl   $0xcb8,0xcb4
 949:	0c 00 00 
 94c:	c7 05 b8 0c 00 00 b8 	movl   $0xcb8,0xcb8
 953:	0c 00 00 
    base.s.size = 0;
 956:	c7 05 bc 0c 00 00 00 	movl   $0x0,0xcbc
 95d:	00 00 00 
 960:	ba b8 0c 00 00       	mov    $0xcb8,%edx
 965:	e9 50 ff ff ff       	jmp    8ba <malloc+0x2a>
