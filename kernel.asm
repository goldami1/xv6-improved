
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 0c 2c 10 80       	mov    $0x80102c0c,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	53                   	push   %ebx
80100038:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003b:	c7 44 24 04 40 66 10 	movl   $0x80106640,0x4(%esp)
80100042:	80 
80100043:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010004a:	e8 05 3d 00 00       	call   80103d54 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100056:	fc 10 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100060:	fc 10 80 
80100063:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100068:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
8010006d:	eb 05                	jmp    80100074 <binit+0x40>
8010006f:	90                   	nop
80100070:	89 da                	mov    %ebx,%edx
80100072:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
80100074:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
80100077:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010007e:	c7 44 24 04 47 66 10 	movl   $0x80106647,0x4(%esp)
80100085:	80 
80100086:	8d 43 0c             	lea    0xc(%ebx),%eax
80100089:	89 04 24             	mov    %eax,(%esp)
8010008c:	e8 d3 3b 00 00       	call   80103c64 <initsleeplock>
    bcache.head.next->prev = b;
80100091:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100096:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100099:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000a5:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000aa:	75 c4                	jne    80100070 <binit+0x3c>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ac:	83 c4 14             	add    $0x14,%esp
801000af:	5b                   	pop    %ebx
801000b0:	5d                   	pop    %ebp
801000b1:	c3                   	ret    
801000b2:	66 90                	xchg   %ax,%ax

801000b4 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000b4:	55                   	push   %ebp
801000b5:	89 e5                	mov    %esp,%ebp
801000b7:	57                   	push   %edi
801000b8:	56                   	push   %esi
801000b9:	53                   	push   %ebx
801000ba:	83 ec 1c             	sub    $0x1c,%esp
801000bd:	8b 75 08             	mov    0x8(%ebp),%esi
801000c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000c3:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801000ca:	e8 4d 3d 00 00       	call   80103e1c <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000cf:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000d5:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000db:	75 0e                	jne    801000eb <bread+0x37>
801000dd:	eb 1d                	jmp    801000fc <bread+0x48>
801000df:	90                   	nop
801000e0:	8b 5b 54             	mov    0x54(%ebx),%ebx
801000e3:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000e9:	74 11                	je     801000fc <bread+0x48>
    if(b->dev == dev && b->blockno == blockno){
801000eb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000ee:	75 f0                	jne    801000e0 <bread+0x2c>
801000f0:	3b 7b 08             	cmp    0x8(%ebx),%edi
801000f3:	75 eb                	jne    801000e0 <bread+0x2c>
      b->refcnt++;
801000f5:	ff 43 4c             	incl   0x4c(%ebx)
801000f8:	eb 3c                	jmp    80100136 <bread+0x82>
801000fa:	66 90                	xchg   %ax,%ax
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801000fc:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100102:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100108:	75 0d                	jne    80100117 <bread+0x63>
8010010a:	eb 5e                	jmp    8010016a <bread+0xb6>
8010010c:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010010f:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100115:	74 53                	je     8010016a <bread+0xb6>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100117:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010011a:	85 c0                	test   %eax,%eax
8010011c:	75 ee                	jne    8010010c <bread+0x58>
8010011e:	f6 03 04             	testb  $0x4,(%ebx)
80100121:	75 e9                	jne    8010010c <bread+0x58>
      b->dev = dev;
80100123:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100126:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
80100129:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
8010012f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100136:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010013d:	e8 b2 3d 00 00       	call   80103ef4 <release>
      acquiresleep(&b->lock);
80100142:	8d 43 0c             	lea    0xc(%ebx),%eax
80100145:	89 04 24             	mov    %eax,(%esp)
80100148:	e8 4f 3b 00 00       	call   80103c9c <acquiresleep>
8010014d:	89 d8                	mov    %ebx,%eax
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
8010014f:	f6 03 02             	testb  $0x2,(%ebx)
80100152:	75 0e                	jne    80100162 <bread+0xae>
    iderw(b);
80100154:	89 1c 24             	mov    %ebx,(%esp)
80100157:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010015a:	e8 9d 1d 00 00       	call   80101efc <iderw>
8010015f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  return b;
}
80100162:	83 c4 1c             	add    $0x1c,%esp
80100165:	5b                   	pop    %ebx
80100166:	5e                   	pop    %esi
80100167:	5f                   	pop    %edi
80100168:	5d                   	pop    %ebp
80100169:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
8010016a:	c7 04 24 4e 66 10 80 	movl   $0x8010664e,(%esp)
80100171:	e8 9e 01 00 00       	call   80100314 <panic>
80100176:	66 90                	xchg   %ax,%ax

80100178 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100178:	55                   	push   %ebp
80100179:	89 e5                	mov    %esp,%ebp
8010017b:	53                   	push   %ebx
8010017c:	83 ec 14             	sub    $0x14,%esp
8010017f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
80100182:	8d 43 0c             	lea    0xc(%ebx),%eax
80100185:	89 04 24             	mov    %eax,(%esp)
80100188:	e8 9b 3b 00 00       	call   80103d28 <holdingsleep>
8010018d:	85 c0                	test   %eax,%eax
8010018f:	74 10                	je     801001a1 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
80100191:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
80100194:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80100197:	83 c4 14             	add    $0x14,%esp
8010019a:	5b                   	pop    %ebx
8010019b:	5d                   	pop    %ebp
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
8010019c:	e9 5b 1d 00 00       	jmp    80101efc <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001a1:	c7 04 24 5f 66 10 80 	movl   $0x8010665f,(%esp)
801001a8:	e8 67 01 00 00       	call   80100314 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	56                   	push   %esi
801001b4:	53                   	push   %ebx
801001b5:	83 ec 10             	sub    $0x10,%esp
801001b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001bb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001be:	89 34 24             	mov    %esi,(%esp)
801001c1:	e8 62 3b 00 00       	call   80103d28 <holdingsleep>
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 5a                	je     80100224 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001ca:	89 34 24             	mov    %esi,(%esp)
801001cd:	e8 1a 3b 00 00       	call   80103cec <releasesleep>

  acquire(&bcache.lock);
801001d2:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801001d9:	e8 3e 3c 00 00       	call   80103e1c <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
801001de:	ff 4b 4c             	decl   0x4c(%ebx)
801001e1:	75 2f                	jne    80100212 <brelse+0x62>
    // no one is waiting for it.
    b->next->prev = b->prev;
801001e3:	8b 43 54             	mov    0x54(%ebx),%eax
801001e6:	8b 53 50             	mov    0x50(%ebx),%edx
801001e9:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801001ec:	8b 43 50             	mov    0x50(%ebx),%eax
801001ef:	8b 53 54             	mov    0x54(%ebx),%edx
801001f2:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
801001f5:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801001fa:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
801001fd:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    bcache.head.next->prev = b;
80100204:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100209:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010020c:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
80100212:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100219:	83 c4 10             	add    $0x10,%esp
8010021c:	5b                   	pop    %ebx
8010021d:	5e                   	pop    %esi
8010021e:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010021f:	e9 d0 3c 00 00       	jmp    80103ef4 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100224:	c7 04 24 66 66 10 80 	movl   $0x80106666,(%esp)
8010022b:	e8 e4 00 00 00       	call   80100314 <panic>

80100230 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100230:	55                   	push   %ebp
80100231:	89 e5                	mov    %esp,%ebp
80100233:	57                   	push   %edi
80100234:	56                   	push   %esi
80100235:	53                   	push   %ebx
80100236:	83 ec 1c             	sub    $0x1c,%esp
80100239:	8b 7d 08             	mov    0x8(%ebp),%edi
8010023c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010023f:	89 3c 24             	mov    %edi,(%esp)
80100242:	e8 b9 13 00 00       	call   80101600 <iunlock>
  target = n;
  acquire(&cons.lock);
80100247:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010024e:	e8 c9 3b 00 00       	call   80103e1c <acquire>
  while(n > 0){
80100253:	8b 55 10             	mov    0x10(%ebp),%edx
80100256:	85 d2                	test   %edx,%edx
80100258:	0f 8e b0 00 00 00    	jle    8010030e <consoleread+0xde>
8010025e:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100261:	eb 21                	jmp    80100284 <consoleread+0x54>
80100263:	90                   	nop
    while(input.r == input.w){
      if(myproc()->killed){
80100264:	e8 03 32 00 00       	call   8010346c <myproc>
80100269:	8b 40 24             	mov    0x24(%eax),%eax
8010026c:	85 c0                	test   %eax,%eax
8010026e:	75 6c                	jne    801002dc <consoleread+0xac>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100270:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
80100277:	80 
80100278:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
8010027f:	e8 e4 36 00 00       	call   80103968 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100284:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
80100289:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010028f:	74 d3                	je     80100264 <consoleread+0x34>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100291:	8d 50 01             	lea    0x1(%eax),%edx
80100294:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
8010029a:	89 c2                	mov    %eax,%edx
8010029c:	83 e2 7f             	and    $0x7f,%edx
8010029f:	8a 92 20 ff 10 80    	mov    -0x7fef00e0(%edx),%dl
801002a5:	0f be ca             	movsbl %dl,%ecx
    if(c == C('D')){  // EOF
801002a8:	83 f9 04             	cmp    $0x4,%ecx
801002ab:	74 50                	je     801002fd <consoleread+0xcd>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002ad:	46                   	inc    %esi
801002ae:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
801002b1:	4b                   	dec    %ebx
    if(c == '\n')
801002b2:	83 f9 0a             	cmp    $0xa,%ecx
801002b5:	74 50                	je     80100307 <consoleread+0xd7>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
801002b7:	85 db                	test   %ebx,%ebx
801002b9:	75 c9                	jne    80100284 <consoleread+0x54>
801002bb:	8b 45 10             	mov    0x10(%ebp),%eax
801002be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
801002c1:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801002c8:	e8 27 3c 00 00       	call   80103ef4 <release>
  ilock(ip);
801002cd:	89 3c 24             	mov    %edi,(%esp)
801002d0:	e8 5b 12 00 00       	call   80101530 <ilock>
801002d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
801002d8:	eb 1b                	jmp    801002f5 <consoleread+0xc5>
801002da:	66 90                	xchg   %ax,%ax
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
801002dc:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801002e3:	e8 0c 3c 00 00       	call   80103ef4 <release>
        ilock(ip);
801002e8:	89 3c 24             	mov    %edi,(%esp)
801002eb:	e8 40 12 00 00       	call   80101530 <ilock>
        return -1;
801002f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002f5:	83 c4 1c             	add    $0x1c,%esp
801002f8:	5b                   	pop    %ebx
801002f9:	5e                   	pop    %esi
801002fa:	5f                   	pop    %edi
801002fb:	5d                   	pop    %ebp
801002fc:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
801002fd:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100300:	76 05                	jbe    80100307 <consoleread+0xd7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100302:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100307:	8b 45 10             	mov    0x10(%ebp),%eax
8010030a:	29 d8                	sub    %ebx,%eax
8010030c:	eb b0                	jmp    801002be <consoleread+0x8e>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
8010030e:	31 c0                	xor    %eax,%eax
80100310:	eb ac                	jmp    801002be <consoleread+0x8e>
80100312:	66 90                	xchg   %ax,%ax

80100314 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100314:	55                   	push   %ebp
80100315:	89 e5                	mov    %esp,%ebp
80100317:	56                   	push   %esi
80100318:	53                   	push   %ebx
80100319:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010031c:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
8010031d:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100324:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100327:	e8 0c 23 00 00       	call   80102638 <lapicid>
8010032c:	89 44 24 04          	mov    %eax,0x4(%esp)
80100330:	c7 04 24 6d 66 10 80 	movl   $0x8010666d,(%esp)
80100337:	e8 88 02 00 00       	call   801005c4 <cprintf>
  cprintf(s);
8010033c:	8b 45 08             	mov    0x8(%ebp),%eax
8010033f:	89 04 24             	mov    %eax,(%esp)
80100342:	e8 7d 02 00 00       	call   801005c4 <cprintf>
  cprintf("\n");
80100347:	c7 04 24 b7 6f 10 80 	movl   $0x80106fb7,(%esp)
8010034e:	e8 71 02 00 00       	call   801005c4 <cprintf>
  getcallerpcs(&s, pcs);
80100353:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100356:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010035a:	8d 45 08             	lea    0x8(%ebp),%eax
8010035d:	89 04 24             	mov    %eax,(%esp)
80100360:	e8 0b 3a 00 00       	call   80103d70 <getcallerpcs>
80100365:	8d 75 f8             	lea    -0x8(%ebp),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100368:	8b 03                	mov    (%ebx),%eax
8010036a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010036e:	c7 04 24 81 66 10 80 	movl   $0x80106681,(%esp)
80100375:	e8 4a 02 00 00       	call   801005c4 <cprintf>
8010037a:	83 c3 04             	add    $0x4,%ebx
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010037d:	39 f3                	cmp    %esi,%ebx
8010037f:	75 e7                	jne    80100368 <panic+0x54>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
80100381:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100388:	00 00 00 
8010038b:	eb fe                	jmp    8010038b <panic+0x77>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
80100390:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100396:	85 c9                	test   %ecx,%ecx
80100398:	74 06                	je     801003a0 <consputc+0x10>
8010039a:	fa                   	cli    
8010039b:	eb fe                	jmp    8010039b <consputc+0xb>
8010039d:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	57                   	push   %edi
801003a4:	56                   	push   %esi
801003a5:	53                   	push   %ebx
801003a6:	83 ec 1c             	sub    $0x1c,%esp
801003a9:	89 c6                	mov    %eax,%esi
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003ab:	3d 00 01 00 00       	cmp    $0x100,%eax
801003b0:	0f 84 99 00 00 00    	je     8010044f <consputc+0xbf>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003b6:	89 04 24             	mov    %eax,(%esp)
801003b9:	e8 9e 4e 00 00       	call   8010525c <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003be:	ba d4 03 00 00       	mov    $0x3d4,%edx
801003c3:	b0 0e                	mov    $0xe,%al
801003c5:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003c6:	b2 d5                	mov    $0xd5,%dl
801003c8:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
801003c9:	0f b6 c8             	movzbl %al,%ecx
801003cc:	c1 e1 08             	shl    $0x8,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003cf:	b2 d4                	mov    $0xd4,%dl
801003d1:	b0 0f                	mov    $0xf,%al
801003d3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003d4:	b2 d5                	mov    $0xd5,%dl
801003d6:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
801003d7:	0f b6 c0             	movzbl %al,%eax
801003da:	09 c1                	or     %eax,%ecx

  if(c == '\n')
801003dc:	83 fe 0a             	cmp    $0xa,%esi
801003df:	0f 84 fa 00 00 00    	je     801004df <consputc+0x14f>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
801003e5:	81 fe 00 01 00 00    	cmp    $0x100,%esi
801003eb:	0f 84 e2 00 00 00    	je     801004d3 <consputc+0x143>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801003f1:	8d 59 01             	lea    0x1(%ecx),%ebx
801003f4:	89 f0                	mov    %esi,%eax
801003f6:	0f b6 f0             	movzbl %al,%esi
801003f9:	81 ce 00 07 00 00    	or     $0x700,%esi
801003ff:	66 89 b4 09 00 80 0b 	mov    %si,-0x7ff48000(%ecx,%ecx,1)
80100406:	80 

  if(pos < 0 || pos > 25*80)
80100407:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010040d:	0f 87 b4 00 00 00    	ja     801004c7 <consputc+0x137>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100413:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100419:	7f 5d                	jg     80100478 <consputc+0xe8>
8010041b:	89 d8                	mov    %ebx,%eax
8010041d:	c1 e8 08             	shr    $0x8,%eax
80100420:	89 c7                	mov    %eax,%edi
80100422:	89 de                	mov    %ebx,%esi
80100424:	8d 8c 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010042b:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100430:	b0 0e                	mov    $0xe,%al
80100432:	ee                   	out    %al,(%dx)
80100433:	b2 d5                	mov    $0xd5,%dl
80100435:	89 f8                	mov    %edi,%eax
80100437:	ee                   	out    %al,(%dx)
80100438:	b2 d4                	mov    $0xd4,%dl
8010043a:	b0 0f                	mov    $0xf,%al
8010043c:	ee                   	out    %al,(%dx)
8010043d:	b2 d5                	mov    $0xd5,%dl
8010043f:	89 f0                	mov    %esi,%eax
80100441:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
80100442:	66 c7 01 20 07       	movw   $0x720,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
80100447:	83 c4 1c             	add    $0x1c,%esp
8010044a:	5b                   	pop    %ebx
8010044b:	5e                   	pop    %esi
8010044c:	5f                   	pop    %edi
8010044d:	5d                   	pop    %ebp
8010044e:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010044f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100456:	e8 01 4e 00 00       	call   8010525c <uartputc>
8010045b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100462:	e8 f5 4d 00 00       	call   8010525c <uartputc>
80100467:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010046e:	e8 e9 4d 00 00       	call   8010525c <uartputc>
80100473:	e9 46 ff ff ff       	jmp    801003be <consputc+0x2e>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100478:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
8010047f:	00 
80100480:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
80100487:	80 
80100488:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
8010048f:	e8 44 3b 00 00       	call   80103fd8 <memmove>
    pos -= 80;
80100494:	8d 73 b0             	lea    -0x50(%ebx),%esi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100497:	8d bc 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%edi
8010049e:	b8 d0 07 00 00       	mov    $0x7d0,%eax
801004a3:	29 d8                	sub    %ebx,%eax
801004a5:	01 c0                	add    %eax,%eax
801004a7:	89 44 24 08          	mov    %eax,0x8(%esp)
801004ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801004b2:	00 
801004b3:	89 3c 24             	mov    %edi,(%esp)
801004b6:	e8 89 3a 00 00       	call   80103f44 <memset>
801004bb:	89 f9                	mov    %edi,%ecx
801004bd:	bf 07 00 00 00       	mov    $0x7,%edi
801004c2:	e9 64 ff ff ff       	jmp    8010042b <consputc+0x9b>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
801004c7:	c7 04 24 85 66 10 80 	movl   $0x80106685,(%esp)
801004ce:	e8 41 fe ff ff       	call   80100314 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
801004d3:	85 c9                	test   %ecx,%ecx
801004d5:	74 1b                	je     801004f2 <consputc+0x162>
801004d7:	8d 59 ff             	lea    -0x1(%ecx),%ebx
801004da:	e9 28 ff ff ff       	jmp    80100407 <consputc+0x77>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
801004df:	bb 50 00 00 00       	mov    $0x50,%ebx
801004e4:	89 c8                	mov    %ecx,%eax
801004e6:	99                   	cltd   
801004e7:	f7 fb                	idiv   %ebx
801004e9:	29 d3                	sub    %edx,%ebx
801004eb:	01 cb                	add    %ecx,%ebx
801004ed:	e9 15 ff ff ff       	jmp    80100407 <consputc+0x77>
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
801004f2:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
801004f7:	31 f6                	xor    %esi,%esi
801004f9:	31 ff                	xor    %edi,%edi
801004fb:	e9 2b ff ff ff       	jmp    8010042b <consputc+0x9b>

80100500 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100500:	55                   	push   %ebp
80100501:	89 e5                	mov    %esp,%ebp
80100503:	57                   	push   %edi
80100504:	56                   	push   %esi
80100505:	53                   	push   %ebx
80100506:	83 ec 1c             	sub    $0x1c,%esp
80100509:	89 d6                	mov    %edx,%esi
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010050b:	85 c9                	test   %ecx,%ecx
8010050d:	74 51                	je     80100560 <printint+0x60>
8010050f:	85 c0                	test   %eax,%eax
80100511:	79 4d                	jns    80100560 <printint+0x60>
    x = -xx;
80100513:	f7 d8                	neg    %eax
80100515:	bf 01 00 00 00       	mov    $0x1,%edi
  else
    x = xx;

  i = 0;
8010051a:	31 c9                	xor    %ecx,%ecx
8010051c:	eb 04                	jmp    80100522 <printint+0x22>
8010051e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
80100520:	89 d9                	mov    %ebx,%ecx
80100522:	8d 59 01             	lea    0x1(%ecx),%ebx
80100525:	31 d2                	xor    %edx,%edx
80100527:	f7 f6                	div    %esi
80100529:	8a 92 b0 66 10 80    	mov    -0x7fef9950(%edx),%dl
8010052f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100533:	85 c0                	test   %eax,%eax
80100535:	75 e9                	jne    80100520 <printint+0x20>
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
80100537:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);

  if(sign)
80100539:	85 ff                	test   %edi,%edi
8010053b:	74 08                	je     80100545 <printint+0x45>
    buf[i++] = '-';
8010053d:	8d 59 02             	lea    0x2(%ecx),%ebx
80100540:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
80100545:	4b                   	dec    %ebx
80100546:	66 90                	xchg   %ax,%ax
    consputc(buf[i]);
80100548:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
8010054d:	e8 3e fe ff ff       	call   80100390 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100552:	4b                   	dec    %ebx
80100553:	83 fb ff             	cmp    $0xffffffff,%ebx
80100556:	75 f0                	jne    80100548 <printint+0x48>
    consputc(buf[i]);
}
80100558:	83 c4 1c             	add    $0x1c,%esp
8010055b:	5b                   	pop    %ebx
8010055c:	5e                   	pop    %esi
8010055d:	5f                   	pop    %edi
8010055e:	5d                   	pop    %ebp
8010055f:	c3                   	ret    
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;
80100560:	31 ff                	xor    %edi,%edi
80100562:	eb b6                	jmp    8010051a <printint+0x1a>

80100564 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100564:	55                   	push   %ebp
80100565:	89 e5                	mov    %esp,%ebp
80100567:	57                   	push   %edi
80100568:	56                   	push   %esi
80100569:	53                   	push   %ebx
8010056a:	83 ec 1c             	sub    $0x1c,%esp
8010056d:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
80100570:	8b 45 08             	mov    0x8(%ebp),%eax
80100573:	89 04 24             	mov    %eax,(%esp)
80100576:	e8 85 10 00 00       	call   80101600 <iunlock>
  acquire(&cons.lock);
8010057b:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100582:	e8 95 38 00 00       	call   80103e1c <acquire>
  for(i = 0; i < n; i++)
80100587:	85 f6                	test   %esi,%esi
80100589:	7e 16                	jle    801005a1 <consolewrite+0x3d>
8010058b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010058e:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
80100591:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100594:	0f b6 07             	movzbl (%edi),%eax
80100597:	e8 f4 fd ff ff       	call   80100390 <consputc>
8010059c:	47                   	inc    %edi
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010059d:	39 df                	cmp    %ebx,%edi
8010059f:	75 f3                	jne    80100594 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801005a1:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801005a8:	e8 47 39 00 00       	call   80103ef4 <release>
  ilock(ip);
801005ad:	8b 45 08             	mov    0x8(%ebp),%eax
801005b0:	89 04 24             	mov    %eax,(%esp)
801005b3:	e8 78 0f 00 00       	call   80101530 <ilock>

  return n;
}
801005b8:	89 f0                	mov    %esi,%eax
801005ba:	83 c4 1c             	add    $0x1c,%esp
801005bd:	5b                   	pop    %ebx
801005be:	5e                   	pop    %esi
801005bf:	5f                   	pop    %edi
801005c0:	5d                   	pop    %ebp
801005c1:	c3                   	ret    
801005c2:	66 90                	xchg   %ax,%ax

801005c4 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801005c4:	55                   	push   %ebp
801005c5:	89 e5                	mov    %esp,%ebp
801005c7:	57                   	push   %edi
801005c8:	56                   	push   %esi
801005c9:	53                   	push   %ebx
801005ca:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801005cd:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801005d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801005d5:	85 c0                	test   %eax,%eax
801005d7:	0f 85 07 01 00 00    	jne    801006e4 <cprintf+0x120>
    acquire(&cons.lock);

  if (fmt == 0)
801005dd:	8b 75 08             	mov    0x8(%ebp),%esi
801005e0:	85 f6                	test   %esi,%esi
801005e2:	0f 84 17 01 00 00    	je     801006ff <cprintf+0x13b>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801005e8:	0f b6 06             	movzbl (%esi),%eax
801005eb:	85 c0                	test   %eax,%eax
801005ed:	74 5d                	je     8010064c <cprintf+0x88>
801005ef:	8d 7d 0c             	lea    0xc(%ebp),%edi
801005f2:	31 db                	xor    %ebx,%ebx
801005f4:	eb 43                	jmp    80100639 <cprintf+0x75>
801005f6:	66 90                	xchg   %ax,%ax
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801005f8:	43                   	inc    %ebx
801005f9:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801005fd:	85 d2                	test   %edx,%edx
801005ff:	74 4b                	je     8010064c <cprintf+0x88>
      break;
    switch(c){
80100601:	83 fa 70             	cmp    $0x70,%edx
80100604:	74 6c                	je     80100672 <cprintf+0xae>
80100606:	7f 60                	jg     80100668 <cprintf+0xa4>
80100608:	83 fa 25             	cmp    $0x25,%edx
8010060b:	0f 84 97 00 00 00    	je     801006a8 <cprintf+0xe4>
80100611:	83 fa 64             	cmp    $0x64,%edx
80100614:	75 76                	jne    8010068c <cprintf+0xc8>
    case 'd':
      printint(*argp++, 10, 1);
80100616:	8d 47 04             	lea    0x4(%edi),%eax
80100619:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010061c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100621:	ba 0a 00 00 00       	mov    $0xa,%edx
80100626:	8b 07                	mov    (%edi),%eax
80100628:	e8 d3 fe ff ff       	call   80100500 <printint>
8010062d:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100630:	43                   	inc    %ebx
80100631:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100635:	85 c0                	test   %eax,%eax
80100637:	74 13                	je     8010064c <cprintf+0x88>
    if(c != '%'){
80100639:	83 f8 25             	cmp    $0x25,%eax
8010063c:	74 ba                	je     801005f8 <cprintf+0x34>
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
8010063e:	e8 4d fd ff ff       	call   80100390 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100643:	43                   	inc    %ebx
80100644:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100648:	85 c0                	test   %eax,%eax
8010064a:	75 ed                	jne    80100639 <cprintf+0x75>
      consputc(c);
      break;
    }
  }

  if(locking)
8010064c:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010064f:	85 db                	test   %ebx,%ebx
80100651:	74 0c                	je     8010065f <cprintf+0x9b>
    release(&cons.lock);
80100653:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010065a:	e8 95 38 00 00       	call   80103ef4 <release>
}
8010065f:	83 c4 1c             	add    $0x1c,%esp
80100662:	5b                   	pop    %ebx
80100663:	5e                   	pop    %esi
80100664:	5f                   	pop    %edi
80100665:	5d                   	pop    %ebp
80100666:	c3                   	ret    
80100667:	90                   	nop
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100668:	83 fa 73             	cmp    $0x73,%edx
8010066b:	74 4b                	je     801006b8 <cprintf+0xf4>
8010066d:	83 fa 78             	cmp    $0x78,%edx
80100670:	75 1a                	jne    8010068c <cprintf+0xc8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100672:	8d 47 04             	lea    0x4(%edi),%eax
80100675:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100678:	31 c9                	xor    %ecx,%ecx
8010067a:	ba 10 00 00 00       	mov    $0x10,%edx
8010067f:	8b 07                	mov    (%edi),%eax
80100681:	e8 7a fe ff ff       	call   80100500 <printint>
80100686:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
80100689:	eb a5                	jmp    80100630 <cprintf+0x6c>
8010068b:	90                   	nop
8010068c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010068f:	b8 25 00 00 00       	mov    $0x25,%eax
80100694:	e8 f7 fc ff ff       	call   80100390 <consputc>
      consputc(c);
80100699:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010069c:	89 d0                	mov    %edx,%eax
8010069e:	e8 ed fc ff ff       	call   80100390 <consputc>
801006a3:	eb 9e                	jmp    80100643 <cprintf+0x7f>
801006a5:	8d 76 00             	lea    0x0(%esi),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006a8:	b8 25 00 00 00       	mov    $0x25,%eax
801006ad:	e8 de fc ff ff       	call   80100390 <consputc>
      break;
801006b2:	e9 79 ff ff ff       	jmp    80100630 <cprintf+0x6c>
801006b7:	90                   	nop
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801006b8:	8d 47 04             	lea    0x4(%edi),%eax
801006bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006be:	8b 3f                	mov    (%edi),%edi
801006c0:	85 ff                	test   %edi,%edi
801006c2:	74 34                	je     801006f8 <cprintf+0x134>
        s = "(null)";
      for(; *s; s++)
801006c4:	0f be 07             	movsbl (%edi),%eax
801006c7:	84 c0                	test   %al,%al
801006c9:	74 0e                	je     801006d9 <cprintf+0x115>
801006cb:	90                   	nop
        consputc(*s);
801006cc:	e8 bf fc ff ff       	call   80100390 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801006d1:	47                   	inc    %edi
801006d2:	0f be 07             	movsbl (%edi),%eax
801006d5:	84 c0                	test   %al,%al
801006d7:	75 f3                	jne    801006cc <cprintf+0x108>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801006d9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801006dc:	e9 4f ff ff ff       	jmp    80100630 <cprintf+0x6c>
801006e1:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801006e4:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006eb:	e8 2c 37 00 00       	call   80103e1c <acquire>
801006f0:	e9 e8 fe ff ff       	jmp    801005dd <cprintf+0x19>
801006f5:	8d 76 00             	lea    0x0(%esi),%esi
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
801006f8:	bf 98 66 10 80       	mov    $0x80106698,%edi
801006fd:	eb c5                	jmp    801006c4 <cprintf+0x100>
  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");
801006ff:	c7 04 24 9f 66 10 80 	movl   $0x8010669f,(%esp)
80100706:	e8 09 fc ff ff       	call   80100314 <panic>
8010070b:	90                   	nop

8010070c <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
8010070c:	55                   	push   %ebp
8010070d:	89 e5                	mov    %esp,%ebp
8010070f:	57                   	push   %edi
80100710:	56                   	push   %esi
80100711:	53                   	push   %ebx
80100712:	83 ec 1c             	sub    $0x1c,%esp
80100715:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
80100718:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010071f:	e8 f8 36 00 00       	call   80103e1c <acquire>
#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
80100724:	31 f6                	xor    %esi,%esi
80100726:	66 90                	xchg   %ax,%ax

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100728:	ff d3                	call   *%ebx
8010072a:	89 c7                	mov    %eax,%edi
8010072c:	85 c0                	test   %eax,%eax
8010072e:	78 40                	js     80100770 <consoleintr+0x64>
    switch(c){
80100730:	83 ff 10             	cmp    $0x10,%edi
80100733:	0f 84 13 01 00 00    	je     8010084c <consoleintr+0x140>
80100739:	7e 51                	jle    8010078c <consoleintr+0x80>
8010073b:	83 ff 15             	cmp    $0x15,%edi
8010073e:	0f 84 c0 00 00 00    	je     80100804 <consoleintr+0xf8>
80100744:	83 ff 7f             	cmp    $0x7f,%edi
80100747:	75 48                	jne    80100791 <consoleintr+0x85>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100749:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010074e:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100754:	74 d2                	je     80100728 <consoleintr+0x1c>
        input.e--;
80100756:	48                   	dec    %eax
80100757:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
8010075c:	b8 00 01 00 00       	mov    $0x100,%eax
80100761:	e8 2a fc ff ff       	call   80100390 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100766:	ff d3                	call   *%ebx
80100768:	89 c7                	mov    %eax,%edi
8010076a:	85 c0                	test   %eax,%eax
8010076c:	79 c2                	jns    80100730 <consoleintr+0x24>
8010076e:	66 90                	xchg   %ax,%ax
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100770:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100777:	e8 78 37 00 00       	call   80103ef4 <release>
  if(doprocdump) {
8010077c:	85 f6                	test   %esi,%esi
8010077e:	0f 85 d4 00 00 00    	jne    80100858 <consoleintr+0x14c>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100784:	83 c4 1c             	add    $0x1c,%esp
80100787:	5b                   	pop    %ebx
80100788:	5e                   	pop    %esi
80100789:	5f                   	pop    %edi
8010078a:	5d                   	pop    %ebp
8010078b:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
8010078c:	83 ff 08             	cmp    $0x8,%edi
8010078f:	74 b8                	je     80100749 <consoleintr+0x3d>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100791:	85 ff                	test   %edi,%edi
80100793:	74 93                	je     80100728 <consoleintr+0x1c>
80100795:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010079a:	89 c2                	mov    %eax,%edx
8010079c:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801007a2:	83 fa 7f             	cmp    $0x7f,%edx
801007a5:	77 81                	ja     80100728 <consoleintr+0x1c>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801007a7:	8d 50 01             	lea    0x1(%eax),%edx
801007aa:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
801007b0:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801007b3:	83 ff 0d             	cmp    $0xd,%edi
801007b6:	0f 84 a8 00 00 00    	je     80100864 <consoleintr+0x158>
        input.buf[input.e++ % INPUT_BUF] = c;
801007bc:	89 f9                	mov    %edi,%ecx
801007be:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801007c4:	89 f8                	mov    %edi,%eax
801007c6:	e8 c5 fb ff ff       	call   80100390 <consputc>
801007cb:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801007d0:	83 ff 0a             	cmp    $0xa,%edi
801007d3:	74 19                	je     801007ee <consoleintr+0xe2>
801007d5:	83 ff 04             	cmp    $0x4,%edi
801007d8:	74 14                	je     801007ee <consoleintr+0xe2>
801007da:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
801007e0:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
801007e6:	39 d0                	cmp    %edx,%eax
801007e8:	0f 85 3a ff ff ff    	jne    80100728 <consoleintr+0x1c>
          input.w = input.e;
801007ee:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801007f3:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801007fa:	e8 e5 32 00 00       	call   80103ae4 <wakeup>
801007ff:	e9 24 ff ff ff       	jmp    80100728 <consoleintr+0x1c>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100804:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100809:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010080f:	75 27                	jne    80100838 <consoleintr+0x12c>
80100811:	e9 12 ff ff ff       	jmp    80100728 <consoleintr+0x1c>
80100816:	66 90                	xchg   %ax,%ax
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100818:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
8010081d:	b8 00 01 00 00       	mov    $0x100,%eax
80100822:	e8 69 fb ff ff       	call   80100390 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100827:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010082c:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100832:	0f 84 f0 fe ff ff    	je     80100728 <consoleintr+0x1c>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100838:	48                   	dec    %eax
80100839:	89 c2                	mov    %eax,%edx
8010083b:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010083e:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100845:	75 d1                	jne    80100818 <consoleintr+0x10c>
80100847:	e9 dc fe ff ff       	jmp    80100728 <consoleintr+0x1c>
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
8010084c:	be 01 00 00 00       	mov    $0x1,%esi
80100851:	e9 d2 fe ff ff       	jmp    80100728 <consoleintr+0x1c>
80100856:	66 90                	xchg   %ax,%ax
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100858:	83 c4 1c             	add    $0x1c,%esp
8010085b:	5b                   	pop    %ebx
8010085c:	5e                   	pop    %esi
8010085d:	5f                   	pop    %edi
8010085e:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
8010085f:	e9 50 33 00 00       	jmp    80103bb4 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100864:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
8010086b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100870:	e8 1b fb ff ff       	call   80100390 <consputc>
80100875:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010087a:	e9 6f ff ff ff       	jmp    801007ee <consoleintr+0xe2>
8010087f:	90                   	nop

80100880 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100886:	c7 44 24 04 a8 66 10 	movl   $0x801066a8,0x4(%esp)
8010088d:	80 
8010088e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100895:	e8 ba 34 00 00       	call   80103d54 <initlock>

  devsw[CONSOLE].write = consolewrite;
8010089a:	c7 05 6c 09 11 80 64 	movl   $0x80100564,0x8011096c
801008a1:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801008a4:	c7 05 68 09 11 80 30 	movl   $0x80100230,0x80110968
801008ab:	02 10 80 
  cons.locking = 1;
801008ae:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801008b5:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801008b8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801008bf:	00 
801008c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801008c7:	e8 ac 17 00 00       	call   80102078 <ioapicenable>
}
801008cc:	c9                   	leave  
801008cd:	c3                   	ret    
801008ce:	66 90                	xchg   %ax,%ax

801008d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	57                   	push   %edi
801008d4:	56                   	push   %esi
801008d5:	53                   	push   %ebx
801008d6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801008dc:	e8 8b 2b 00 00       	call   8010346c <myproc>
801008e1:	89 c7                	mov    %eax,%edi

  begin_op();
801008e3:	e8 88 20 00 00       	call   80102970 <begin_op>

  if((ip = namei(path)) == 0){
801008e8:	8b 45 08             	mov    0x8(%ebp),%eax
801008eb:	89 04 24             	mov    %eax,(%esp)
801008ee:	e8 35 14 00 00       	call   80101d28 <namei>
801008f3:	89 c3                	mov    %eax,%ebx
801008f5:	85 c0                	test   %eax,%eax
801008f7:	0f 84 cb 01 00 00    	je     80100ac8 <exec+0x1f8>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801008fd:	89 04 24             	mov    %eax,(%esp)
80100900:	e8 2b 0c 00 00       	call   80101530 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100905:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
8010090c:	00 
8010090d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100914:	00 
80100915:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
8010091b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010091f:	89 1c 24             	mov    %ebx,(%esp)
80100922:	e8 a1 0e 00 00       	call   801017c8 <readi>
80100927:	83 f8 34             	cmp    $0x34,%eax
8010092a:	74 20                	je     8010094c <exec+0x7c>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
8010092c:	89 1c 24             	mov    %ebx,(%esp)
8010092f:	e8 48 0e 00 00       	call   8010177c <iunlockput>
    end_op();
80100934:	e8 97 20 00 00       	call   801029d0 <end_op>
  }
  return -1;
80100939:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010093e:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100944:	5b                   	pop    %ebx
80100945:	5e                   	pop    %esi
80100946:	5f                   	pop    %edi
80100947:	5d                   	pop    %ebp
80100948:	c3                   	ret    
80100949:	8d 76 00             	lea    0x0(%esi),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
8010094c:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100953:	45 4c 46 
80100956:	75 d4                	jne    8010092c <exec+0x5c>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100958:	e8 6b 5a 00 00       	call   801063c8 <setupkvm>
8010095d:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100963:	85 c0                	test   %eax,%eax
80100965:	74 c5                	je     8010092c <exec+0x5c>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100967:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
8010096d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100974:	00 

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
80100975:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010097c:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010097f:	0f 84 e8 00 00 00    	je     80100a6d <exec+0x19d>
80100985:	31 c0                	xor    %eax,%eax
80100987:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
8010098d:	89 c7                	mov    %eax,%edi
8010098f:	eb 16                	jmp    801009a7 <exec+0xd7>
80100991:	8d 76 00             	lea    0x0(%esi),%esi
80100994:	47                   	inc    %edi
80100995:	83 c6 20             	add    $0x20,%esi
80100998:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010099f:	39 f8                	cmp    %edi,%eax
801009a1:	0f 8e c0 00 00 00    	jle    80100a67 <exec+0x197>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801009a7:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
801009ae:	00 
801009af:	89 74 24 08          	mov    %esi,0x8(%esp)
801009b3:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801009b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801009bd:	89 1c 24             	mov    %ebx,(%esp)
801009c0:	e8 03 0e 00 00       	call   801017c8 <readi>
801009c5:	83 f8 20             	cmp    $0x20,%eax
801009c8:	0f 85 86 00 00 00    	jne    80100a54 <exec+0x184>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801009ce:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801009d5:	75 bd                	jne    80100994 <exec+0xc4>
      continue;
    if(ph.memsz < ph.filesz)
801009d7:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801009dd:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801009e3:	72 6f                	jb     80100a54 <exec+0x184>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
801009e5:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801009eb:	72 67                	jb     80100a54 <exec+0x184>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801009ed:	89 44 24 08          	mov    %eax,0x8(%esp)
801009f1:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
801009f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801009fb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a01:	89 04 24             	mov    %eax,(%esp)
80100a04:	e8 57 58 00 00       	call   80106260 <allocuvm>
80100a09:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a0f:	85 c0                	test   %eax,%eax
80100a11:	74 41                	je     80100a54 <exec+0x184>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100a13:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100a19:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100a1e:	75 34                	jne    80100a54 <exec+0x184>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100a20:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100a26:	89 54 24 10          	mov    %edx,0x10(%esp)
80100a2a:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100a30:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100a34:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a38:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a3c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a42:	89 04 24             	mov    %eax,(%esp)
80100a45:	e8 5a 57 00 00       	call   801061a4 <loaduvm>
80100a4a:	85 c0                	test   %eax,%eax
80100a4c:	0f 89 42 ff ff ff    	jns    80100994 <exec+0xc4>
80100a52:	66 90                	xchg   %ax,%ax
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100a54:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a5a:	89 04 24             	mov    %eax,(%esp)
80100a5d:	e8 fa 58 00 00       	call   8010635c <freevm>
80100a62:	e9 c5 fe ff ff       	jmp    8010092c <exec+0x5c>
80100a67:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100a6d:	89 1c 24             	mov    %ebx,(%esp)
80100a70:	e8 07 0d 00 00       	call   8010177c <iunlockput>
  end_op();
80100a75:	e8 56 1f 00 00       	call   801029d0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100a7a:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a80:	05 ff 0f 00 00       	add    $0xfff,%eax
80100a85:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100a8a:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100a90:	89 54 24 08          	mov    %edx,0x8(%esp)
80100a94:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a98:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a9e:	89 04 24             	mov    %eax,(%esp)
80100aa1:	e8 ba 57 00 00       	call   80106260 <allocuvm>
80100aa6:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100aac:	85 c0                	test   %eax,%eax
80100aae:	75 33                	jne    80100ae3 <exec+0x213>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ab0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100ab6:	89 04 24             	mov    %eax,(%esp)
80100ab9:	e8 9e 58 00 00       	call   8010635c <freevm>
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100abe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ac3:	e9 76 fe ff ff       	jmp    8010093e <exec+0x6e>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100ac8:	e8 03 1f 00 00       	call   801029d0 <end_op>
    cprintf("exec: fail\n");
80100acd:	c7 04 24 c1 66 10 80 	movl   $0x801066c1,(%esp)
80100ad4:	e8 eb fa ff ff       	call   801005c4 <cprintf>
    return -1;
80100ad9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ade:	e9 5b fe ff ff       	jmp    8010093e <exec+0x6e>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ae3:	8b 9d ec fe ff ff    	mov    -0x114(%ebp),%ebx
80100ae9:	89 d8                	mov    %ebx,%eax
80100aeb:	2d 00 20 00 00       	sub    $0x2000,%eax
80100af0:	89 44 24 04          	mov    %eax,0x4(%esp)
80100af4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100afa:	89 04 24             	mov    %eax,(%esp)
80100afd:	e8 5e 59 00 00       	call   80106460 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b02:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b05:	8b 00                	mov    (%eax),%eax
80100b07:	85 c0                	test   %eax,%eax
80100b09:	0f 84 57 01 00 00    	je     80100c66 <exec+0x396>
80100b0f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100b12:	8d 51 04             	lea    0x4(%ecx),%edx
80100b15:	89 ce                	mov    %ecx,%esi
80100b17:	31 c9                	xor    %ecx,%ecx
80100b19:	89 bd e8 fe ff ff    	mov    %edi,-0x118(%ebp)
80100b1f:	89 d7                	mov    %edx,%edi
80100b21:	89 ca                	mov    %ecx,%edx
80100b23:	eb 0b                	jmp    80100b30 <exec+0x260>
80100b25:	8d 76 00             	lea    0x0(%esi),%esi
80100b28:	83 c7 04             	add    $0x4,%edi
    if(argc >= MAXARG)
80100b2b:	83 fa 20             	cmp    $0x20,%edx
80100b2e:	74 80                	je     80100ab0 <exec+0x1e0>
80100b30:	89 95 f0 fe ff ff    	mov    %edx,-0x110(%ebp)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100b36:	89 04 24             	mov    %eax,(%esp)
80100b39:	e8 e6 35 00 00       	call   80104124 <strlen>
80100b3e:	f7 d0                	not    %eax
80100b40:	01 c3                	add    %eax,%ebx
80100b42:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100b45:	8b 06                	mov    (%esi),%eax
80100b47:	89 04 24             	mov    %eax,(%esp)
80100b4a:	e8 d5 35 00 00       	call   80104124 <strlen>
80100b4f:	40                   	inc    %eax
80100b50:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100b54:	8b 06                	mov    (%esi),%eax
80100b56:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b5a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100b5e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b64:	89 04 24             	mov    %eax,(%esp)
80100b67:	e8 30 5a 00 00       	call   8010659c <copyout>
80100b6c:	85 c0                	test   %eax,%eax
80100b6e:	0f 88 3c ff ff ff    	js     80100ab0 <exec+0x1e0>
      goto bad;
    ustack[3+argc] = sp;
80100b74:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100b7a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100b80:	89 9c 95 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b87:	42                   	inc    %edx
80100b88:	89 fe                	mov    %edi,%esi
80100b8a:	8b 07                	mov    (%edi),%eax
80100b8c:	85 c0                	test   %eax,%eax
80100b8e:	75 98                	jne    80100b28 <exec+0x258>
80100b90:	8b bd e8 fe ff ff    	mov    -0x118(%ebp),%edi
80100b96:	89 d0                	mov    %edx,%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100b98:	c7 84 85 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%eax,4)
80100b9f:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100ba3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100baa:	ff ff ff 
  ustack[1] = argc;
80100bad:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100bb3:	8d 04 85 04 00 00 00 	lea    0x4(,%eax,4),%eax
80100bba:	89 da                	mov    %ebx,%edx
80100bbc:	29 c2                	sub    %eax,%edx
80100bbe:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
80100bc4:	83 c0 0c             	add    $0xc,%eax
80100bc7:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100bc9:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100bcd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100bd1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100bd5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100bdb:	89 04 24             	mov    %eax,(%esp)
80100bde:	e8 b9 59 00 00       	call   8010659c <copyout>
80100be3:	85 c0                	test   %eax,%eax
80100be5:	0f 88 c5 fe ff ff    	js     80100ab0 <exec+0x1e0>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100beb:	8b 45 08             	mov    0x8(%ebp),%eax
80100bee:	8a 10                	mov    (%eax),%dl
80100bf0:	84 d2                	test   %dl,%dl
80100bf2:	74 1b                	je     80100c0f <exec+0x33f>
80100bf4:	40                   	inc    %eax
80100bf5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100bf8:	eb 09                	jmp    80100c03 <exec+0x333>
80100bfa:	66 90                	xchg   %ax,%ax
80100bfc:	8a 10                	mov    (%eax),%dl
80100bfe:	40                   	inc    %eax
80100bff:	84 d2                	test   %dl,%dl
80100c01:	74 09                	je     80100c0c <exec+0x33c>
    if(*s == '/')
80100c03:	80 fa 2f             	cmp    $0x2f,%dl
80100c06:	75 f4                	jne    80100bfc <exec+0x32c>
      last = s+1;
80100c08:	89 c1                	mov    %eax,%ecx
80100c0a:	eb f0                	jmp    80100bfc <exec+0x32c>
80100c0c:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100c0f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100c16:	00 
80100c17:	8b 45 08             	mov    0x8(%ebp),%eax
80100c1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c1e:	8d 47 6c             	lea    0x6c(%edi),%eax
80100c21:	89 04 24             	mov    %eax,(%esp)
80100c24:	e8 c7 34 00 00       	call   801040f0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100c29:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->pgdir = pgdir;
80100c2c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c32:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100c35:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c3b:	89 07                	mov    %eax,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100c3d:	8b 47 18             	mov    0x18(%edi),%eax
80100c40:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100c46:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100c49:	8b 47 18             	mov    0x18(%edi),%eax
80100c4c:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100c4f:	89 3c 24             	mov    %edi,(%esp)
80100c52:	e8 d1 53 00 00       	call   80106028 <switchuvm>
  freevm(oldpgdir);
80100c57:	89 34 24             	mov    %esi,(%esp)
80100c5a:	e8 fd 56 00 00       	call   8010635c <freevm>
  return 0;
80100c5f:	31 c0                	xor    %eax,%eax
80100c61:	e9 d8 fc ff ff       	jmp    8010093e <exec+0x6e>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c66:	8b 9d ec fe ff ff    	mov    -0x114(%ebp),%ebx
80100c6c:	31 c0                	xor    %eax,%eax
80100c6e:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100c74:	e9 1f ff ff ff       	jmp    80100b98 <exec+0x2c8>
80100c79:	66 90                	xchg   %ax,%ax
80100c7b:	90                   	nop

80100c7c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100c7c:	55                   	push   %ebp
80100c7d:	89 e5                	mov    %esp,%ebp
80100c7f:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100c82:	c7 44 24 04 cd 66 10 	movl   $0x801066cd,0x4(%esp)
80100c89:	80 
80100c8a:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100c91:	e8 be 30 00 00       	call   80103d54 <initlock>
}
80100c96:	c9                   	leave  
80100c97:	c3                   	ret    

80100c98 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100c98:	55                   	push   %ebp
80100c99:	89 e5                	mov    %esp,%ebp
80100c9b:	53                   	push   %ebx
80100c9c:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100c9f:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100ca6:	e8 71 31 00 00       	call   80103e1c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100cab:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
80100cb0:	eb 0d                	jmp    80100cbf <filealloc+0x27>
80100cb2:	66 90                	xchg   %ax,%ax
80100cb4:	83 c3 18             	add    $0x18,%ebx
80100cb7:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100cbd:	74 25                	je     80100ce4 <filealloc+0x4c>
    if(f->ref == 0){
80100cbf:	8b 43 04             	mov    0x4(%ebx),%eax
80100cc2:	85 c0                	test   %eax,%eax
80100cc4:	75 ee                	jne    80100cb4 <filealloc+0x1c>
      f->ref = 1;
80100cc6:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100ccd:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100cd4:	e8 1b 32 00 00       	call   80103ef4 <release>
      return f;
80100cd9:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100cdb:	83 c4 14             	add    $0x14,%esp
80100cde:	5b                   	pop    %ebx
80100cdf:	5d                   	pop    %ebp
80100ce0:	c3                   	ret    
80100ce1:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100ce4:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100ceb:	e8 04 32 00 00       	call   80103ef4 <release>
  return 0;
80100cf0:	31 c0                	xor    %eax,%eax
}
80100cf2:	83 c4 14             	add    $0x14,%esp
80100cf5:	5b                   	pop    %ebx
80100cf6:	5d                   	pop    %ebp
80100cf7:	c3                   	ret    

80100cf8 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100cf8:	55                   	push   %ebp
80100cf9:	89 e5                	mov    %esp,%ebp
80100cfb:	53                   	push   %ebx
80100cfc:	83 ec 14             	sub    $0x14,%esp
80100cff:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100d02:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d09:	e8 0e 31 00 00       	call   80103e1c <acquire>
  if(f->ref < 1)
80100d0e:	8b 43 04             	mov    0x4(%ebx),%eax
80100d11:	85 c0                	test   %eax,%eax
80100d13:	7e 18                	jle    80100d2d <filedup+0x35>
    panic("filedup");
  f->ref++;
80100d15:	40                   	inc    %eax
80100d16:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100d19:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d20:	e8 cf 31 00 00       	call   80103ef4 <release>
  return f;
}
80100d25:	89 d8                	mov    %ebx,%eax
80100d27:	83 c4 14             	add    $0x14,%esp
80100d2a:	5b                   	pop    %ebx
80100d2b:	5d                   	pop    %ebp
80100d2c:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100d2d:	c7 04 24 d4 66 10 80 	movl   $0x801066d4,(%esp)
80100d34:	e8 db f5 ff ff       	call   80100314 <panic>
80100d39:	8d 76 00             	lea    0x0(%esi),%esi

80100d3c <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100d3c:	55                   	push   %ebp
80100d3d:	89 e5                	mov    %esp,%ebp
80100d3f:	57                   	push   %edi
80100d40:	56                   	push   %esi
80100d41:	53                   	push   %ebx
80100d42:	83 ec 1c             	sub    $0x1c,%esp
80100d45:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100d48:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d4f:	e8 c8 30 00 00       	call   80103e1c <acquire>
  if(f->ref < 1)
80100d54:	8b 57 04             	mov    0x4(%edi),%edx
80100d57:	85 d2                	test   %edx,%edx
80100d59:	0f 8e 85 00 00 00    	jle    80100de4 <fileclose+0xa8>
    panic("fileclose");
  if(--f->ref > 0){
80100d5f:	4a                   	dec    %edx
80100d60:	89 57 04             	mov    %edx,0x4(%edi)
80100d63:	85 d2                	test   %edx,%edx
80100d65:	74 15                	je     80100d7c <fileclose+0x40>
    release(&ftable.lock);
80100d67:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100d6e:	83 c4 1c             	add    $0x1c,%esp
80100d71:	5b                   	pop    %ebx
80100d72:	5e                   	pop    %esi
80100d73:	5f                   	pop    %edi
80100d74:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100d75:	e9 7a 31 00 00       	jmp    80103ef4 <release>
80100d7a:	66 90                	xchg   %ax,%ax
    return;
  }
  ff = *f;
80100d7c:	8b 1f                	mov    (%edi),%ebx
80100d7e:	8a 47 09             	mov    0x9(%edi),%al
80100d81:	88 45 e7             	mov    %al,-0x19(%ebp)
80100d84:	8b 77 0c             	mov    0xc(%edi),%esi
80100d87:	8b 47 10             	mov    0x10(%edi),%eax
80100d8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
80100d8d:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  release(&ftable.lock);
80100d93:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d9a:	e8 55 31 00 00       	call   80103ef4 <release>

  if(ff.type == FD_PIPE)
80100d9f:	83 fb 01             	cmp    $0x1,%ebx
80100da2:	74 10                	je     80100db4 <fileclose+0x78>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100da4:	83 fb 02             	cmp    $0x2,%ebx
80100da7:	74 1f                	je     80100dc8 <fileclose+0x8c>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100da9:	83 c4 1c             	add    $0x1c,%esp
80100dac:	5b                   	pop    %ebx
80100dad:	5e                   	pop    %esi
80100dae:	5f                   	pop    %edi
80100daf:	5d                   	pop    %ebp
80100db0:	c3                   	ret    
80100db1:	8d 76 00             	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100db4:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100db8:	89 44 24 04          	mov    %eax,0x4(%esp)
80100dbc:	89 34 24             	mov    %esi,(%esp)
80100dbf:	e8 88 22 00 00       	call   8010304c <pipeclose>
80100dc4:	eb e3                	jmp    80100da9 <fileclose+0x6d>
80100dc6:	66 90                	xchg   %ax,%ax
  else if(ff.type == FD_INODE){
    begin_op();
80100dc8:	e8 a3 1b 00 00       	call   80102970 <begin_op>
    iput(ff.ip);
80100dcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dd0:	89 04 24             	mov    %eax,(%esp)
80100dd3:	e8 68 08 00 00       	call   80101640 <iput>
    end_op();
  }
}
80100dd8:	83 c4 1c             	add    $0x1c,%esp
80100ddb:	5b                   	pop    %ebx
80100ddc:	5e                   	pop    %esi
80100ddd:	5f                   	pop    %edi
80100dde:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100ddf:	e9 ec 1b 00 00       	jmp    801029d0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100de4:	c7 04 24 dc 66 10 80 	movl   $0x801066dc,(%esp)
80100deb:	e8 24 f5 ff ff       	call   80100314 <panic>

80100df0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 14             	sub    $0x14,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100dfa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100dfd:	75 31                	jne    80100e30 <filestat+0x40>
    ilock(f->ip);
80100dff:	8b 43 10             	mov    0x10(%ebx),%eax
80100e02:	89 04 24             	mov    %eax,(%esp)
80100e05:	e8 26 07 00 00       	call   80101530 <ilock>
    stati(f->ip, st);
80100e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e11:	8b 43 10             	mov    0x10(%ebx),%eax
80100e14:	89 04 24             	mov    %eax,(%esp)
80100e17:	e8 80 09 00 00       	call   8010179c <stati>
    iunlock(f->ip);
80100e1c:	8b 43 10             	mov    0x10(%ebx),%eax
80100e1f:	89 04 24             	mov    %eax,(%esp)
80100e22:	e8 d9 07 00 00       	call   80101600 <iunlock>
    return 0;
80100e27:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100e29:	83 c4 14             	add    $0x14,%esp
80100e2c:	5b                   	pop    %ebx
80100e2d:	5d                   	pop    %ebp
80100e2e:	c3                   	ret    
80100e2f:	90                   	nop
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e35:	83 c4 14             	add    $0x14,%esp
80100e38:	5b                   	pop    %ebx
80100e39:	5d                   	pop    %ebp
80100e3a:	c3                   	ret    
80100e3b:	90                   	nop

80100e3c <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100e3c:	55                   	push   %ebp
80100e3d:	89 e5                	mov    %esp,%ebp
80100e3f:	57                   	push   %edi
80100e40:	56                   	push   %esi
80100e41:	53                   	push   %ebx
80100e42:	83 ec 1c             	sub    $0x1c,%esp
80100e45:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e48:	8b 75 0c             	mov    0xc(%ebp),%esi
80100e4b:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100e4e:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100e52:	74 64                	je     80100eb8 <fileread+0x7c>
    return -1;
  if(f->type == FD_PIPE)
80100e54:	8b 03                	mov    (%ebx),%eax
80100e56:	83 f8 01             	cmp    $0x1,%eax
80100e59:	74 49                	je     80100ea4 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100e5b:	83 f8 02             	cmp    $0x2,%eax
80100e5e:	75 5f                	jne    80100ebf <fileread+0x83>
    ilock(f->ip);
80100e60:	8b 43 10             	mov    0x10(%ebx),%eax
80100e63:	89 04 24             	mov    %eax,(%esp)
80100e66:	e8 c5 06 00 00       	call   80101530 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e6b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100e6f:	8b 43 14             	mov    0x14(%ebx),%eax
80100e72:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e76:	89 74 24 04          	mov    %esi,0x4(%esp)
80100e7a:	8b 43 10             	mov    0x10(%ebx),%eax
80100e7d:	89 04 24             	mov    %eax,(%esp)
80100e80:	e8 43 09 00 00       	call   801017c8 <readi>
80100e85:	89 c6                	mov    %eax,%esi
80100e87:	85 c0                	test   %eax,%eax
80100e89:	7e 03                	jle    80100e8e <fileread+0x52>
      f->off += r;
80100e8b:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100e8e:	8b 43 10             	mov    0x10(%ebx),%eax
80100e91:	89 04 24             	mov    %eax,(%esp)
80100e94:	e8 67 07 00 00       	call   80101600 <iunlock>
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e99:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100e9b:	83 c4 1c             	add    $0x1c,%esp
80100e9e:	5b                   	pop    %ebx
80100e9f:	5e                   	pop    %esi
80100ea0:	5f                   	pop    %edi
80100ea1:	5d                   	pop    %ebp
80100ea2:	c3                   	ret    
80100ea3:	90                   	nop
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100ea4:	8b 43 0c             	mov    0xc(%ebx),%eax
80100ea7:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100eaa:	83 c4 1c             	add    $0x1c,%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100eb1:	e9 0e 23 00 00       	jmp    801031c4 <piperead>
80100eb6:	66 90                	xchg   %ax,%ax
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ebd:	eb dc                	jmp    80100e9b <fileread+0x5f>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100ebf:	c7 04 24 e6 66 10 80 	movl   $0x801066e6,(%esp)
80100ec6:	e8 49 f4 ff ff       	call   80100314 <panic>
80100ecb:	90                   	nop

80100ecc <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ecc:	55                   	push   %ebp
80100ecd:	89 e5                	mov    %esp,%ebp
80100ecf:	57                   	push   %edi
80100ed0:	56                   	push   %esi
80100ed1:	53                   	push   %ebx
80100ed2:	83 ec 2c             	sub    $0x2c,%esp
80100ed5:	8b 7d 08             	mov    0x8(%ebp),%edi
80100ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100edb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ede:	8b 45 10             	mov    0x10(%ebp),%eax
80100ee1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ee4:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
80100ee8:	0f 84 a9 00 00 00    	je     80100f97 <filewrite+0xcb>
    return -1;
  if(f->type == FD_PIPE)
80100eee:	8b 07                	mov    (%edi),%eax
80100ef0:	83 f8 01             	cmp    $0x1,%eax
80100ef3:	0f 84 ba 00 00 00    	je     80100fb3 <filewrite+0xe7>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ef9:	83 f8 02             	cmp    $0x2,%eax
80100efc:	0f 85 cf 00 00 00    	jne    80100fd1 <filewrite+0x105>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100f02:	31 db                	xor    %ebx,%ebx
80100f04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100f07:	85 d2                	test   %edx,%edx
80100f09:	7f 2d                	jg     80100f38 <filewrite+0x6c>
80100f0b:	e9 94 00 00 00       	jmp    80100fa4 <filewrite+0xd8>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100f10:	01 47 14             	add    %eax,0x14(%edi)
80100f13:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80100f16:	8b 4f 10             	mov    0x10(%edi),%ecx
80100f19:	89 0c 24             	mov    %ecx,(%esp)
80100f1c:	e8 df 06 00 00       	call   80101600 <iunlock>
      end_op();
80100f21:	e8 aa 1a 00 00       	call   801029d0 <end_op>
80100f26:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80100f29:	39 f0                	cmp    %esi,%eax
80100f2b:	0f 85 94 00 00 00    	jne    80100fc5 <filewrite+0xf9>
        panic("short filewrite");
      i += r;
80100f31:	01 c3                	add    %eax,%ebx
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100f33:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80100f36:	7e 6c                	jle    80100fa4 <filewrite+0xd8>
80100f38:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100f3b:	29 de                	sub    %ebx,%esi
80100f3d:	81 fe 00 1a 00 00    	cmp    $0x1a00,%esi
80100f43:	7e 05                	jle    80100f4a <filewrite+0x7e>
80100f45:	be 00 1a 00 00       	mov    $0x1a00,%esi
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
80100f4a:	e8 21 1a 00 00       	call   80102970 <begin_op>
      ilock(f->ip);
80100f4f:	8b 47 10             	mov    0x10(%edi),%eax
80100f52:	89 04 24             	mov    %eax,(%esp)
80100f55:	e8 d6 05 00 00       	call   80101530 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100f5a:	89 74 24 0c          	mov    %esi,0xc(%esp)
80100f5e:	8b 47 14             	mov    0x14(%edi),%eax
80100f61:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f65:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f68:	01 d8                	add    %ebx,%eax
80100f6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f6e:	8b 47 10             	mov    0x10(%edi),%eax
80100f71:	89 04 24             	mov    %eax,(%esp)
80100f74:	e8 53 09 00 00       	call   801018cc <writei>
80100f79:	85 c0                	test   %eax,%eax
80100f7b:	7f 93                	jg     80100f10 <filewrite+0x44>
80100f7d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        f->off += r;
      iunlock(f->ip);
80100f80:	8b 4f 10             	mov    0x10(%edi),%ecx
80100f83:	89 0c 24             	mov    %ecx,(%esp)
80100f86:	e8 75 06 00 00       	call   80101600 <iunlock>
      end_op();
80100f8b:	e8 40 1a 00 00       	call   801029d0 <end_op>

      if(r < 0)
80100f90:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f93:	85 c0                	test   %eax,%eax
80100f95:	74 92                	je     80100f29 <filewrite+0x5d>
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
80100f97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100f9c:	83 c4 2c             	add    $0x2c,%esp
80100f9f:	5b                   	pop    %ebx
80100fa0:	5e                   	pop    %esi
80100fa1:	5f                   	pop    %edi
80100fa2:	5d                   	pop    %ebp
80100fa3:	c3                   	ret    
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100fa4:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80100fa7:	75 ee                	jne    80100f97 <filewrite+0xcb>
80100fa9:	89 d8                	mov    %ebx,%eax
  }
  panic("filewrite");
}
80100fab:	83 c4 2c             	add    $0x2c,%esp
80100fae:	5b                   	pop    %ebx
80100faf:	5e                   	pop    %esi
80100fb0:	5f                   	pop    %edi
80100fb1:	5d                   	pop    %ebp
80100fb2:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100fb3:	8b 47 0c             	mov    0xc(%edi),%eax
80100fb6:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100fb9:	83 c4 2c             	add    $0x2c,%esp
80100fbc:	5b                   	pop    %ebx
80100fbd:	5e                   	pop    %esi
80100fbe:	5f                   	pop    %edi
80100fbf:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100fc0:	e9 0f 21 00 00       	jmp    801030d4 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80100fc5:	c7 04 24 ef 66 10 80 	movl   $0x801066ef,(%esp)
80100fcc:	e8 43 f3 ff ff       	call   80100314 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100fd1:	c7 04 24 f5 66 10 80 	movl   $0x801066f5,(%esp)
80100fd8:	e8 37 f3 ff ff       	call   80100314 <panic>
80100fdd:	66 90                	xchg   %ax,%ax
80100fdf:	90                   	nop

80100fe0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 2c             	sub    $0x2c,%esp
80100fe9:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80100fec:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80100ff1:	85 c0                	test   %eax,%eax
80100ff3:	74 7f                	je     80101074 <balloc+0x94>
80100ff5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80100ffc:	8b 75 dc             	mov    -0x24(%ebp),%esi
80100fff:	89 f0                	mov    %esi,%eax
80101001:	c1 f8 0c             	sar    $0xc,%eax
80101004:	03 05 d8 09 11 80    	add    0x801109d8,%eax
8010100a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010100e:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101011:	89 04 24             	mov    %eax,(%esp)
80101014:	e8 9b f0 ff ff       	call   801000b4 <bread>
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010101c:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101021:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101024:	31 c0                	xor    %eax,%eax
80101026:	eb 2a                	jmp    80101052 <balloc+0x72>
      m = 1 << (bi % 8);
80101028:	89 c1                	mov    %eax,%ecx
8010102a:	83 e1 07             	and    $0x7,%ecx
8010102d:	bf 01 00 00 00       	mov    $0x1,%edi
80101032:	d3 e7                	shl    %cl,%edi
80101034:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101036:	89 c3                	mov    %eax,%ebx
80101038:	c1 fb 03             	sar    $0x3,%ebx
8010103b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010103e:	8a 54 1a 5c          	mov    0x5c(%edx,%ebx,1),%dl
80101042:	0f b6 fa             	movzbl %dl,%edi
80101045:	85 cf                	test   %ecx,%edi
80101047:	74 37                	je     80101080 <balloc+0xa0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101049:	40                   	inc    %eax
8010104a:	46                   	inc    %esi
8010104b:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101050:	74 05                	je     80101057 <balloc+0x77>
80101052:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101055:	72 d1                	jb     80101028 <balloc+0x48>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101057:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010105a:	89 04 24             	mov    %eax,(%esp)
8010105d:	e8 4e f1 ff ff       	call   801001b0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101062:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101069:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010106c:	3b 05 c0 09 11 80    	cmp    0x801109c0,%eax
80101072:	72 88                	jb     80100ffc <balloc+0x1c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101074:	c7 04 24 ff 66 10 80 	movl   $0x801066ff,(%esp)
8010107b:	e8 94 f2 ff ff       	call   80100314 <panic>
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101080:	09 ca                	or     %ecx,%edx
80101082:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101085:	88 54 1f 5c          	mov    %dl,0x5c(%edi,%ebx,1)
        log_write(bp);
80101089:	89 3c 24             	mov    %edi,(%esp)
8010108c:	e8 67 1a 00 00       	call   80102af8 <log_write>
        brelse(bp);
80101091:	89 3c 24             	mov    %edi,(%esp)
80101094:	e8 17 f1 ff ff       	call   801001b0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101099:	89 74 24 04          	mov    %esi,0x4(%esp)
8010109d:	8b 45 d8             	mov    -0x28(%ebp),%eax
801010a0:	89 04 24             	mov    %eax,(%esp)
801010a3:	e8 0c f0 ff ff       	call   801000b4 <bread>
801010a8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801010aa:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801010b1:	00 
801010b2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801010b9:	00 
801010ba:	8d 40 5c             	lea    0x5c(%eax),%eax
801010bd:	89 04 24             	mov    %eax,(%esp)
801010c0:	e8 7f 2e 00 00       	call   80103f44 <memset>
  log_write(bp);
801010c5:	89 1c 24             	mov    %ebx,(%esp)
801010c8:	e8 2b 1a 00 00       	call   80102af8 <log_write>
  brelse(bp);
801010cd:	89 1c 24             	mov    %ebx,(%esp)
801010d0:	e8 db f0 ff ff       	call   801001b0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801010d5:	89 f0                	mov    %esi,%eax
801010d7:	83 c4 2c             	add    $0x2c,%esp
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop

801010e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	56                   	push   %esi
801010e5:	53                   	push   %ebx
801010e6:	83 ec 1c             	sub    $0x1c,%esp
801010e9:	89 c7                	mov    %eax,%edi
801010eb:	89 d6                	mov    %edx,%esi
  struct inode *ip, *empty;

  acquire(&icache.lock);
801010ed:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801010f4:	e8 23 2d 00 00       	call   80103e1c <acquire>

  // Is the inode already cached?
  empty = 0;
801010f9:	31 c0                	xor    %eax,%eax
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801010fb:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
80101100:	eb 14                	jmp    80101116 <iget+0x36>
80101102:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101104:	85 c0                	test   %eax,%eax
80101106:	74 38                	je     80101140 <iget+0x60>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101108:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010110e:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101114:	74 3e                	je     80101154 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101116:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101119:	85 c9                	test   %ecx,%ecx
8010111b:	7e e7                	jle    80101104 <iget+0x24>
8010111d:	39 3b                	cmp    %edi,(%ebx)
8010111f:	75 e3                	jne    80101104 <iget+0x24>
80101121:	39 73 04             	cmp    %esi,0x4(%ebx)
80101124:	75 de                	jne    80101104 <iget+0x24>
      ip->ref++;
80101126:	41                   	inc    %ecx
80101127:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010112a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101131:	e8 be 2d 00 00       	call   80103ef4 <release>
      return ip;
80101136:	89 d8                	mov    %ebx,%eax
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
80101138:	83 c4 1c             	add    $0x1c,%esp
8010113b:	5b                   	pop    %ebx
8010113c:	5e                   	pop    %esi
8010113d:	5f                   	pop    %edi
8010113e:	5d                   	pop    %ebp
8010113f:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101140:	85 c9                	test   %ecx,%ecx
80101142:	75 c4                	jne    80101108 <iget+0x28>
80101144:	89 d8                	mov    %ebx,%eax

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101146:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010114c:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101152:	75 c2                	jne    80101116 <iget+0x36>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101154:	85 c0                	test   %eax,%eax
80101156:	74 2d                	je     80101185 <iget+0xa5>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101158:	89 38                	mov    %edi,(%eax)
  ip->inum = inum;
8010115a:	89 70 04             	mov    %esi,0x4(%eax)
  ip->ref = 1;
8010115d:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
80101164:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
8010116b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  release(&icache.lock);
8010116e:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101175:	e8 7a 2d 00 00       	call   80103ef4 <release>
8010117a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return ip;
}
8010117d:	83 c4 1c             	add    $0x1c,%esp
80101180:	5b                   	pop    %ebx
80101181:	5e                   	pop    %esi
80101182:	5f                   	pop    %edi
80101183:	5d                   	pop    %ebp
80101184:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101185:	c7 04 24 15 67 10 80 	movl   $0x80106715,(%esp)
8010118c:	e8 83 f1 ff ff       	call   80100314 <panic>
80101191:	8d 76 00             	lea    0x0(%esi),%esi

80101194 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101194:	55                   	push   %ebp
80101195:	89 e5                	mov    %esp,%ebp
80101197:	57                   	push   %edi
80101198:	56                   	push   %esi
80101199:	53                   	push   %ebx
8010119a:	83 ec 1c             	sub    $0x1c,%esp
8010119d:	89 c3                	mov    %eax,%ebx
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010119f:	83 fa 0b             	cmp    $0xb,%edx
801011a2:	77 14                	ja     801011b8 <bmap+0x24>
801011a4:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
801011a7:	8b 46 5c             	mov    0x5c(%esi),%eax
801011aa:	85 c0                	test   %eax,%eax
801011ac:	74 62                	je     80101210 <bmap+0x7c>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801011ae:	83 c4 1c             	add    $0x1c,%esp
801011b1:	5b                   	pop    %ebx
801011b2:	5e                   	pop    %esi
801011b3:	5f                   	pop    %edi
801011b4:	5d                   	pop    %ebp
801011b5:	c3                   	ret    
801011b6:	66 90                	xchg   %ax,%ax
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801011b8:	8d 72 f4             	lea    -0xc(%edx),%esi

  if(bn < NINDIRECT){
801011bb:	83 fe 7f             	cmp    $0x7f,%esi
801011be:	77 73                	ja     80101233 <bmap+0x9f>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801011c0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801011c6:	85 c0                	test   %eax,%eax
801011c8:	74 5a                	je     80101224 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801011ca:	89 44 24 04          	mov    %eax,0x4(%esp)
801011ce:	8b 03                	mov    (%ebx),%eax
801011d0:	89 04 24             	mov    %eax,(%esp)
801011d3:	e8 dc ee ff ff       	call   801000b4 <bread>
801011d8:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801011da:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx
801011de:	8b 32                	mov    (%edx),%esi
801011e0:	85 f6                	test   %esi,%esi
801011e2:	75 19                	jne    801011fd <bmap+0x69>
801011e4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801011e7:	8b 03                	mov    (%ebx),%eax
801011e9:	e8 f2 fd ff ff       	call   80100fe0 <balloc>
801011ee:	89 c6                	mov    %eax,%esi
801011f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801011f3:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801011f5:	89 3c 24             	mov    %edi,(%esp)
801011f8:	e8 fb 18 00 00       	call   80102af8 <log_write>
    }
    brelse(bp);
801011fd:	89 3c 24             	mov    %edi,(%esp)
80101200:	e8 ab ef ff ff       	call   801001b0 <brelse>
80101205:	89 f0                	mov    %esi,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101207:	83 c4 1c             	add    $0x1c,%esp
8010120a:	5b                   	pop    %ebx
8010120b:	5e                   	pop    %esi
8010120c:	5f                   	pop    %edi
8010120d:	5d                   	pop    %ebp
8010120e:	c3                   	ret    
8010120f:	90                   	nop
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101210:	8b 03                	mov    (%ebx),%eax
80101212:	e8 c9 fd ff ff       	call   80100fe0 <balloc>
80101217:	89 46 5c             	mov    %eax,0x5c(%esi)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010121a:	83 c4 1c             	add    $0x1c,%esp
8010121d:	5b                   	pop    %ebx
8010121e:	5e                   	pop    %esi
8010121f:	5f                   	pop    %edi
80101220:	5d                   	pop    %ebp
80101221:	c3                   	ret    
80101222:	66 90                	xchg   %ax,%ax
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101224:	8b 03                	mov    (%ebx),%eax
80101226:	e8 b5 fd ff ff       	call   80100fe0 <balloc>
8010122b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101231:	eb 97                	jmp    801011ca <bmap+0x36>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101233:	c7 04 24 25 67 10 80 	movl   $0x80106725,(%esp)
8010123a:	e8 d5 f0 ff ff       	call   80100314 <panic>
8010123f:	90                   	nop

80101240 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	56                   	push   %esi
80101244:	53                   	push   %ebx
80101245:	83 ec 10             	sub    $0x10,%esp
80101248:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
8010124b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101252:	00 
80101253:	8b 45 08             	mov    0x8(%ebp),%eax
80101256:	89 04 24             	mov    %eax,(%esp)
80101259:	e8 56 ee ff ff       	call   801000b4 <bread>
8010125e:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101260:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101267:	00 
80101268:	8d 40 5c             	lea    0x5c(%eax),%eax
8010126b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010126f:	89 34 24             	mov    %esi,(%esp)
80101272:	e8 61 2d 00 00       	call   80103fd8 <memmove>
  brelse(bp);
80101277:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010127a:	83 c4 10             	add    $0x10,%esp
8010127d:	5b                   	pop    %ebx
8010127e:	5e                   	pop    %esi
8010127f:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101280:	e9 2b ef ff ff       	jmp    801001b0 <brelse>
80101285:	8d 76 00             	lea    0x0(%esi),%esi

80101288 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101288:	55                   	push   %ebp
80101289:	89 e5                	mov    %esp,%ebp
8010128b:	57                   	push   %edi
8010128c:	56                   	push   %esi
8010128d:	53                   	push   %ebx
8010128e:	83 ec 1c             	sub    $0x1c,%esp
80101291:	89 c3                	mov    %eax,%ebx
80101293:	89 d7                	mov    %edx,%edi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101295:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
8010129c:	80 
8010129d:	89 04 24             	mov    %eax,(%esp)
801012a0:	e8 9b ff ff ff       	call   80101240 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801012a5:	89 fa                	mov    %edi,%edx
801012a7:	c1 ea 0c             	shr    $0xc,%edx
801012aa:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801012b0:	89 54 24 04          	mov    %edx,0x4(%esp)
801012b4:	89 1c 24             	mov    %ebx,(%esp)
801012b7:	e8 f8 ed ff ff       	call   801000b4 <bread>
801012bc:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
801012be:	89 f9                	mov    %edi,%ecx
801012c0:	83 e1 07             	and    $0x7,%ecx
801012c3:	bb 01 00 00 00       	mov    $0x1,%ebx
801012c8:	d3 e3                	shl    %cl,%ebx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
801012ca:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
801012d0:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801012d2:	c1 fa 03             	sar    $0x3,%edx
801012d5:	8a 44 10 5c          	mov    0x5c(%eax,%edx,1),%al
801012d9:	0f b6 c8             	movzbl %al,%ecx
801012dc:	85 d9                	test   %ebx,%ecx
801012de:	74 20                	je     80101300 <bfree+0x78>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801012e0:	f7 d3                	not    %ebx
801012e2:	21 c3                	and    %eax,%ebx
801012e4:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
801012e8:	89 34 24             	mov    %esi,(%esp)
801012eb:	e8 08 18 00 00       	call   80102af8 <log_write>
  brelse(bp);
801012f0:	89 34 24             	mov    %esi,(%esp)
801012f3:	e8 b8 ee ff ff       	call   801001b0 <brelse>
}
801012f8:	83 c4 1c             	add    $0x1c,%esp
801012fb:	5b                   	pop    %ebx
801012fc:	5e                   	pop    %esi
801012fd:	5f                   	pop    %edi
801012fe:	5d                   	pop    %ebp
801012ff:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101300:	c7 04 24 38 67 10 80 	movl   $0x80106738,(%esp)
80101307:	e8 08 f0 ff ff       	call   80100314 <panic>

8010130c <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
8010130c:	55                   	push   %ebp
8010130d:	89 e5                	mov    %esp,%ebp
8010130f:	53                   	push   %ebx
80101310:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
80101313:	c7 44 24 04 4b 67 10 	movl   $0x8010674b,0x4(%esp)
8010131a:	80 
8010131b:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101322:	e8 2d 2a 00 00       	call   80103d54 <initlock>
80101327:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
8010132c:	c7 44 24 04 52 67 10 	movl   $0x80106752,0x4(%esp)
80101333:	80 
80101334:	89 1c 24             	mov    %ebx,(%esp)
80101337:	e8 28 29 00 00       	call   80103c64 <initsleeplock>
8010133c:	81 c3 90 00 00 00    	add    $0x90,%ebx
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101342:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
80101348:	75 e2                	jne    8010132c <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010134a:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
80101351:	80 
80101352:	8b 45 08             	mov    0x8(%ebp),%eax
80101355:	89 04 24             	mov    %eax,(%esp)
80101358:	e8 e3 fe ff ff       	call   80101240 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010135d:	a1 d8 09 11 80       	mov    0x801109d8,%eax
80101362:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101366:	a1 d4 09 11 80       	mov    0x801109d4,%eax
8010136b:	89 44 24 18          	mov    %eax,0x18(%esp)
8010136f:	a1 d0 09 11 80       	mov    0x801109d0,%eax
80101374:	89 44 24 14          	mov    %eax,0x14(%esp)
80101378:	a1 cc 09 11 80       	mov    0x801109cc,%eax
8010137d:	89 44 24 10          	mov    %eax,0x10(%esp)
80101381:	a1 c8 09 11 80       	mov    0x801109c8,%eax
80101386:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010138a:	a1 c4 09 11 80       	mov    0x801109c4,%eax
8010138f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101393:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101398:	89 44 24 04          	mov    %eax,0x4(%esp)
8010139c:	c7 04 24 b8 67 10 80 	movl   $0x801067b8,(%esp)
801013a3:	e8 1c f2 ff ff       	call   801005c4 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801013a8:	83 c4 24             	add    $0x24,%esp
801013ab:	5b                   	pop    %ebx
801013ac:	5d                   	pop    %ebp
801013ad:	c3                   	ret    
801013ae:	66 90                	xchg   %ax,%ax

801013b0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
801013b4:	56                   	push   %esi
801013b5:	53                   	push   %ebx
801013b6:	83 ec 2c             	sub    $0x2c,%esp
801013b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801013bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801013bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801013c2:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
801013c9:	0f 86 9b 00 00 00    	jbe    8010146a <ialloc+0xba>
801013cf:	be 01 00 00 00       	mov    $0x1,%esi
801013d4:	bb 01 00 00 00       	mov    $0x1,%ebx
801013d9:	eb 14                	jmp    801013ef <ialloc+0x3f>
801013db:	90                   	nop
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801013dc:	89 14 24             	mov    %edx,(%esp)
801013df:	e8 cc ed ff ff       	call   801001b0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801013e4:	43                   	inc    %ebx
801013e5:	89 de                	mov    %ebx,%esi
801013e7:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
801013ed:	73 7b                	jae    8010146a <ialloc+0xba>
    bp = bread(dev, IBLOCK(inum, sb));
801013ef:	89 f0                	mov    %esi,%eax
801013f1:	c1 e8 03             	shr    $0x3,%eax
801013f4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801013fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801013fe:	89 3c 24             	mov    %edi,(%esp)
80101401:	e8 ae ec ff ff       	call   801000b4 <bread>
80101406:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
80101408:	89 f0                	mov    %esi,%eax
8010140a:	83 e0 07             	and    $0x7,%eax
8010140d:	c1 e0 06             	shl    $0x6,%eax
80101410:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101414:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101418:	75 c2                	jne    801013dc <ialloc+0x2c>
8010141a:	89 55 dc             	mov    %edx,-0x24(%ebp)
      memset(dip, 0, sizeof(*dip));
8010141d:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101424:	00 
80101425:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010142c:	00 
8010142d:	89 0c 24             	mov    %ecx,(%esp)
80101430:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101433:	e8 0c 2b 00 00       	call   80103f44 <memset>
      dip->type = type;
80101438:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010143b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010143e:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101441:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101444:	89 14 24             	mov    %edx,(%esp)
80101447:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010144a:	e8 a9 16 00 00       	call   80102af8 <log_write>
      brelse(bp);
8010144f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101452:	89 14 24             	mov    %edx,(%esp)
80101455:	e8 56 ed ff ff       	call   801001b0 <brelse>
      return iget(dev, inum);
8010145a:	89 f2                	mov    %esi,%edx
8010145c:	89 f8                	mov    %edi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
8010145e:	83 c4 2c             	add    $0x2c,%esp
80101461:	5b                   	pop    %ebx
80101462:	5e                   	pop    %esi
80101463:	5f                   	pop    %edi
80101464:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101465:	e9 76 fc ff ff       	jmp    801010e0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010146a:	c7 04 24 58 67 10 80 	movl   $0x80106758,(%esp)
80101471:	e8 9e ee ff ff       	call   80100314 <panic>
80101476:	66 90                	xchg   %ax,%ax

80101478 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101478:	55                   	push   %ebp
80101479:	89 e5                	mov    %esp,%ebp
8010147b:	56                   	push   %esi
8010147c:	53                   	push   %ebx
8010147d:	83 ec 10             	sub    $0x10,%esp
80101480:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101483:	8b 43 04             	mov    0x4(%ebx),%eax
80101486:	c1 e8 03             	shr    $0x3,%eax
80101489:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010148f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101493:	8b 03                	mov    (%ebx),%eax
80101495:	89 04 24             	mov    %eax,(%esp)
80101498:	e8 17 ec ff ff       	call   801000b4 <bread>
8010149d:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010149f:	8b 53 04             	mov    0x4(%ebx),%edx
801014a2:	83 e2 07             	and    $0x7,%edx
801014a5:	c1 e2 06             	shl    $0x6,%edx
801014a8:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  dip->type = ip->type;
801014ac:	8b 43 50             	mov    0x50(%ebx),%eax
801014af:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
801014b2:	66 8b 43 52          	mov    0x52(%ebx),%ax
801014b6:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
801014ba:	8b 43 54             	mov    0x54(%ebx),%eax
801014bd:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
801014c1:	66 8b 43 56          	mov    0x56(%ebx),%ax
801014c5:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
801014c9:	8b 43 58             	mov    0x58(%ebx),%eax
801014cc:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801014cf:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801014d6:	00 
801014d7:	83 c3 5c             	add    $0x5c,%ebx
801014da:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801014de:	83 c2 0c             	add    $0xc,%edx
801014e1:	89 14 24             	mov    %edx,(%esp)
801014e4:	e8 ef 2a 00 00       	call   80103fd8 <memmove>
  log_write(bp);
801014e9:	89 34 24             	mov    %esi,(%esp)
801014ec:	e8 07 16 00 00       	call   80102af8 <log_write>
  brelse(bp);
801014f1:	89 75 08             	mov    %esi,0x8(%ebp)
}
801014f4:	83 c4 10             	add    $0x10,%esp
801014f7:	5b                   	pop    %ebx
801014f8:	5e                   	pop    %esi
801014f9:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801014fa:	e9 b1 ec ff ff       	jmp    801001b0 <brelse>
801014ff:	90                   	nop

80101500 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	53                   	push   %ebx
80101504:	83 ec 14             	sub    $0x14,%esp
80101507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010150a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101511:	e8 06 29 00 00       	call   80103e1c <acquire>
  ip->ref++;
80101516:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
80101519:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101520:	e8 cf 29 00 00       	call   80103ef4 <release>
  return ip;
}
80101525:	89 d8                	mov    %ebx,%eax
80101527:	83 c4 14             	add    $0x14,%esp
8010152a:	5b                   	pop    %ebx
8010152b:	5d                   	pop    %ebp
8010152c:	c3                   	ret    
8010152d:	8d 76 00             	lea    0x0(%esi),%esi

80101530 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	56                   	push   %esi
80101534:	53                   	push   %ebx
80101535:	83 ec 10             	sub    $0x10,%esp
80101538:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010153b:	85 db                	test   %ebx,%ebx
8010153d:	0f 84 b1 00 00 00    	je     801015f4 <ilock+0xc4>
80101543:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101546:	85 c9                	test   %ecx,%ecx
80101548:	0f 8e a6 00 00 00    	jle    801015f4 <ilock+0xc4>
    panic("ilock");

  acquiresleep(&ip->lock);
8010154e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101551:	89 04 24             	mov    %eax,(%esp)
80101554:	e8 43 27 00 00       	call   80103c9c <acquiresleep>

  if(ip->valid == 0){
80101559:	8b 53 4c             	mov    0x4c(%ebx),%edx
8010155c:	85 d2                	test   %edx,%edx
8010155e:	74 08                	je     80101568 <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101560:	83 c4 10             	add    $0x10,%esp
80101563:	5b                   	pop    %ebx
80101564:	5e                   	pop    %esi
80101565:	5d                   	pop    %ebp
80101566:	c3                   	ret    
80101567:	90                   	nop
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101568:	8b 43 04             	mov    0x4(%ebx),%eax
8010156b:	c1 e8 03             	shr    $0x3,%eax
8010156e:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101574:	89 44 24 04          	mov    %eax,0x4(%esp)
80101578:	8b 03                	mov    (%ebx),%eax
8010157a:	89 04 24             	mov    %eax,(%esp)
8010157d:	e8 32 eb ff ff       	call   801000b4 <bread>
80101582:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101584:	8b 53 04             	mov    0x4(%ebx),%edx
80101587:	83 e2 07             	and    $0x7,%edx
8010158a:	c1 e2 06             	shl    $0x6,%edx
8010158d:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    ip->type = dip->type;
80101591:	8b 02                	mov    (%edx),%eax
80101593:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
80101597:	66 8b 42 02          	mov    0x2(%edx),%ax
8010159b:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
8010159f:	8b 42 04             	mov    0x4(%edx),%eax
801015a2:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
801015a6:	66 8b 42 06          	mov    0x6(%edx),%ax
801015aa:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
801015ae:	8b 42 08             	mov    0x8(%edx),%eax
801015b1:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801015b4:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801015bb:	00 
801015bc:	83 c2 0c             	add    $0xc,%edx
801015bf:	89 54 24 04          	mov    %edx,0x4(%esp)
801015c3:	8d 43 5c             	lea    0x5c(%ebx),%eax
801015c6:	89 04 24             	mov    %eax,(%esp)
801015c9:	e8 0a 2a 00 00       	call   80103fd8 <memmove>
    brelse(bp);
801015ce:	89 34 24             	mov    %esi,(%esp)
801015d1:	e8 da eb ff ff       	call   801001b0 <brelse>
    ip->valid = 1;
801015d6:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801015dd:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
801015e2:	0f 85 78 ff ff ff    	jne    80101560 <ilock+0x30>
      panic("ilock: no type");
801015e8:	c7 04 24 70 67 10 80 	movl   $0x80106770,(%esp)
801015ef:	e8 20 ed ff ff       	call   80100314 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801015f4:	c7 04 24 6a 67 10 80 	movl   $0x8010676a,(%esp)
801015fb:	e8 14 ed ff ff       	call   80100314 <panic>

80101600 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	56                   	push   %esi
80101604:	53                   	push   %ebx
80101605:	83 ec 10             	sub    $0x10,%esp
80101608:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010160b:	85 db                	test   %ebx,%ebx
8010160d:	74 24                	je     80101633 <iunlock+0x33>
8010160f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101612:	89 34 24             	mov    %esi,(%esp)
80101615:	e8 0e 27 00 00       	call   80103d28 <holdingsleep>
8010161a:	85 c0                	test   %eax,%eax
8010161c:	74 15                	je     80101633 <iunlock+0x33>
8010161e:	8b 5b 08             	mov    0x8(%ebx),%ebx
80101621:	85 db                	test   %ebx,%ebx
80101623:	7e 0e                	jle    80101633 <iunlock+0x33>
    panic("iunlock");

  releasesleep(&ip->lock);
80101625:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101628:	83 c4 10             	add    $0x10,%esp
8010162b:	5b                   	pop    %ebx
8010162c:	5e                   	pop    %esi
8010162d:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010162e:	e9 b9 26 00 00       	jmp    80103cec <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101633:	c7 04 24 7f 67 10 80 	movl   $0x8010677f,(%esp)
8010163a:	e8 d5 ec ff ff       	call   80100314 <panic>
8010163f:	90                   	nop

80101640 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	57                   	push   %edi
80101644:	56                   	push   %esi
80101645:	53                   	push   %ebx
80101646:	83 ec 1c             	sub    $0x1c,%esp
80101649:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010164c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010164f:	89 3c 24             	mov    %edi,(%esp)
80101652:	e8 45 26 00 00       	call   80103c9c <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101657:	8b 46 4c             	mov    0x4c(%esi),%eax
8010165a:	85 c0                	test   %eax,%eax
8010165c:	74 07                	je     80101665 <iput+0x25>
8010165e:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101663:	74 2b                	je     80101690 <iput+0x50>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101665:	89 3c 24             	mov    %edi,(%esp)
80101668:	e8 7f 26 00 00       	call   80103cec <releasesleep>

  acquire(&icache.lock);
8010166d:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101674:	e8 a3 27 00 00       	call   80103e1c <acquire>
  ip->ref--;
80101679:	ff 4e 08             	decl   0x8(%esi)
  release(&icache.lock);
8010167c:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101683:	83 c4 1c             	add    $0x1c,%esp
80101686:	5b                   	pop    %ebx
80101687:	5e                   	pop    %esi
80101688:	5f                   	pop    %edi
80101689:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
8010168a:	e9 65 28 00 00       	jmp    80103ef4 <release>
8010168f:	90                   	nop
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101690:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101697:	e8 80 27 00 00       	call   80103e1c <acquire>
    int r = ip->ref;
8010169c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010169f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016a6:	e8 49 28 00 00       	call   80103ef4 <release>
    if(r == 1){
801016ab:	4b                   	dec    %ebx
801016ac:	75 b7                	jne    80101665 <iput+0x25>
801016ae:	89 f3                	mov    %esi,%ebx
801016b0:	8d 4e 30             	lea    0x30(%esi),%ecx
801016b3:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801016b6:	89 cf                	mov    %ecx,%edi
801016b8:	eb 09                	jmp    801016c3 <iput+0x83>
801016ba:	66 90                	xchg   %ax,%ax
801016bc:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801016bf:	39 fb                	cmp    %edi,%ebx
801016c1:	74 19                	je     801016dc <iput+0x9c>
    if(ip->addrs[i]){
801016c3:	8b 53 5c             	mov    0x5c(%ebx),%edx
801016c6:	85 d2                	test   %edx,%edx
801016c8:	74 f2                	je     801016bc <iput+0x7c>
      bfree(ip->dev, ip->addrs[i]);
801016ca:	8b 06                	mov    (%esi),%eax
801016cc:	e8 b7 fb ff ff       	call   80101288 <bfree>
      ip->addrs[i] = 0;
801016d1:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
801016d8:	eb e2                	jmp    801016bc <iput+0x7c>
801016da:	66 90                	xchg   %ax,%ax
801016dc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    }
  }

  if(ip->addrs[NDIRECT]){
801016df:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801016e5:	85 c0                	test   %eax,%eax
801016e7:	75 2b                	jne    80101714 <iput+0xd4>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801016e9:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801016f0:	89 34 24             	mov    %esi,(%esp)
801016f3:	e8 80 fd ff ff       	call   80101478 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
801016f8:	66 c7 46 50 00 00    	movw   $0x0,0x50(%esi)
      iupdate(ip);
801016fe:	89 34 24             	mov    %esi,(%esp)
80101701:	e8 72 fd ff ff       	call   80101478 <iupdate>
      ip->valid = 0;
80101706:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010170d:	e9 53 ff ff ff       	jmp    80101665 <iput+0x25>
80101712:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101714:	89 44 24 04          	mov    %eax,0x4(%esp)
80101718:	8b 06                	mov    (%esi),%eax
8010171a:	89 04 24             	mov    %eax,(%esp)
8010171d:	e8 92 e9 ff ff       	call   801000b4 <bread>
80101722:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101725:	8d 48 5c             	lea    0x5c(%eax),%ecx
    for(j = 0; j < NINDIRECT; j++){
80101728:	31 db                	xor    %ebx,%ebx
8010172a:	31 c0                	xor    %eax,%eax
8010172c:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010172f:	89 cf                	mov    %ecx,%edi
80101731:	eb 0c                	jmp    8010173f <iput+0xff>
80101733:	90                   	nop
80101734:	43                   	inc    %ebx
80101735:	89 d8                	mov    %ebx,%eax
80101737:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
8010173d:	74 10                	je     8010174f <iput+0x10f>
      if(a[j])
8010173f:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101742:	85 d2                	test   %edx,%edx
80101744:	74 ee                	je     80101734 <iput+0xf4>
        bfree(ip->dev, a[j]);
80101746:	8b 06                	mov    (%esi),%eax
80101748:	e8 3b fb ff ff       	call   80101288 <bfree>
8010174d:	eb e5                	jmp    80101734 <iput+0xf4>
8010174f:	8b 7d e0             	mov    -0x20(%ebp),%edi
    }
    brelse(bp);
80101752:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101755:	89 04 24             	mov    %eax,(%esp)
80101758:	e8 53 ea ff ff       	call   801001b0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010175d:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101763:	8b 06                	mov    (%esi),%eax
80101765:	e8 1e fb ff ff       	call   80101288 <bfree>
    ip->addrs[NDIRECT] = 0;
8010176a:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101771:	00 00 00 
80101774:	e9 70 ff ff ff       	jmp    801016e9 <iput+0xa9>
80101779:	8d 76 00             	lea    0x0(%esi),%esi

8010177c <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
8010177c:	55                   	push   %ebp
8010177d:	89 e5                	mov    %esp,%ebp
8010177f:	53                   	push   %ebx
80101780:	83 ec 14             	sub    $0x14,%esp
80101783:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101786:	89 1c 24             	mov    %ebx,(%esp)
80101789:	e8 72 fe ff ff       	call   80101600 <iunlock>
  iput(ip);
8010178e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101791:	83 c4 14             	add    $0x14,%esp
80101794:	5b                   	pop    %ebx
80101795:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101796:	e9 a5 fe ff ff       	jmp    80101640 <iput>
8010179b:	90                   	nop

8010179c <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
8010179c:	55                   	push   %ebp
8010179d:	89 e5                	mov    %esp,%ebp
8010179f:	8b 55 08             	mov    0x8(%ebp),%edx
801017a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801017a5:	8b 0a                	mov    (%edx),%ecx
801017a7:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801017aa:	8b 4a 04             	mov    0x4(%edx),%ecx
801017ad:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801017b0:	8b 4a 50             	mov    0x50(%edx),%ecx
801017b3:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801017b6:	66 8b 4a 56          	mov    0x56(%edx),%cx
801017ba:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801017be:	8b 52 58             	mov    0x58(%edx),%edx
801017c1:	89 50 10             	mov    %edx,0x10(%eax)
}
801017c4:	5d                   	pop    %ebp
801017c5:	c3                   	ret    
801017c6:	66 90                	xchg   %ax,%ax

801017c8 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801017c8:	55                   	push   %ebp
801017c9:	89 e5                	mov    %esp,%ebp
801017cb:	57                   	push   %edi
801017cc:	56                   	push   %esi
801017cd:	53                   	push   %ebx
801017ce:	83 ec 2c             	sub    $0x2c,%esp
801017d1:	8b 7d 08             	mov    0x8(%ebp),%edi
801017d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801017d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801017da:	8b 75 10             	mov    0x10(%ebp),%esi
801017dd:	8b 45 14             	mov    0x14(%ebp),%eax
801017e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801017e3:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
801017e8:	0f 84 b2 00 00 00    	je     801018a0 <readi+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801017ee:	8b 47 58             	mov    0x58(%edi),%eax
801017f1:	39 f0                	cmp    %esi,%eax
801017f3:	0f 82 cb 00 00 00    	jb     801018c4 <readi+0xfc>
801017f9:	8b 55 e0             	mov    -0x20(%ebp),%edx
801017fc:	01 f2                	add    %esi,%edx
801017fe:	0f 82 c0 00 00 00    	jb     801018c4 <readi+0xfc>
    return -1;
  if(off + n > ip->size)
80101804:	39 d0                	cmp    %edx,%eax
80101806:	0f 82 88 00 00 00    	jb     80101894 <readi+0xcc>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010180c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101813:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101816:	85 c0                	test   %eax,%eax
80101818:	74 6d                	je     80101887 <readi+0xbf>
8010181a:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010181c:	89 f2                	mov    %esi,%edx
8010181e:	c1 ea 09             	shr    $0x9,%edx
80101821:	89 f8                	mov    %edi,%eax
80101823:	e8 6c f9 ff ff       	call   80101194 <bmap>
80101828:	89 44 24 04          	mov    %eax,0x4(%esp)
8010182c:	8b 07                	mov    (%edi),%eax
8010182e:	89 04 24             	mov    %eax,(%esp)
80101831:	e8 7e e8 ff ff       	call   801000b4 <bread>
80101836:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101838:	89 f0                	mov    %esi,%eax
8010183a:	25 ff 01 00 00       	and    $0x1ff,%eax
8010183f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101842:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
80101845:	bb 00 02 00 00       	mov    $0x200,%ebx
8010184a:	29 c3                	sub    %eax,%ebx
8010184c:	39 cb                	cmp    %ecx,%ebx
8010184e:	76 02                	jbe    80101852 <readi+0x8a>
80101850:	89 cb                	mov    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101852:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101856:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
8010185a:	89 55 d8             	mov    %edx,-0x28(%ebp)
8010185d:	89 44 24 04          	mov    %eax,0x4(%esp)
80101861:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101864:	89 04 24             	mov    %eax,(%esp)
80101867:	e8 6c 27 00 00       	call   80103fd8 <memmove>
    brelse(bp);
8010186c:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010186f:	89 14 24             	mov    %edx,(%esp)
80101872:	e8 39 e9 ff ff       	call   801001b0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101877:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010187a:	01 de                	add    %ebx,%esi
8010187c:	01 5d dc             	add    %ebx,-0x24(%ebp)
8010187f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101882:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101885:	77 95                	ja     8010181c <readi+0x54>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101887:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
8010188a:	83 c4 2c             	add    $0x2c,%esp
8010188d:	5b                   	pop    %ebx
8010188e:	5e                   	pop    %esi
8010188f:	5f                   	pop    %edi
80101890:	5d                   	pop    %ebp
80101891:	c3                   	ret    
80101892:	66 90                	xchg   %ax,%ax
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101894:	29 f0                	sub    %esi,%eax
80101896:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101899:	e9 6e ff ff ff       	jmp    8010180c <readi+0x44>
8010189e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801018a0:	0f bf 47 52          	movswl 0x52(%edi),%eax
801018a4:	66 83 f8 09          	cmp    $0x9,%ax
801018a8:	77 1a                	ja     801018c4 <readi+0xfc>
801018aa:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
801018b1:	85 c0                	test   %eax,%eax
801018b3:	74 0f                	je     801018c4 <readi+0xfc>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801018b5:	8b 75 e0             	mov    -0x20(%ebp),%esi
801018b8:	89 75 10             	mov    %esi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
801018bb:	83 c4 2c             	add    $0x2c,%esp
801018be:	5b                   	pop    %ebx
801018bf:	5e                   	pop    %esi
801018c0:	5f                   	pop    %edi
801018c1:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801018c2:	ff e0                	jmp    *%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
801018c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801018c9:	eb bf                	jmp    8010188a <readi+0xc2>
801018cb:	90                   	nop

801018cc <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801018cc:	55                   	push   %ebp
801018cd:	89 e5                	mov    %esp,%ebp
801018cf:	57                   	push   %edi
801018d0:	56                   	push   %esi
801018d1:	53                   	push   %ebx
801018d2:	83 ec 2c             	sub    $0x2c,%esp
801018d5:	8b 7d 08             	mov    0x8(%ebp),%edi
801018d8:	8b 45 0c             	mov    0xc(%ebp),%eax
801018db:	89 45 d8             	mov    %eax,-0x28(%ebp)
801018de:	8b 45 10             	mov    0x10(%ebp),%eax
801018e1:	89 45 dc             	mov    %eax,-0x24(%ebp)
801018e4:	8b 45 14             	mov    0x14(%ebp),%eax
801018e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801018ea:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
801018ef:	0f 84 b3 00 00 00    	je     801019a8 <writei+0xdc>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801018f5:	8b 55 dc             	mov    -0x24(%ebp),%edx
801018f8:	39 57 58             	cmp    %edx,0x58(%edi)
801018fb:	0f 82 db 00 00 00    	jb     801019dc <writei+0x110>
80101901:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101904:	89 f0                	mov    %esi,%eax
80101906:	01 d0                	add    %edx,%eax
80101908:	0f 82 ce 00 00 00    	jb     801019dc <writei+0x110>
    return -1;
  if(off + n > MAXFILE*BSIZE)
8010190e:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101913:	0f 87 c3 00 00 00    	ja     801019dc <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101919:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101920:	85 f6                	test   %esi,%esi
80101922:	74 79                	je     8010199d <writei+0xd1>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101924:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101927:	89 da                	mov    %ebx,%edx
80101929:	c1 ea 09             	shr    $0x9,%edx
8010192c:	89 f8                	mov    %edi,%eax
8010192e:	e8 61 f8 ff ff       	call   80101194 <bmap>
80101933:	89 44 24 04          	mov    %eax,0x4(%esp)
80101937:	8b 07                	mov    (%edi),%eax
80101939:	89 04 24             	mov    %eax,(%esp)
8010193c:	e8 73 e7 ff ff       	call   801000b4 <bread>
80101941:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101943:	89 d8                	mov    %ebx,%eax
80101945:	25 ff 01 00 00       	and    $0x1ff,%eax
8010194a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010194d:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
80101950:	bb 00 02 00 00       	mov    $0x200,%ebx
80101955:	29 c3                	sub    %eax,%ebx
80101957:	39 cb                	cmp    %ecx,%ebx
80101959:	76 02                	jbe    8010195d <writei+0x91>
8010195b:	89 cb                	mov    %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010195d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101961:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80101964:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101968:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
8010196c:	89 04 24             	mov    %eax,(%esp)
8010196f:	e8 64 26 00 00       	call   80103fd8 <memmove>
    log_write(bp);
80101974:	89 34 24             	mov    %esi,(%esp)
80101977:	e8 7c 11 00 00       	call   80102af8 <log_write>
    brelse(bp);
8010197c:	89 34 24             	mov    %esi,(%esp)
8010197f:	e8 2c e8 ff ff       	call   801001b0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101984:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101987:	01 5d dc             	add    %ebx,-0x24(%ebp)
8010198a:	01 5d d8             	add    %ebx,-0x28(%ebp)
8010198d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101990:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101993:	77 8f                	ja     80101924 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101995:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101998:	39 47 58             	cmp    %eax,0x58(%edi)
8010199b:	72 2f                	jb     801019cc <writei+0x100>
    ip->size = off;
    iupdate(ip);
  }
  return n;
8010199d:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801019a0:	83 c4 2c             	add    $0x2c,%esp
801019a3:	5b                   	pop    %ebx
801019a4:	5e                   	pop    %esi
801019a5:	5f                   	pop    %edi
801019a6:	5d                   	pop    %ebp
801019a7:	c3                   	ret    
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801019a8:	0f bf 47 52          	movswl 0x52(%edi),%eax
801019ac:	66 83 f8 09          	cmp    $0x9,%ax
801019b0:	77 2a                	ja     801019dc <writei+0x110>
801019b2:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
801019b9:	85 c0                	test   %eax,%eax
801019bb:	74 1f                	je     801019dc <writei+0x110>
      return -1;
    return devsw[ip->major].write(ip, src, n);
801019bd:	8b 75 e0             	mov    -0x20(%ebp),%esi
801019c0:	89 75 10             	mov    %esi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
801019c3:	83 c4 2c             	add    $0x2c,%esp
801019c6:	5b                   	pop    %ebx
801019c7:	5e                   	pop    %esi
801019c8:	5f                   	pop    %edi
801019c9:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
801019ca:	ff e0                	jmp    *%eax
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
801019cc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801019cf:	89 47 58             	mov    %eax,0x58(%edi)
    iupdate(ip);
801019d2:	89 3c 24             	mov    %edi,(%esp)
801019d5:	e8 9e fa ff ff       	call   80101478 <iupdate>
801019da:	eb c1                	jmp    8010199d <writei+0xd1>
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
801019dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
801019e1:	83 c4 2c             	add    $0x2c,%esp
801019e4:	5b                   	pop    %ebx
801019e5:	5e                   	pop    %esi
801019e6:	5f                   	pop    %edi
801019e7:	5d                   	pop    %ebp
801019e8:	c3                   	ret    
801019e9:	8d 76 00             	lea    0x0(%esi),%esi

801019ec <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801019ec:	55                   	push   %ebp
801019ed:	89 e5                	mov    %esp,%ebp
801019ef:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
801019f2:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801019f9:	00 
801019fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801019fd:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a01:	8b 45 08             	mov    0x8(%ebp),%eax
80101a04:	89 04 24             	mov    %eax,(%esp)
80101a07:	e8 3c 26 00 00       	call   80104048 <strncmp>
}
80101a0c:	c9                   	leave  
80101a0d:	c3                   	ret    
80101a0e:	66 90                	xchg   %ax,%ax

80101a10 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	57                   	push   %edi
80101a14:	56                   	push   %esi
80101a15:	53                   	push   %ebx
80101a16:	83 ec 2c             	sub    $0x2c,%esp
80101a19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101a1c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101a21:	0f 85 93 00 00 00    	jne    80101aba <dirlookup+0xaa>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101a27:	8b 43 58             	mov    0x58(%ebx),%eax
80101a2a:	85 c0                	test   %eax,%eax
80101a2c:	74 76                	je     80101aa4 <dirlookup+0x94>
80101a2e:	31 ff                	xor    %edi,%edi
80101a30:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101a33:	eb 0b                	jmp    80101a40 <dirlookup+0x30>
80101a35:	8d 76 00             	lea    0x0(%esi),%esi
80101a38:	83 c7 10             	add    $0x10,%edi
80101a3b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101a3e:	76 64                	jbe    80101aa4 <dirlookup+0x94>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101a40:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101a47:	00 
80101a48:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101a4c:	89 74 24 04          	mov    %esi,0x4(%esp)
80101a50:	89 1c 24             	mov    %ebx,(%esp)
80101a53:	e8 70 fd ff ff       	call   801017c8 <readi>
80101a58:	83 f8 10             	cmp    $0x10,%eax
80101a5b:	75 51                	jne    80101aae <dirlookup+0x9e>
      panic("dirlookup read");
    if(de.inum == 0)
80101a5d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101a62:	74 d4                	je     80101a38 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101a64:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101a6b:	00 
80101a6c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101a6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a73:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a76:	89 04 24             	mov    %eax,(%esp)
80101a79:	e8 ca 25 00 00       	call   80104048 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101a7e:	85 c0                	test   %eax,%eax
80101a80:	75 b6                	jne    80101a38 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101a82:	8b 45 10             	mov    0x10(%ebp),%eax
80101a85:	85 c0                	test   %eax,%eax
80101a87:	74 05                	je     80101a8e <dirlookup+0x7e>
        *poff = off;
80101a89:	8b 45 10             	mov    0x10(%ebp),%eax
80101a8c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101a8e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101a92:	8b 03                	mov    (%ebx),%eax
80101a94:	e8 47 f6 ff ff       	call   801010e0 <iget>
    }
  }

  return 0;
}
80101a99:	83 c4 2c             	add    $0x2c,%esp
80101a9c:	5b                   	pop    %ebx
80101a9d:	5e                   	pop    %esi
80101a9e:	5f                   	pop    %edi
80101a9f:	5d                   	pop    %ebp
80101aa0:	c3                   	ret    
80101aa1:	8d 76 00             	lea    0x0(%esi),%esi
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101aa4:	31 c0                	xor    %eax,%eax
}
80101aa6:	83 c4 2c             	add    $0x2c,%esp
80101aa9:	5b                   	pop    %ebx
80101aaa:	5e                   	pop    %esi
80101aab:	5f                   	pop    %edi
80101aac:	5d                   	pop    %ebp
80101aad:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101aae:	c7 04 24 99 67 10 80 	movl   $0x80106799,(%esp)
80101ab5:	e8 5a e8 ff ff       	call   80100314 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101aba:	c7 04 24 87 67 10 80 	movl   $0x80106787,(%esp)
80101ac1:	e8 4e e8 ff ff       	call   80100314 <panic>
80101ac6:	66 90                	xchg   %ax,%ax

80101ac8 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ac8:	55                   	push   %ebp
80101ac9:	89 e5                	mov    %esp,%ebp
80101acb:	57                   	push   %edi
80101acc:	56                   	push   %esi
80101acd:	53                   	push   %ebx
80101ace:	83 ec 2c             	sub    $0x2c,%esp
80101ad1:	89 c3                	mov    %eax,%ebx
80101ad3:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ad6:	89 cf                	mov    %ecx,%edi
  struct inode *ip, *next;

  if(*path == '/')
80101ad8:	80 38 2f             	cmpb   $0x2f,(%eax)
80101adb:	0f 84 35 01 00 00    	je     80101c16 <namex+0x14e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101ae1:	e8 86 19 00 00       	call   8010346c <myproc>
80101ae6:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101ae9:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101af0:	e8 27 23 00 00       	call   80103e1c <acquire>
  ip->ref++;
80101af5:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101af8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101aff:	e8 f0 23 00 00       	call   80103ef4 <release>
80101b04:	eb 03                	jmp    80101b09 <namex+0x41>
80101b06:	66 90                	xchg   %ax,%ax
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101b08:	43                   	inc    %ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101b09:	8a 03                	mov    (%ebx),%al
80101b0b:	3c 2f                	cmp    $0x2f,%al
80101b0d:	74 f9                	je     80101b08 <namex+0x40>
    path++;
  if(*path == 0)
80101b0f:	84 c0                	test   %al,%al
80101b11:	0f 84 d4 00 00 00    	je     80101beb <namex+0x123>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101b17:	8a 03                	mov    (%ebx),%al
80101b19:	89 da                	mov    %ebx,%edx
80101b1b:	3c 2f                	cmp    $0x2f,%al
80101b1d:	0f 84 9f 00 00 00    	je     80101bc2 <namex+0xfa>
80101b23:	84 c0                	test   %al,%al
80101b25:	75 09                	jne    80101b30 <namex+0x68>
80101b27:	e9 96 00 00 00       	jmp    80101bc2 <namex+0xfa>
80101b2c:	84 c0                	test   %al,%al
80101b2e:	74 07                	je     80101b37 <namex+0x6f>
    path++;
80101b30:	42                   	inc    %edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101b31:	8a 02                	mov    (%edx),%al
80101b33:	3c 2f                	cmp    $0x2f,%al
80101b35:	75 f5                	jne    80101b2c <namex+0x64>
80101b37:	89 d1                	mov    %edx,%ecx
80101b39:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101b3b:	83 f9 0d             	cmp    $0xd,%ecx
80101b3e:	0f 8e 80 00 00 00    	jle    80101bc4 <namex+0xfc>
80101b44:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    memmove(name, s, DIRSIZ);
80101b47:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101b4e:	00 
80101b4f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101b53:	89 3c 24             	mov    %edi,(%esp)
80101b56:	e8 7d 24 00 00       	call   80103fd8 <memmove>
80101b5b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b5e:	89 d3                	mov    %edx,%ebx
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101b60:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101b63:	75 09                	jne    80101b6e <namex+0xa6>
80101b65:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101b68:	43                   	inc    %ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101b69:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101b6c:	74 fa                	je     80101b68 <namex+0xa0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101b6e:	89 34 24             	mov    %esi,(%esp)
80101b71:	e8 ba f9 ff ff       	call   80101530 <ilock>
    if(ip->type != T_DIR){
80101b76:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101b7b:	75 7f                	jne    80101bfc <namex+0x134>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101b7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b80:	85 c0                	test   %eax,%eax
80101b82:	74 09                	je     80101b8d <namex+0xc5>
80101b84:	80 3b 00             	cmpb   $0x0,(%ebx)
80101b87:	0f 84 9f 00 00 00    	je     80101c2c <namex+0x164>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101b8d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101b94:	00 
80101b95:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101b99:	89 34 24             	mov    %esi,(%esp)
80101b9c:	e8 6f fe ff ff       	call   80101a10 <dirlookup>
80101ba1:	85 c0                	test   %eax,%eax
80101ba3:	74 57                	je     80101bfc <namex+0x134>
80101ba5:	89 45 e4             	mov    %eax,-0x1c(%ebp)

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ba8:	89 34 24             	mov    %esi,(%esp)
80101bab:	e8 50 fa ff ff       	call   80101600 <iunlock>
  iput(ip);
80101bb0:	89 34 24             	mov    %esi,(%esp)
80101bb3:	e8 88 fa ff ff       	call   80101640 <iput>
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101bb8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bbb:	89 c6                	mov    %eax,%esi
80101bbd:	e9 47 ff ff ff       	jmp    80101b09 <namex+0x41>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101bc2:	31 c9                	xor    %ecx,%ecx
80101bc4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101bc7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101bcb:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101bce:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101bd2:	89 3c 24             	mov    %edi,(%esp)
80101bd5:	e8 fe 23 00 00       	call   80103fd8 <memmove>
    name[len] = 0;
80101bda:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101bdd:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101be1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101be4:	89 d3                	mov    %edx,%ebx
80101be6:	e9 75 ff ff ff       	jmp    80101b60 <namex+0x98>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101beb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bee:	85 c0                	test   %eax,%eax
80101bf0:	75 4c                	jne    80101c3e <namex+0x176>
80101bf2:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101bf4:	83 c4 2c             	add    $0x2c,%esp
80101bf7:	5b                   	pop    %ebx
80101bf8:	5e                   	pop    %esi
80101bf9:	5f                   	pop    %edi
80101bfa:	5d                   	pop    %ebp
80101bfb:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101bfc:	89 34 24             	mov    %esi,(%esp)
80101bff:	e8 fc f9 ff ff       	call   80101600 <iunlock>
  iput(ip);
80101c04:	89 34 24             	mov    %esi,(%esp)
80101c07:	e8 34 fa ff ff       	call   80101640 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101c0c:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101c0e:	83 c4 2c             	add    $0x2c,%esp
80101c11:	5b                   	pop    %ebx
80101c12:	5e                   	pop    %esi
80101c13:	5f                   	pop    %edi
80101c14:	5d                   	pop    %ebp
80101c15:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101c16:	ba 01 00 00 00       	mov    $0x1,%edx
80101c1b:	b8 01 00 00 00       	mov    $0x1,%eax
80101c20:	e8 bb f4 ff ff       	call   801010e0 <iget>
80101c25:	89 c6                	mov    %eax,%esi
80101c27:	e9 dd fe ff ff       	jmp    80101b09 <namex+0x41>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101c2c:	89 34 24             	mov    %esi,(%esp)
80101c2f:	e8 cc f9 ff ff       	call   80101600 <iunlock>
      return ip;
80101c34:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101c36:	83 c4 2c             	add    $0x2c,%esp
80101c39:	5b                   	pop    %ebx
80101c3a:	5e                   	pop    %esi
80101c3b:	5f                   	pop    %edi
80101c3c:	5d                   	pop    %ebp
80101c3d:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101c3e:	89 34 24             	mov    %esi,(%esp)
80101c41:	e8 fa f9 ff ff       	call   80101640 <iput>
    return 0;
80101c46:	31 c0                	xor    %eax,%eax
80101c48:	eb aa                	jmp    80101bf4 <namex+0x12c>
80101c4a:	66 90                	xchg   %ax,%ax

80101c4c <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101c4c:	55                   	push   %ebp
80101c4d:	89 e5                	mov    %esp,%ebp
80101c4f:	57                   	push   %edi
80101c50:	56                   	push   %esi
80101c51:	53                   	push   %ebx
80101c52:	83 ec 2c             	sub    $0x2c,%esp
80101c55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101c58:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101c5f:	00 
80101c60:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c63:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c67:	89 1c 24             	mov    %ebx,(%esp)
80101c6a:	e8 a1 fd ff ff       	call   80101a10 <dirlookup>
80101c6f:	85 c0                	test   %eax,%eax
80101c71:	0f 85 87 00 00 00    	jne    80101cfe <dirlink+0xb2>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c77:	31 ff                	xor    %edi,%edi
80101c79:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c7c:	8b 53 58             	mov    0x58(%ebx),%edx
80101c7f:	85 d2                	test   %edx,%edx
80101c81:	75 0f                	jne    80101c92 <dirlink+0x46>
80101c83:	eb 31                	jmp    80101cb6 <dirlink+0x6a>
80101c85:	8d 76 00             	lea    0x0(%esi),%esi
80101c88:	8d 57 10             	lea    0x10(%edi),%edx
80101c8b:	89 d7                	mov    %edx,%edi
80101c8d:	39 53 58             	cmp    %edx,0x58(%ebx)
80101c90:	76 24                	jbe    80101cb6 <dirlink+0x6a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c92:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101c99:	00 
80101c9a:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101c9e:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ca2:	89 1c 24             	mov    %ebx,(%esp)
80101ca5:	e8 1e fb ff ff       	call   801017c8 <readi>
80101caa:	83 f8 10             	cmp    $0x10,%eax
80101cad:	75 5e                	jne    80101d0d <dirlink+0xc1>
      panic("dirlink read");
    if(de.inum == 0)
80101caf:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cb4:	75 d2                	jne    80101c88 <dirlink+0x3c>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101cb6:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101cbd:	00 
80101cbe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cc1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cc5:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cc8:	89 04 24             	mov    %eax,(%esp)
80101ccb:	e8 dc 23 00 00       	call   801040ac <strncpy>
  de.inum = inum;
80101cd0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cd3:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101cd7:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101cde:	00 
80101cdf:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ce3:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ce7:	89 1c 24             	mov    %ebx,(%esp)
80101cea:	e8 dd fb ff ff       	call   801018cc <writei>
80101cef:	83 f8 10             	cmp    $0x10,%eax
80101cf2:	75 25                	jne    80101d19 <dirlink+0xcd>
    panic("dirlink");

  return 0;
80101cf4:	31 c0                	xor    %eax,%eax
}
80101cf6:	83 c4 2c             	add    $0x2c,%esp
80101cf9:	5b                   	pop    %ebx
80101cfa:	5e                   	pop    %esi
80101cfb:	5f                   	pop    %edi
80101cfc:	5d                   	pop    %ebp
80101cfd:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101cfe:	89 04 24             	mov    %eax,(%esp)
80101d01:	e8 3a f9 ff ff       	call   80101640 <iput>
    return -1;
80101d06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d0b:	eb e9                	jmp    80101cf6 <dirlink+0xaa>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101d0d:	c7 04 24 a8 67 10 80 	movl   $0x801067a8,(%esp)
80101d14:	e8 fb e5 ff ff       	call   80100314 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101d19:	c7 04 24 9e 6d 10 80 	movl   $0x80106d9e,(%esp)
80101d20:	e8 ef e5 ff ff       	call   80100314 <panic>
80101d25:	8d 76 00             	lea    0x0(%esi),%esi

80101d28 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101d28:	55                   	push   %ebp
80101d29:	89 e5                	mov    %esp,%ebp
80101d2b:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101d2e:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101d31:	31 d2                	xor    %edx,%edx
80101d33:	8b 45 08             	mov    0x8(%ebp),%eax
80101d36:	e8 8d fd ff ff       	call   80101ac8 <namex>
}
80101d3b:	c9                   	leave  
80101d3c:	c3                   	ret    
80101d3d:	8d 76 00             	lea    0x0(%esi),%esi

80101d40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101d43:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101d46:	ba 01 00 00 00       	mov    $0x1,%edx
80101d4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101d4e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101d4f:	e9 74 fd ff ff       	jmp    80101ac8 <namex>

80101d54 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101d54:	55                   	push   %ebp
80101d55:	89 e5                	mov    %esp,%ebp
80101d57:	56                   	push   %esi
80101d58:	83 ec 14             	sub    $0x14,%esp
80101d5b:	89 c6                	mov    %eax,%esi
  if(b == 0)
80101d5d:	85 c0                	test   %eax,%eax
80101d5f:	0f 84 8a 00 00 00    	je     80101def <idestart+0x9b>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101d65:	8b 48 08             	mov    0x8(%eax),%ecx
80101d68:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101d6e:	77 73                	ja     80101de3 <idestart+0x8f>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d70:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101d75:	8d 76 00             	lea    0x0(%esi),%esi
80101d78:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101d79:	83 e0 c0             	and    $0xffffffc0,%eax
80101d7c:	3c 40                	cmp    $0x40,%al
80101d7e:	75 f8                	jne    80101d78 <idestart+0x24>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d80:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101d85:	31 c0                	xor    %eax,%eax
80101d87:	ee                   	out    %al,(%dx)
80101d88:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101d8d:	b0 01                	mov    $0x1,%al
80101d8f:	ee                   	out    %al,(%dx)
80101d90:	0f b6 c1             	movzbl %cl,%eax
80101d93:	b2 f3                	mov    $0xf3,%dl
80101d95:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101d96:	89 c8                	mov    %ecx,%eax
80101d98:	c1 f8 08             	sar    $0x8,%eax
80101d9b:	b2 f4                	mov    $0xf4,%dl
80101d9d:	ee                   	out    %al,(%dx)
80101d9e:	b2 f5                	mov    $0xf5,%dl
80101da0:	31 c0                	xor    %eax,%eax
80101da2:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101da3:	8a 46 04             	mov    0x4(%esi),%al
80101da6:	83 e0 01             	and    $0x1,%eax
80101da9:	c1 e0 04             	shl    $0x4,%eax
80101dac:	83 c8 e0             	or     $0xffffffe0,%eax
80101daf:	b2 f6                	mov    $0xf6,%dl
80101db1:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101db2:	f6 06 04             	testb  $0x4,(%esi)
80101db5:	75 11                	jne    80101dc8 <idestart+0x74>
80101db7:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101dbc:	b0 20                	mov    $0x20,%al
80101dbe:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101dbf:	83 c4 14             	add    $0x14,%esp
80101dc2:	5e                   	pop    %esi
80101dc3:	5d                   	pop    %ebp
80101dc4:	c3                   	ret    
80101dc5:	8d 76 00             	lea    0x0(%esi),%esi
80101dc8:	b2 f7                	mov    $0xf7,%dl
80101dca:	b0 30                	mov    $0x30,%al
80101dcc:	ee                   	out    %al,(%dx)
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101dcd:	83 c6 5c             	add    $0x5c,%esi
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101dd0:	b9 80 00 00 00       	mov    $0x80,%ecx
80101dd5:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101dda:	fc                   	cld    
80101ddb:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101ddd:	83 c4 14             	add    $0x14,%esp
80101de0:	5e                   	pop    %esi
80101de1:	5d                   	pop    %ebp
80101de2:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101de3:	c7 04 24 14 68 10 80 	movl   $0x80106814,(%esp)
80101dea:	e8 25 e5 ff ff       	call   80100314 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101def:	c7 04 24 0b 68 10 80 	movl   $0x8010680b,(%esp)
80101df6:	e8 19 e5 ff ff       	call   80100314 <panic>
80101dfb:	90                   	nop

80101dfc <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101dfc:	55                   	push   %ebp
80101dfd:	89 e5                	mov    %esp,%ebp
80101dff:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80101e02:	c7 44 24 04 26 68 10 	movl   $0x80106826,0x4(%esp)
80101e09:	80 
80101e0a:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80101e11:	e8 3e 1f 00 00       	call   80103d54 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101e16:	a1 44 2f 11 80       	mov    0x80112f44,%eax
80101e1b:	48                   	dec    %eax
80101e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e20:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101e27:	e8 4c 02 00 00       	call   80102078 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e2c:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101e31:	8d 76 00             	lea    0x0(%esi),%esi
80101e34:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101e35:	83 e0 c0             	and    $0xffffffc0,%eax
80101e38:	3c 40                	cmp    $0x40,%al
80101e3a:	75 f8                	jne    80101e34 <ideinit+0x38>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101e3c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101e41:	b0 f0                	mov    $0xf0,%al
80101e43:	ee                   	out    %al,(%dx)
80101e44:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e49:	b2 f7                	mov    $0xf7,%dl
80101e4b:	eb 06                	jmp    80101e53 <ideinit+0x57>
80101e4d:	8d 76 00             	lea    0x0(%esi),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80101e50:	49                   	dec    %ecx
80101e51:	74 0f                	je     80101e62 <ideinit+0x66>
80101e53:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101e54:	84 c0                	test   %al,%al
80101e56:	74 f8                	je     80101e50 <ideinit+0x54>
      havedisk1 = 1;
80101e58:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80101e5f:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101e62:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101e67:	b0 e0                	mov    $0xe0,%al
80101e69:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80101e6a:	c9                   	leave  
80101e6b:	c3                   	ret    

80101e6c <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80101e6c:	55                   	push   %ebp
80101e6d:	89 e5                	mov    %esp,%ebp
80101e6f:	57                   	push   %edi
80101e70:	56                   	push   %esi
80101e71:	53                   	push   %ebx
80101e72:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101e75:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80101e7c:	e8 9b 1f 00 00       	call   80103e1c <acquire>

  if((b = idequeue) == 0){
80101e81:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80101e87:	85 db                	test   %ebx,%ebx
80101e89:	74 30                	je     80101ebb <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101e8b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e8e:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101e93:	8b 33                	mov    (%ebx),%esi
80101e95:	f7 c6 04 00 00 00    	test   $0x4,%esi
80101e9b:	74 33                	je     80101ed0 <ideintr+0x64>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80101e9d:	83 e6 fb             	and    $0xfffffffb,%esi
80101ea0:	83 ce 02             	or     $0x2,%esi
80101ea3:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80101ea5:	89 1c 24             	mov    %ebx,(%esp)
80101ea8:	e8 37 1c 00 00       	call   80103ae4 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101ead:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80101eb2:	85 c0                	test   %eax,%eax
80101eb4:	74 05                	je     80101ebb <ideintr+0x4f>
    idestart(idequeue);
80101eb6:	e8 99 fe ff ff       	call   80101d54 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80101ebb:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80101ec2:	e8 2d 20 00 00       	call   80103ef4 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80101ec7:	83 c4 1c             	add    $0x1c,%esp
80101eca:	5b                   	pop    %ebx
80101ecb:	5e                   	pop    %esi
80101ecc:	5f                   	pop    %edi
80101ecd:	5d                   	pop    %ebp
80101ece:	c3                   	ret    
80101ecf:	90                   	nop
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ed0:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ed5:	8d 76 00             	lea    0x0(%esi),%esi
80101ed8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ed9:	88 c1                	mov    %al,%cl
80101edb:	83 e1 c0             	and    $0xffffffc0,%ecx
80101ede:	80 f9 40             	cmp    $0x40,%cl
80101ee1:	75 f5                	jne    80101ed8 <ideintr+0x6c>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101ee3:	a8 21                	test   $0x21,%al
80101ee5:	75 b6                	jne    80101e9d <ideintr+0x31>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80101ee7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80101eea:	b9 80 00 00 00       	mov    $0x80,%ecx
80101eef:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101ef4:	fc                   	cld    
80101ef5:	f3 6d                	rep insl (%dx),%es:(%edi)
80101ef7:	8b 33                	mov    (%ebx),%esi
80101ef9:	eb a2                	jmp    80101e9d <ideintr+0x31>
80101efb:	90                   	nop

80101efc <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80101efc:	55                   	push   %ebp
80101efd:	89 e5                	mov    %esp,%ebp
80101eff:	53                   	push   %ebx
80101f00:	83 ec 14             	sub    $0x14,%esp
80101f03:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80101f06:	8d 43 0c             	lea    0xc(%ebx),%eax
80101f09:	89 04 24             	mov    %eax,(%esp)
80101f0c:	e8 17 1e 00 00       	call   80103d28 <holdingsleep>
80101f11:	85 c0                	test   %eax,%eax
80101f13:	0f 84 9e 00 00 00    	je     80101fb7 <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80101f19:	8b 03                	mov    (%ebx),%eax
80101f1b:	83 e0 06             	and    $0x6,%eax
80101f1e:	83 f8 02             	cmp    $0x2,%eax
80101f21:	0f 84 a8 00 00 00    	je     80101fcf <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80101f27:	8b 53 04             	mov    0x4(%ebx),%edx
80101f2a:	85 d2                	test   %edx,%edx
80101f2c:	74 0d                	je     80101f3b <iderw+0x3f>
80101f2e:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 88 00 00 00    	je     80101fc3 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80101f3b:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80101f42:	e8 d5 1e 00 00       	call   80103e1c <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80101f47:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101f4e:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80101f53:	85 c0                	test   %eax,%eax
80101f55:	75 07                	jne    80101f5e <iderw+0x62>
80101f57:	eb 4e                	jmp    80101fa7 <iderw+0xab>
80101f59:	8d 76 00             	lea    0x0(%esi),%esi
80101f5c:	89 d0                	mov    %edx,%eax
80101f5e:	8b 50 58             	mov    0x58(%eax),%edx
80101f61:	85 d2                	test   %edx,%edx
80101f63:	75 f7                	jne    80101f5c <iderw+0x60>
80101f65:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
80101f68:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80101f6a:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80101f70:	74 3c                	je     80101fae <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101f72:	8b 03                	mov    (%ebx),%eax
80101f74:	83 e0 06             	and    $0x6,%eax
80101f77:	83 f8 02             	cmp    $0x2,%eax
80101f7a:	74 1a                	je     80101f96 <iderw+0x9a>
    sleep(b, &idelock);
80101f7c:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
80101f83:	80 
80101f84:	89 1c 24             	mov    %ebx,(%esp)
80101f87:	e8 dc 19 00 00       	call   80103968 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101f8c:	8b 13                	mov    (%ebx),%edx
80101f8e:	83 e2 06             	and    $0x6,%edx
80101f91:	83 fa 02             	cmp    $0x2,%edx
80101f94:	75 e6                	jne    80101f7c <iderw+0x80>
    sleep(b, &idelock);
  }


  release(&idelock);
80101f96:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80101f9d:	83 c4 14             	add    $0x14,%esp
80101fa0:	5b                   	pop    %ebx
80101fa1:	5d                   	pop    %ebp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80101fa2:	e9 4d 1f 00 00       	jmp    80103ef4 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101fa7:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
80101fac:	eb ba                	jmp    80101f68 <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80101fae:	89 d8                	mov    %ebx,%eax
80101fb0:	e8 9f fd ff ff       	call   80101d54 <idestart>
80101fb5:	eb bb                	jmp    80101f72 <iderw+0x76>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
80101fb7:	c7 04 24 2a 68 10 80 	movl   $0x8010682a,(%esp)
80101fbe:	e8 51 e3 ff ff       	call   80100314 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80101fc3:	c7 04 24 55 68 10 80 	movl   $0x80106855,(%esp)
80101fca:	e8 45 e3 ff ff       	call   80100314 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80101fcf:	c7 04 24 40 68 10 80 	movl   $0x80106840,(%esp)
80101fd6:	e8 39 e3 ff ff       	call   80100314 <panic>
80101fdb:	90                   	nop

80101fdc <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80101fdc:	55                   	push   %ebp
80101fdd:	89 e5                	mov    %esp,%ebp
80101fdf:	56                   	push   %esi
80101fe0:	53                   	push   %ebx
80101fe1:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80101fe4:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80101feb:	00 c0 fe 
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101fee:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80101ff5:	00 00 00 
  return ioapic->data;
80101ff8:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80101ffe:	8b 42 10             	mov    0x10(%edx),%eax
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102001:	c1 e8 10             	shr    $0x10,%eax
80102004:	0f b6 f0             	movzbl %al,%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102007:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010200d:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102013:	8b 43 10             	mov    0x10(%ebx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102016:	0f b6 15 80 29 11 80 	movzbl 0x80112980,%edx
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
8010201d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102020:	39 c2                	cmp    %eax,%edx
80102022:	74 12                	je     80102036 <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102024:	c7 04 24 74 68 10 80 	movl   $0x80106874,(%esp)
8010202b:	e8 94 e5 ff ff       	call   801005c4 <cprintf>
80102030:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102036:	ba 10 00 00 00       	mov    $0x10,%edx
8010203b:	31 c0                	xor    %eax,%eax
8010203d:	eb 03                	jmp    80102042 <ioapicinit+0x66>
8010203f:	90                   	nop
80102040:	89 cb                	mov    %ecx,%ebx
80102042:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102045:	81 c9 00 00 01 00    	or     $0x10000,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010204b:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010204d:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102053:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102056:	8d 4a 01             	lea    0x1(%edx),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102059:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
8010205b:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102061:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102068:	40                   	inc    %eax
80102069:	83 c2 02             	add    $0x2,%edx
8010206c:	39 c6                	cmp    %eax,%esi
8010206e:	7d d0                	jge    80102040 <ioapicinit+0x64>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102070:	83 c4 10             	add    $0x10,%esp
80102073:	5b                   	pop    %ebx
80102074:	5e                   	pop    %esi
80102075:	5d                   	pop    %ebp
80102076:	c3                   	ret    
80102077:	90                   	nop

80102078 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102078:	55                   	push   %ebp
80102079:	89 e5                	mov    %esp,%ebp
8010207b:	53                   	push   %ebx
8010207c:	8b 55 08             	mov    0x8(%ebp),%edx
8010207f:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102082:	8d 5a 20             	lea    0x20(%edx),%ebx
80102085:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102089:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010208f:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
80102091:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102097:	89 5a 10             	mov    %ebx,0x10(%edx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010209a:	c1 e0 18             	shl    $0x18,%eax
8010209d:	41                   	inc    %ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010209e:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801020a0:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801020a6:	89 42 10             	mov    %eax,0x10(%edx)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801020a9:	5b                   	pop    %ebx
801020aa:	5d                   	pop    %ebp
801020ab:	c3                   	ret    

801020ac <skfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
skfree(char *v)
{
801020ac:	55                   	push   %ebp
801020ad:	89 e5                	mov    %esp,%ebp
801020af:	53                   	push   %ebx
801020b0:	83 ec 14             	sub    $0x14,%esp
801020b3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801020b6:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801020bc:	75 78                	jne    80102136 <skfree+0x8a>
801020be:	81 fb e8 56 11 80    	cmp    $0x801156e8,%ebx
801020c4:	72 70                	jb     80102136 <skfree+0x8a>
801020c6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801020cc:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801020d1:	77 63                	ja     80102136 <skfree+0x8a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801020d3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801020da:	00 
801020db:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801020e2:	00 
801020e3:	89 1c 24             	mov    %ebx,(%esp)
801020e6:	e8 59 1e 00 00       	call   80103f44 <memset>

  if(kmem.use_lock)
801020eb:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801020f1:	85 d2                	test   %edx,%edx
801020f3:	75 33                	jne    80102128 <skfree+0x7c>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801020f5:	a1 78 26 11 80       	mov    0x80112678,%eax
801020fa:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
801020fc:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102102:	a1 74 26 11 80       	mov    0x80112674,%eax
80102107:	85 c0                	test   %eax,%eax
80102109:	75 09                	jne    80102114 <skfree+0x68>
    release(&kmem.lock);
}
8010210b:	83 c4 14             	add    $0x14,%esp
8010210e:	5b                   	pop    %ebx
8010210f:	5d                   	pop    %ebp
80102110:	c3                   	ret    
80102111:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102114:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010211b:	83 c4 14             	add    $0x14,%esp
8010211e:	5b                   	pop    %ebx
8010211f:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102120:	e9 cf 1d 00 00       	jmp    80103ef4 <release>
80102125:	8d 76 00             	lea    0x0(%esi),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102128:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010212f:	e8 e8 1c 00 00       	call   80103e1c <acquire>
80102134:	eb bf                	jmp    801020f5 <skfree+0x49>
skfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102136:	c7 04 24 a6 68 10 80 	movl   $0x801068a6,(%esp)
8010213d:	e8 d2 e1 ff ff       	call   80100314 <panic>
80102142:	66 90                	xchg   %ax,%ax

80102144 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102144:	55                   	push   %ebp
80102145:	89 e5                	mov    %esp,%ebp
80102147:	53                   	push   %ebx
80102148:	83 ec 14             	sub    $0x14,%esp
8010214b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!kmem.use_lock)
8010214e:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
80102154:	85 c9                	test   %ecx,%ecx
80102156:	0f 84 90 00 00 00    	je     801021ec <kfree+0xa8>
    return;
  }
  
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010215c:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102162:	0f 85 a2 00 00 00    	jne    8010220a <kfree+0xc6>
80102168:	81 fb e8 56 11 80    	cmp    $0x801156e8,%ebx
8010216e:	0f 82 96 00 00 00    	jb     8010220a <kfree+0xc6>
80102174:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010217a:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
8010217f:	0f 87 85 00 00 00    	ja     8010220a <kfree+0xc6>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102185:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010218c:	00 
8010218d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102194:	00 
80102195:	89 1c 24             	mov    %ebx,(%esp)
80102198:	e8 a7 1d 00 00       	call   80103f44 <memset>

  pushcli();
8010219d:	e8 42 1c 00 00       	call   80103de4 <pushcli>
  if(pkmem[cpuid()].count == PLIST_MAX)
801021a2:	e8 91 12 00 00       	call   80103438 <cpuid>
801021a7:	c1 e0 06             	shl    $0x6,%eax
801021aa:	83 b8 80 26 11 80 04 	cmpl   $0x4,-0x7feed980(%eax)
801021b1:	74 45                	je     801021f8 <kfree+0xb4>
    popcli();
    return;
  }

  r = (struct run*)v;
  r->next = pkmem[cpuid()].freelist;
801021b3:	e8 80 12 00 00       	call   80103438 <cpuid>
801021b8:	c1 e0 06             	shl    $0x6,%eax
801021bb:	8b 80 bc 26 11 80    	mov    -0x7feed944(%eax),%eax
801021c1:	89 03                	mov    %eax,(%ebx)
  pkmem[cpuid()].freelist = r;
801021c3:	e8 70 12 00 00       	call   80103438 <cpuid>
801021c8:	c1 e0 06             	shl    $0x6,%eax
801021cb:	89 98 bc 26 11 80    	mov    %ebx,-0x7feed944(%eax)
  pkmem[cpuid()].count++;
801021d1:	e8 62 12 00 00       	call   80103438 <cpuid>
801021d6:	c1 e0 06             	shl    $0x6,%eax
801021d9:	ff 80 80 26 11 80    	incl   -0x7feed980(%eax)
  popcli();

}
801021df:	83 c4 14             	add    $0x14,%esp
801021e2:	5b                   	pop    %ebx
801021e3:	5d                   	pop    %ebp

  r = (struct run*)v;
  r->next = pkmem[cpuid()].freelist;
  pkmem[cpuid()].freelist = r;
  pkmem[cpuid()].count++;
  popcli();
801021e4:	e9 a7 1c 00 00       	jmp    80103e90 <popcli>
801021e9:	8d 76 00             	lea    0x0(%esi),%esi

}
801021ec:	83 c4 14             	add    $0x14,%esp
801021ef:	5b                   	pop    %ebx
801021f0:	5d                   	pop    %ebp
void
kfree(char *v)
{
  if(!kmem.use_lock)
  {
    skfree(v);
801021f1:	e9 b6 fe ff ff       	jmp    801020ac <skfree>
801021f6:	66 90                	xchg   %ax,%ax
  memset(v, 1, PGSIZE);

  pushcli();
  if(pkmem[cpuid()].count == PLIST_MAX)
  {
    skfree(v);
801021f8:	89 1c 24             	mov    %ebx,(%esp)
801021fb:	e8 ac fe ff ff       	call   801020ac <skfree>
  r->next = pkmem[cpuid()].freelist;
  pkmem[cpuid()].freelist = r;
  pkmem[cpuid()].count++;
  popcli();

}
80102200:	83 c4 14             	add    $0x14,%esp
80102203:	5b                   	pop    %ebx
80102204:	5d                   	pop    %ebp

  pushcli();
  if(pkmem[cpuid()].count == PLIST_MAX)
  {
    skfree(v);
    popcli();
80102205:	e9 86 1c 00 00       	jmp    80103e90 <popcli>
  }
  
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
8010220a:	c7 04 24 a6 68 10 80 	movl   $0x801068a6,(%esp)
80102211:	e8 fe e0 ff ff       	call   80100314 <panic>
80102216:	66 90                	xchg   %ax,%ax

80102218 <freerange>:
  }
}

void
freerange(void *vstart, void *vend)
{
80102218:	55                   	push   %ebp
80102219:	89 e5                	mov    %esp,%ebp
8010221b:	56                   	push   %esi
8010221c:	53                   	push   %ebx
8010221d:	83 ec 10             	sub    $0x10,%esp
80102220:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102223:	8b 45 08             	mov    0x8(%ebp),%eax
80102226:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010222c:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102232:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102238:	39 de                	cmp    %ebx,%esi
8010223a:	73 08                	jae    80102244 <freerange+0x2c>
8010223c:	eb 18                	jmp    80102256 <freerange+0x3e>
8010223e:	66 90                	xchg   %ax,%ax
80102240:	89 da                	mov    %ebx,%edx
80102242:	89 c3                	mov    %eax,%ebx
    kfree(p);
80102244:	89 14 24             	mov    %edx,(%esp)
80102247:	e8 f8 fe ff ff       	call   80102144 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010224c:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
80102252:	39 f0                	cmp    %esi,%eax
80102254:	76 ea                	jbe    80102240 <freerange+0x28>
    kfree(p);
}
80102256:	83 c4 10             	add    $0x10,%esp
80102259:	5b                   	pop    %ebx
8010225a:	5e                   	pop    %esi
8010225b:	5d                   	pop    %ebp
8010225c:	c3                   	ret    
8010225d:	8d 76 00             	lea    0x0(%esi),%esi

80102260 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102260:	55                   	push   %ebp
80102261:	89 e5                	mov    %esp,%ebp
80102263:	56                   	push   %esi
80102264:	53                   	push   %ebx
80102265:	83 ec 10             	sub    $0x10,%esp
80102268:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010226b:	c7 44 24 04 ac 68 10 	movl   $0x801068ac,0x4(%esp)
80102272:	80 
80102273:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010227a:	e8 d5 1a 00 00       	call   80103d54 <initlock>
  kmem.use_lock = 0;
8010227f:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102286:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102289:	8b 45 08             	mov    0x8(%ebp),%eax
8010228c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102292:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102298:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010229e:	39 de                	cmp    %ebx,%esi
801022a0:	73 06                	jae    801022a8 <kinit1+0x48>
801022a2:	eb 16                	jmp    801022ba <kinit1+0x5a>
801022a4:	89 da                	mov    %ebx,%edx
801022a6:	89 c3                	mov    %eax,%ebx
    kfree(p);
801022a8:	89 14 24             	mov    %edx,(%esp)
801022ab:	e8 94 fe ff ff       	call   80102144 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022b0:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801022b6:	39 c6                	cmp    %eax,%esi
801022b8:	73 ea                	jae    801022a4 <kinit1+0x44>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801022ba:	83 c4 10             	add    $0x10,%esp
801022bd:	5b                   	pop    %ebx
801022be:	5e                   	pop    %esi
801022bf:	5d                   	pop    %ebp
801022c0:	c3                   	ret    
801022c1:	8d 76 00             	lea    0x0(%esi),%esi

801022c4 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801022c4:	55                   	push   %ebp
801022c5:	89 e5                	mov    %esp,%ebp
801022c7:	56                   	push   %esi
801022c8:	53                   	push   %ebx
801022c9:	83 ec 10             	sub    $0x10,%esp
801022cc:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801022cf:	8b 45 08             	mov    0x8(%ebp),%eax
801022d2:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801022d8:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022de:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801022e4:	39 de                	cmp    %ebx,%esi
801022e6:	73 08                	jae    801022f0 <kinit2+0x2c>
801022e8:	eb 18                	jmp    80102302 <kinit2+0x3e>
801022ea:	66 90                	xchg   %ax,%ax
801022ec:	89 da                	mov    %ebx,%edx
801022ee:	89 c3                	mov    %eax,%ebx
    kfree(p);
801022f0:	89 14 24             	mov    %edx,(%esp)
801022f3:	e8 4c fe ff ff       	call   80102144 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022f8:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801022fe:	39 c6                	cmp    %eax,%esi
80102300:	73 ea                	jae    801022ec <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102302:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102309:	00 00 00 
8010230c:	b8 80 26 11 80       	mov    $0x80112680,%eax
80102311:	8d 76 00             	lea    0x0(%esi),%esi
  int i;
  for (i=0 ; i<NCPU ; ++i)
  {
    pkmem[i].count = 0;
80102314:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010231a:	83 c0 40             	add    $0x40,%eax
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
  int i;
  for (i=0 ; i<NCPU ; ++i)
8010231d:	3d 80 28 11 80       	cmp    $0x80112880,%eax
80102322:	75 f0                	jne    80102314 <kinit2+0x50>
  {
    pkmem[i].count = 0;
  }
}
80102324:	83 c4 10             	add    $0x10,%esp
80102327:	5b                   	pop    %ebx
80102328:	5e                   	pop    %esi
80102329:	5d                   	pop    %ebp
8010232a:	c3                   	ret    
8010232b:	90                   	nop

8010232c <skalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
skalloc(void)
{
8010232c:	55                   	push   %ebp
8010232d:	89 e5                	mov    %esp,%ebp
8010232f:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102332:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102338:	85 d2                	test   %edx,%edx
8010233a:	75 2c                	jne    80102368 <skalloc+0x3c>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010233c:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
80102341:	85 c0                	test   %eax,%eax
80102343:	74 08                	je     8010234d <skalloc+0x21>
    kmem.freelist = r->next;
80102345:	8b 08                	mov    (%eax),%ecx
80102347:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
8010234d:	85 d2                	test   %edx,%edx
8010234f:	75 03                	jne    80102354 <skalloc+0x28>
    release(&kmem.lock);
  return (char*)r;
}
80102351:	c9                   	leave  
80102352:	c3                   	ret    
80102353:	90                   	nop
80102354:	89 45 f4             	mov    %eax,-0xc(%ebp)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  if(kmem.use_lock)
    release(&kmem.lock);
80102357:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010235e:	e8 91 1b 00 00       	call   80103ef4 <release>
80102363:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return (char*)r;
}
80102366:	c9                   	leave  
80102367:	c3                   	ret    
skalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102368:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010236f:	e8 a8 1a 00 00       	call   80103e1c <acquire>
80102374:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010237a:	eb c0                	jmp    8010233c <skalloc+0x10>

8010237c <kalloc>:
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  if(!kmem.use_lock)
8010237c:	a1 74 26 11 80       	mov    0x80112674,%eax
80102381:	85 c0                	test   %eax,%eax
80102383:	0f 84 87 00 00 00    	je     80102410 <kalloc+0x94>
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102389:	55                   	push   %ebp
8010238a:	89 e5                	mov    %esp,%ebp
8010238c:	56                   	push   %esi
8010238d:	53                   	push   %ebx
8010238e:	83 ec 10             	sub    $0x10,%esp

  struct run *r;
  
  
  
  pushcli();
80102391:	e8 4e 1a 00 00       	call   80103de4 <pushcli>
  if(pkmem[cpuid()].count <= PLIST_MIN)
80102396:	e8 9d 10 00 00       	call   80103438 <cpuid>
8010239b:	c1 e0 06             	shl    $0x6,%eax
8010239e:	83 b8 80 26 11 80 04 	cmpl   $0x4,-0x7feed980(%eax)
801023a5:	7f 2b                	jg     801023d2 <kalloc+0x56>
801023a7:	31 db                	xor    %ebx,%ebx
  {
    int i;
    for (i =0 ; i< PLIST_MIN - pkmem[cpuid()].count ; ++i)
801023a9:	be 04 00 00 00       	mov    $0x4,%esi
801023ae:	eb 0e                	jmp    801023be <kalloc+0x42>
    {
      r = (struct run*)skalloc();
801023b0:	e8 77 ff ff ff       	call   8010232c <skalloc>
      kfree((char*)r);
801023b5:	89 04 24             	mov    %eax,(%esp)
801023b8:	e8 87 fd ff ff       	call   80102144 <kfree>
  
  pushcli();
  if(pkmem[cpuid()].count <= PLIST_MIN)
  {
    int i;
    for (i =0 ; i< PLIST_MIN - pkmem[cpuid()].count ; ++i)
801023bd:	43                   	inc    %ebx
801023be:	e8 75 10 00 00       	call   80103438 <cpuid>
801023c3:	c1 e0 06             	shl    $0x6,%eax
801023c6:	89 f1                	mov    %esi,%ecx
801023c8:	2b 88 80 26 11 80    	sub    -0x7feed980(%eax),%ecx
801023ce:	39 cb                	cmp    %ecx,%ebx
801023d0:	7c de                	jl     801023b0 <kalloc+0x34>
      r = (struct run*)skalloc();
      kfree((char*)r);
    }
  }

  r = pkmem[cpuid()].freelist;
801023d2:	e8 61 10 00 00       	call   80103438 <cpuid>
801023d7:	c1 e0 06             	shl    $0x6,%eax
801023da:	8b 98 bc 26 11 80    	mov    -0x7feed944(%eax),%ebx
  if(r)
801023e0:	85 db                	test   %ebx,%ebx
801023e2:	74 1e                	je     80102402 <kalloc+0x86>
  {
    pkmem[cpuid()].count--;
801023e4:	e8 4f 10 00 00       	call   80103438 <cpuid>
801023e9:	c1 e0 06             	shl    $0x6,%eax
801023ec:	ff 88 80 26 11 80    	decl   -0x7feed980(%eax)
    pkmem[cpuid()].freelist = r->next;
801023f2:	e8 41 10 00 00       	call   80103438 <cpuid>
801023f7:	8b 13                	mov    (%ebx),%edx
801023f9:	c1 e0 06             	shl    $0x6,%eax
801023fc:	89 90 bc 26 11 80    	mov    %edx,-0x7feed944(%eax)
  }
    

  popcli();
80102402:	e8 89 1a 00 00       	call   80103e90 <popcli>
  return (char*)r;
80102407:	89 d8                	mov    %ebx,%eax
80102409:	83 c4 10             	add    $0x10,%esp
8010240c:	5b                   	pop    %ebx
8010240d:	5e                   	pop    %esi
8010240e:	5d                   	pop    %ebp
8010240f:	c3                   	ret    
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  if(!kmem.use_lock)
    return skalloc();
80102410:	e9 17 ff ff ff       	jmp    8010232c <skalloc>
80102415:	66 90                	xchg   %ax,%ax
80102417:	90                   	nop

80102418 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102418:	55                   	push   %ebp
80102419:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010241b:	ba 64 00 00 00       	mov    $0x64,%edx
80102420:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102421:	a8 01                	test   $0x1,%al
80102423:	0f 84 af 00 00 00    	je     801024d8 <kbdgetc+0xc0>
80102429:	b2 60                	mov    $0x60,%dl
8010242b:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010242c:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
8010242f:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
80102435:	0f 84 81 00 00 00    	je     801024bc <kbdgetc+0xa4>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010243b:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102441:	84 c0                	test   %al,%al
80102443:	79 23                	jns    80102468 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102445:	f6 c2 40             	test   $0x40,%dl
80102448:	75 05                	jne    8010244f <kbdgetc+0x37>
8010244a:	89 c1                	mov    %eax,%ecx
8010244c:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
8010244f:	8a 81 e0 69 10 80    	mov    -0x7fef9620(%ecx),%al
80102455:	83 c8 40             	or     $0x40,%eax
80102458:	0f b6 c0             	movzbl %al,%eax
8010245b:	f7 d0                	not    %eax
8010245d:	21 d0                	and    %edx,%eax
8010245f:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
80102464:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102466:	5d                   	pop    %ebp
80102467:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102468:	f6 c2 40             	test   $0x40,%dl
8010246b:	75 3f                	jne    801024ac <kbdgetc+0x94>
8010246d:	89 d0                	mov    %edx,%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
8010246f:	0f b6 91 e0 69 10 80 	movzbl -0x7fef9620(%ecx),%edx
80102476:	09 c2                	or     %eax,%edx
  shift ^= togglecode[data];
80102478:	0f b6 81 e0 68 10 80 	movzbl -0x7fef9720(%ecx),%eax
8010247f:	31 c2                	xor    %eax,%edx
80102481:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102487:	89 d0                	mov    %edx,%eax
80102489:	83 e0 03             	and    $0x3,%eax
8010248c:	8b 04 85 c0 68 10 80 	mov    -0x7fef9740(,%eax,4),%eax
80102493:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102497:	83 e2 08             	and    $0x8,%edx
8010249a:	74 ca                	je     80102466 <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010249c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010249f:	83 fa 19             	cmp    $0x19,%edx
801024a2:	77 24                	ja     801024c8 <kbdgetc+0xb0>
      c += 'A' - 'a';
801024a4:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801024a7:	5d                   	pop    %ebp
801024a8:	c3                   	ret    
801024a9:	8d 76 00             	lea    0x0(%esi),%esi
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801024ac:	83 c8 80             	or     $0xffffff80,%eax
801024af:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
801024b2:	89 d0                	mov    %edx,%eax
801024b4:	83 e0 bf             	and    $0xffffffbf,%eax
801024b7:	eb b6                	jmp    8010246f <kbdgetc+0x57>
801024b9:	8d 76 00             	lea    0x0(%esi),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801024bc:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801024c3:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801024c5:	5d                   	pop    %ebp
801024c6:	c3                   	ret    
801024c7:	90                   	nop
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801024c8:	8d 50 bf             	lea    -0x41(%eax),%edx
801024cb:	83 fa 19             	cmp    $0x19,%edx
801024ce:	77 96                	ja     80102466 <kbdgetc+0x4e>
      c += 'a' - 'A';
801024d0:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret    
801024d5:	8d 76 00             	lea    0x0(%esi),%esi
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801024d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801024dd:	5d                   	pop    %ebp
801024de:	c3                   	ret    
801024df:	90                   	nop

801024e0 <kbdintr>:

void
kbdintr(void)
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801024e6:	c7 04 24 18 24 10 80 	movl   $0x80102418,(%esp)
801024ed:	e8 1a e2 ff ff       	call   8010070c <consoleintr>
}
801024f2:	c9                   	leave  
801024f3:	c3                   	ret    

801024f4 <fill_rtcdate>:

  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
801024f4:	55                   	push   %ebp
801024f5:	89 e5                	mov    %esp,%ebp
801024f7:	89 c1                	mov    %eax,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024f9:	ba 70 00 00 00       	mov    $0x70,%edx
801024fe:	31 c0                	xor    %eax,%eax
80102500:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102501:	b2 71                	mov    $0x71,%dl
80102503:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
80102504:	0f b6 c0             	movzbl %al,%eax
80102507:	89 01                	mov    %eax,(%ecx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102509:	b2 70                	mov    $0x70,%dl
8010250b:	b0 02                	mov    $0x2,%al
8010250d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010250e:	b2 71                	mov    $0x71,%dl
80102510:	ec                   	in     (%dx),%al
80102511:	0f b6 c0             	movzbl %al,%eax
80102514:	89 41 04             	mov    %eax,0x4(%ecx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102517:	b2 70                	mov    $0x70,%dl
80102519:	b0 04                	mov    $0x4,%al
8010251b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010251c:	b2 71                	mov    $0x71,%dl
8010251e:	ec                   	in     (%dx),%al
8010251f:	0f b6 c0             	movzbl %al,%eax
80102522:	89 41 08             	mov    %eax,0x8(%ecx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102525:	b2 70                	mov    $0x70,%dl
80102527:	b0 07                	mov    $0x7,%al
80102529:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010252a:	b2 71                	mov    $0x71,%dl
8010252c:	ec                   	in     (%dx),%al
8010252d:	0f b6 c0             	movzbl %al,%eax
80102530:	89 41 0c             	mov    %eax,0xc(%ecx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102533:	b2 70                	mov    $0x70,%dl
80102535:	b0 08                	mov    $0x8,%al
80102537:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102538:	b2 71                	mov    $0x71,%dl
8010253a:	ec                   	in     (%dx),%al
8010253b:	0f b6 c0             	movzbl %al,%eax
8010253e:	89 41 10             	mov    %eax,0x10(%ecx)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102541:	b2 70                	mov    $0x70,%dl
80102543:	b0 09                	mov    $0x9,%al
80102545:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102546:	b2 71                	mov    $0x71,%dl
80102548:	ec                   	in     (%dx),%al
80102549:	0f b6 c0             	movzbl %al,%eax
8010254c:	89 41 14             	mov    %eax,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
8010254f:	5d                   	pop    %ebp
80102550:	c3                   	ret    
80102551:	8d 76 00             	lea    0x0(%esi),%esi

80102554 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102554:	55                   	push   %ebp
80102555:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102557:	a1 80 28 11 80       	mov    0x80112880,%eax
8010255c:	85 c0                	test   %eax,%eax
8010255e:	0f 84 c0 00 00 00    	je     80102624 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102564:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
8010256b:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010256e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102571:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102578:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010257b:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010257e:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102585:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102588:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010258b:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102592:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102595:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102598:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010259f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025a2:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025a5:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801025ac:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025af:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801025b2:	8b 50 30             	mov    0x30(%eax),%edx
801025b5:	c1 ea 10             	shr    $0x10,%edx
801025b8:	80 fa 03             	cmp    $0x3,%dl
801025bb:	77 6b                	ja     80102628 <lapicinit+0xd4>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025bd:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801025c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025c7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025ca:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801025d1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025d4:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025d7:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801025de:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025e1:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025e4:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801025eb:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025ee:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025f1:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801025f8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025fb:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025fe:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102605:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102608:	8b 50 20             	mov    0x20(%eax),%edx
8010260b:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
8010260c:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102612:	80 e6 10             	and    $0x10,%dh
80102615:	75 f5                	jne    8010260c <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102617:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010261e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102621:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102624:	5d                   	pop    %ebp
80102625:	c3                   	ret    
80102626:	66 90                	xchg   %ax,%ax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102628:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010262f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102632:	8b 50 20             	mov    0x20(%eax),%edx
80102635:	eb 86                	jmp    801025bd <lapicinit+0x69>
80102637:	90                   	nop

80102638 <lapicid>:
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102638:	55                   	push   %ebp
80102639:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010263b:	a1 80 28 11 80       	mov    0x80112880,%eax
80102640:	85 c0                	test   %eax,%eax
80102642:	74 08                	je     8010264c <lapicid+0x14>
    return 0;
  return lapic[ID] >> 24;
80102644:	8b 40 20             	mov    0x20(%eax),%eax
80102647:	c1 e8 18             	shr    $0x18,%eax
}
8010264a:	5d                   	pop    %ebp
8010264b:	c3                   	ret    

int
lapicid(void)
{
  if (!lapic)
    return 0;
8010264c:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010264e:	5d                   	pop    %ebp
8010264f:	c3                   	ret    

80102650 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102653:	a1 80 28 11 80       	mov    0x80112880,%eax
80102658:	85 c0                	test   %eax,%eax
8010265a:	74 0d                	je     80102669 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010265c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102663:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102666:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102669:	5d                   	pop    %ebp
8010266a:	c3                   	ret    
8010266b:	90                   	nop

8010266c <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
8010266c:	55                   	push   %ebp
8010266d:	89 e5                	mov    %esp,%ebp
}
8010266f:	5d                   	pop    %ebp
80102670:	c3                   	ret    
80102671:	8d 76 00             	lea    0x0(%esi),%esi

80102674 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102674:	55                   	push   %ebp
80102675:	89 e5                	mov    %esp,%ebp
80102677:	53                   	push   %ebx
80102678:	8b 4d 08             	mov    0x8(%ebp),%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010267b:	ba 70 00 00 00       	mov    $0x70,%edx
80102680:	b0 0f                	mov    $0xf,%al
80102682:	ee                   	out    %al,(%dx)
80102683:	b2 71                	mov    $0x71,%dl
80102685:	b0 0a                	mov    $0xa,%al
80102687:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102688:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
8010268f:	00 00 
  wrv[1] = addr >> 4;
80102691:	8b 45 0c             	mov    0xc(%ebp),%eax
80102694:	c1 e8 04             	shr    $0x4,%eax
80102697:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269d:	a1 80 28 11 80       	mov    0x80112880,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801026a2:	c1 e1 18             	shl    $0x18,%ecx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a5:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ae:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801026b5:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b8:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026bb:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801026c2:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c5:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c8:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026ce:	8b 50 20             	mov    0x20(%eax),%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801026d1:	8b 55 0c             	mov    0xc(%ebp),%edx
801026d4:	c1 ea 0c             	shr    $0xc,%edx
801026d7:	80 ce 06             	or     $0x6,%dh

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026da:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026e0:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e3:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026e9:	8b 48 20             	mov    0x20(%eax),%ecx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ec:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801026f2:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801026f5:	5b                   	pop    %ebx
801026f6:	5d                   	pop    %ebp
801026f7:	c3                   	ret    

801026f8 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801026f8:	55                   	push   %ebp
801026f9:	89 e5                	mov    %esp,%ebp
801026fb:	57                   	push   %edi
801026fc:	56                   	push   %esi
801026fd:	53                   	push   %ebx
801026fe:	83 ec 4c             	sub    $0x4c,%esp
80102701:	ba 70 00 00 00       	mov    $0x70,%edx
80102706:	b0 0b                	mov    $0xb,%al
80102708:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102709:	b2 71                	mov    $0x71,%dl
8010270b:	ec                   	in     (%dx),%al
8010270c:	88 45 b7             	mov    %al,-0x49(%ebp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010270f:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102713:	8d 75 b8             	lea    -0x48(%ebp),%esi
80102716:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102719:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010271c:	bb 70 00 00 00       	mov    $0x70,%ebx

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80102721:	89 f0                	mov    %esi,%eax
80102723:	e8 cc fd ff ff       	call   801024f4 <fill_rtcdate>
80102728:	b0 0a                	mov    $0xa,%al
8010272a:	89 da                	mov    %ebx,%edx
8010272c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010272d:	ba 71 00 00 00       	mov    $0x71,%edx
80102732:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102733:	84 c0                	test   %al,%al
80102735:	78 ea                	js     80102721 <cmostime+0x29>
        continue;
    fill_rtcdate(&t2);
80102737:	89 f8                	mov    %edi,%eax
80102739:	e8 b6 fd ff ff       	call   801024f4 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010273e:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80102745:	00 
80102746:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010274a:	89 34 24             	mov    %esi,(%esp)
8010274d:	e8 3e 18 00 00       	call   80103f90 <memcmp>
80102752:	85 c0                	test   %eax,%eax
80102754:	75 c6                	jne    8010271c <cmostime+0x24>
      break;
  }

  // convert
  if(bcd) {
80102756:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
8010275a:	75 78                	jne    801027d4 <cmostime+0xdc>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010275c:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010275f:	89 c2                	mov    %eax,%edx
80102761:	c1 ea 04             	shr    $0x4,%edx
80102764:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102767:	83 e0 0f             	and    $0xf,%eax
8010276a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010276d:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102770:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102773:	89 c2                	mov    %eax,%edx
80102775:	c1 ea 04             	shr    $0x4,%edx
80102778:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010277b:	83 e0 0f             	and    $0xf,%eax
8010277e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102781:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102784:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102787:	89 c2                	mov    %eax,%edx
80102789:	c1 ea 04             	shr    $0x4,%edx
8010278c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010278f:	83 e0 0f             	and    $0xf,%eax
80102792:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102795:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102798:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010279b:	89 c2                	mov    %eax,%edx
8010279d:	c1 ea 04             	shr    $0x4,%edx
801027a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801027a3:	83 e0 0f             	and    $0xf,%eax
801027a6:	8d 04 50             	lea    (%eax,%edx,2),%eax
801027a9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801027ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
801027af:	89 c2                	mov    %eax,%edx
801027b1:	c1 ea 04             	shr    $0x4,%edx
801027b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801027b7:	83 e0 0f             	and    $0xf,%eax
801027ba:	8d 04 50             	lea    (%eax,%edx,2),%eax
801027bd:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801027c0:	8b 45 cc             	mov    -0x34(%ebp),%eax
801027c3:	89 c2                	mov    %eax,%edx
801027c5:	c1 ea 04             	shr    $0x4,%edx
801027c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801027cb:	83 e0 0f             	and    $0xf,%eax
801027ce:	8d 04 50             	lea    (%eax,%edx,2),%eax
801027d1:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801027d4:	b9 06 00 00 00       	mov    $0x6,%ecx
801027d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801027dc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
801027de:	8b 45 08             	mov    0x8(%ebp),%eax
801027e1:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
801027e8:	83 c4 4c             	add    $0x4c,%esp
801027eb:	5b                   	pop    %ebx
801027ec:	5e                   	pop    %esi
801027ed:	5f                   	pop    %edi
801027ee:	5d                   	pop    %ebp
801027ef:	c3                   	ret    

801027f0 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801027f0:	55                   	push   %ebp
801027f1:	89 e5                	mov    %esp,%ebp
801027f3:	57                   	push   %edi
801027f4:	56                   	push   %esi
801027f5:	53                   	push   %ebx
801027f6:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801027f9:	31 db                	xor    %ebx,%ebx
801027fb:	a1 e8 28 11 80       	mov    0x801128e8,%eax
80102800:	85 c0                	test   %eax,%eax
80102802:	7e 70                	jle    80102874 <install_trans+0x84>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102804:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102809:	01 d8                	add    %ebx,%eax
8010280b:	40                   	inc    %eax
8010280c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102810:	a1 e4 28 11 80       	mov    0x801128e4,%eax
80102815:	89 04 24             	mov    %eax,(%esp)
80102818:	e8 97 d8 ff ff       	call   801000b4 <bread>
8010281d:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010281f:	8b 04 9d ec 28 11 80 	mov    -0x7feed714(,%ebx,4),%eax
80102826:	89 44 24 04          	mov    %eax,0x4(%esp)
8010282a:	a1 e4 28 11 80       	mov    0x801128e4,%eax
8010282f:	89 04 24             	mov    %eax,(%esp)
80102832:	e8 7d d8 ff ff       	call   801000b4 <bread>
80102837:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102839:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102840:	00 
80102841:	8d 47 5c             	lea    0x5c(%edi),%eax
80102844:	89 44 24 04          	mov    %eax,0x4(%esp)
80102848:	8d 46 5c             	lea    0x5c(%esi),%eax
8010284b:	89 04 24             	mov    %eax,(%esp)
8010284e:	e8 85 17 00 00       	call   80103fd8 <memmove>
    bwrite(dbuf);  // write dst to disk
80102853:	89 34 24             	mov    %esi,(%esp)
80102856:	e8 1d d9 ff ff       	call   80100178 <bwrite>
    brelse(lbuf);
8010285b:	89 3c 24             	mov    %edi,(%esp)
8010285e:	e8 4d d9 ff ff       	call   801001b0 <brelse>
    brelse(dbuf);
80102863:	89 34 24             	mov    %esi,(%esp)
80102866:	e8 45 d9 ff ff       	call   801001b0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010286b:	43                   	inc    %ebx
8010286c:	39 1d e8 28 11 80    	cmp    %ebx,0x801128e8
80102872:	7f 90                	jg     80102804 <install_trans+0x14>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102874:	83 c4 1c             	add    $0x1c,%esp
80102877:	5b                   	pop    %ebx
80102878:	5e                   	pop    %esi
80102879:	5f                   	pop    %edi
8010287a:	5d                   	pop    %ebp
8010287b:	c3                   	ret    

8010287c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010287c:	55                   	push   %ebp
8010287d:	89 e5                	mov    %esp,%ebp
8010287f:	57                   	push   %edi
80102880:	56                   	push   %esi
80102881:	53                   	push   %ebx
80102882:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102885:	a1 d4 28 11 80       	mov    0x801128d4,%eax
8010288a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010288e:	a1 e4 28 11 80       	mov    0x801128e4,%eax
80102893:	89 04 24             	mov    %eax,(%esp)
80102896:	e8 19 d8 ff ff       	call   801000b4 <bread>
8010289b:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
8010289d:	8b 1d e8 28 11 80    	mov    0x801128e8,%ebx
801028a3:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
801028a6:	85 db                	test   %ebx,%ebx
801028a8:	7e 16                	jle    801028c0 <write_head+0x44>
801028aa:	31 d2                	xor    %edx,%edx
801028ac:	8d 70 5c             	lea    0x5c(%eax),%esi
801028af:	90                   	nop
    hb->block[i] = log.lh.block[i];
801028b0:	8b 0c 95 ec 28 11 80 	mov    -0x7feed714(,%edx,4),%ecx
801028b7:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801028bb:	42                   	inc    %edx
801028bc:	39 da                	cmp    %ebx,%edx
801028be:	75 f0                	jne    801028b0 <write_head+0x34>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801028c0:	89 3c 24             	mov    %edi,(%esp)
801028c3:	e8 b0 d8 ff ff       	call   80100178 <bwrite>
  brelse(buf);
801028c8:	89 3c 24             	mov    %edi,(%esp)
801028cb:	e8 e0 d8 ff ff       	call   801001b0 <brelse>
}
801028d0:	83 c4 1c             	add    $0x1c,%esp
801028d3:	5b                   	pop    %ebx
801028d4:	5e                   	pop    %esi
801028d5:	5f                   	pop    %edi
801028d6:	5d                   	pop    %ebp
801028d7:	c3                   	ret    

801028d8 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801028d8:	55                   	push   %ebp
801028d9:	89 e5                	mov    %esp,%ebp
801028db:	56                   	push   %esi
801028dc:	53                   	push   %ebx
801028dd:	83 ec 30             	sub    $0x30,%esp
801028e0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801028e3:	c7 44 24 04 e0 6a 10 	movl   $0x80106ae0,0x4(%esp)
801028ea:	80 
801028eb:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
801028f2:	e8 5d 14 00 00       	call   80103d54 <initlock>
  readsb(dev, &sb);
801028f7:	8d 45 dc             	lea    -0x24(%ebp),%eax
801028fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801028fe:	89 1c 24             	mov    %ebx,(%esp)
80102901:	e8 3a e9 ff ff       	call   80101240 <readsb>
  log.start = sb.logstart;
80102906:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102909:	a3 d4 28 11 80       	mov    %eax,0x801128d4
  log.size = sb.nlog;
8010290e:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102911:	89 15 d8 28 11 80    	mov    %edx,0x801128d8
  log.dev = dev;
80102917:	89 1d e4 28 11 80    	mov    %ebx,0x801128e4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
8010291d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102921:	89 1c 24             	mov    %ebx,(%esp)
80102924:	e8 8b d7 ff ff       	call   801000b4 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102929:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010292c:	89 1d e8 28 11 80    	mov    %ebx,0x801128e8
  for (i = 0; i < log.lh.n; i++) {
80102932:	85 db                	test   %ebx,%ebx
80102934:	7e 16                	jle    8010294c <initlog+0x74>
80102936:	31 d2                	xor    %edx,%edx
80102938:	8d 70 5c             	lea    0x5c(%eax),%esi
8010293b:	90                   	nop
    log.lh.block[i] = lh->block[i];
8010293c:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102940:	89 0c 95 ec 28 11 80 	mov    %ecx,-0x7feed714(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102947:	42                   	inc    %edx
80102948:	39 da                	cmp    %ebx,%edx
8010294a:	75 f0                	jne    8010293c <initlog+0x64>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
8010294c:	89 04 24             	mov    %eax,(%esp)
8010294f:	e8 5c d8 ff ff       	call   801001b0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102954:	e8 97 fe ff ff       	call   801027f0 <install_trans>
  log.lh.n = 0;
80102959:	c7 05 e8 28 11 80 00 	movl   $0x0,0x801128e8
80102960:	00 00 00 
  write_head(); // clear the log
80102963:	e8 14 ff ff ff       	call   8010287c <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102968:	83 c4 30             	add    $0x30,%esp
8010296b:	5b                   	pop    %ebx
8010296c:	5e                   	pop    %esi
8010296d:	5d                   	pop    %ebp
8010296e:	c3                   	ret    
8010296f:	90                   	nop

80102970 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102970:	55                   	push   %ebp
80102971:	89 e5                	mov    %esp,%ebp
80102973:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102976:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
8010297d:	e8 9a 14 00 00       	call   80103e1c <acquire>
80102982:	eb 14                	jmp    80102998 <begin_op+0x28>
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102984:	c7 44 24 04 a0 28 11 	movl   $0x801128a0,0x4(%esp)
8010298b:	80 
8010298c:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
80102993:	e8 d0 0f 00 00       	call   80103968 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102998:	8b 15 e0 28 11 80    	mov    0x801128e0,%edx
8010299e:	85 d2                	test   %edx,%edx
801029a0:	75 e2                	jne    80102984 <begin_op+0x14>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801029a2:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801029a7:	8d 50 01             	lea    0x1(%eax),%edx
801029aa:	8d 04 92             	lea    (%edx,%edx,4),%eax
801029ad:	01 c0                	add    %eax,%eax
801029af:	03 05 e8 28 11 80    	add    0x801128e8,%eax
801029b5:	83 f8 1e             	cmp    $0x1e,%eax
801029b8:	7f ca                	jg     80102984 <begin_op+0x14>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
801029ba:	89 15 dc 28 11 80    	mov    %edx,0x801128dc
      release(&log.lock);
801029c0:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
801029c7:	e8 28 15 00 00       	call   80103ef4 <release>
      break;
    }
  }
}
801029cc:	c9                   	leave  
801029cd:	c3                   	ret    
801029ce:	66 90                	xchg   %ax,%ax

801029d0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	57                   	push   %edi
801029d4:	56                   	push   %esi
801029d5:	53                   	push   %ebx
801029d6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
801029d9:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
801029e0:	e8 37 14 00 00       	call   80103e1c <acquire>
  log.outstanding -= 1;
801029e5:	a1 dc 28 11 80       	mov    0x801128dc,%eax
801029ea:	48                   	dec    %eax
801029eb:	a3 dc 28 11 80       	mov    %eax,0x801128dc
  if(log.committing)
801029f0:	8b 1d e0 28 11 80    	mov    0x801128e0,%ebx
801029f6:	85 db                	test   %ebx,%ebx
801029f8:	0f 85 ed 00 00 00    	jne    80102aeb <end_op+0x11b>
    panic("log.committing");
  if(log.outstanding == 0){
801029fe:	85 c0                	test   %eax,%eax
80102a00:	0f 85 c5 00 00 00    	jne    80102acb <end_op+0xfb>
    do_commit = 1;
    log.committing = 1;
80102a06:	c7 05 e0 28 11 80 01 	movl   $0x1,0x801128e0
80102a0d:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102a10:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
80102a17:	e8 d8 14 00 00       	call   80103ef4 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102a1c:	8b 0d e8 28 11 80    	mov    0x801128e8,%ecx
80102a22:	85 c9                	test   %ecx,%ecx
80102a24:	0f 8e 8b 00 00 00    	jle    80102ab5 <end_op+0xe5>
80102a2a:	31 db                	xor    %ebx,%ebx
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102a2c:	a1 d4 28 11 80       	mov    0x801128d4,%eax
80102a31:	01 d8                	add    %ebx,%eax
80102a33:	40                   	inc    %eax
80102a34:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a38:	a1 e4 28 11 80       	mov    0x801128e4,%eax
80102a3d:	89 04 24             	mov    %eax,(%esp)
80102a40:	e8 6f d6 ff ff       	call   801000b4 <bread>
80102a45:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102a47:	8b 04 9d ec 28 11 80 	mov    -0x7feed714(,%ebx,4),%eax
80102a4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a52:	a1 e4 28 11 80       	mov    0x801128e4,%eax
80102a57:	89 04 24             	mov    %eax,(%esp)
80102a5a:	e8 55 d6 ff ff       	call   801000b4 <bread>
80102a5f:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102a61:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102a68:	00 
80102a69:	8d 40 5c             	lea    0x5c(%eax),%eax
80102a6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a73:	89 04 24             	mov    %eax,(%esp)
80102a76:	e8 5d 15 00 00       	call   80103fd8 <memmove>
    bwrite(to);  // write the log
80102a7b:	89 34 24             	mov    %esi,(%esp)
80102a7e:	e8 f5 d6 ff ff       	call   80100178 <bwrite>
    brelse(from);
80102a83:	89 3c 24             	mov    %edi,(%esp)
80102a86:	e8 25 d7 ff ff       	call   801001b0 <brelse>
    brelse(to);
80102a8b:	89 34 24             	mov    %esi,(%esp)
80102a8e:	e8 1d d7 ff ff       	call   801001b0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a93:	43                   	inc    %ebx
80102a94:	3b 1d e8 28 11 80    	cmp    0x801128e8,%ebx
80102a9a:	7c 90                	jl     80102a2c <end_op+0x5c>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102a9c:	e8 db fd ff ff       	call   8010287c <write_head>
    install_trans(); // Now install writes to home locations
80102aa1:	e8 4a fd ff ff       	call   801027f0 <install_trans>
    log.lh.n = 0;
80102aa6:	c7 05 e8 28 11 80 00 	movl   $0x0,0x801128e8
80102aad:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ab0:	e8 c7 fd ff ff       	call   8010287c <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102ab5:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
80102abc:	e8 5b 13 00 00       	call   80103e1c <acquire>
    log.committing = 0;
80102ac1:	c7 05 e0 28 11 80 00 	movl   $0x0,0x801128e0
80102ac8:	00 00 00 
    wakeup(&log);
80102acb:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
80102ad2:	e8 0d 10 00 00       	call   80103ae4 <wakeup>
    release(&log.lock);
80102ad7:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
80102ade:	e8 11 14 00 00       	call   80103ef4 <release>
  }
}
80102ae3:	83 c4 1c             	add    $0x1c,%esp
80102ae6:	5b                   	pop    %ebx
80102ae7:	5e                   	pop    %esi
80102ae8:	5f                   	pop    %edi
80102ae9:	5d                   	pop    %ebp
80102aea:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102aeb:	c7 04 24 e4 6a 10 80 	movl   $0x80106ae4,(%esp)
80102af2:	e8 1d d8 ff ff       	call   80100314 <panic>
80102af7:	90                   	nop

80102af8 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102af8:	55                   	push   %ebp
80102af9:	89 e5                	mov    %esp,%ebp
80102afb:	53                   	push   %ebx
80102afc:	83 ec 14             	sub    $0x14,%esp
80102aff:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102b02:	a1 e8 28 11 80       	mov    0x801128e8,%eax
80102b07:	83 f8 1d             	cmp    $0x1d,%eax
80102b0a:	0f 8f 84 00 00 00    	jg     80102b94 <log_write+0x9c>
80102b10:	8b 0d d8 28 11 80    	mov    0x801128d8,%ecx
80102b16:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102b19:	39 d0                	cmp    %edx,%eax
80102b1b:	7d 77                	jge    80102b94 <log_write+0x9c>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102b1d:	a1 dc 28 11 80       	mov    0x801128dc,%eax
80102b22:	85 c0                	test   %eax,%eax
80102b24:	7e 7a                	jle    80102ba0 <log_write+0xa8>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102b26:	c7 04 24 a0 28 11 80 	movl   $0x801128a0,(%esp)
80102b2d:	e8 ea 12 00 00       	call   80103e1c <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102b32:	8b 15 e8 28 11 80    	mov    0x801128e8,%edx
80102b38:	83 fa 00             	cmp    $0x0,%edx
80102b3b:	7e 48                	jle    80102b85 <log_write+0x8d>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102b3d:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102b40:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102b42:	39 0d ec 28 11 80    	cmp    %ecx,0x801128ec
80102b48:	75 0b                	jne    80102b55 <log_write+0x5d>
80102b4a:	eb 30                	jmp    80102b7c <log_write+0x84>
80102b4c:	39 0c 85 ec 28 11 80 	cmp    %ecx,-0x7feed714(,%eax,4)
80102b53:	74 27                	je     80102b7c <log_write+0x84>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102b55:	40                   	inc    %eax
80102b56:	39 d0                	cmp    %edx,%eax
80102b58:	75 f2                	jne    80102b4c <log_write+0x54>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102b5a:	89 0c 95 ec 28 11 80 	mov    %ecx,-0x7feed714(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102b61:	42                   	inc    %edx
80102b62:	89 15 e8 28 11 80    	mov    %edx,0x801128e8
  b->flags |= B_DIRTY; // prevent eviction
80102b68:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102b6b:	c7 45 08 a0 28 11 80 	movl   $0x801128a0,0x8(%ebp)
}
80102b72:	83 c4 14             	add    $0x14,%esp
80102b75:	5b                   	pop    %ebx
80102b76:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102b77:	e9 78 13 00 00       	jmp    80103ef4 <release>
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102b7c:	89 0c 85 ec 28 11 80 	mov    %ecx,-0x7feed714(,%eax,4)
80102b83:	eb e3                	jmp    80102b68 <log_write+0x70>
80102b85:	8b 43 08             	mov    0x8(%ebx),%eax
80102b88:	a3 ec 28 11 80       	mov    %eax,0x801128ec
  if (i == log.lh.n)
80102b8d:	75 d9                	jne    80102b68 <log_write+0x70>
80102b8f:	eb d0                	jmp    80102b61 <log_write+0x69>
80102b91:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102b94:	c7 04 24 f3 6a 10 80 	movl   $0x80106af3,(%esp)
80102b9b:	e8 74 d7 ff ff       	call   80100314 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102ba0:	c7 04 24 09 6b 10 80 	movl   $0x80106b09,(%esp)
80102ba7:	e8 68 d7 ff ff       	call   80100314 <panic>

80102bac <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102bac:	55                   	push   %ebp
80102bad:	89 e5                	mov    %esp,%ebp
80102baf:	53                   	push   %ebx
80102bb0:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102bb3:	e8 80 08 00 00       	call   80103438 <cpuid>
80102bb8:	89 c3                	mov    %eax,%ebx
80102bba:	e8 79 08 00 00       	call   80103438 <cpuid>
80102bbf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102bc3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bc7:	c7 04 24 24 6b 10 80 	movl   $0x80106b24,(%esp)
80102bce:	e8 f1 d9 ff ff       	call   801005c4 <cprintf>
  idtinit();       // load idt register
80102bd3:	e8 f4 23 00 00       	call   80104fcc <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102bd8:	e8 e3 07 00 00       	call   801033c0 <mycpu>
80102bdd:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102bdf:	b8 01 00 00 00       	mov    $0x1,%eax
80102be4:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102beb:	e8 08 0b 00 00       	call   801036f8 <scheduler>

80102bf0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102bf6:	e8 19 34 00 00       	call   80106014 <switchkvm>
  seginit();
80102bfb:	e8 38 33 00 00       	call   80105f38 <seginit>
  lapicinit();
80102c00:	e8 4f f9 ff ff       	call   80102554 <lapicinit>
  mpmain();
80102c05:	e8 a2 ff ff ff       	call   80102bac <mpmain>
80102c0a:	66 90                	xchg   %ax,%ax

80102c0c <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102c0c:	55                   	push   %ebp
80102c0d:	89 e5                	mov    %esp,%ebp
80102c0f:	53                   	push   %ebx
80102c10:	83 e4 f0             	and    $0xfffffff0,%esp
80102c13:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102c16:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102c1d:	80 
80102c1e:	c7 04 24 e8 56 11 80 	movl   $0x801156e8,(%esp)
80102c25:	e8 36 f6 ff ff       	call   80102260 <kinit1>
  kvmalloc();      // kernel page table
80102c2a:	e8 15 38 00 00       	call   80106444 <kvmalloc>
  mpinit();        // detect other processors
80102c2f:	e8 60 01 00 00       	call   80102d94 <mpinit>
  lapicinit();     // interrupt controller
80102c34:	e8 1b f9 ff ff       	call   80102554 <lapicinit>
  seginit();       // segment descriptors
80102c39:	e8 fa 32 00 00       	call   80105f38 <seginit>
  picinit();       // disable pic
80102c3e:	e8 09 03 00 00       	call   80102f4c <picinit>
  ioapicinit();    // another interrupt controller
80102c43:	e8 94 f3 ff ff       	call   80101fdc <ioapicinit>
  consoleinit();   // console hardware
80102c48:	e8 33 dc ff ff       	call   80100880 <consoleinit>
  uartinit();      // serial port
80102c4d:	e8 52 26 00 00       	call   801052a4 <uartinit>
  pinit();         // process table
80102c52:	e8 4d 07 00 00       	call   801033a4 <pinit>
  tvinit();        // trap vectors
80102c57:	e8 e8 22 00 00       	call   80104f44 <tvinit>
  binit();         // buffer cache
80102c5c:	e8 d3 d3 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80102c61:	e8 16 e0 ff ff       	call   80100c7c <fileinit>
  ideinit();       // disk 
80102c66:	e8 91 f1 ff ff       	call   80101dfc <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102c6b:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102c72:	00 
80102c73:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102c7a:	80 
80102c7b:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102c82:	e8 51 13 00 00       	call   80103fd8 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102c87:	8b 15 44 2f 11 80    	mov    0x80112f44,%edx
80102c8d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102c90:	01 c0                	add    %eax,%eax
80102c92:	01 d0                	add    %edx,%eax
80102c94:	c1 e0 04             	shl    $0x4,%eax
80102c97:	05 a0 29 11 80       	add    $0x801129a0,%eax
80102c9c:	bb a0 29 11 80       	mov    $0x801129a0,%ebx
80102ca1:	39 d8                	cmp    %ebx,%eax
80102ca3:	76 6c                	jbe    80102d11 <main+0x105>
80102ca5:	8d 76 00             	lea    0x0(%esi),%esi
    if(c == mycpu())  // We've started already.
80102ca8:	e8 13 07 00 00       	call   801033c0 <mycpu>
80102cad:	39 d8                	cmp    %ebx,%eax
80102caf:	74 41                	je     80102cf2 <main+0xe6>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102cb1:	e8 c6 f6 ff ff       	call   8010237c <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102cb6:	05 00 10 00 00       	add    $0x1000,%eax
80102cbb:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
80102cc0:	c7 05 f8 6f 00 80 f0 	movl   $0x80102bf0,0x80006ff8
80102cc7:	2b 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102cca:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102cd1:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
80102cd4:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102cdb:	00 
80102cdc:	0f b6 03             	movzbl (%ebx),%eax
80102cdf:	89 04 24             	mov    %eax,(%esp)
80102ce2:	e8 8d f9 ff ff       	call   80102674 <lapicstartap>
80102ce7:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102ce8:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102cee:	85 c0                	test   %eax,%eax
80102cf0:	74 f6                	je     80102ce8 <main+0xdc>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102cf2:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102cf8:	8b 15 44 2f 11 80    	mov    0x80112f44,%edx
80102cfe:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102d01:	01 c0                	add    %eax,%eax
80102d03:	01 d0                	add    %edx,%eax
80102d05:	c1 e0 04             	shl    $0x4,%eax
80102d08:	05 a0 29 11 80       	add    $0x801129a0,%eax
80102d0d:	39 c3                	cmp    %eax,%ebx
80102d0f:	72 97                	jb     80102ca8 <main+0x9c>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102d11:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102d18:	8e 
80102d19:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102d20:	e8 9f f5 ff ff       	call   801022c4 <kinit2>
  userinit();      // first user process
80102d25:	e8 62 07 00 00       	call   8010348c <userinit>
  mpmain();        // finish this processor's setup
80102d2a:	e8 7d fe ff ff       	call   80102bac <mpmain>
80102d2f:	90                   	nop

80102d30 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102d30:	55                   	push   %ebp
80102d31:	89 e5                	mov    %esp,%ebp
80102d33:	56                   	push   %esi
80102d34:	53                   	push   %ebx
80102d35:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80102d38:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
  e = addr+len;
80102d3e:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80102d41:	39 de                	cmp    %ebx,%esi
80102d43:	73 3a                	jae    80102d7f <mpsearch1+0x4f>
80102d45:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102d48:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102d4f:	00 
80102d50:	c7 44 24 04 38 6b 10 	movl   $0x80106b38,0x4(%esp)
80102d57:	80 
80102d58:	89 34 24             	mov    %esi,(%esp)
80102d5b:	e8 30 12 00 00       	call   80103f90 <memcmp>
80102d60:	85 c0                	test   %eax,%eax
80102d62:	75 14                	jne    80102d78 <mpsearch1+0x48>
80102d64:	31 c9                	xor    %ecx,%ecx
80102d66:	31 d2                	xor    %edx,%edx
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102d68:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
80102d6c:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102d6e:	42                   	inc    %edx
80102d6f:	83 fa 10             	cmp    $0x10,%edx
80102d72:	75 f4                	jne    80102d68 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102d74:	84 c9                	test   %cl,%cl
80102d76:	74 10                	je     80102d88 <mpsearch1+0x58>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102d78:	83 c6 10             	add    $0x10,%esi
80102d7b:	39 f3                	cmp    %esi,%ebx
80102d7d:	77 c9                	ja     80102d48 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80102d7f:	31 c0                	xor    %eax,%eax
}
80102d81:	83 c4 10             	add    $0x10,%esp
80102d84:	5b                   	pop    %ebx
80102d85:	5e                   	pop    %esi
80102d86:	5d                   	pop    %ebp
80102d87:	c3                   	ret    
80102d88:	89 f0                	mov    %esi,%eax
80102d8a:	83 c4 10             	add    $0x10,%esp
80102d8d:	5b                   	pop    %ebx
80102d8e:	5e                   	pop    %esi
80102d8f:	5d                   	pop    %ebp
80102d90:	c3                   	ret    
80102d91:	8d 76 00             	lea    0x0(%esi),%esi

80102d94 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102d94:	55                   	push   %ebp
80102d95:	89 e5                	mov    %esp,%ebp
80102d97:	57                   	push   %edi
80102d98:	56                   	push   %esi
80102d99:	53                   	push   %ebx
80102d9a:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102d9d:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102da4:	c1 e0 08             	shl    $0x8,%eax
80102da7:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102dae:	09 d0                	or     %edx,%eax
80102db0:	c1 e0 04             	shl    $0x4,%eax
80102db3:	75 1b                	jne    80102dd0 <mpinit+0x3c>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102db5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102dbc:	c1 e0 08             	shl    $0x8,%eax
80102dbf:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102dc6:	09 d0                	or     %edx,%eax
80102dc8:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102dcb:	2d 00 04 00 00       	sub    $0x400,%eax
80102dd0:	ba 00 04 00 00       	mov    $0x400,%edx
80102dd5:	e8 56 ff ff ff       	call   80102d30 <mpsearch1>
80102dda:	85 c0                	test   %eax,%eax
80102ddc:	0f 84 36 01 00 00    	je     80102f18 <mpinit+0x184>
80102de2:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102de4:	8b 5f 04             	mov    0x4(%edi),%ebx
80102de7:	85 db                	test   %ebx,%ebx
80102de9:	0f 84 42 01 00 00    	je     80102f31 <mpinit+0x19d>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102def:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102df5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80102df8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102dff:	00 
80102e00:	c7 44 24 04 3d 6b 10 	movl   $0x80106b3d,0x4(%esp)
80102e07:	80 
80102e08:	89 04 24             	mov    %eax,(%esp)
80102e0b:	e8 80 11 00 00       	call   80103f90 <memcmp>
80102e10:	85 c0                	test   %eax,%eax
80102e12:	0f 85 19 01 00 00    	jne    80102f31 <mpinit+0x19d>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80102e18:	8a 83 06 00 00 80    	mov    -0x7ffffffa(%ebx),%al
80102e1e:	3c 01                	cmp    $0x1,%al
80102e20:	74 08                	je     80102e2a <mpinit+0x96>
80102e22:	3c 04                	cmp    $0x4,%al
80102e24:	0f 85 07 01 00 00    	jne    80102f31 <mpinit+0x19d>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102e2a:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102e31:	85 c0                	test   %eax,%eax
80102e33:	74 1e                	je     80102e53 <mpinit+0xbf>
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
80102e35:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80102e37:	31 d2                	xor    %edx,%edx
80102e39:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80102e3c:	0f b6 b4 13 00 00 00 	movzbl -0x80000000(%ebx,%edx,1),%esi
80102e43:	80 
80102e44:	01 f1                	add    %esi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102e46:	42                   	inc    %edx
80102e47:	39 d0                	cmp    %edx,%eax
80102e49:	7f f1                	jg     80102e3c <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102e4b:	84 c9                	test   %cl,%cl
80102e4d:	0f 85 de 00 00 00    	jne    80102f31 <mpinit+0x19d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80102e53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102e56:	85 c0                	test   %eax,%eax
80102e58:	0f 84 d3 00 00 00    	je     80102f31 <mpinit+0x19d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102e5e:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80102e64:	a3 80 28 11 80       	mov    %eax,0x80112880
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102e69:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80102e6f:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80102e76:	03 4d e4             	add    -0x1c(%ebp),%ecx
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80102e79:	bb 01 00 00 00       	mov    $0x1,%ebx
80102e7e:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102e81:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102e84:	39 c1                	cmp    %eax,%ecx
80102e86:	76 17                	jbe    80102e9f <mpinit+0x10b>
80102e88:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80102e8b:	80 fa 04             	cmp    $0x4,%dl
80102e8e:	77 7c                	ja     80102f0c <mpinit+0x178>
80102e90:	ff 24 95 7c 6b 10 80 	jmp    *-0x7fef9484(,%edx,4)
80102e97:	90                   	nop
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102e98:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102e9b:	39 c1                	cmp    %eax,%ecx
80102e9d:	77 e9                	ja     80102e88 <mpinit+0xf4>
80102e9f:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102ea2:	85 db                	test   %ebx,%ebx
80102ea4:	0f 84 93 00 00 00    	je     80102f3d <mpinit+0x1a9>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102eaa:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
80102eae:	74 0f                	je     80102ebf <mpinit+0x12b>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eb0:	ba 22 00 00 00       	mov    $0x22,%edx
80102eb5:	b0 70                	mov    $0x70,%al
80102eb7:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eb8:	b2 23                	mov    $0x23,%dl
80102eba:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102ebb:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ebe:	ee                   	out    %al,(%dx)
  }
}
80102ebf:	83 c4 1c             	add    $0x1c,%esp
80102ec2:	5b                   	pop    %ebx
80102ec3:	5e                   	pop    %esi
80102ec4:	5f                   	pop    %edi
80102ec5:	5d                   	pop    %ebp
80102ec6:	c3                   	ret    
80102ec7:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80102ec8:	8b 15 44 2f 11 80    	mov    0x80112f44,%edx
80102ece:	83 fa 07             	cmp    $0x7,%edx
80102ed1:	7f 20                	jg     80102ef3 <mpinit+0x15f>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102ed3:	8d 34 92             	lea    (%edx,%edx,4),%esi
80102ed6:	01 f6                	add    %esi,%esi
80102ed8:	01 d6                	add    %edx,%esi
80102eda:	c1 e6 04             	shl    $0x4,%esi
80102edd:	8a 58 01             	mov    0x1(%eax),%bl
80102ee0:	88 9e a0 29 11 80    	mov    %bl,-0x7feed660(%esi)
        ncpu++;
80102ee6:	42                   	inc    %edx
80102ee7:	89 15 44 2f 11 80    	mov    %edx,0x80112f44
		cpu_pg_stats.ncpu = ncpu;
80102eed:	89 15 20 2f 11 80    	mov    %edx,0x80112f20
      }
      p += sizeof(struct mpproc);
80102ef3:	83 c0 14             	add    $0x14,%eax
      continue;
80102ef6:	eb 8c                	jmp    80102e84 <mpinit+0xf0>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80102ef8:	8a 50 01             	mov    0x1(%eax),%dl
80102efb:	88 15 80 29 11 80    	mov    %dl,0x80112980
      p += sizeof(struct mpioapic);
80102f01:	83 c0 08             	add    $0x8,%eax
      continue;
80102f04:	e9 7b ff ff ff       	jmp    80102e84 <mpinit+0xf0>
80102f09:	8d 76 00             	lea    0x0(%esi),%esi
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80102f0c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102f13:	e9 73 ff ff ff       	jmp    80102e8b <mpinit+0xf7>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80102f18:	ba 00 00 01 00       	mov    $0x10000,%edx
80102f1d:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80102f22:	e8 09 fe ff ff       	call   80102d30 <mpsearch1>
80102f27:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102f29:	85 c0                	test   %eax,%eax
80102f2b:	0f 85 b3 fe ff ff    	jne    80102de4 <mpinit+0x50>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80102f31:	c7 04 24 42 6b 10 80 	movl   $0x80106b42,(%esp)
80102f38:	e8 d7 d3 ff ff       	call   80100314 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80102f3d:	c7 04 24 5c 6b 10 80 	movl   $0x80106b5c,(%esp)
80102f44:	e8 cb d3 ff ff       	call   80100314 <panic>
80102f49:	66 90                	xchg   %ax,%ax
80102f4b:	90                   	nop

80102f4c <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80102f4c:	55                   	push   %ebp
80102f4d:	89 e5                	mov    %esp,%ebp
80102f4f:	ba 21 00 00 00       	mov    $0x21,%edx
80102f54:	b0 ff                	mov    $0xff,%al
80102f56:	ee                   	out    %al,(%dx)
80102f57:	b2 a1                	mov    $0xa1,%dl
80102f59:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102f5a:	5d                   	pop    %ebp
80102f5b:	c3                   	ret    

80102f5c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102f5c:	55                   	push   %ebp
80102f5d:	89 e5                	mov    %esp,%ebp
80102f5f:	56                   	push   %esi
80102f60:	53                   	push   %ebx
80102f61:	83 ec 10             	sub    $0x10,%esp
80102f64:	8b 75 08             	mov    0x8(%ebp),%esi
80102f67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102f6a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80102f70:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102f76:	e8 1d dd ff ff       	call   80100c98 <filealloc>
80102f7b:	89 06                	mov    %eax,(%esi)
80102f7d:	85 c0                	test   %eax,%eax
80102f7f:	0f 84 a1 00 00 00    	je     80103026 <pipealloc+0xca>
80102f85:	e8 0e dd ff ff       	call   80100c98 <filealloc>
80102f8a:	89 03                	mov    %eax,(%ebx)
80102f8c:	85 c0                	test   %eax,%eax
80102f8e:	0f 84 84 00 00 00    	je     80103018 <pipealloc+0xbc>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102f94:	e8 e3 f3 ff ff       	call   8010237c <kalloc>
80102f99:	85 c0                	test   %eax,%eax
80102f9b:	74 7b                	je     80103018 <pipealloc+0xbc>
    goto bad;
  p->readopen = 1;
80102f9d:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102fa4:	00 00 00 
  p->writeopen = 1;
80102fa7:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102fae:	00 00 00 
  p->nwrite = 0;
80102fb1:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102fb8:	00 00 00 
  p->nread = 0;
80102fbb:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102fc2:	00 00 00 
  initlock(&p->lock, "pipe");
80102fc5:	c7 44 24 04 90 6b 10 	movl   $0x80106b90,0x4(%esp)
80102fcc:	80 
80102fcd:	89 04 24             	mov    %eax,(%esp)
80102fd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102fd3:	e8 7c 0d 00 00       	call   80103d54 <initlock>
  (*f0)->type = FD_PIPE;
80102fd8:	8b 16                	mov    (%esi),%edx
80102fda:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80102fe0:	8b 16                	mov    (%esi),%edx
80102fe2:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
80102fe6:	8b 16                	mov    (%esi),%edx
80102fe8:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80102fec:	8b 16                	mov    (%esi),%edx
80102fee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ff1:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80102ff4:	8b 13                	mov    (%ebx),%edx
80102ff6:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
80102ffc:	8b 13                	mov    (%ebx),%edx
80102ffe:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
80103002:	8b 13                	mov    (%ebx),%edx
80103004:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
80103008:	8b 13                	mov    (%ebx),%edx
8010300a:	89 42 0c             	mov    %eax,0xc(%edx)
  return 0;
8010300d:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
8010300f:	83 c4 10             	add    $0x10,%esp
80103012:	5b                   	pop    %ebx
80103013:	5e                   	pop    %esi
80103014:	5d                   	pop    %ebp
80103015:	c3                   	ret    
80103016:	66 90                	xchg   %ax,%ax

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103018:	8b 06                	mov    (%esi),%eax
8010301a:	85 c0                	test   %eax,%eax
8010301c:	74 08                	je     80103026 <pipealloc+0xca>
    fileclose(*f0);
8010301e:	89 04 24             	mov    %eax,(%esp)
80103021:	e8 16 dd ff ff       	call   80100d3c <fileclose>
  if(*f1)
80103026:	8b 03                	mov    (%ebx),%eax
80103028:	85 c0                	test   %eax,%eax
8010302a:	74 14                	je     80103040 <pipealloc+0xe4>
    fileclose(*f1);
8010302c:	89 04 24             	mov    %eax,(%esp)
8010302f:	e8 08 dd ff ff       	call   80100d3c <fileclose>
  return -1;
80103034:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103039:	83 c4 10             	add    $0x10,%esp
8010303c:	5b                   	pop    %ebx
8010303d:	5e                   	pop    %esi
8010303e:	5d                   	pop    %ebp
8010303f:	c3                   	ret    
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103045:	83 c4 10             	add    $0x10,%esp
80103048:	5b                   	pop    %ebx
80103049:	5e                   	pop    %esi
8010304a:	5d                   	pop    %ebp
8010304b:	c3                   	ret    

8010304c <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
8010304c:	55                   	push   %ebp
8010304d:	89 e5                	mov    %esp,%ebp
8010304f:	56                   	push   %esi
80103050:	53                   	push   %ebx
80103051:	83 ec 10             	sub    $0x10,%esp
80103054:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103057:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010305a:	89 1c 24             	mov    %ebx,(%esp)
8010305d:	e8 ba 0d 00 00       	call   80103e1c <acquire>
  if(writable){
80103062:	85 f6                	test   %esi,%esi
80103064:	74 3a                	je     801030a0 <pipeclose+0x54>
    p->writeopen = 0;
80103066:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010306d:	00 00 00 
    wakeup(&p->nread);
80103070:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103076:	89 04 24             	mov    %eax,(%esp)
80103079:	e8 66 0a 00 00       	call   80103ae4 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010307e:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103084:	85 d2                	test   %edx,%edx
80103086:	75 0a                	jne    80103092 <pipeclose+0x46>
80103088:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
8010308e:	85 c0                	test   %eax,%eax
80103090:	74 2a                	je     801030bc <pipeclose+0x70>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103092:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103095:	83 c4 10             	add    $0x10,%esp
80103098:	5b                   	pop    %ebx
80103099:	5e                   	pop    %esi
8010309a:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010309b:	e9 54 0e 00 00       	jmp    80103ef4 <release>
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801030a0:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801030a7:	00 00 00 
    wakeup(&p->nwrite);
801030aa:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801030b0:	89 04 24             	mov    %eax,(%esp)
801030b3:	e8 2c 0a 00 00       	call   80103ae4 <wakeup>
801030b8:	eb c4                	jmp    8010307e <pipeclose+0x32>
801030ba:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801030bc:	89 1c 24             	mov    %ebx,(%esp)
801030bf:	e8 30 0e 00 00       	call   80103ef4 <release>
    kfree((char*)p);
801030c4:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
801030c7:	83 c4 10             	add    $0x10,%esp
801030ca:	5b                   	pop    %ebx
801030cb:	5e                   	pop    %esi
801030cc:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801030cd:	e9 72 f0 ff ff       	jmp    80102144 <kfree>
801030d2:	66 90                	xchg   %ax,%ax

801030d4 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801030d4:	55                   	push   %ebp
801030d5:	89 e5                	mov    %esp,%ebp
801030d7:	57                   	push   %edi
801030d8:	56                   	push   %esi
801030d9:	53                   	push   %ebx
801030da:	83 ec 2c             	sub    $0x2c,%esp
801030dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801030e0:	89 1c 24             	mov    %ebx,(%esp)
801030e3:	e8 34 0d 00 00       	call   80103e1c <acquire>
  for(i = 0; i < n; i++){
801030e8:	8b 45 10             	mov    0x10(%ebp),%eax
801030eb:	85 c0                	test   %eax,%eax
801030ed:	0f 8e b3 00 00 00    	jle    801031a6 <pipewrite+0xd2>
801030f3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801030f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801030fc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801030ff:	03 4d 10             	add    0x10(%ebp),%ecx
80103102:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103105:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010310b:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103111:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103117:	81 c1 00 02 00 00    	add    $0x200,%ecx
8010311d:	39 c8                	cmp    %ecx,%eax
8010311f:	74 38                	je     80103159 <pipewrite+0x85>
80103121:	eb 55                	jmp    80103178 <pipewrite+0xa4>
80103123:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103124:	e8 43 03 00 00       	call   8010346c <myproc>
80103129:	8b 48 24             	mov    0x24(%eax),%ecx
8010312c:	85 c9                	test   %ecx,%ecx
8010312e:	75 33                	jne    80103163 <pipewrite+0x8f>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103130:	89 3c 24             	mov    %edi,(%esp)
80103133:	e8 ac 09 00 00       	call   80103ae4 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103138:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010313c:	89 34 24             	mov    %esi,(%esp)
8010313f:	e8 24 08 00 00       	call   80103968 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103144:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010314a:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103150:	05 00 02 00 00       	add    $0x200,%eax
80103155:	39 c2                	cmp    %eax,%edx
80103157:	75 23                	jne    8010317c <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
80103159:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010315f:	85 c0                	test   %eax,%eax
80103161:	75 c1                	jne    80103124 <pipewrite+0x50>
        release(&p->lock);
80103163:	89 1c 24             	mov    %ebx,(%esp)
80103166:	e8 89 0d 00 00       	call   80103ef4 <release>
        return -1;
8010316b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103170:	83 c4 2c             	add    $0x2c,%esp
80103173:	5b                   	pop    %ebx
80103174:	5e                   	pop    %esi
80103175:	5f                   	pop    %edi
80103176:	5d                   	pop    %ebp
80103177:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103178:	89 c2                	mov    %eax,%edx
8010317a:	66 90                	xchg   %ax,%ax
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010317c:	8d 42 01             	lea    0x1(%edx),%eax
8010317f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103185:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103188:	8a 09                	mov    (%ecx),%cl
8010318a:	88 4d df             	mov    %cl,-0x21(%ebp)
8010318d:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103193:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103197:	ff 45 e4             	incl   -0x1c(%ebp)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010319a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010319d:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801031a0:	0f 85 6b ff ff ff    	jne    80103111 <pipewrite+0x3d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801031a6:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801031ac:	89 04 24             	mov    %eax,(%esp)
801031af:	e8 30 09 00 00       	call   80103ae4 <wakeup>
  release(&p->lock);
801031b4:	89 1c 24             	mov    %ebx,(%esp)
801031b7:	e8 38 0d 00 00       	call   80103ef4 <release>
  return n;
801031bc:	8b 45 10             	mov    0x10(%ebp),%eax
801031bf:	eb af                	jmp    80103170 <pipewrite+0x9c>
801031c1:	8d 76 00             	lea    0x0(%esi),%esi

801031c4 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801031c4:	55                   	push   %ebp
801031c5:	89 e5                	mov    %esp,%ebp
801031c7:	57                   	push   %edi
801031c8:	56                   	push   %esi
801031c9:	53                   	push   %ebx
801031ca:	83 ec 1c             	sub    $0x1c,%esp
801031cd:	8b 75 08             	mov    0x8(%ebp),%esi
801031d0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801031d3:	89 34 24             	mov    %esi,(%esp)
801031d6:	e8 41 0c 00 00       	call   80103e1c <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801031db:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801031e1:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801031e7:	75 5b                	jne    80103244 <piperead+0x80>
801031e9:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801031ef:	85 db                	test   %ebx,%ebx
801031f1:	74 51                	je     80103244 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801031f3:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801031f9:	eb 25                	jmp    80103220 <piperead+0x5c>
801031fb:	90                   	nop
801031fc:	89 74 24 04          	mov    %esi,0x4(%esp)
80103200:	89 1c 24             	mov    %ebx,(%esp)
80103203:	e8 60 07 00 00       	call   80103968 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103208:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010320e:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103214:	75 2e                	jne    80103244 <piperead+0x80>
80103216:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
8010321c:	85 d2                	test   %edx,%edx
8010321e:	74 24                	je     80103244 <piperead+0x80>
    if(myproc()->killed){
80103220:	e8 47 02 00 00       	call   8010346c <myproc>
80103225:	8b 48 24             	mov    0x24(%eax),%ecx
80103228:	85 c9                	test   %ecx,%ecx
8010322a:	74 d0                	je     801031fc <piperead+0x38>
      release(&p->lock);
8010322c:	89 34 24             	mov    %esi,(%esp)
8010322f:	e8 c0 0c 00 00       	call   80103ef4 <release>
      return -1;
80103234:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103239:	83 c4 1c             	add    $0x1c,%esp
8010323c:	5b                   	pop    %ebx
8010323d:	5e                   	pop    %esi
8010323e:	5f                   	pop    %edi
8010323f:	5d                   	pop    %ebp
80103240:	c3                   	ret    
80103241:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
80103244:	31 db                	xor    %ebx,%ebx
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103246:	8b 55 10             	mov    0x10(%ebp),%edx
80103249:	85 d2                	test   %edx,%edx
8010324b:	7f 24                	jg     80103271 <piperead+0xad>
8010324d:	eb 2a                	jmp    80103279 <piperead+0xb5>
8010324f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103250:	8d 48 01             	lea    0x1(%eax),%ecx
80103253:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103259:	25 ff 01 00 00       	and    $0x1ff,%eax
8010325e:	8a 44 06 34          	mov    0x34(%esi,%eax,1),%al
80103262:	88 04 1f             	mov    %al,(%edi,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103265:	43                   	inc    %ebx
80103266:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80103269:	74 0e                	je     80103279 <piperead+0xb5>
    if(p->nread == p->nwrite)
8010326b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103271:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103277:	75 d7                	jne    80103250 <piperead+0x8c>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103279:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
8010327f:	89 04 24             	mov    %eax,(%esp)
80103282:	e8 5d 08 00 00       	call   80103ae4 <wakeup>
  release(&p->lock);
80103287:	89 34 24             	mov    %esi,(%esp)
8010328a:	e8 65 0c 00 00       	call   80103ef4 <release>
  return i;
8010328f:	89 d8                	mov    %ebx,%eax
}
80103291:	83 c4 1c             	add    $0x1c,%esp
80103294:	5b                   	pop    %ebx
80103295:	5e                   	pop    %esi
80103296:	5f                   	pop    %edi
80103297:	5d                   	pop    %ebp
80103298:	c3                   	ret    
80103299:	66 90                	xchg   %ax,%ax
8010329b:	90                   	nop

8010329c <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010329c:	55                   	push   %ebp
8010329d:	89 e5                	mov    %esp,%ebp
8010329f:	53                   	push   %ebx
801032a0:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801032a3:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801032aa:	e8 6d 0b 00 00       	call   80103e1c <acquire>

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801032af:	bb 94 2f 11 80       	mov    $0x80112f94,%ebx
801032b4:	eb 0d                	jmp    801032c3 <allocproc+0x27>
801032b6:	66 90                	xchg   %ax,%ax
801032b8:	83 c3 7c             	add    $0x7c,%ebx
801032bb:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
801032c1:	74 7d                	je     80103340 <allocproc+0xa4>
    if(p->state == UNUSED)
801032c3:	8b 43 0c             	mov    0xc(%ebx),%eax
801032c6:	85 c0                	test   %eax,%eax
801032c8:	75 ee                	jne    801032b8 <allocproc+0x1c>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801032ca:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801032d1:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801032d6:	8d 50 01             	lea    0x1(%eax),%edx
801032d9:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
801032df:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801032e2:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801032e9:	e8 06 0c 00 00       	call   80103ef4 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801032ee:	e8 89 f0 ff ff       	call   8010237c <kalloc>
801032f3:	89 43 08             	mov    %eax,0x8(%ebx)
801032f6:	85 c0                	test   %eax,%eax
801032f8:	74 5a                	je     80103354 <allocproc+0xb8>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801032fa:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103300:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103303:	c7 80 b0 0f 00 00 38 	movl   $0x80104f38,0xfb0(%eax)
8010330a:	4f 10 80 

  sp -= sizeof *p->context;
8010330d:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
80103312:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103315:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010331c:	00 
8010331d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103324:	00 
80103325:	89 04 24             	mov    %eax,(%esp)
80103328:	e8 17 0c 00 00       	call   80103f44 <memset>
  p->context->eip = (uint)forkret;
8010332d:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103330:	c7 40 10 60 33 10 80 	movl   $0x80103360,0x10(%eax)

  return p;
80103337:	89 d8                	mov    %ebx,%eax
}
80103339:	83 c4 14             	add    $0x14,%esp
8010333c:	5b                   	pop    %ebx
8010333d:	5d                   	pop    %ebp
8010333e:	c3                   	ret    
8010333f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103340:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103347:	e8 a8 0b 00 00       	call   80103ef4 <release>
  return 0;
8010334c:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010334e:	83 c4 14             	add    $0x14,%esp
80103351:	5b                   	pop    %ebx
80103352:	5d                   	pop    %ebp
80103353:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103354:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010335b:	eb dc                	jmp    80103339 <allocproc+0x9d>
8010335d:	8d 76 00             	lea    0x0(%esi),%esi

80103360 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103366:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
8010336d:	e8 82 0b 00 00       	call   80103ef4 <release>

  if (first) {
80103372:	8b 15 00 a0 10 80    	mov    0x8010a000,%edx
80103378:	85 d2                	test   %edx,%edx
8010337a:	75 04                	jne    80103380 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010337c:	c9                   	leave  
8010337d:	c3                   	ret    
8010337e:	66 90                	xchg   %ax,%ax

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103380:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103387:	00 00 00 
    iinit(ROOTDEV);
8010338a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103391:	e8 76 df ff ff       	call   8010130c <iinit>
    initlog(ROOTDEV);
80103396:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010339d:	e8 36 f5 ff ff       	call   801028d8 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
801033a2:	c9                   	leave  
801033a3:	c3                   	ret    

801033a4 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801033a4:	55                   	push   %ebp
801033a5:	89 e5                	mov    %esp,%ebp
801033a7:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801033aa:	c7 44 24 04 95 6b 10 	movl   $0x80106b95,0x4(%esp)
801033b1:	80 
801033b2:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801033b9:	e8 96 09 00 00       	call   80103d54 <initlock>
}
801033be:	c9                   	leave  
801033bf:	c3                   	ret    

801033c0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	56                   	push   %esi
801033c4:	53                   	push   %ebx
801033c5:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801033c8:	9c                   	pushf  
801033c9:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801033ca:	f6 c4 02             	test   $0x2,%ah
801033cd:	75 5a                	jne    80103429 <mycpu+0x69>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801033cf:	e8 64 f2 ff ff       	call   80102638 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801033d4:	8b 35 44 2f 11 80    	mov    0x80112f44,%esi
801033da:	85 f6                	test   %esi,%esi
801033dc:	7e 3f                	jle    8010341d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801033de:	0f b6 15 a0 29 11 80 	movzbl 0x801129a0,%edx
801033e5:	39 c2                	cmp    %eax,%edx
801033e7:	74 30                	je     80103419 <mycpu+0x59>
801033e9:	b9 50 2a 11 80       	mov    $0x80112a50,%ecx
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801033ee:	31 d2                	xor    %edx,%edx
801033f0:	42                   	inc    %edx
801033f1:	39 f2                	cmp    %esi,%edx
801033f3:	74 28                	je     8010341d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801033f5:	0f b6 19             	movzbl (%ecx),%ebx
801033f8:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801033fe:	39 c3                	cmp    %eax,%ebx
80103400:	75 ee                	jne    801033f0 <mycpu+0x30>
      return &cpus[i];
80103402:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103405:	01 c0                	add    %eax,%eax
80103407:	01 c2                	add    %eax,%edx
80103409:	c1 e2 04             	shl    $0x4,%edx
8010340c:	8d 82 a0 29 11 80    	lea    -0x7feed660(%edx),%eax
  }
  panic("unknown apicid\n");
}
80103412:	83 c4 10             	add    $0x10,%esp
80103415:	5b                   	pop    %ebx
80103416:	5e                   	pop    %esi
80103417:	5d                   	pop    %ebp
80103418:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103419:	31 d2                	xor    %edx,%edx
8010341b:	eb e5                	jmp    80103402 <mycpu+0x42>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010341d:	c7 04 24 9c 6b 10 80 	movl   $0x80106b9c,(%esp)
80103424:	e8 eb ce ff ff       	call   80100314 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103429:	c7 04 24 78 6c 10 80 	movl   $0x80106c78,(%esp)
80103430:	e8 df ce ff ff       	call   80100314 <panic>
80103435:	8d 76 00             	lea    0x0(%esi),%esi

80103438 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103438:	55                   	push   %ebp
80103439:	89 e5                	mov    %esp,%ebp
8010343b:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
8010343e:	e8 7d ff ff ff       	call   801033c0 <mycpu>
80103443:	2d a0 29 11 80       	sub    $0x801129a0,%eax
80103448:	c1 f8 04             	sar    $0x4,%eax
8010344b:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
8010344e:	89 ca                	mov    %ecx,%edx
80103450:	c1 e2 05             	shl    $0x5,%edx
80103453:	29 ca                	sub    %ecx,%edx
80103455:	8d 14 90             	lea    (%eax,%edx,4),%edx
80103458:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
8010345b:	89 ca                	mov    %ecx,%edx
8010345d:	c1 e2 0f             	shl    $0xf,%edx
80103460:	29 ca                	sub    %ecx,%edx
80103462:	8d 04 90             	lea    (%eax,%edx,4),%eax
80103465:	f7 d8                	neg    %eax
}
80103467:	c9                   	leave  
80103468:	c3                   	ret    
80103469:	8d 76 00             	lea    0x0(%esi),%esi

8010346c <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
8010346c:	55                   	push   %ebp
8010346d:	89 e5                	mov    %esp,%ebp
8010346f:	53                   	push   %ebx
80103470:	51                   	push   %ecx
  struct cpu *c;
  struct proc *p;
  pushcli();
80103471:	e8 6e 09 00 00       	call   80103de4 <pushcli>
  c = mycpu();
80103476:	e8 45 ff ff ff       	call   801033c0 <mycpu>
  p = c->proc;
8010347b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103481:	e8 0a 0a 00 00       	call   80103e90 <popcli>
  return p;
}
80103486:	89 d8                	mov    %ebx,%eax
80103488:	5b                   	pop    %ebx
80103489:	5b                   	pop    %ebx
8010348a:	5d                   	pop    %ebp
8010348b:	c3                   	ret    

8010348c <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010348c:	55                   	push   %ebp
8010348d:	89 e5                	mov    %esp,%ebp
8010348f:	53                   	push   %ebx
80103490:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103493:	e8 04 fe ff ff       	call   8010329c <allocproc>
80103498:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010349a:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
8010349f:	e8 24 2f 00 00       	call   801063c8 <setupkvm>
801034a4:	89 43 04             	mov    %eax,0x4(%ebx)
801034a7:	85 c0                	test   %eax,%eax
801034a9:	0f 84 cc 00 00 00    	je     8010357b <userinit+0xef>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801034af:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
801034b6:	00 
801034b7:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
801034be:	80 
801034bf:	89 04 24             	mov    %eax,(%esp)
801034c2:	e8 5d 2c 00 00       	call   80106124 <inituvm>
  p->sz = PGSIZE;
801034c7:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801034cd:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801034d4:	00 
801034d5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801034dc:	00 
801034dd:	8b 43 18             	mov    0x18(%ebx),%eax
801034e0:	89 04 24             	mov    %eax,(%esp)
801034e3:	e8 5c 0a 00 00       	call   80103f44 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801034e8:	8b 43 18             	mov    0x18(%ebx),%eax
801034eb:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801034f1:	8b 43 18             	mov    0x18(%ebx),%eax
801034f4:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
801034fa:	8b 43 18             	mov    0x18(%ebx),%eax
801034fd:	8b 50 2c             	mov    0x2c(%eax),%edx
80103500:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103504:	8b 43 18             	mov    0x18(%ebx),%eax
80103507:	8b 50 2c             	mov    0x2c(%eax),%edx
8010350a:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010350e:	8b 43 18             	mov    0x18(%ebx),%eax
80103511:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103518:	8b 43 18             	mov    0x18(%ebx),%eax
8010351b:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103522:	8b 43 18             	mov    0x18(%ebx),%eax
80103525:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010352c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103533:	00 
80103534:	c7 44 24 04 c5 6b 10 	movl   $0x80106bc5,0x4(%esp)
8010353b:	80 
8010353c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010353f:	89 04 24             	mov    %eax,(%esp)
80103542:	e8 a9 0b 00 00       	call   801040f0 <safestrcpy>
  p->cwd = namei("/");
80103547:	c7 04 24 ce 6b 10 80 	movl   $0x80106bce,(%esp)
8010354e:	e8 d5 e7 ff ff       	call   80101d28 <namei>
80103553:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103556:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
8010355d:	e8 ba 08 00 00       	call   80103e1c <acquire>

  p->state = RUNNABLE;
80103562:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103569:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103570:	e8 7f 09 00 00       	call   80103ef4 <release>
}
80103575:	83 c4 14             	add    $0x14,%esp
80103578:	5b                   	pop    %ebx
80103579:	5d                   	pop    %ebp
8010357a:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
8010357b:	c7 04 24 ac 6b 10 80 	movl   $0x80106bac,(%esp)
80103582:	e8 8d cd ff ff       	call   80100314 <panic>
80103587:	90                   	nop

80103588 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103588:	55                   	push   %ebp
80103589:	89 e5                	mov    %esp,%ebp
8010358b:	53                   	push   %ebx
8010358c:	83 ec 14             	sub    $0x14,%esp
  uint sz;
  struct proc *curproc = myproc();
8010358f:	e8 d8 fe ff ff       	call   8010346c <myproc>
80103594:	89 c3                	mov    %eax,%ebx

  sz = curproc->sz;
80103596:	8b 00                	mov    (%eax),%eax
  if(n > 0){
80103598:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010359c:	7e 2e                	jle    801035cc <growproc+0x44>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010359e:	8b 55 08             	mov    0x8(%ebp),%edx
801035a1:	01 c2                	add    %eax,%edx
801035a3:	89 54 24 08          	mov    %edx,0x8(%esp)
801035a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801035ab:	8b 43 04             	mov    0x4(%ebx),%eax
801035ae:	89 04 24             	mov    %eax,(%esp)
801035b1:	e8 aa 2c 00 00       	call   80106260 <allocuvm>
801035b6:	85 c0                	test   %eax,%eax
801035b8:	74 32                	je     801035ec <growproc+0x64>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801035ba:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801035bc:	89 1c 24             	mov    %ebx,(%esp)
801035bf:	e8 64 2a 00 00       	call   80106028 <switchuvm>
  return 0;
801035c4:	31 c0                	xor    %eax,%eax
}
801035c6:	83 c4 14             	add    $0x14,%esp
801035c9:	5b                   	pop    %ebx
801035ca:	5d                   	pop    %ebp
801035cb:	c3                   	ret    

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
801035cc:	74 ec                	je     801035ba <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801035ce:	8b 55 08             	mov    0x8(%ebp),%edx
801035d1:	01 c2                	add    %eax,%edx
801035d3:	89 54 24 08          	mov    %edx,0x8(%esp)
801035d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801035db:	8b 43 04             	mov    0x4(%ebx),%eax
801035de:	89 04 24             	mov    %eax,(%esp)
801035e1:	e8 5a 2d 00 00       	call   80106340 <deallocuvm>
801035e6:	85 c0                	test   %eax,%eax
801035e8:	75 d0                	jne    801035ba <growproc+0x32>
801035ea:	66 90                	xchg   %ax,%ax
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
801035ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035f1:	eb d3                	jmp    801035c6 <growproc+0x3e>
801035f3:	90                   	nop

801035f4 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801035f4:	55                   	push   %ebp
801035f5:	89 e5                	mov    %esp,%ebp
801035f7:	57                   	push   %edi
801035f8:	56                   	push   %esi
801035f9:	53                   	push   %ebx
801035fa:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
801035fd:	e8 6a fe ff ff       	call   8010346c <myproc>
80103602:	89 c3                	mov    %eax,%ebx

  // Allocate process.
  if((np = allocproc()) == 0){
80103604:	e8 93 fc ff ff       	call   8010329c <allocproc>
80103609:	89 c7                	mov    %eax,%edi
8010360b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010360e:	85 c0                	test   %eax,%eax
80103610:	0f 84 b6 00 00 00    	je     801036cc <fork+0xd8>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103616:	8b 03                	mov    (%ebx),%eax
80103618:	89 44 24 04          	mov    %eax,0x4(%esp)
8010361c:	8b 43 04             	mov    0x4(%ebx),%eax
8010361f:	89 04 24             	mov    %eax,(%esp)
80103622:	e8 61 2e 00 00       	call   80106488 <copyuvm>
80103627:	89 47 04             	mov    %eax,0x4(%edi)
8010362a:	85 c0                	test   %eax,%eax
8010362c:	0f 84 a1 00 00 00    	je     801036d3 <fork+0xdf>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103632:	8b 03                	mov    (%ebx),%eax
80103634:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103637:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103639:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010363c:	89 c8                	mov    %ecx,%eax
8010363e:	8b 79 18             	mov    0x18(%ecx),%edi
80103641:	8b 73 18             	mov    0x18(%ebx),%esi
80103644:	b9 13 00 00 00       	mov    $0x13,%ecx
80103649:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010364b:	8b 40 18             	mov    0x18(%eax),%eax
8010364e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80103655:	31 f6                	xor    %esi,%esi
80103657:	90                   	nop
    if(curproc->ofile[i])
80103658:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010365c:	85 c0                	test   %eax,%eax
8010365e:	74 0f                	je     8010366f <fork+0x7b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103660:	89 04 24             	mov    %eax,(%esp)
80103663:	e8 90 d6 ff ff       	call   80100cf8 <filedup>
80103668:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010366b:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010366f:	46                   	inc    %esi
80103670:	83 fe 10             	cmp    $0x10,%esi
80103673:	75 e3                	jne    80103658 <fork+0x64>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103675:	8b 43 68             	mov    0x68(%ebx),%eax
80103678:	89 04 24             	mov    %eax,(%esp)
8010367b:	e8 80 de ff ff       	call   80101500 <idup>
80103680:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103683:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103686:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010368d:	00 
8010368e:	83 c3 6c             	add    $0x6c,%ebx
80103691:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103695:	8d 47 6c             	lea    0x6c(%edi),%eax
80103698:	89 04 24             	mov    %eax,(%esp)
8010369b:	e8 50 0a 00 00       	call   801040f0 <safestrcpy>

  pid = np->pid;
801036a0:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801036a3:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801036aa:	e8 6d 07 00 00       	call   80103e1c <acquire>

  np->state = RUNNABLE;
801036af:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801036b6:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801036bd:	e8 32 08 00 00       	call   80103ef4 <release>

  return pid;
801036c2:	89 d8                	mov    %ebx,%eax
}
801036c4:	83 c4 1c             	add    $0x1c,%esp
801036c7:	5b                   	pop    %ebx
801036c8:	5e                   	pop    %esi
801036c9:	5f                   	pop    %edi
801036ca:	5d                   	pop    %ebp
801036cb:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
801036cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036d1:	eb f1                	jmp    801036c4 <fork+0xd0>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
801036d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801036d6:	8b 47 08             	mov    0x8(%edi),%eax
801036d9:	89 04 24             	mov    %eax,(%esp)
801036dc:	e8 63 ea ff ff       	call   80102144 <kfree>
    np->kstack = 0;
801036e1:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
801036e8:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
801036ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036f4:	eb ce                	jmp    801036c4 <fork+0xd0>
801036f6:	66 90                	xchg   %ax,%ax

801036f8 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801036f8:	55                   	push   %ebp
801036f9:	89 e5                	mov    %esp,%ebp
801036fb:	57                   	push   %edi
801036fc:	56                   	push   %esi
801036fd:	53                   	push   %ebx
801036fe:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103701:	e8 ba fc ff ff       	call   801033c0 <mycpu>
80103706:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103708:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010370f:	00 00 00 
80103712:	8d 78 04             	lea    0x4(%eax),%edi
80103715:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103718:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103719:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103720:	e8 f7 06 00 00       	call   80103e1c <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103725:	bb 94 2f 11 80       	mov    $0x80112f94,%ebx
8010372a:	eb 0b                	jmp    80103737 <scheduler+0x3f>
8010372c:	83 c3 7c             	add    $0x7c,%ebx
8010372f:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
80103735:	74 45                	je     8010377c <scheduler+0x84>
      if(p->state != RUNNABLE)
80103737:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010373b:	75 ef                	jne    8010372c <scheduler+0x34>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
8010373d:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103743:	89 1c 24             	mov    %ebx,(%esp)
80103746:	e8 dd 28 00 00       	call   80106028 <switchuvm>
      p->state = RUNNING;
8010374b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)

      swtch(&(c->scheduler), p->context);
80103752:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103755:	89 44 24 04          	mov    %eax,0x4(%esp)
80103759:	89 3c 24             	mov    %edi,(%esp)
8010375c:	e8 df 09 00 00       	call   80104140 <swtch>
      switchkvm();
80103761:	e8 ae 28 00 00       	call   80106014 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103766:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
8010376d:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103770:	83 c3 7c             	add    $0x7c,%ebx
80103773:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
80103779:	75 bc                	jne    80103737 <scheduler+0x3f>
8010377b:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
8010377c:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103783:	e8 6c 07 00 00       	call   80103ef4 <release>

  }
80103788:	eb 8e                	jmp    80103718 <scheduler+0x20>
8010378a:	66 90                	xchg   %ax,%ax

8010378c <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
8010378c:	55                   	push   %ebp
8010378d:	89 e5                	mov    %esp,%ebp
8010378f:	56                   	push   %esi
80103790:	53                   	push   %ebx
80103791:	83 ec 10             	sub    $0x10,%esp
  int intena;
  struct proc *p = myproc();
80103794:	e8 d3 fc ff ff       	call   8010346c <myproc>
80103799:	89 c3                	mov    %eax,%ebx

  if(!holding(&ptable.lock))
8010379b:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801037a2:	e8 15 06 00 00       	call   80103dbc <holding>
801037a7:	85 c0                	test   %eax,%eax
801037a9:	74 4f                	je     801037fa <sched+0x6e>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
801037ab:	e8 10 fc ff ff       	call   801033c0 <mycpu>
801037b0:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801037b7:	75 65                	jne    8010381e <sched+0x92>
    panic("sched locks");
  if(p->state == RUNNING)
801037b9:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801037bd:	74 53                	je     80103812 <sched+0x86>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037bf:	9c                   	pushf  
801037c0:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
801037c1:	f6 c4 02             	test   $0x2,%ah
801037c4:	75 40                	jne    80103806 <sched+0x7a>
    panic("sched interruptible");
  intena = mycpu()->intena;
801037c6:	e8 f5 fb ff ff       	call   801033c0 <mycpu>
801037cb:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801037d1:	e8 ea fb ff ff       	call   801033c0 <mycpu>
801037d6:	8b 40 04             	mov    0x4(%eax),%eax
801037d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801037dd:	83 c3 1c             	add    $0x1c,%ebx
801037e0:	89 1c 24             	mov    %ebx,(%esp)
801037e3:	e8 58 09 00 00       	call   80104140 <swtch>
  mycpu()->intena = intena;
801037e8:	e8 d3 fb ff ff       	call   801033c0 <mycpu>
801037ed:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801037f3:	83 c4 10             	add    $0x10,%esp
801037f6:	5b                   	pop    %ebx
801037f7:	5e                   	pop    %esi
801037f8:	5d                   	pop    %ebp
801037f9:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
801037fa:	c7 04 24 d0 6b 10 80 	movl   $0x80106bd0,(%esp)
80103801:	e8 0e cb ff ff       	call   80100314 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103806:	c7 04 24 fc 6b 10 80 	movl   $0x80106bfc,(%esp)
8010380d:	e8 02 cb ff ff       	call   80100314 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103812:	c7 04 24 ee 6b 10 80 	movl   $0x80106bee,(%esp)
80103819:	e8 f6 ca ff ff       	call   80100314 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
8010381e:	c7 04 24 e2 6b 10 80 	movl   $0x80106be2,(%esp)
80103825:	e8 ea ca ff ff       	call   80100314 <panic>
8010382a:	66 90                	xchg   %ax,%ax

8010382c <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
8010382c:	55                   	push   %ebp
8010382d:	89 e5                	mov    %esp,%ebp
8010382f:	56                   	push   %esi
80103830:	53                   	push   %ebx
80103831:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103834:	e8 33 fc ff ff       	call   8010346c <myproc>
80103839:	89 c3                	mov    %eax,%ebx
  struct proc *p;
  int fd;

  if(curproc == initproc)
8010383b:	31 f6                	xor    %esi,%esi
8010383d:	3b 05 b8 a5 10 80    	cmp    0x8010a5b8,%eax
80103843:	0f 84 de 00 00 00    	je     80103927 <exit+0xfb>
80103849:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
8010384c:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103850:	85 c0                	test   %eax,%eax
80103852:	74 10                	je     80103864 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103854:	89 04 24             	mov    %eax,(%esp)
80103857:	e8 e0 d4 ff ff       	call   80100d3c <fileclose>
      curproc->ofile[fd] = 0;
8010385c:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103863:	00 

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103864:	46                   	inc    %esi
80103865:	83 fe 10             	cmp    $0x10,%esi
80103868:	75 e2                	jne    8010384c <exit+0x20>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
8010386a:	e8 01 f1 ff ff       	call   80102970 <begin_op>
  iput(curproc->cwd);
8010386f:	8b 43 68             	mov    0x68(%ebx),%eax
80103872:	89 04 24             	mov    %eax,(%esp)
80103875:	e8 c6 dd ff ff       	call   80101640 <iput>
  end_op();
8010387a:	e8 51 f1 ff ff       	call   801029d0 <end_op>
  curproc->cwd = 0;
8010387f:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)

  acquire(&ptable.lock);
80103886:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
8010388d:	e8 8a 05 00 00       	call   80103e1c <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103892:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103895:	ba 94 2f 11 80       	mov    $0x80112f94,%edx
8010389a:	eb 0b                	jmp    801038a7 <exit+0x7b>
8010389c:	83 c2 7c             	add    $0x7c,%edx
8010389f:	81 fa 94 4e 11 80    	cmp    $0x80114e94,%edx
801038a5:	74 1d                	je     801038c4 <exit+0x98>
    if(p->state == SLEEPING && p->chan == chan)
801038a7:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
801038ab:	75 ef                	jne    8010389c <exit+0x70>
801038ad:	3b 42 20             	cmp    0x20(%edx),%eax
801038b0:	75 ea                	jne    8010389c <exit+0x70>
      p->state = RUNNABLE;
801038b2:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038b9:	83 c2 7c             	add    $0x7c,%edx
801038bc:	81 fa 94 4e 11 80    	cmp    $0x80114e94,%edx
801038c2:	75 e3                	jne    801038a7 <exit+0x7b>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
801038c4:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
801038c9:	b9 94 2f 11 80       	mov    $0x80112f94,%ecx
801038ce:	eb 0b                	jmp    801038db <exit+0xaf>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801038d0:	83 c1 7c             	add    $0x7c,%ecx
801038d3:	81 f9 94 4e 11 80    	cmp    $0x80114e94,%ecx
801038d9:	74 34                	je     8010390f <exit+0xe3>
    if(p->parent == curproc){
801038db:	39 59 14             	cmp    %ebx,0x14(%ecx)
801038de:	75 f0                	jne    801038d0 <exit+0xa4>
      p->parent = initproc;
801038e0:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
801038e3:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
801038e7:	75 e7                	jne    801038d0 <exit+0xa4>
801038e9:	ba 94 2f 11 80       	mov    $0x80112f94,%edx
801038ee:	eb 0b                	jmp    801038fb <exit+0xcf>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038f0:	83 c2 7c             	add    $0x7c,%edx
801038f3:	81 fa 94 4e 11 80    	cmp    $0x80114e94,%edx
801038f9:	74 d5                	je     801038d0 <exit+0xa4>
    if(p->state == SLEEPING && p->chan == chan)
801038fb:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
801038ff:	75 ef                	jne    801038f0 <exit+0xc4>
80103901:	3b 42 20             	cmp    0x20(%edx),%eax
80103904:	75 ea                	jne    801038f0 <exit+0xc4>
      p->state = RUNNABLE;
80103906:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
8010390d:	eb e1                	jmp    801038f0 <exit+0xc4>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
8010390f:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103916:	e8 71 fe ff ff       	call   8010378c <sched>
  panic("zombie exit");
8010391b:	c7 04 24 1d 6c 10 80 	movl   $0x80106c1d,(%esp)
80103922:	e8 ed c9 ff ff       	call   80100314 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103927:	c7 04 24 10 6c 10 80 	movl   $0x80106c10,(%esp)
8010392e:	e8 e1 c9 ff ff       	call   80100314 <panic>
80103933:	90                   	nop

80103934 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103934:	55                   	push   %ebp
80103935:	89 e5                	mov    %esp,%ebp
80103937:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010393a:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103941:	e8 d6 04 00 00       	call   80103e1c <acquire>
  myproc()->state = RUNNABLE;
80103946:	e8 21 fb ff ff       	call   8010346c <myproc>
8010394b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103952:	e8 35 fe ff ff       	call   8010378c <sched>
  release(&ptable.lock);
80103957:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
8010395e:	e8 91 05 00 00       	call   80103ef4 <release>
}
80103963:	c9                   	leave  
80103964:	c3                   	ret    
80103965:	8d 76 00             	lea    0x0(%esi),%esi

80103968 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103968:	55                   	push   %ebp
80103969:	89 e5                	mov    %esp,%ebp
8010396b:	57                   	push   %edi
8010396c:	56                   	push   %esi
8010396d:	53                   	push   %ebx
8010396e:	83 ec 1c             	sub    $0x1c,%esp
80103971:	8b 7d 08             	mov    0x8(%ebp),%edi
80103974:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103977:	e8 f0 fa ff ff       	call   8010346c <myproc>
8010397c:	89 c3                	mov    %eax,%ebx
  
  if(p == 0)
8010397e:	85 c0                	test   %eax,%eax
80103980:	74 7c                	je     801039fe <sleep+0x96>
    panic("sleep");

  if(lk == 0)
80103982:	85 f6                	test   %esi,%esi
80103984:	74 6c                	je     801039f2 <sleep+0x8a>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103986:	81 fe 60 2f 11 80    	cmp    $0x80112f60,%esi
8010398c:	74 46                	je     801039d4 <sleep+0x6c>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010398e:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103995:	e8 82 04 00 00       	call   80103e1c <acquire>
    release(lk);
8010399a:	89 34 24             	mov    %esi,(%esp)
8010399d:	e8 52 05 00 00       	call   80103ef4 <release>
  }
  // Go to sleep.
  p->chan = chan;
801039a2:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801039a5:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801039ac:	e8 db fd ff ff       	call   8010378c <sched>

  // Tidy up.
  p->chan = 0;
801039b1:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
801039b8:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
801039bf:	e8 30 05 00 00       	call   80103ef4 <release>
    acquire(lk);
801039c4:	89 75 08             	mov    %esi,0x8(%ebp)
  }
}
801039c7:	83 c4 1c             	add    $0x1c,%esp
801039ca:	5b                   	pop    %ebx
801039cb:	5e                   	pop    %esi
801039cc:	5f                   	pop    %edi
801039cd:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
801039ce:	e9 49 04 00 00       	jmp    80103e1c <acquire>
801039d3:	90                   	nop
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
801039d4:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
801039d7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
801039de:	e8 a9 fd ff ff       	call   8010378c <sched>

  // Tidy up.
  p->chan = 0;
801039e3:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
801039ea:	83 c4 1c             	add    $0x1c,%esp
801039ed:	5b                   	pop    %ebx
801039ee:	5e                   	pop    %esi
801039ef:	5f                   	pop    %edi
801039f0:	5d                   	pop    %ebp
801039f1:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
801039f2:	c7 04 24 2f 6c 10 80 	movl   $0x80106c2f,(%esp)
801039f9:	e8 16 c9 ff ff       	call   80100314 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
801039fe:	c7 04 24 29 6c 10 80 	movl   $0x80106c29,(%esp)
80103a05:	e8 0a c9 ff ff       	call   80100314 <panic>
80103a0a:	66 90                	xchg   %ax,%ax

80103a0c <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103a0c:	55                   	push   %ebp
80103a0d:	89 e5                	mov    %esp,%ebp
80103a0f:	56                   	push   %esi
80103a10:	53                   	push   %ebx
80103a11:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103a14:	e8 53 fa ff ff       	call   8010346c <myproc>
80103a19:	89 c6                	mov    %eax,%esi
  
  acquire(&ptable.lock);
80103a1b:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103a22:	e8 f5 03 00 00       	call   80103e1c <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103a27:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a29:	bb 94 2f 11 80       	mov    $0x80112f94,%ebx
80103a2e:	eb 0b                	jmp    80103a3b <wait+0x2f>
80103a30:	83 c3 7c             	add    $0x7c,%ebx
80103a33:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
80103a39:	74 1d                	je     80103a58 <wait+0x4c>
      if(p->parent != curproc)
80103a3b:	39 73 14             	cmp    %esi,0x14(%ebx)
80103a3e:	75 f0                	jne    80103a30 <wait+0x24>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103a40:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103a44:	74 2f                	je     80103a75 <wait+0x69>
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103a46:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a4b:	83 c3 7c             	add    $0x7c,%ebx
80103a4e:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
80103a54:	75 e5                	jne    80103a3b <wait+0x2f>
80103a56:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103a58:	85 c0                	test   %eax,%eax
80103a5a:	74 6e                	je     80103aca <wait+0xbe>
80103a5c:	8b 46 24             	mov    0x24(%esi),%eax
80103a5f:	85 c0                	test   %eax,%eax
80103a61:	75 67                	jne    80103aca <wait+0xbe>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103a63:	c7 44 24 04 60 2f 11 	movl   $0x80112f60,0x4(%esp)
80103a6a:	80 
80103a6b:	89 34 24             	mov    %esi,(%esp)
80103a6e:	e8 f5 fe ff ff       	call   80103968 <sleep>
  }
80103a73:	eb b2                	jmp    80103a27 <wait+0x1b>
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103a75:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103a78:	8b 43 08             	mov    0x8(%ebx),%eax
80103a7b:	89 04 24             	mov    %eax,(%esp)
80103a7e:	e8 c1 e6 ff ff       	call   80102144 <kfree>
        p->kstack = 0;
80103a83:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103a8a:	8b 43 04             	mov    0x4(%ebx),%eax
80103a8d:	89 04 24             	mov    %eax,(%esp)
80103a90:	e8 c7 28 00 00       	call   8010635c <freevm>
        p->pid = 0;
80103a95:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103a9c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103aa3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103aa7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103aae:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103ab5:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103abc:	e8 33 04 00 00       	call   80103ef4 <release>
        return pid;
80103ac1:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ac3:	83 c4 10             	add    $0x10,%esp
80103ac6:	5b                   	pop    %ebx
80103ac7:	5e                   	pop    %esi
80103ac8:	5d                   	pop    %ebp
80103ac9:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103aca:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103ad1:	e8 1e 04 00 00       	call   80103ef4 <release>
      return -1;
80103ad6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103adb:	83 c4 10             	add    $0x10,%esp
80103ade:	5b                   	pop    %ebx
80103adf:	5e                   	pop    %esi
80103ae0:	5d                   	pop    %ebp
80103ae1:	c3                   	ret    
80103ae2:	66 90                	xchg   %ax,%ax

80103ae4 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ae4:	55                   	push   %ebp
80103ae5:	89 e5                	mov    %esp,%ebp
80103ae7:	53                   	push   %ebx
80103ae8:	83 ec 14             	sub    $0x14,%esp
80103aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103aee:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103af5:	e8 22 03 00 00       	call   80103e1c <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103afa:	b8 94 2f 11 80       	mov    $0x80112f94,%eax
80103aff:	eb 0d                	jmp    80103b0e <wakeup+0x2a>
80103b01:	8d 76 00             	lea    0x0(%esi),%esi
80103b04:	83 c0 7c             	add    $0x7c,%eax
80103b07:	3d 94 4e 11 80       	cmp    $0x80114e94,%eax
80103b0c:	74 1e                	je     80103b2c <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103b0e:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103b12:	75 f0                	jne    80103b04 <wakeup+0x20>
80103b14:	3b 58 20             	cmp    0x20(%eax),%ebx
80103b17:	75 eb                	jne    80103b04 <wakeup+0x20>
      p->state = RUNNABLE;
80103b19:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b20:	83 c0 7c             	add    $0x7c,%eax
80103b23:	3d 94 4e 11 80       	cmp    $0x80114e94,%eax
80103b28:	75 e4                	jne    80103b0e <wakeup+0x2a>
80103b2a:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103b2c:	c7 45 08 60 2f 11 80 	movl   $0x80112f60,0x8(%ebp)
}
80103b33:	83 c4 14             	add    $0x14,%esp
80103b36:	5b                   	pop    %ebx
80103b37:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103b38:	e9 b7 03 00 00       	jmp    80103ef4 <release>
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi

80103b40 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	53                   	push   %ebx
80103b44:	83 ec 14             	sub    $0x14,%esp
80103b47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103b4a:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103b51:	e8 c6 02 00 00       	call   80103e1c <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b56:	b8 94 2f 11 80       	mov    $0x80112f94,%eax
80103b5b:	eb 0d                	jmp    80103b6a <kill+0x2a>
80103b5d:	8d 76 00             	lea    0x0(%esi),%esi
80103b60:	83 c0 7c             	add    $0x7c,%eax
80103b63:	3d 94 4e 11 80       	cmp    $0x80114e94,%eax
80103b68:	74 32                	je     80103b9c <kill+0x5c>
    if(p->pid == pid){
80103b6a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103b6d:	75 f1                	jne    80103b60 <kill+0x20>
      p->killed = 1;
80103b6f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103b76:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103b7a:	74 14                	je     80103b90 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103b7c:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103b83:	e8 6c 03 00 00       	call   80103ef4 <release>
      return 0;
80103b88:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103b8a:	83 c4 14             	add    $0x14,%esp
80103b8d:	5b                   	pop    %ebx
80103b8e:	5d                   	pop    %ebp
80103b8f:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103b90:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103b97:	eb e3                	jmp    80103b7c <kill+0x3c>
80103b99:	8d 76 00             	lea    0x0(%esi),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103b9c:	c7 04 24 60 2f 11 80 	movl   $0x80112f60,(%esp)
80103ba3:	e8 4c 03 00 00       	call   80103ef4 <release>
  return -1;
80103ba8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103bad:	83 c4 14             	add    $0x14,%esp
80103bb0:	5b                   	pop    %ebx
80103bb1:	5d                   	pop    %ebp
80103bb2:	c3                   	ret    
80103bb3:	90                   	nop

80103bb4 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103bb4:	55                   	push   %ebp
80103bb5:	89 e5                	mov    %esp,%ebp
80103bb7:	57                   	push   %edi
80103bb8:	56                   	push   %esi
80103bb9:	53                   	push   %ebx
80103bba:	83 ec 4c             	sub    $0x4c,%esp
80103bbd:	bb 00 30 11 80       	mov    $0x80113000,%ebx
80103bc2:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103bc5:	eb 44                	jmp    80103c0b <procdump+0x57>
80103bc7:	90                   	nop
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103bc8:	8b 04 85 a0 6c 10 80 	mov    -0x7fef9360(,%eax,4),%eax
80103bcf:	85 c0                	test   %eax,%eax
80103bd1:	74 44                	je     80103c17 <procdump+0x63>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103bd3:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103bd7:	89 44 24 08          	mov    %eax,0x8(%esp)
80103bdb:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103bde:	89 44 24 04          	mov    %eax,0x4(%esp)
80103be2:	c7 04 24 44 6c 10 80 	movl   $0x80106c44,(%esp)
80103be9:	e8 d6 c9 ff ff       	call   801005c4 <cprintf>
    if(p->state == SLEEPING){
80103bee:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103bf2:	74 2c                	je     80103c20 <procdump+0x6c>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103bf4:	c7 04 24 b7 6f 10 80 	movl   $0x80106fb7,(%esp)
80103bfb:	e8 c4 c9 ff ff       	call   801005c4 <cprintf>
80103c00:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c03:	81 fb 00 4f 11 80    	cmp    $0x80114f00,%ebx
80103c09:	74 51                	je     80103c5c <procdump+0xa8>
    if(p->state == UNUSED)
80103c0b:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103c0e:	85 c0                	test   %eax,%eax
80103c10:	74 ee                	je     80103c00 <procdump+0x4c>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103c12:	83 f8 05             	cmp    $0x5,%eax
80103c15:	76 b1                	jbe    80103bc8 <procdump+0x14>
      state = states[p->state];
    else
      state = "???";
80103c17:	b8 40 6c 10 80       	mov    $0x80106c40,%eax
80103c1c:	eb b5                	jmp    80103bd3 <procdump+0x1f>
80103c1e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103c20:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103c23:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c27:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103c2a:	8b 40 0c             	mov    0xc(%eax),%eax
80103c2d:	83 c0 08             	add    $0x8,%eax
80103c30:	89 04 24             	mov    %eax,(%esp)
80103c33:	e8 38 01 00 00       	call   80103d70 <getcallerpcs>
80103c38:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103c3b:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80103c3c:	8b 17                	mov    (%edi),%edx
80103c3e:	85 d2                	test   %edx,%edx
80103c40:	74 b2                	je     80103bf4 <procdump+0x40>
        cprintf(" %p", pc[i]);
80103c42:	89 54 24 04          	mov    %edx,0x4(%esp)
80103c46:	c7 04 24 81 66 10 80 	movl   $0x80106681,(%esp)
80103c4d:	e8 72 c9 ff ff       	call   801005c4 <cprintf>
80103c52:	83 c7 04             	add    $0x4,%edi
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80103c55:	39 f7                	cmp    %esi,%edi
80103c57:	75 e3                	jne    80103c3c <procdump+0x88>
80103c59:	eb 99                	jmp    80103bf4 <procdump+0x40>
80103c5b:	90                   	nop
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80103c5c:	83 c4 4c             	add    $0x4c,%esp
80103c5f:	5b                   	pop    %ebx
80103c60:	5e                   	pop    %esi
80103c61:	5f                   	pop    %edi
80103c62:	5d                   	pop    %ebp
80103c63:	c3                   	ret    

80103c64 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80103c64:	55                   	push   %ebp
80103c65:	89 e5                	mov    %esp,%ebp
80103c67:	53                   	push   %ebx
80103c68:	83 ec 14             	sub    $0x14,%esp
80103c6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103c6e:	c7 44 24 04 b8 6c 10 	movl   $0x80106cb8,0x4(%esp)
80103c75:	80 
80103c76:	8d 43 04             	lea    0x4(%ebx),%eax
80103c79:	89 04 24             	mov    %eax,(%esp)
80103c7c:	e8 d3 00 00 00       	call   80103d54 <initlock>
  lk->name = name;
80103c81:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c84:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103c87:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103c8d:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
80103c94:	83 c4 14             	add    $0x14,%esp
80103c97:	5b                   	pop    %ebx
80103c98:	5d                   	pop    %ebp
80103c99:	c3                   	ret    
80103c9a:	66 90                	xchg   %ax,%ax

80103c9c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80103c9c:	55                   	push   %ebp
80103c9d:	89 e5                	mov    %esp,%ebp
80103c9f:	56                   	push   %esi
80103ca0:	53                   	push   %ebx
80103ca1:	83 ec 10             	sub    $0x10,%esp
80103ca4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103ca7:	8d 73 04             	lea    0x4(%ebx),%esi
80103caa:	89 34 24             	mov    %esi,(%esp)
80103cad:	e8 6a 01 00 00       	call   80103e1c <acquire>
  while (lk->locked) {
80103cb2:	8b 13                	mov    (%ebx),%edx
80103cb4:	85 d2                	test   %edx,%edx
80103cb6:	74 12                	je     80103cca <acquiresleep+0x2e>
    sleep(lk, &lk->lk);
80103cb8:	89 74 24 04          	mov    %esi,0x4(%esp)
80103cbc:	89 1c 24             	mov    %ebx,(%esp)
80103cbf:	e8 a4 fc ff ff       	call   80103968 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80103cc4:	8b 03                	mov    (%ebx),%eax
80103cc6:	85 c0                	test   %eax,%eax
80103cc8:	75 ee                	jne    80103cb8 <acquiresleep+0x1c>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80103cca:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80103cd0:	e8 97 f7 ff ff       	call   8010346c <myproc>
80103cd5:	8b 40 10             	mov    0x10(%eax),%eax
80103cd8:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80103cdb:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103cde:	83 c4 10             	add    $0x10,%esp
80103ce1:	5b                   	pop    %ebx
80103ce2:	5e                   	pop    %esi
80103ce3:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
80103ce4:	e9 0b 02 00 00       	jmp    80103ef4 <release>
80103ce9:	8d 76 00             	lea    0x0(%esi),%esi

80103cec <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80103cec:	55                   	push   %ebp
80103ced:	89 e5                	mov    %esp,%ebp
80103cef:	56                   	push   %esi
80103cf0:	53                   	push   %ebx
80103cf1:	83 ec 10             	sub    $0x10,%esp
80103cf4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103cf7:	8d 73 04             	lea    0x4(%ebx),%esi
80103cfa:	89 34 24             	mov    %esi,(%esp)
80103cfd:	e8 1a 01 00 00       	call   80103e1c <acquire>
  lk->locked = 0;
80103d02:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103d08:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80103d0f:	89 1c 24             	mov    %ebx,(%esp)
80103d12:	e8 cd fd ff ff       	call   80103ae4 <wakeup>
  release(&lk->lk);
80103d17:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103d1a:	83 c4 10             	add    $0x10,%esp
80103d1d:	5b                   	pop    %ebx
80103d1e:	5e                   	pop    %esi
80103d1f:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80103d20:	e9 cf 01 00 00       	jmp    80103ef4 <release>
80103d25:	8d 76 00             	lea    0x0(%esi),%esi

80103d28 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80103d28:	55                   	push   %ebp
80103d29:	89 e5                	mov    %esp,%ebp
80103d2b:	56                   	push   %esi
80103d2c:	53                   	push   %ebx
80103d2d:	83 ec 10             	sub    $0x10,%esp
80103d30:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80103d33:	8d 73 04             	lea    0x4(%ebx),%esi
80103d36:	89 34 24             	mov    %esi,(%esp)
80103d39:	e8 de 00 00 00       	call   80103e1c <acquire>
  r = lk->locked;
80103d3e:	8b 1b                	mov    (%ebx),%ebx
  release(&lk->lk);
80103d40:	89 34 24             	mov    %esi,(%esp)
80103d43:	e8 ac 01 00 00       	call   80103ef4 <release>
  return r;
}
80103d48:	89 d8                	mov    %ebx,%eax
80103d4a:	83 c4 10             	add    $0x10,%esp
80103d4d:	5b                   	pop    %ebx
80103d4e:	5e                   	pop    %esi
80103d4f:	5d                   	pop    %ebp
80103d50:	c3                   	ret    
80103d51:	66 90                	xchg   %ax,%ax
80103d53:	90                   	nop

80103d54 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103d54:	55                   	push   %ebp
80103d55:	89 e5                	mov    %esp,%ebp
80103d57:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80103d5a:	8b 55 0c             	mov    0xc(%ebp),%edx
80103d5d:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103d60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103d66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80103d6d:	5d                   	pop    %ebp
80103d6e:	c3                   	ret    
80103d6f:	90                   	nop

80103d70 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	53                   	push   %ebx
80103d74:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103d77:	8b 45 08             	mov    0x8(%ebp),%eax
80103d7a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
80103d7d:	31 c0                	xor    %eax,%eax
80103d7f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103d80:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80103d86:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80103d8c:	77 12                	ja     80103da0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103d8e:	8b 5a 04             	mov    0x4(%edx),%ebx
80103d91:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103d94:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80103d96:	40                   	inc    %eax
80103d97:	83 f8 0a             	cmp    $0xa,%eax
80103d9a:	75 e4                	jne    80103d80 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80103d9c:	5b                   	pop    %ebx
80103d9d:	5d                   	pop    %ebp
80103d9e:	c3                   	ret    
80103d9f:	90                   	nop
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80103da0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80103da7:	40                   	inc    %eax
80103da8:	83 f8 0a             	cmp    $0xa,%eax
80103dab:	74 ef                	je     80103d9c <getcallerpcs+0x2c>
    pcs[i] = 0;
80103dad:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80103db4:	40                   	inc    %eax
80103db5:	83 f8 0a             	cmp    $0xa,%eax
80103db8:	75 e6                	jne    80103da0 <getcallerpcs+0x30>
80103dba:	eb e0                	jmp    80103d9c <getcallerpcs+0x2c>

80103dbc <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80103dbc:	55                   	push   %ebp
80103dbd:	89 e5                	mov    %esp,%ebp
80103dbf:	53                   	push   %ebx
80103dc0:	51                   	push   %ecx
80103dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == mycpu();
80103dc4:	8b 18                	mov    (%eax),%ebx
80103dc6:	85 db                	test   %ebx,%ebx
80103dc8:	75 06                	jne    80103dd0 <holding+0x14>
80103dca:	31 c0                	xor    %eax,%eax
}
80103dcc:	5a                   	pop    %edx
80103dcd:	5b                   	pop    %ebx
80103dce:	5d                   	pop    %ebp
80103dcf:	c3                   	ret    

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103dd0:	8b 58 08             	mov    0x8(%eax),%ebx
80103dd3:	e8 e8 f5 ff ff       	call   801033c0 <mycpu>
80103dd8:	39 c3                	cmp    %eax,%ebx
80103dda:	0f 94 c0             	sete   %al
80103ddd:	0f b6 c0             	movzbl %al,%eax
}
80103de0:	5a                   	pop    %edx
80103de1:	5b                   	pop    %ebx
80103de2:	5d                   	pop    %ebp
80103de3:	c3                   	ret    

80103de4 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80103de4:	55                   	push   %ebp
80103de5:	89 e5                	mov    %esp,%ebp
80103de7:	53                   	push   %ebx
80103de8:	50                   	push   %eax
80103de9:	9c                   	pushf  
80103dea:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80103deb:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80103dec:	e8 cf f5 ff ff       	call   801033c0 <mycpu>
80103df1:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80103df7:	85 c0                	test   %eax,%eax
80103df9:	75 11                	jne    80103e0c <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
80103dfb:	e8 c0 f5 ff ff       	call   801033c0 <mycpu>
80103e00:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103e06:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80103e0c:	e8 af f5 ff ff       	call   801033c0 <mycpu>
80103e11:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103e17:	58                   	pop    %eax
80103e18:	5b                   	pop    %ebx
80103e19:	5d                   	pop    %ebp
80103e1a:	c3                   	ret    
80103e1b:	90                   	nop

80103e1c <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80103e1c:	55                   	push   %ebp
80103e1d:	89 e5                	mov    %esp,%ebp
80103e1f:	53                   	push   %ebx
80103e20:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80103e23:	e8 bc ff ff ff       	call   80103de4 <pushcli>
  if(holding(lk))
80103e28:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103e2b:	8b 02                	mov    (%edx),%eax
80103e2d:	85 c0                	test   %eax,%eax
80103e2f:	75 3f                	jne    80103e70 <acquire+0x54>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103e31:	b9 01 00 00 00       	mov    $0x1,%ecx
80103e36:	eb 03                	jmp    80103e3b <acquire+0x1f>
80103e38:	8b 55 08             	mov    0x8(%ebp),%edx
80103e3b:	89 c8                	mov    %ecx,%eax
80103e3d:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80103e40:	85 c0                	test   %eax,%eax
80103e42:	75 f4                	jne    80103e38 <acquire+0x1c>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80103e44:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80103e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103e4c:	e8 6f f5 ff ff       	call   801033c0 <mycpu>
80103e51:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80103e54:	8b 45 08             	mov    0x8(%ebp),%eax
80103e57:	83 c0 0c             	add    $0xc,%eax
80103e5a:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e5e:	8d 45 08             	lea    0x8(%ebp),%eax
80103e61:	89 04 24             	mov    %eax,(%esp)
80103e64:	e8 07 ff ff ff       	call   80103d70 <getcallerpcs>
}
80103e69:	83 c4 14             	add    $0x14,%esp
80103e6c:	5b                   	pop    %ebx
80103e6d:	5d                   	pop    %ebp
80103e6e:	c3                   	ret    
80103e6f:	90                   	nop

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103e70:	8b 5a 08             	mov    0x8(%edx),%ebx
80103e73:	e8 48 f5 ff ff       	call   801033c0 <mycpu>
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
80103e78:	39 c3                	cmp    %eax,%ebx
80103e7a:	74 05                	je     80103e81 <acquire+0x65>
80103e7c:	8b 55 08             	mov    0x8(%ebp),%edx
80103e7f:	eb b0                	jmp    80103e31 <acquire+0x15>
    panic("acquire");
80103e81:	c7 04 24 c3 6c 10 80 	movl   $0x80106cc3,(%esp)
80103e88:	e8 87 c4 ff ff       	call   80100314 <panic>
80103e8d:	8d 76 00             	lea    0x0(%esi),%esi

80103e90 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e96:	9c                   	pushf  
80103e97:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e98:	f6 c4 02             	test   $0x2,%ah
80103e9b:	75 49                	jne    80103ee6 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103e9d:	e8 1e f5 ff ff       	call   801033c0 <mycpu>
80103ea2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103ea8:	8d 51 ff             	lea    -0x1(%ecx),%edx
80103eab:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80103eb1:	85 d2                	test   %edx,%edx
80103eb3:	78 25                	js     80103eda <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103eb5:	e8 06 f5 ff ff       	call   801033c0 <mycpu>
80103eba:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80103ec0:	85 c0                	test   %eax,%eax
80103ec2:	74 04                	je     80103ec8 <popcli+0x38>
    sti();
}
80103ec4:	c9                   	leave  
80103ec5:	c3                   	ret    
80103ec6:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103ec8:	e8 f3 f4 ff ff       	call   801033c0 <mycpu>
80103ecd:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103ed3:	85 c0                	test   %eax,%eax
80103ed5:	74 ed                	je     80103ec4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ed7:	fb                   	sti    
    sti();
}
80103ed8:	c9                   	leave  
80103ed9:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80103eda:	c7 04 24 e2 6c 10 80 	movl   $0x80106ce2,(%esp)
80103ee1:	e8 2e c4 ff ff       	call   80100314 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80103ee6:	c7 04 24 cb 6c 10 80 	movl   $0x80106ccb,(%esp)
80103eed:	e8 22 c4 ff ff       	call   80100314 <panic>
80103ef2:	66 90                	xchg   %ax,%ax

80103ef4 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80103ef4:	55                   	push   %ebp
80103ef5:	89 e5                	mov    %esp,%ebp
80103ef7:	56                   	push   %esi
80103ef8:	53                   	push   %ebx
80103ef9:	83 ec 10             	sub    $0x10,%esp
80103efc:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103eff:	8b 13                	mov    (%ebx),%edx
80103f01:	85 d2                	test   %edx,%edx
80103f03:	75 0f                	jne    80103f14 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80103f05:	c7 04 24 e9 6c 10 80 	movl   $0x80106ce9,(%esp)
80103f0c:	e8 03 c4 ff ff       	call   80100314 <panic>
80103f11:	8d 76 00             	lea    0x0(%esi),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80103f14:	8b 73 08             	mov    0x8(%ebx),%esi
80103f17:	e8 a4 f4 ff ff       	call   801033c0 <mycpu>

// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
80103f1c:	39 c6                	cmp    %eax,%esi
80103f1e:	75 e5                	jne    80103f05 <release+0x11>
    panic("release");

  lk->pcs[0] = 0;
80103f20:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80103f27:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80103f2e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80103f33:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80103f39:	83 c4 10             	add    $0x10,%esp
80103f3c:	5b                   	pop    %ebx
80103f3d:	5e                   	pop    %esi
80103f3e:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80103f3f:	e9 4c ff ff ff       	jmp    80103e90 <popcli>

80103f44 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80103f44:	55                   	push   %ebp
80103f45:	89 e5                	mov    %esp,%ebp
80103f47:	57                   	push   %edi
80103f48:	53                   	push   %ebx
80103f49:	8b 55 08             	mov    0x8(%ebp),%edx
  if ((int)dst%4 == 0 && n%4 == 0){
80103f4c:	f6 c2 03             	test   $0x3,%dl
80103f4f:	75 06                	jne    80103f57 <memset+0x13>
80103f51:	f6 45 10 03          	testb  $0x3,0x10(%ebp)
80103f55:	74 11                	je     80103f68 <memset+0x24>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80103f57:	89 d7                	mov    %edx,%edi
80103f59:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f5f:	fc                   	cld    
80103f60:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80103f62:	89 d0                	mov    %edx,%eax
80103f64:	5b                   	pop    %ebx
80103f65:	5f                   	pop    %edi
80103f66:	5d                   	pop    %ebp
80103f67:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80103f68:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80103f6c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103f6f:	c1 e9 02             	shr    $0x2,%ecx
80103f72:	89 f8                	mov    %edi,%eax
80103f74:	c1 e0 18             	shl    $0x18,%eax
80103f77:	89 fb                	mov    %edi,%ebx
80103f79:	c1 e3 10             	shl    $0x10,%ebx
80103f7c:	09 d8                	or     %ebx,%eax
80103f7e:	09 f8                	or     %edi,%eax
80103f80:	c1 e7 08             	shl    $0x8,%edi
80103f83:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80103f85:	89 d7                	mov    %edx,%edi
80103f87:	fc                   	cld    
80103f88:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80103f8a:	89 d0                	mov    %edx,%eax
80103f8c:	5b                   	pop    %ebx
80103f8d:	5f                   	pop    %edi
80103f8e:	5d                   	pop    %ebp
80103f8f:	c3                   	ret    

80103f90 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	57                   	push   %edi
80103f94:	56                   	push   %esi
80103f95:	53                   	push   %ebx
80103f96:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103f99:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f9c:	8b 45 10             	mov    0x10(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103f9f:	8d 78 ff             	lea    -0x1(%eax),%edi
80103fa2:	85 c0                	test   %eax,%eax
80103fa4:	74 20                	je     80103fc6 <memcmp+0x36>
    if(*s1 != *s2)
80103fa6:	0f b6 03             	movzbl (%ebx),%eax
80103fa9:	0f b6 0e             	movzbl (%esi),%ecx
80103fac:	31 d2                	xor    %edx,%edx
80103fae:	38 c8                	cmp    %cl,%al
80103fb0:	74 10                	je     80103fc2 <memcmp+0x32>
80103fb2:	eb 1c                	jmp    80103fd0 <memcmp+0x40>
80103fb4:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
80103fb9:	42                   	inc    %edx
80103fba:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80103fbe:	38 c8                	cmp    %cl,%al
80103fc0:	75 0e                	jne    80103fd0 <memcmp+0x40>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103fc2:	39 fa                	cmp    %edi,%edx
80103fc4:	75 ee                	jne    80103fb4 <memcmp+0x24>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80103fc6:	31 c0                	xor    %eax,%eax
}
80103fc8:	5b                   	pop    %ebx
80103fc9:	5e                   	pop    %esi
80103fca:	5f                   	pop    %edi
80103fcb:	5d                   	pop    %ebp
80103fcc:	c3                   	ret    
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80103fd0:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80103fd2:	5b                   	pop    %ebx
80103fd3:	5e                   	pop    %esi
80103fd4:	5f                   	pop    %edi
80103fd5:	5d                   	pop    %ebp
80103fd6:	c3                   	ret    
80103fd7:	90                   	nop

80103fd8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80103fd8:	55                   	push   %ebp
80103fd9:	89 e5                	mov    %esp,%ebp
80103fdb:	57                   	push   %edi
80103fdc:	56                   	push   %esi
80103fdd:	53                   	push   %ebx
80103fde:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80103fe4:	3b 5d 08             	cmp    0x8(%ebp),%ebx
80103fe7:	73 33                	jae    8010401c <memmove+0x44>
80103fe9:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80103fec:	39 75 08             	cmp    %esi,0x8(%ebp)
80103fef:	73 2b                	jae    8010401c <memmove+0x44>
    s += n;
    d += n;
80103ff1:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ff4:	01 c7                	add    %eax,%edi
    while(n-- > 0)
80103ff6:	8d 50 ff             	lea    -0x1(%eax),%edx
80103ff9:	85 c0                	test   %eax,%eax
80103ffb:	74 17                	je     80104014 <memmove+0x3c>
80103ffd:	f7 d8                	neg    %eax
80103fff:	89 c1                	mov    %eax,%ecx
80104001:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80104004:	01 f9                	add    %edi,%ecx
80104006:	66 90                	xchg   %ax,%ax
      *--d = *--s;
80104008:	8a 04 13             	mov    (%ebx,%edx,1),%al
8010400b:	88 04 11             	mov    %al,(%ecx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010400e:	4a                   	dec    %edx
8010400f:	83 fa ff             	cmp    $0xffffffff,%edx
80104012:	75 f4                	jne    80104008 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104014:	8b 45 08             	mov    0x8(%ebp),%eax
80104017:	5b                   	pop    %ebx
80104018:	5e                   	pop    %esi
80104019:	5f                   	pop    %edi
8010401a:	5d                   	pop    %ebp
8010401b:	c3                   	ret    
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010401c:	31 d2                	xor    %edx,%edx
8010401e:	85 c0                	test   %eax,%eax
80104020:	74 f2                	je     80104014 <memmove+0x3c>
80104022:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104024:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
80104027:	8b 7d 08             	mov    0x8(%ebp),%edi
8010402a:	88 0c 17             	mov    %cl,(%edi,%edx,1)
8010402d:	42                   	inc    %edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010402e:	39 c2                	cmp    %eax,%edx
80104030:	75 f2                	jne    80104024 <memmove+0x4c>
      *d++ = *s++;

  return dst;
}
80104032:	8b 45 08             	mov    0x8(%ebp),%eax
80104035:	5b                   	pop    %ebx
80104036:	5e                   	pop    %esi
80104037:	5f                   	pop    %edi
80104038:	5d                   	pop    %ebp
80104039:	c3                   	ret    
8010403a:	66 90                	xchg   %ax,%ax

8010403c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
8010403c:	55                   	push   %ebp
8010403d:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
8010403f:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104040:	e9 93 ff ff ff       	jmp    80103fd8 <memmove>
80104045:	8d 76 00             	lea    0x0(%esi),%esi

80104048 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104048:	55                   	push   %ebp
80104049:	89 e5                	mov    %esp,%ebp
8010404b:	56                   	push   %esi
8010404c:	53                   	push   %ebx
8010404d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104050:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104053:	8b 75 10             	mov    0x10(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104056:	85 f6                	test   %esi,%esi
80104058:	74 2d                	je     80104087 <strncmp+0x3f>
8010405a:	0f b6 01             	movzbl (%ecx),%eax
8010405d:	84 c0                	test   %al,%al
8010405f:	74 2c                	je     8010408d <strncmp+0x45>
80104061:	8a 13                	mov    (%ebx),%dl
80104063:	38 d0                	cmp    %dl,%al
80104065:	75 3e                	jne    801040a5 <strncmp+0x5d>
80104067:	8d 51 01             	lea    0x1(%ecx),%edx
8010406a:	01 ce                	add    %ecx,%esi
8010406c:	eb 12                	jmp    80104080 <strncmp+0x38>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	0f b6 02             	movzbl (%edx),%eax
80104073:	84 c0                	test   %al,%al
80104075:	74 29                	je     801040a0 <strncmp+0x58>
80104077:	8a 19                	mov    (%ecx),%bl
80104079:	42                   	inc    %edx
8010407a:	38 d8                	cmp    %bl,%al
8010407c:	75 16                	jne    80104094 <strncmp+0x4c>
    n--, p++, q++;
8010407e:	89 cb                	mov    %ecx,%ebx
80104080:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104083:	39 f2                	cmp    %esi,%edx
80104085:	75 e9                	jne    80104070 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
80104087:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80104089:	5b                   	pop    %ebx
8010408a:	5e                   	pop    %esi
8010408b:	5d                   	pop    %ebp
8010408c:	c3                   	ret    
8010408d:	8a 1b                	mov    (%ebx),%bl
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010408f:	31 c0                	xor    %eax,%eax
80104091:	8d 76 00             	lea    0x0(%esi),%esi
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104094:	0f b6 d3             	movzbl %bl,%edx
80104097:	29 d0                	sub    %edx,%eax
}
80104099:	5b                   	pop    %ebx
8010409a:	5e                   	pop    %esi
8010409b:	5d                   	pop    %ebp
8010409c:	c3                   	ret    
8010409d:	8d 76 00             	lea    0x0(%esi),%esi
801040a0:	8a 5b 01             	mov    0x1(%ebx),%bl
801040a3:	eb ef                	jmp    80104094 <strncmp+0x4c>
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801040a5:	88 d3                	mov    %dl,%bl
801040a7:	eb eb                	jmp    80104094 <strncmp+0x4c>
801040a9:	8d 76 00             	lea    0x0(%esi),%esi

801040ac <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
801040ac:	55                   	push   %ebp
801040ad:	89 e5                	mov    %esp,%ebp
801040af:	56                   	push   %esi
801040b0:	53                   	push   %ebx
801040b1:	8b 45 08             	mov    0x8(%ebp),%eax
801040b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801040b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801040ba:	89 c2                	mov    %eax,%edx
801040bc:	eb 10                	jmp    801040ce <strncpy+0x22>
801040be:	66 90                	xchg   %ax,%ax
801040c0:	42                   	inc    %edx
801040c1:	43                   	inc    %ebx
801040c2:	8a 4b ff             	mov    -0x1(%ebx),%cl
801040c5:	88 4a ff             	mov    %cl,-0x1(%edx)
801040c8:	84 c9                	test   %cl,%cl
801040ca:	74 09                	je     801040d5 <strncpy+0x29>
801040cc:	89 f1                	mov    %esi,%ecx
801040ce:	8d 71 ff             	lea    -0x1(%ecx),%esi
801040d1:	85 c9                	test   %ecx,%ecx
801040d3:	7f eb                	jg     801040c0 <strncpy+0x14>
    ;
  while(n-- > 0)
801040d5:	31 c9                	xor    %ecx,%ecx
801040d7:	85 f6                	test   %esi,%esi
801040d9:	7e 0e                	jle    801040e9 <strncpy+0x3d>
801040db:	90                   	nop
    *s++ = 0;
801040dc:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801040e0:	41                   	inc    %ecx
801040e1:	89 f3                	mov    %esi,%ebx
801040e3:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801040e5:	85 db                	test   %ebx,%ebx
801040e7:	7f f3                	jg     801040dc <strncpy+0x30>
    *s++ = 0;
  return os;
}
801040e9:	5b                   	pop    %ebx
801040ea:	5e                   	pop    %esi
801040eb:	5d                   	pop    %ebp
801040ec:	c3                   	ret    
801040ed:	8d 76 00             	lea    0x0(%esi),%esi

801040f0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	56                   	push   %esi
801040f4:	53                   	push   %ebx
801040f5:	8b 45 08             	mov    0x8(%ebp),%eax
801040f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801040fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  if(n <= 0)
801040fe:	85 c9                	test   %ecx,%ecx
80104100:	7e 1d                	jle    8010411f <safestrcpy+0x2f>
80104102:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104106:	89 c1                	mov    %eax,%ecx
80104108:	eb 0e                	jmp    80104118 <safestrcpy+0x28>
8010410a:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
8010410c:	41                   	inc    %ecx
8010410d:	42                   	inc    %edx
8010410e:	8a 5a ff             	mov    -0x1(%edx),%bl
80104111:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104114:	84 db                	test   %bl,%bl
80104116:	74 04                	je     8010411c <safestrcpy+0x2c>
80104118:	39 f2                	cmp    %esi,%edx
8010411a:	75 f0                	jne    8010410c <safestrcpy+0x1c>
    ;
  *s = 0;
8010411c:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
8010411f:	5b                   	pop    %ebx
80104120:	5e                   	pop    %esi
80104121:	5d                   	pop    %ebp
80104122:	c3                   	ret    
80104123:	90                   	nop

80104124 <strlen>:

int
strlen(const char *s)
{
80104124:	55                   	push   %ebp
80104125:	89 e5                	mov    %esp,%ebp
80104127:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
8010412a:	31 c0                	xor    %eax,%eax
8010412c:	80 3a 00             	cmpb   $0x0,(%edx)
8010412f:	74 0a                	je     8010413b <strlen+0x17>
80104131:	8d 76 00             	lea    0x0(%esi),%esi
80104134:	40                   	inc    %eax
80104135:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104139:	75 f9                	jne    80104134 <strlen+0x10>
    ;
  return n;
}
8010413b:	5d                   	pop    %ebp
8010413c:	c3                   	ret    
8010413d:	66 90                	xchg   %ax,%ax
8010413f:	90                   	nop

80104140 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104140:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104144:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104148:	55                   	push   %ebp
  pushl %ebx
80104149:	53                   	push   %ebx
  pushl %esi
8010414a:	56                   	push   %esi
  pushl %edi
8010414b:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
8010414c:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010414e:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80104150:	5f                   	pop    %edi
  popl %esi
80104151:	5e                   	pop    %esi
  popl %ebx
80104152:	5b                   	pop    %ebx
  popl %ebp
80104153:	5d                   	pop    %ebp
  ret
80104154:	c3                   	ret    
80104155:	66 90                	xchg   %ax,%ax
80104157:	90                   	nop

80104158 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104158:	55                   	push   %ebp
80104159:	89 e5                	mov    %esp,%ebp
8010415b:	53                   	push   %ebx
8010415c:	51                   	push   %ecx
8010415d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104160:	e8 07 f3 ff ff       	call   8010346c <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104165:	8b 00                	mov    (%eax),%eax
80104167:	39 d8                	cmp    %ebx,%eax
80104169:	76 15                	jbe    80104180 <fetchint+0x28>
8010416b:	8d 53 04             	lea    0x4(%ebx),%edx
8010416e:	39 d0                	cmp    %edx,%eax
80104170:	72 0e                	jb     80104180 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
80104172:	8b 13                	mov    (%ebx),%edx
80104174:	8b 45 0c             	mov    0xc(%ebp),%eax
80104177:	89 10                	mov    %edx,(%eax)
  return 0;
80104179:	31 c0                	xor    %eax,%eax
}
8010417b:	5a                   	pop    %edx
8010417c:	5b                   	pop    %ebx
8010417d:	5d                   	pop    %ebp
8010417e:	c3                   	ret    
8010417f:	90                   	nop
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104185:	eb f4                	jmp    8010417b <fetchint+0x23>
80104187:	90                   	nop

80104188 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104188:	55                   	push   %ebp
80104189:	89 e5                	mov    %esp,%ebp
8010418b:	53                   	push   %ebx
8010418c:	50                   	push   %eax
8010418d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104190:	e8 d7 f2 ff ff       	call   8010346c <myproc>

  if(addr >= curproc->sz)
80104195:	39 18                	cmp    %ebx,(%eax)
80104197:	76 21                	jbe    801041ba <fetchstr+0x32>
    return -1;
  *pp = (char*)addr;
80104199:	89 da                	mov    %ebx,%edx
8010419b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010419e:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801041a0:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801041a2:	39 c3                	cmp    %eax,%ebx
801041a4:	73 14                	jae    801041ba <fetchstr+0x32>
    if(*s == 0)
801041a6:	80 3b 00             	cmpb   $0x0,(%ebx)
801041a9:	75 0a                	jne    801041b5 <fetchstr+0x2d>
801041ab:	eb 17                	jmp    801041c4 <fetchstr+0x3c>
801041ad:	8d 76 00             	lea    0x0(%esi),%esi
801041b0:	80 3a 00             	cmpb   $0x0,(%edx)
801041b3:	74 0f                	je     801041c4 <fetchstr+0x3c>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801041b5:	42                   	inc    %edx
801041b6:	39 d0                	cmp    %edx,%eax
801041b8:	77 f6                	ja     801041b0 <fetchstr+0x28>
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801041ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801041bf:	5b                   	pop    %ebx
801041c0:	5b                   	pop    %ebx
801041c1:	5d                   	pop    %ebp
801041c2:	c3                   	ret    
801041c3:	90                   	nop
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801041c4:	89 d0                	mov    %edx,%eax
801041c6:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801041c8:	5b                   	pop    %ebx
801041c9:	5b                   	pop    %ebx
801041ca:	5d                   	pop    %ebp
801041cb:	c3                   	ret    

801041cc <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801041cc:	55                   	push   %ebp
801041cd:	89 e5                	mov    %esp,%ebp
801041cf:	56                   	push   %esi
801041d0:	53                   	push   %ebx
801041d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801041d4:	8b 75 0c             	mov    0xc(%ebp),%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801041d7:	e8 90 f2 ff ff       	call   8010346c <myproc>
801041dc:	89 75 0c             	mov    %esi,0xc(%ebp)
801041df:	8b 40 18             	mov    0x18(%eax),%eax
801041e2:	8b 40 44             	mov    0x44(%eax),%eax
801041e5:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
801041e9:	89 45 08             	mov    %eax,0x8(%ebp)
}
801041ec:	5b                   	pop    %ebx
801041ed:	5e                   	pop    %esi
801041ee:	5d                   	pop    %ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801041ef:	e9 64 ff ff ff       	jmp    80104158 <fetchint>

801041f4 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801041f4:	55                   	push   %ebp
801041f5:	89 e5                	mov    %esp,%ebp
801041f7:	56                   	push   %esi
801041f8:	53                   	push   %ebx
801041f9:	83 ec 20             	sub    $0x20,%esp
801041fc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801041ff:	e8 68 f2 ff ff       	call   8010346c <myproc>
80104204:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104206:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104209:	89 44 24 04          	mov    %eax,0x4(%esp)
8010420d:	8b 45 08             	mov    0x8(%ebp),%eax
80104210:	89 04 24             	mov    %eax,(%esp)
80104213:	e8 b4 ff ff ff       	call   801041cc <argint>
80104218:	85 c0                	test   %eax,%eax
8010421a:	78 24                	js     80104240 <argptr+0x4c>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010421c:	85 db                	test   %ebx,%ebx
8010421e:	78 20                	js     80104240 <argptr+0x4c>
80104220:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104223:	8b 06                	mov    (%esi),%eax
80104225:	39 c2                	cmp    %eax,%edx
80104227:	73 17                	jae    80104240 <argptr+0x4c>
80104229:	01 d3                	add    %edx,%ebx
8010422b:	39 d8                	cmp    %ebx,%eax
8010422d:	72 11                	jb     80104240 <argptr+0x4c>
    return -1;
  *pp = (char*)i;
8010422f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104232:	89 10                	mov    %edx,(%eax)
  return 0;
80104234:	31 c0                	xor    %eax,%eax
}
80104236:	83 c4 20             	add    $0x20,%esp
80104239:	5b                   	pop    %ebx
8010423a:	5e                   	pop    %esi
8010423b:	5d                   	pop    %ebp
8010423c:	c3                   	ret    
8010423d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
80104240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}
80104245:	83 c4 20             	add    $0x20,%esp
80104248:	5b                   	pop    %ebx
80104249:	5e                   	pop    %esi
8010424a:	5d                   	pop    %ebp
8010424b:	c3                   	ret    

8010424c <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010424c:	55                   	push   %ebp
8010424d:	89 e5                	mov    %esp,%ebp
8010424f:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104252:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104255:	89 44 24 04          	mov    %eax,0x4(%esp)
80104259:	8b 45 08             	mov    0x8(%ebp),%eax
8010425c:	89 04 24             	mov    %eax,(%esp)
8010425f:	e8 68 ff ff ff       	call   801041cc <argint>
80104264:	85 c0                	test   %eax,%eax
80104266:	78 14                	js     8010427c <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104268:	8b 45 0c             	mov    0xc(%ebp),%eax
8010426b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010426f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104272:	89 04 24             	mov    %eax,(%esp)
80104275:	e8 0e ff ff ff       	call   80104188 <fetchstr>
}
8010427a:	c9                   	leave  
8010427b:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
8010427c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104281:	c9                   	leave  
80104282:	c3                   	ret    
80104283:	90                   	nop

80104284 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104284:	55                   	push   %ebp
80104285:	89 e5                	mov    %esp,%ebp
80104287:	53                   	push   %ebx
80104288:	83 ec 24             	sub    $0x24,%esp
  int num;
  struct proc *curproc = myproc();
8010428b:	e8 dc f1 ff ff       	call   8010346c <myproc>

  num = curproc->tf->eax;
80104290:	8b 58 18             	mov    0x18(%eax),%ebx
80104293:	8b 53 1c             	mov    0x1c(%ebx),%edx
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104296:	8d 4a ff             	lea    -0x1(%edx),%ecx
80104299:	83 f9 14             	cmp    $0x14,%ecx
8010429c:	77 16                	ja     801042b4 <syscall+0x30>
8010429e:	8b 0c 95 20 6d 10 80 	mov    -0x7fef92e0(,%edx,4),%ecx
801042a5:	85 c9                	test   %ecx,%ecx
801042a7:	74 0b                	je     801042b4 <syscall+0x30>
    curproc->tf->eax = syscalls[num]();
801042a9:	ff d1                	call   *%ecx
801042ab:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801042ae:	83 c4 24             	add    $0x24,%esp
801042b1:	5b                   	pop    %ebx
801042b2:	5d                   	pop    %ebp
801042b3:	c3                   	ret    

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801042b4:	89 54 24 0c          	mov    %edx,0xc(%esp)
            curproc->pid, curproc->name, num);
801042b8:	8d 50 6c             	lea    0x6c(%eax),%edx
801042bb:	89 54 24 08          	mov    %edx,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801042bf:	8b 50 10             	mov    0x10(%eax),%edx
801042c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042c5:	89 54 24 04          	mov    %edx,0x4(%esp)
801042c9:	c7 04 24 f1 6c 10 80 	movl   $0x80106cf1,(%esp)
801042d0:	e8 ef c2 ff ff       	call   801005c4 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
801042d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042d8:	8b 40 18             	mov    0x18(%eax),%eax
801042db:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801042e2:	83 c4 24             	add    $0x24,%esp
801042e5:	5b                   	pop    %ebx
801042e6:	5d                   	pop    %ebp
801042e7:	c3                   	ret    

801042e8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801042e8:	55                   	push   %ebp
801042e9:	89 e5                	mov    %esp,%ebp
801042eb:	53                   	push   %ebx
801042ec:	53                   	push   %ebx
801042ed:	89 c3                	mov    %eax,%ebx
  int fd;
  struct proc *curproc = myproc();
801042ef:	e8 78 f1 ff ff       	call   8010346c <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801042f4:	31 d2                	xor    %edx,%edx
801042f6:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801042f8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801042fc:	85 c9                	test   %ecx,%ecx
801042fe:	74 10                	je     80104310 <fdalloc+0x28>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104300:	42                   	inc    %edx
80104301:	83 fa 10             	cmp    $0x10,%edx
80104304:	75 f2                	jne    801042f8 <fdalloc+0x10>
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80104306:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010430b:	5a                   	pop    %edx
8010430c:	5b                   	pop    %ebx
8010430d:	5d                   	pop    %ebp
8010430e:	c3                   	ret    
8010430f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104310:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
      return fd;
80104314:	89 d0                	mov    %edx,%eax
    }
  }
  return -1;
}
80104316:	5a                   	pop    %edx
80104317:	5b                   	pop    %ebx
80104318:	5d                   	pop    %ebp
80104319:	c3                   	ret    
8010431a:	66 90                	xchg   %ax,%ax

8010431c <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
8010431c:	55                   	push   %ebp
8010431d:	89 e5                	mov    %esp,%ebp
8010431f:	57                   	push   %edi
80104320:	56                   	push   %esi
80104321:	53                   	push   %ebx
80104322:	83 ec 4c             	sub    $0x4c,%esp
80104325:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104328:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010432b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010432e:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104331:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104334:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104338:	89 04 24             	mov    %eax,(%esp)
8010433b:	e8 00 da ff ff       	call   80101d40 <nameiparent>
80104340:	89 c6                	mov    %eax,%esi
80104342:	85 c0                	test   %eax,%eax
80104344:	0f 84 ce 00 00 00    	je     80104418 <create+0xfc>
    return 0;
  ilock(dp);
8010434a:	89 04 24             	mov    %eax,(%esp)
8010434d:	e8 de d1 ff ff       	call   80101530 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104352:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104355:	89 44 24 08          	mov    %eax,0x8(%esp)
80104359:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010435d:	89 34 24             	mov    %esi,(%esp)
80104360:	e8 ab d6 ff ff       	call   80101a10 <dirlookup>
80104365:	89 c7                	mov    %eax,%edi
80104367:	85 c0                	test   %eax,%eax
80104369:	74 3d                	je     801043a8 <create+0x8c>
    iunlockput(dp);
8010436b:	89 34 24             	mov    %esi,(%esp)
8010436e:	e8 09 d4 ff ff       	call   8010177c <iunlockput>
    ilock(ip);
80104373:	89 3c 24             	mov    %edi,(%esp)
80104376:	e8 b5 d1 ff ff       	call   80101530 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010437b:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104380:	75 12                	jne    80104394 <create+0x78>
80104382:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104387:	75 0b                	jne    80104394 <create+0x78>
80104389:	89 f8                	mov    %edi,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010438b:	83 c4 4c             	add    $0x4c,%esp
8010438e:	5b                   	pop    %ebx
8010438f:	5e                   	pop    %esi
80104390:	5f                   	pop    %edi
80104391:	5d                   	pop    %ebp
80104392:	c3                   	ret    
80104393:	90                   	nop
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104394:	89 3c 24             	mov    %edi,(%esp)
80104397:	e8 e0 d3 ff ff       	call   8010177c <iunlockput>
    return 0;
8010439c:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010439e:	83 c4 4c             	add    $0x4c,%esp
801043a1:	5b                   	pop    %ebx
801043a2:	5e                   	pop    %esi
801043a3:	5f                   	pop    %edi
801043a4:	5d                   	pop    %ebp
801043a5:	c3                   	ret    
801043a6:	66 90                	xchg   %ax,%ax
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801043a8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801043ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801043af:	8b 06                	mov    (%esi),%eax
801043b1:	89 04 24             	mov    %eax,(%esp)
801043b4:	e8 f7 cf ff ff       	call   801013b0 <ialloc>
801043b9:	89 c7                	mov    %eax,%edi
801043bb:	85 c0                	test   %eax,%eax
801043bd:	0f 84 b7 00 00 00    	je     8010447a <create+0x15e>
    panic("create: ialloc");

  ilock(ip);
801043c3:	89 04 24             	mov    %eax,(%esp)
801043c6:	e8 65 d1 ff ff       	call   80101530 <ilock>
  ip->major = major;
801043cb:	8b 45 c0             	mov    -0x40(%ebp),%eax
801043ce:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801043d2:	8b 45 bc             	mov    -0x44(%ebp),%eax
801043d5:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
801043d9:	66 c7 47 56 01 00    	movw   $0x1,0x56(%edi)
  iupdate(ip);
801043df:	89 3c 24             	mov    %edi,(%esp)
801043e2:	e8 91 d0 ff ff       	call   80101478 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801043e7:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801043ec:	74 32                	je     80104420 <create+0x104>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
801043ee:	8b 47 04             	mov    0x4(%edi),%eax
801043f1:	89 44 24 08          	mov    %eax,0x8(%esp)
801043f5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801043f9:	89 34 24             	mov    %esi,(%esp)
801043fc:	e8 4b d8 ff ff       	call   80101c4c <dirlink>
80104401:	85 c0                	test   %eax,%eax
80104403:	78 69                	js     8010446e <create+0x152>
    panic("create: dirlink");

  iunlockput(dp);
80104405:	89 34 24             	mov    %esi,(%esp)
80104408:	e8 6f d3 ff ff       	call   8010177c <iunlockput>

  return ip;
8010440d:	89 f8                	mov    %edi,%eax
}
8010440f:	83 c4 4c             	add    $0x4c,%esp
80104412:	5b                   	pop    %ebx
80104413:	5e                   	pop    %esi
80104414:	5f                   	pop    %edi
80104415:	5d                   	pop    %ebp
80104416:	c3                   	ret    
80104417:	90                   	nop
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104418:	31 c0                	xor    %eax,%eax
8010441a:	e9 6c ff ff ff       	jmp    8010438b <create+0x6f>
8010441f:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104420:	66 ff 46 56          	incw   0x56(%esi)
    iupdate(dp);
80104424:	89 34 24             	mov    %esi,(%esp)
80104427:	e8 4c d0 ff ff       	call   80101478 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010442c:	8b 47 04             	mov    0x4(%edi),%eax
8010442f:	89 44 24 08          	mov    %eax,0x8(%esp)
80104433:	c7 44 24 04 94 6d 10 	movl   $0x80106d94,0x4(%esp)
8010443a:	80 
8010443b:	89 3c 24             	mov    %edi,(%esp)
8010443e:	e8 09 d8 ff ff       	call   80101c4c <dirlink>
80104443:	85 c0                	test   %eax,%eax
80104445:	78 1b                	js     80104462 <create+0x146>
80104447:	8b 46 04             	mov    0x4(%esi),%eax
8010444a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010444e:	c7 44 24 04 93 6d 10 	movl   $0x80106d93,0x4(%esp)
80104455:	80 
80104456:	89 3c 24             	mov    %edi,(%esp)
80104459:	e8 ee d7 ff ff       	call   80101c4c <dirlink>
8010445e:	85 c0                	test   %eax,%eax
80104460:	79 8c                	jns    801043ee <create+0xd2>
      panic("create dots");
80104462:	c7 04 24 87 6d 10 80 	movl   $0x80106d87,(%esp)
80104469:	e8 a6 be ff ff       	call   80100314 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
8010446e:	c7 04 24 96 6d 10 80 	movl   $0x80106d96,(%esp)
80104475:	e8 9a be ff ff       	call   80100314 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
8010447a:	c7 04 24 78 6d 10 80 	movl   $0x80106d78,(%esp)
80104481:	e8 8e be ff ff       	call   80100314 <panic>
80104486:	66 90                	xchg   %ax,%ax

80104488 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104488:	55                   	push   %ebp
80104489:	89 e5                	mov    %esp,%ebp
8010448b:	56                   	push   %esi
8010448c:	53                   	push   %ebx
8010448d:	83 ec 20             	sub    $0x20,%esp
80104490:	89 c6                	mov    %eax,%esi
80104492:	89 d3                	mov    %edx,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104494:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104497:	89 44 24 04          	mov    %eax,0x4(%esp)
8010449b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801044a2:	e8 25 fd ff ff       	call   801041cc <argint>
801044a7:	85 c0                	test   %eax,%eax
801044a9:	78 2d                	js     801044d8 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801044ab:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801044af:	77 27                	ja     801044d8 <argfd.constprop.0+0x50>
801044b1:	e8 b6 ef ff ff       	call   8010346c <myproc>
801044b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044b9:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801044bd:	85 c0                	test   %eax,%eax
801044bf:	74 17                	je     801044d8 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
801044c1:	85 f6                	test   %esi,%esi
801044c3:	74 02                	je     801044c7 <argfd.constprop.0+0x3f>
    *pfd = fd;
801044c5:	89 16                	mov    %edx,(%esi)
  if(pf)
801044c7:	85 db                	test   %ebx,%ebx
801044c9:	74 19                	je     801044e4 <argfd.constprop.0+0x5c>
    *pf = f;
801044cb:	89 03                	mov    %eax,(%ebx)
  return 0;
801044cd:	31 c0                	xor    %eax,%eax
}
801044cf:	83 c4 20             	add    $0x20,%esp
801044d2:	5b                   	pop    %ebx
801044d3:	5e                   	pop    %esi
801044d4:	5d                   	pop    %ebp
801044d5:	c3                   	ret    
801044d6:	66 90                	xchg   %ax,%ax
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801044d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
801044dd:	83 c4 20             	add    $0x20,%esp
801044e0:	5b                   	pop    %ebx
801044e1:	5e                   	pop    %esi
801044e2:	5d                   	pop    %ebp
801044e3:	c3                   	ret    
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801044e4:	31 c0                	xor    %eax,%eax
801044e6:	eb e7                	jmp    801044cf <argfd.constprop.0+0x47>

801044e8 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801044e8:	55                   	push   %ebp
801044e9:	89 e5                	mov    %esp,%ebp
801044eb:	53                   	push   %ebx
801044ec:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801044ef:	8d 55 f4             	lea    -0xc(%ebp),%edx
801044f2:	31 c0                	xor    %eax,%eax
801044f4:	e8 8f ff ff ff       	call   80104488 <argfd.constprop.0>
801044f9:	85 c0                	test   %eax,%eax
801044fb:	78 23                	js     80104520 <sys_dup+0x38>
    return -1;
  if((fd=fdalloc(f)) < 0)
801044fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104500:	e8 e3 fd ff ff       	call   801042e8 <fdalloc>
80104505:	89 c3                	mov    %eax,%ebx
80104507:	85 c0                	test   %eax,%eax
80104509:	78 15                	js     80104520 <sys_dup+0x38>
    return -1;
  filedup(f);
8010450b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450e:	89 04 24             	mov    %eax,(%esp)
80104511:	e8 e2 c7 ff ff       	call   80100cf8 <filedup>
  return fd;
80104516:	89 d8                	mov    %ebx,%eax
}
80104518:	83 c4 24             	add    $0x24,%esp
8010451b:	5b                   	pop    %ebx
8010451c:	5d                   	pop    %ebp
8010451d:	c3                   	ret    
8010451e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104525:	eb f1                	jmp    80104518 <sys_dup+0x30>
80104527:	90                   	nop

80104528 <sys_read>:
  return fd;
}

int
sys_read(void)
{
80104528:	55                   	push   %ebp
80104529:	89 e5                	mov    %esp,%ebp
8010452b:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010452e:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104531:	31 c0                	xor    %eax,%eax
80104533:	e8 50 ff ff ff       	call   80104488 <argfd.constprop.0>
80104538:	85 c0                	test   %eax,%eax
8010453a:	78 50                	js     8010458c <sys_read+0x64>
8010453c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010453f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104543:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010454a:	e8 7d fc ff ff       	call   801041cc <argint>
8010454f:	85 c0                	test   %eax,%eax
80104551:	78 39                	js     8010458c <sys_read+0x64>
80104553:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104556:	89 44 24 08          	mov    %eax,0x8(%esp)
8010455a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010455d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104561:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104568:	e8 87 fc ff ff       	call   801041f4 <argptr>
8010456d:	85 c0                	test   %eax,%eax
8010456f:	78 1b                	js     8010458c <sys_read+0x64>
    return -1;
  return fileread(f, p, n);
80104571:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104574:	89 44 24 08          	mov    %eax,0x8(%esp)
80104578:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010457b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010457f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104582:	89 04 24             	mov    %eax,(%esp)
80104585:	e8 b2 c8 ff ff       	call   80100e3c <fileread>
}
8010458a:	c9                   	leave  
8010458b:	c3                   	ret    
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
8010458c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104591:	c9                   	leave  
80104592:	c3                   	ret    
80104593:	90                   	nop

80104594 <sys_write>:

int
sys_write(void)
{
80104594:	55                   	push   %ebp
80104595:	89 e5                	mov    %esp,%ebp
80104597:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010459a:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010459d:	31 c0                	xor    %eax,%eax
8010459f:	e8 e4 fe ff ff       	call   80104488 <argfd.constprop.0>
801045a4:	85 c0                	test   %eax,%eax
801045a6:	78 50                	js     801045f8 <sys_write+0x64>
801045a8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801045ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801045af:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801045b6:	e8 11 fc ff ff       	call   801041cc <argint>
801045bb:	85 c0                	test   %eax,%eax
801045bd:	78 39                	js     801045f8 <sys_write+0x64>
801045bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801045c2:	89 44 24 08          	mov    %eax,0x8(%esp)
801045c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801045c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801045cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801045d4:	e8 1b fc ff ff       	call   801041f4 <argptr>
801045d9:	85 c0                	test   %eax,%eax
801045db:	78 1b                	js     801045f8 <sys_write+0x64>
    return -1;
  return filewrite(f, p, n);
801045dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801045e0:	89 44 24 08          	mov    %eax,0x8(%esp)
801045e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801045eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045ee:	89 04 24             	mov    %eax,(%esp)
801045f1:	e8 d6 c8 ff ff       	call   80100ecc <filewrite>
}
801045f6:	c9                   	leave  
801045f7:	c3                   	ret    
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801045f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
801045fd:	c9                   	leave  
801045fe:	c3                   	ret    
801045ff:	90                   	nop

80104600 <sys_close>:

int
sys_close(void)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104606:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104609:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010460c:	e8 77 fe ff ff       	call   80104488 <argfd.constprop.0>
80104611:	85 c0                	test   %eax,%eax
80104613:	78 1f                	js     80104634 <sys_close+0x34>
    return -1;
  myproc()->ofile[fd] = 0;
80104615:	e8 52 ee ff ff       	call   8010346c <myproc>
8010461a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010461d:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104624:	00 
  fileclose(f);
80104625:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104628:	89 04 24             	mov    %eax,(%esp)
8010462b:	e8 0c c7 ff ff       	call   80100d3c <fileclose>
  return 0;
80104630:	31 c0                	xor    %eax,%eax
}
80104632:	c9                   	leave  
80104633:	c3                   	ret    
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104634:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104639:	c9                   	leave  
8010463a:	c3                   	ret    
8010463b:	90                   	nop

8010463c <sys_fstat>:

int
sys_fstat(void)
{
8010463c:	55                   	push   %ebp
8010463d:	89 e5                	mov    %esp,%ebp
8010463f:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104642:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104645:	31 c0                	xor    %eax,%eax
80104647:	e8 3c fe ff ff       	call   80104488 <argfd.constprop.0>
8010464c:	85 c0                	test   %eax,%eax
8010464e:	78 34                	js     80104684 <sys_fstat+0x48>
80104650:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104657:	00 
80104658:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010465b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010465f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104666:	e8 89 fb ff ff       	call   801041f4 <argptr>
8010466b:	85 c0                	test   %eax,%eax
8010466d:	78 15                	js     80104684 <sys_fstat+0x48>
    return -1;
  return filestat(f, st);
8010466f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104672:	89 44 24 04          	mov    %eax,0x4(%esp)
80104676:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104679:	89 04 24             	mov    %eax,(%esp)
8010467c:	e8 6f c7 ff ff       	call   80100df0 <filestat>
}
80104681:	c9                   	leave  
80104682:	c3                   	ret    
80104683:	90                   	nop
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104684:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104689:	c9                   	leave  
8010468a:	c3                   	ret    
8010468b:	90                   	nop

8010468c <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010468c:	55                   	push   %ebp
8010468d:	89 e5                	mov    %esp,%ebp
8010468f:	57                   	push   %edi
80104690:	56                   	push   %esi
80104691:	53                   	push   %ebx
80104692:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104695:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104698:	89 44 24 04          	mov    %eax,0x4(%esp)
8010469c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801046a3:	e8 a4 fb ff ff       	call   8010424c <argstr>
801046a8:	85 c0                	test   %eax,%eax
801046aa:	0f 88 e1 00 00 00    	js     80104791 <sys_link+0x105>
801046b0:	8d 45 d0             	lea    -0x30(%ebp),%eax
801046b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801046b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801046be:	e8 89 fb ff ff       	call   8010424c <argstr>
801046c3:	85 c0                	test   %eax,%eax
801046c5:	0f 88 c6 00 00 00    	js     80104791 <sys_link+0x105>
    return -1;

  begin_op();
801046cb:	e8 a0 e2 ff ff       	call   80102970 <begin_op>
  if((ip = namei(old)) == 0){
801046d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801046d3:	89 04 24             	mov    %eax,(%esp)
801046d6:	e8 4d d6 ff ff       	call   80101d28 <namei>
801046db:	89 c3                	mov    %eax,%ebx
801046dd:	85 c0                	test   %eax,%eax
801046df:	0f 84 a7 00 00 00    	je     8010478c <sys_link+0x100>
    end_op();
    return -1;
  }

  ilock(ip);
801046e5:	89 04 24             	mov    %eax,(%esp)
801046e8:	e8 43 ce ff ff       	call   80101530 <ilock>
  if(ip->type == T_DIR){
801046ed:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801046f2:	0f 84 8c 00 00 00    	je     80104784 <sys_link+0xf8>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801046f8:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
801046fc:	89 1c 24             	mov    %ebx,(%esp)
801046ff:	e8 74 cd ff ff       	call   80101478 <iupdate>
  iunlock(ip);
80104704:	89 1c 24             	mov    %ebx,(%esp)
80104707:	e8 f4 ce ff ff       	call   80101600 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
8010470c:	8d 7d da             	lea    -0x26(%ebp),%edi
8010470f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104713:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104716:	89 04 24             	mov    %eax,(%esp)
80104719:	e8 22 d6 ff ff       	call   80101d40 <nameiparent>
8010471e:	89 c6                	mov    %eax,%esi
80104720:	85 c0                	test   %eax,%eax
80104722:	74 4c                	je     80104770 <sys_link+0xe4>
    goto bad;
  ilock(dp);
80104724:	89 04 24             	mov    %eax,(%esp)
80104727:	e8 04 ce ff ff       	call   80101530 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
8010472c:	8b 03                	mov    (%ebx),%eax
8010472e:	39 06                	cmp    %eax,(%esi)
80104730:	75 36                	jne    80104768 <sys_link+0xdc>
80104732:	8b 43 04             	mov    0x4(%ebx),%eax
80104735:	89 44 24 08          	mov    %eax,0x8(%esp)
80104739:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010473d:	89 34 24             	mov    %esi,(%esp)
80104740:	e8 07 d5 ff ff       	call   80101c4c <dirlink>
80104745:	85 c0                	test   %eax,%eax
80104747:	78 1f                	js     80104768 <sys_link+0xdc>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104749:	89 34 24             	mov    %esi,(%esp)
8010474c:	e8 2b d0 ff ff       	call   8010177c <iunlockput>
  iput(ip);
80104751:	89 1c 24             	mov    %ebx,(%esp)
80104754:	e8 e7 ce ff ff       	call   80101640 <iput>

  end_op();
80104759:	e8 72 e2 ff ff       	call   801029d0 <end_op>

  return 0;
8010475e:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104760:	83 c4 3c             	add    $0x3c,%esp
80104763:	5b                   	pop    %ebx
80104764:	5e                   	pop    %esi
80104765:	5f                   	pop    %edi
80104766:	5d                   	pop    %ebp
80104767:	c3                   	ret    

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104768:	89 34 24             	mov    %esi,(%esp)
8010476b:	e8 0c d0 ff ff       	call   8010177c <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
80104770:	89 1c 24             	mov    %ebx,(%esp)
80104773:	e8 b8 cd ff ff       	call   80101530 <ilock>
  ip->nlink--;
80104778:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010477c:	89 1c 24             	mov    %ebx,(%esp)
8010477f:	e8 f4 cc ff ff       	call   80101478 <iupdate>
  iunlockput(ip);
80104784:	89 1c 24             	mov    %ebx,(%esp)
80104787:	e8 f0 cf ff ff       	call   8010177c <iunlockput>
  end_op();
8010478c:	e8 3f e2 ff ff       	call   801029d0 <end_op>
  return -1;
80104791:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104796:	83 c4 3c             	add    $0x3c,%esp
80104799:	5b                   	pop    %ebx
8010479a:	5e                   	pop    %esi
8010479b:	5f                   	pop    %edi
8010479c:	5d                   	pop    %ebp
8010479d:	c3                   	ret    
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	56                   	push   %esi
801047a5:	53                   	push   %ebx
801047a6:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801047a9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801047ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801047b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801047b7:	e8 90 fa ff ff       	call   8010424c <argstr>
801047bc:	85 c0                	test   %eax,%eax
801047be:	0f 88 6e 01 00 00    	js     80104932 <sys_unlink+0x192>
    return -1;

  begin_op();
801047c4:	e8 a7 e1 ff ff       	call   80102970 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801047c9:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801047cc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801047d0:	8b 45 c0             	mov    -0x40(%ebp),%eax
801047d3:	89 04 24             	mov    %eax,(%esp)
801047d6:	e8 65 d5 ff ff       	call   80101d40 <nameiparent>
801047db:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801047de:	85 c0                	test   %eax,%eax
801047e0:	0f 84 47 01 00 00    	je     8010492d <sys_unlink+0x18d>
    end_op();
    return -1;
  }

  ilock(dp);
801047e6:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801047e9:	89 34 24             	mov    %esi,(%esp)
801047ec:	e8 3f cd ff ff       	call   80101530 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801047f1:	c7 44 24 04 94 6d 10 	movl   $0x80106d94,0x4(%esp)
801047f8:	80 
801047f9:	89 1c 24             	mov    %ebx,(%esp)
801047fc:	e8 eb d1 ff ff       	call   801019ec <namecmp>
80104801:	85 c0                	test   %eax,%eax
80104803:	0f 84 19 01 00 00    	je     80104922 <sys_unlink+0x182>
80104809:	c7 44 24 04 93 6d 10 	movl   $0x80106d93,0x4(%esp)
80104810:	80 
80104811:	89 1c 24             	mov    %ebx,(%esp)
80104814:	e8 d3 d1 ff ff       	call   801019ec <namecmp>
80104819:	85 c0                	test   %eax,%eax
8010481b:	0f 84 01 01 00 00    	je     80104922 <sys_unlink+0x182>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104821:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104824:	89 44 24 08          	mov    %eax,0x8(%esp)
80104828:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010482c:	89 34 24             	mov    %esi,(%esp)
8010482f:	e8 dc d1 ff ff       	call   80101a10 <dirlookup>
80104834:	89 c3                	mov    %eax,%ebx
80104836:	85 c0                	test   %eax,%eax
80104838:	0f 84 e4 00 00 00    	je     80104922 <sys_unlink+0x182>
    goto bad;
  ilock(ip);
8010483e:	89 04 24             	mov    %eax,(%esp)
80104841:	e8 ea cc ff ff       	call   80101530 <ilock>

  if(ip->nlink < 1)
80104846:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010484b:	0f 8e 1b 01 00 00    	jle    8010496c <sys_unlink+0x1cc>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104851:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104856:	74 7c                	je     801048d4 <sys_unlink+0x134>
80104858:	8d 75 d8             	lea    -0x28(%ebp),%esi
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010485b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104862:	00 
80104863:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010486a:	00 
8010486b:	89 34 24             	mov    %esi,(%esp)
8010486e:	e8 d1 f6 ff ff       	call   80103f44 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104873:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010487a:	00 
8010487b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010487e:	89 44 24 08          	mov    %eax,0x8(%esp)
80104882:	89 74 24 04          	mov    %esi,0x4(%esp)
80104886:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104889:	89 04 24             	mov    %eax,(%esp)
8010488c:	e8 3b d0 ff ff       	call   801018cc <writei>
80104891:	83 f8 10             	cmp    $0x10,%eax
80104894:	0f 85 c6 00 00 00    	jne    80104960 <sys_unlink+0x1c0>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010489a:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010489f:	0f 84 9b 00 00 00    	je     80104940 <sys_unlink+0x1a0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801048a5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801048a8:	89 04 24             	mov    %eax,(%esp)
801048ab:	e8 cc ce ff ff       	call   8010177c <iunlockput>

  ip->nlink--;
801048b0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801048b4:	89 1c 24             	mov    %ebx,(%esp)
801048b7:	e8 bc cb ff ff       	call   80101478 <iupdate>
  iunlockput(ip);
801048bc:	89 1c 24             	mov    %ebx,(%esp)
801048bf:	e8 b8 ce ff ff       	call   8010177c <iunlockput>

  end_op();
801048c4:	e8 07 e1 ff ff       	call   801029d0 <end_op>

  return 0;
801048c9:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801048cb:	83 c4 5c             	add    $0x5c,%esp
801048ce:	5b                   	pop    %ebx
801048cf:	5e                   	pop    %esi
801048d0:	5f                   	pop    %edi
801048d1:	5d                   	pop    %ebp
801048d2:	c3                   	ret    
801048d3:	90                   	nop
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801048d4:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801048d8:	0f 86 7a ff ff ff    	jbe    80104858 <sys_unlink+0xb8>
801048de:	bf 20 00 00 00       	mov    $0x20,%edi
801048e3:	8d 75 d8             	lea    -0x28(%ebp),%esi
801048e6:	eb 0e                	jmp    801048f6 <sys_unlink+0x156>
801048e8:	8d 57 10             	lea    0x10(%edi),%edx
801048eb:	3b 53 58             	cmp    0x58(%ebx),%edx
801048ee:	0f 83 67 ff ff ff    	jae    8010485b <sys_unlink+0xbb>
801048f4:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801048f6:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801048fd:	00 
801048fe:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104902:	89 74 24 04          	mov    %esi,0x4(%esp)
80104906:	89 1c 24             	mov    %ebx,(%esp)
80104909:	e8 ba ce ff ff       	call   801017c8 <readi>
8010490e:	83 f8 10             	cmp    $0x10,%eax
80104911:	75 41                	jne    80104954 <sys_unlink+0x1b4>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104913:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104918:	74 ce                	je     801048e8 <sys_unlink+0x148>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
8010491a:	89 1c 24             	mov    %ebx,(%esp)
8010491d:	e8 5a ce ff ff       	call   8010177c <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104922:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104925:	89 04 24             	mov    %eax,(%esp)
80104928:	e8 4f ce ff ff       	call   8010177c <iunlockput>
  end_op();
8010492d:	e8 9e e0 ff ff       	call   801029d0 <end_op>
  return -1;
80104932:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104937:	83 c4 5c             	add    $0x5c,%esp
8010493a:	5b                   	pop    %ebx
8010493b:	5e                   	pop    %esi
8010493c:	5f                   	pop    %edi
8010493d:	5d                   	pop    %ebp
8010493e:	c3                   	ret    
8010493f:	90                   	nop

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104940:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104943:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
80104947:	89 04 24             	mov    %eax,(%esp)
8010494a:	e8 29 cb ff ff       	call   80101478 <iupdate>
8010494f:	e9 51 ff ff ff       	jmp    801048a5 <sys_unlink+0x105>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104954:	c7 04 24 b8 6d 10 80 	movl   $0x80106db8,(%esp)
8010495b:	e8 b4 b9 ff ff       	call   80100314 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104960:	c7 04 24 ca 6d 10 80 	movl   $0x80106dca,(%esp)
80104967:	e8 a8 b9 ff ff       	call   80100314 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
8010496c:	c7 04 24 a6 6d 10 80 	movl   $0x80106da6,(%esp)
80104973:	e8 9c b9 ff ff       	call   80100314 <panic>

80104978 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80104978:	55                   	push   %ebp
80104979:	89 e5                	mov    %esp,%ebp
8010497b:	57                   	push   %edi
8010497c:	56                   	push   %esi
8010497d:	53                   	push   %ebx
8010497e:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104981:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104984:	89 44 24 04          	mov    %eax,0x4(%esp)
80104988:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010498f:	e8 b8 f8 ff ff       	call   8010424c <argstr>
80104994:	85 c0                	test   %eax,%eax
80104996:	0f 88 cd 00 00 00    	js     80104a69 <sys_open+0xf1>
8010499c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010499f:	89 44 24 04          	mov    %eax,0x4(%esp)
801049a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801049aa:	e8 1d f8 ff ff       	call   801041cc <argint>
801049af:	85 c0                	test   %eax,%eax
801049b1:	0f 88 b2 00 00 00    	js     80104a69 <sys_open+0xf1>
    return -1;

  begin_op();
801049b7:	e8 b4 df ff ff       	call   80102970 <begin_op>

  if(omode & O_CREATE){
801049bc:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801049c0:	0f 85 82 00 00 00    	jne    80104a48 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801049c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049c9:	89 04 24             	mov    %eax,(%esp)
801049cc:	e8 57 d3 ff ff       	call   80101d28 <namei>
801049d1:	89 c6                	mov    %eax,%esi
801049d3:	85 c0                	test   %eax,%eax
801049d5:	0f 84 89 00 00 00    	je     80104a64 <sys_open+0xec>
      end_op();
      return -1;
    }
    ilock(ip);
801049db:	89 04 24             	mov    %eax,(%esp)
801049de:	e8 4d cb ff ff       	call   80101530 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801049e3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801049e8:	0f 84 8a 00 00 00    	je     80104a78 <sys_open+0x100>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801049ee:	e8 a5 c2 ff ff       	call   80100c98 <filealloc>
801049f3:	89 c3                	mov    %eax,%ebx
801049f5:	85 c0                	test   %eax,%eax
801049f7:	0f 84 87 00 00 00    	je     80104a84 <sys_open+0x10c>
801049fd:	e8 e6 f8 ff ff       	call   801042e8 <fdalloc>
80104a02:	89 c7                	mov    %eax,%edi
80104a04:	85 c0                	test   %eax,%eax
80104a06:	0f 88 84 00 00 00    	js     80104a90 <sys_open+0x118>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104a0c:	89 34 24             	mov    %esi,(%esp)
80104a0f:	e8 ec cb ff ff       	call   80101600 <iunlock>
  end_op();
80104a14:	e8 b7 df ff ff       	call   801029d0 <end_op>

  f->type = FD_INODE;
80104a19:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
80104a1f:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104a22:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104a29:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104a2c:	89 ca                	mov    %ecx,%edx
80104a2e:	83 e2 01             	and    $0x1,%edx
80104a31:	83 f2 01             	xor    $0x1,%edx
80104a34:	88 53 08             	mov    %dl,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104a37:	83 e1 03             	and    $0x3,%ecx
80104a3a:	0f 95 43 09          	setne  0x9(%ebx)
  return fd;
80104a3e:	89 f8                	mov    %edi,%eax
}
80104a40:	83 c4 2c             	add    $0x2c,%esp
80104a43:	5b                   	pop    %ebx
80104a44:	5e                   	pop    %esi
80104a45:	5f                   	pop    %edi
80104a46:	5d                   	pop    %ebp
80104a47:	c3                   	ret    
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104a48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104a4f:	31 c9                	xor    %ecx,%ecx
80104a51:	ba 02 00 00 00       	mov    $0x2,%edx
80104a56:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a59:	e8 be f8 ff ff       	call   8010431c <create>
80104a5e:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104a60:	85 c0                	test   %eax,%eax
80104a62:	75 8a                	jne    801049ee <sys_open+0x76>

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
80104a64:	e8 67 df ff ff       	call   801029d0 <end_op>
    return -1;
80104a69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104a6e:	83 c4 2c             	add    $0x2c,%esp
80104a71:	5b                   	pop    %ebx
80104a72:	5e                   	pop    %esi
80104a73:	5f                   	pop    %edi
80104a74:	5d                   	pop    %ebp
80104a75:	c3                   	ret    
80104a76:	66 90                	xchg   %ax,%ax
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80104a78:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80104a7b:	85 ff                	test   %edi,%edi
80104a7d:	0f 84 6b ff ff ff    	je     801049ee <sys_open+0x76>
80104a83:	90                   	nop
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
80104a84:	89 34 24             	mov    %esi,(%esp)
80104a87:	e8 f0 cc ff ff       	call   8010177c <iunlockput>
80104a8c:	eb d6                	jmp    80104a64 <sys_open+0xec>
80104a8e:	66 90                	xchg   %ax,%ax
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80104a90:	89 1c 24             	mov    %ebx,(%esp)
80104a93:	e8 a4 c2 ff ff       	call   80100d3c <fileclose>
80104a98:	eb ea                	jmp    80104a84 <sys_open+0x10c>
80104a9a:	66 90                	xchg   %ax,%ax

80104a9c <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80104a9c:	55                   	push   %ebp
80104a9d:	89 e5                	mov    %esp,%ebp
80104a9f:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104aa2:	e8 c9 de ff ff       	call   80102970 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104aa7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104aaa:	89 44 24 04          	mov    %eax,0x4(%esp)
80104aae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ab5:	e8 92 f7 ff ff       	call   8010424c <argstr>
80104aba:	85 c0                	test   %eax,%eax
80104abc:	78 2e                	js     80104aec <sys_mkdir+0x50>
80104abe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ac5:	31 c9                	xor    %ecx,%ecx
80104ac7:	ba 01 00 00 00       	mov    $0x1,%edx
80104acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104acf:	e8 48 f8 ff ff       	call   8010431c <create>
80104ad4:	85 c0                	test   %eax,%eax
80104ad6:	74 14                	je     80104aec <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104ad8:	89 04 24             	mov    %eax,(%esp)
80104adb:	e8 9c cc ff ff       	call   8010177c <iunlockput>
  end_op();
80104ae0:	e8 eb de ff ff       	call   801029d0 <end_op>
  return 0;
80104ae5:	31 c0                	xor    %eax,%eax
}
80104ae7:	c9                   	leave  
80104ae8:	c3                   	ret    
80104ae9:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80104aec:	e8 df de ff ff       	call   801029d0 <end_op>
    return -1;
80104af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104af6:	c9                   	leave  
80104af7:	c3                   	ret    

80104af8 <sys_mknod>:

int
sys_mknod(void)
{
80104af8:	55                   	push   %ebp
80104af9:	89 e5                	mov    %esp,%ebp
80104afb:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104afe:	e8 6d de ff ff       	call   80102970 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104b03:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104b06:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b0a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b11:	e8 36 f7 ff ff       	call   8010424c <argstr>
80104b16:	85 c0                	test   %eax,%eax
80104b18:	78 5e                	js     80104b78 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104b1a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b28:	e8 9f f6 ff ff       	call   801041cc <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104b2d:	85 c0                	test   %eax,%eax
80104b2f:	78 47                	js     80104b78 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104b31:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b34:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b38:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104b3f:	e8 88 f6 ff ff       	call   801041cc <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80104b44:	85 c0                	test   %eax,%eax
80104b46:	78 30                	js     80104b78 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80104b48:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104b4c:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80104b50:	89 04 24             	mov    %eax,(%esp)
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104b53:	ba 03 00 00 00       	mov    $0x3,%edx
80104b58:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b5b:	e8 bc f7 ff ff       	call   8010431c <create>
80104b60:	85 c0                	test   %eax,%eax
80104b62:	74 14                	je     80104b78 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
80104b64:	89 04 24             	mov    %eax,(%esp)
80104b67:	e8 10 cc ff ff       	call   8010177c <iunlockput>
  end_op();
80104b6c:	e8 5f de ff ff       	call   801029d0 <end_op>
  return 0;
80104b71:	31 c0                	xor    %eax,%eax
}
80104b73:	c9                   	leave  
80104b74:	c3                   	ret    
80104b75:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80104b78:	e8 53 de ff ff       	call   801029d0 <end_op>
    return -1;
80104b7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104b82:	c9                   	leave  
80104b83:	c3                   	ret    

80104b84 <sys_chdir>:

int
sys_chdir(void)
{
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	56                   	push   %esi
80104b88:	53                   	push   %ebx
80104b89:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80104b8c:	e8 db e8 ff ff       	call   8010346c <myproc>
80104b91:	89 c6                	mov    %eax,%esi
  
  begin_op();
80104b93:	e8 d8 dd ff ff       	call   80102970 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80104b98:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b9b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b9f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ba6:	e8 a1 f6 ff ff       	call   8010424c <argstr>
80104bab:	85 c0                	test   %eax,%eax
80104bad:	78 4a                	js     80104bf9 <sys_chdir+0x75>
80104baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bb2:	89 04 24             	mov    %eax,(%esp)
80104bb5:	e8 6e d1 ff ff       	call   80101d28 <namei>
80104bba:	89 c3                	mov    %eax,%ebx
80104bbc:	85 c0                	test   %eax,%eax
80104bbe:	74 39                	je     80104bf9 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
80104bc0:	89 04 24             	mov    %eax,(%esp)
80104bc3:	e8 68 c9 ff ff       	call   80101530 <ilock>
  if(ip->type != T_DIR){
80104bc8:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80104bcd:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
80104bd0:	75 22                	jne    80104bf4 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104bd2:	e8 29 ca ff ff       	call   80101600 <iunlock>
  iput(curproc->cwd);
80104bd7:	8b 46 68             	mov    0x68(%esi),%eax
80104bda:	89 04 24             	mov    %eax,(%esp)
80104bdd:	e8 5e ca ff ff       	call   80101640 <iput>
  end_op();
80104be2:	e8 e9 dd ff ff       	call   801029d0 <end_op>
  curproc->cwd = ip;
80104be7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80104bea:	31 c0                	xor    %eax,%eax
}
80104bec:	83 c4 20             	add    $0x20,%esp
80104bef:	5b                   	pop    %ebx
80104bf0:	5e                   	pop    %esi
80104bf1:	5d                   	pop    %ebp
80104bf2:	c3                   	ret    
80104bf3:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80104bf4:	e8 83 cb ff ff       	call   8010177c <iunlockput>
    end_op();
80104bf9:	e8 d2 dd ff ff       	call   801029d0 <end_op>
    return -1;
80104bfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
80104c03:	83 c4 20             	add    $0x20,%esp
80104c06:	5b                   	pop    %ebx
80104c07:	5e                   	pop    %esi
80104c08:	5d                   	pop    %ebp
80104c09:	c3                   	ret    
80104c0a:	66 90                	xchg   %ax,%ax

80104c0c <sys_exec>:

int
sys_exec(void)
{
80104c0c:	55                   	push   %ebp
80104c0d:	89 e5                	mov    %esp,%ebp
80104c0f:	57                   	push   %edi
80104c10:	56                   	push   %esi
80104c11:	53                   	push   %ebx
80104c12:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104c18:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80104c1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c22:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104c29:	e8 1e f6 ff ff       	call   8010424c <argstr>
80104c2e:	85 c0                	test   %eax,%eax
80104c30:	0f 88 90 00 00 00    	js     80104cc6 <sys_exec+0xba>
80104c36:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80104c3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c47:	e8 80 f5 ff ff       	call   801041cc <argint>
80104c4c:	85 c0                	test   %eax,%eax
80104c4e:	78 76                	js     80104cc6 <sys_exec+0xba>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104c50:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80104c57:	00 
80104c58:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104c5f:	00 
80104c60:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80104c66:	89 34 24             	mov    %esi,(%esp)
80104c69:	e8 d6 f2 ff ff       	call   80103f44 <memset>
80104c6e:	31 db                	xor    %ebx,%ebx
  for(i=0;; i++){
80104c70:	c7 85 54 ff ff ff 00 	movl   $0x0,-0xac(%ebp)
80104c77:	00 00 00 
80104c7a:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104c80:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c84:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80104c8a:	01 d8                	add    %ebx,%eax
80104c8c:	89 04 24             	mov    %eax,(%esp)
80104c8f:	e8 c4 f4 ff ff       	call   80104158 <fetchint>
80104c94:	85 c0                	test   %eax,%eax
80104c96:	78 2e                	js     80104cc6 <sys_exec+0xba>
      return -1;
    if(uarg == 0){
80104c98:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80104c9e:	85 c0                	test   %eax,%eax
80104ca0:	74 36                	je     80104cd8 <sys_exec+0xcc>
80104ca2:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104ca5:	89 54 24 04          	mov    %edx,0x4(%esp)
80104ca9:	89 04 24             	mov    %eax,(%esp)
80104cac:	e8 d7 f4 ff ff       	call   80104188 <fetchstr>
80104cb1:	85 c0                	test   %eax,%eax
80104cb3:	78 11                	js     80104cc6 <sys_exec+0xba>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104cb5:	ff 85 54 ff ff ff    	incl   -0xac(%ebp)
80104cbb:	83 c3 04             	add    $0x4,%ebx
    if(i >= NELEM(argv))
80104cbe:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80104cc4:	75 ba                	jne    80104c80 <sys_exec+0x74>
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80104cc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80104ccb:	81 c4 ac 00 00 00    	add    $0xac,%esp
80104cd1:	5b                   	pop    %ebx
80104cd2:	5e                   	pop    %esi
80104cd3:	5f                   	pop    %edi
80104cd4:	5d                   	pop    %ebp
80104cd5:	c3                   	ret    
80104cd6:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80104cd8:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
80104cde:	c7 84 85 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%eax,4)
80104ce5:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104ce9:	89 74 24 04          	mov    %esi,0x4(%esp)
80104ced:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80104cf3:	89 04 24             	mov    %eax,(%esp)
80104cf6:	e8 d5 bb ff ff       	call   801008d0 <exec>
}
80104cfb:	81 c4 ac 00 00 00    	add    $0xac,%esp
80104d01:	5b                   	pop    %ebx
80104d02:	5e                   	pop    %esi
80104d03:	5f                   	pop    %edi
80104d04:	5d                   	pop    %ebp
80104d05:	c3                   	ret    
80104d06:	66 90                	xchg   %ax,%ax

80104d08 <sys_pipe>:

int
sys_pipe(void)
{
80104d08:	55                   	push   %ebp
80104d09:	89 e5                	mov    %esp,%ebp
80104d0b:	53                   	push   %ebx
80104d0c:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104d0f:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80104d16:	00 
80104d17:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104d1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104d25:	e8 ca f4 ff ff       	call   801041f4 <argptr>
80104d2a:	85 c0                	test   %eax,%eax
80104d2c:	78 69                	js     80104d97 <sys_pipe+0x8f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104d2e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d31:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d35:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d38:	89 04 24             	mov    %eax,(%esp)
80104d3b:	e8 1c e2 ff ff       	call   80102f5c <pipealloc>
80104d40:	85 c0                	test   %eax,%eax
80104d42:	78 53                	js     80104d97 <sys_pipe+0x8f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104d44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d47:	e8 9c f5 ff ff       	call   801042e8 <fdalloc>
80104d4c:	89 c3                	mov    %eax,%ebx
80104d4e:	85 c0                	test   %eax,%eax
80104d50:	78 2f                	js     80104d81 <sys_pipe+0x79>
80104d52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d55:	e8 8e f5 ff ff       	call   801042e8 <fdalloc>
80104d5a:	85 c0                	test   %eax,%eax
80104d5c:	78 16                	js     80104d74 <sys_pipe+0x6c>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104d5e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104d61:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80104d63:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104d66:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80104d69:	31 c0                	xor    %eax,%eax
}
80104d6b:	83 c4 24             	add    $0x24,%esp
80104d6e:	5b                   	pop    %ebx
80104d6f:	5d                   	pop    %ebp
80104d70:	c3                   	ret    
80104d71:	8d 76 00             	lea    0x0(%esi),%esi
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80104d74:	e8 f3 e6 ff ff       	call   8010346c <myproc>
80104d79:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
80104d80:	00 
    fileclose(rf);
80104d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d84:	89 04 24             	mov    %eax,(%esp)
80104d87:	e8 b0 bf ff ff       	call   80100d3c <fileclose>
    fileclose(wf);
80104d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d8f:	89 04 24             	mov    %eax,(%esp)
80104d92:	e8 a5 bf ff ff       	call   80100d3c <fileclose>
    return -1;
80104d97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80104d9c:	83 c4 24             	add    $0x24,%esp
80104d9f:	5b                   	pop    %ebx
80104da0:	5d                   	pop    %ebp
80104da1:	c3                   	ret    
80104da2:	66 90                	xchg   %ax,%ax

80104da4 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80104da4:	55                   	push   %ebp
80104da5:	89 e5                	mov    %esp,%ebp
  return fork();
}
80104da7:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80104da8:	e9 47 e8 ff ff       	jmp    801035f4 <fork>
80104dad:	8d 76 00             	lea    0x0(%esi),%esi

80104db0 <sys_exit>:
}

int
sys_exit(void)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	83 ec 08             	sub    $0x8,%esp
  exit();
80104db6:	e8 71 ea ff ff       	call   8010382c <exit>
  return 0;  // not reached
}
80104dbb:	31 c0                	xor    %eax,%eax
80104dbd:	c9                   	leave  
80104dbe:	c3                   	ret    
80104dbf:	90                   	nop

80104dc0 <sys_wait>:

int
sys_wait(void)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80104dc3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80104dc4:	e9 43 ec ff ff       	jmp    80103a0c <wait>
80104dc9:	8d 76 00             	lea    0x0(%esi),%esi

80104dcc <sys_kill>:
}

int
sys_kill(void)
{
80104dcc:	55                   	push   %ebp
80104dcd:	89 e5                	mov    %esp,%ebp
80104dcf:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104dd2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104dd9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104de0:	e8 e7 f3 ff ff       	call   801041cc <argint>
80104de5:	85 c0                	test   %eax,%eax
80104de7:	78 0f                	js     80104df8 <sys_kill+0x2c>
    return -1;
  return kill(pid);
80104de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dec:	89 04 24             	mov    %eax,(%esp)
80104def:	e8 4c ed ff ff       	call   80103b40 <kill>
}
80104df4:	c9                   	leave  
80104df5:	c3                   	ret    
80104df6:	66 90                	xchg   %ax,%ax
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80104df8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80104dfd:	c9                   	leave  
80104dfe:	c3                   	ret    
80104dff:	90                   	nop

80104e00 <sys_getpid>:

int
sys_getpid(void)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104e06:	e8 61 e6 ff ff       	call   8010346c <myproc>
80104e0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80104e0e:	c9                   	leave  
80104e0f:	c3                   	ret    

80104e10 <sys_sbrk>:

int
sys_sbrk(void)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104e17:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e25:	e8 a2 f3 ff ff       	call   801041cc <argint>
80104e2a:	85 c0                	test   %eax,%eax
80104e2c:	78 1e                	js     80104e4c <sys_sbrk+0x3c>
    return -1;
  addr = myproc()->sz;
80104e2e:	e8 39 e6 ff ff       	call   8010346c <myproc>
80104e33:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104e35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e38:	89 14 24             	mov    %edx,(%esp)
80104e3b:	e8 48 e7 ff ff       	call   80103588 <growproc>
80104e40:	85 c0                	test   %eax,%eax
80104e42:	78 08                	js     80104e4c <sys_sbrk+0x3c>
    return -1;
  return addr;
80104e44:	89 d8                	mov    %ebx,%eax
}
80104e46:	83 c4 24             	add    $0x24,%esp
80104e49:	5b                   	pop    %ebx
80104e4a:	5d                   	pop    %ebp
80104e4b:	c3                   	ret    
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80104e4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e51:	eb f3                	jmp    80104e46 <sys_sbrk+0x36>
80104e53:	90                   	nop

80104e54 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80104e54:	55                   	push   %ebp
80104e55:	89 e5                	mov    %esp,%ebp
80104e57:	53                   	push   %ebx
80104e58:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80104e5b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e5e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e62:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e69:	e8 5e f3 ff ff       	call   801041cc <argint>
80104e6e:	85 c0                	test   %eax,%eax
80104e70:	78 76                	js     80104ee8 <sys_sleep+0x94>
    return -1;
  acquire(&tickslock);
80104e72:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104e79:	e8 9e ef ff ff       	call   80103e1c <acquire>
  ticks0 = ticks;
80104e7e:	8b 1d e0 56 11 80    	mov    0x801156e0,%ebx
  while(ticks - ticks0 < n){
80104e84:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e87:	85 d2                	test   %edx,%edx
80104e89:	75 25                	jne    80104eb0 <sys_sleep+0x5c>
80104e8b:	eb 47                	jmp    80104ed4 <sys_sleep+0x80>
80104e8d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80104e90:	c7 44 24 04 a0 4e 11 	movl   $0x80114ea0,0x4(%esp)
80104e97:	80 
80104e98:	c7 04 24 e0 56 11 80 	movl   $0x801156e0,(%esp)
80104e9f:	e8 c4 ea ff ff       	call   80103968 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80104ea4:	a1 e0 56 11 80       	mov    0x801156e0,%eax
80104ea9:	29 d8                	sub    %ebx,%eax
80104eab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80104eae:	73 24                	jae    80104ed4 <sys_sleep+0x80>
    if(myproc()->killed){
80104eb0:	e8 b7 e5 ff ff       	call   8010346c <myproc>
80104eb5:	8b 40 24             	mov    0x24(%eax),%eax
80104eb8:	85 c0                	test   %eax,%eax
80104eba:	74 d4                	je     80104e90 <sys_sleep+0x3c>
      release(&tickslock);
80104ebc:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104ec3:	e8 2c f0 ff ff       	call   80103ef4 <release>
      return -1;
80104ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80104ecd:	83 c4 24             	add    $0x24,%esp
80104ed0:	5b                   	pop    %ebx
80104ed1:	5d                   	pop    %ebp
80104ed2:	c3                   	ret    
80104ed3:	90                   	nop
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80104ed4:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104edb:	e8 14 f0 ff ff       	call   80103ef4 <release>
  return 0;
80104ee0:	31 c0                	xor    %eax,%eax
}
80104ee2:	83 c4 24             	add    $0x24,%esp
80104ee5:	5b                   	pop    %ebx
80104ee6:	5d                   	pop    %ebp
80104ee7:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80104ee8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eed:	eb de                	jmp    80104ecd <sys_sleep+0x79>
80104eef:	90                   	nop

80104ef0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	53                   	push   %ebx
80104ef4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80104ef7:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104efe:	e8 19 ef ff ff       	call   80103e1c <acquire>
  xticks = ticks;
80104f03:	8b 1d e0 56 11 80    	mov    0x801156e0,%ebx
  release(&tickslock);
80104f09:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104f10:	e8 df ef ff ff       	call   80103ef4 <release>
  return xticks;
}
80104f15:	89 d8                	mov    %ebx,%eax
80104f17:	83 c4 14             	add    $0x14,%esp
80104f1a:	5b                   	pop    %ebx
80104f1b:	5d                   	pop    %ebp
80104f1c:	c3                   	ret    
80104f1d:	66 90                	xchg   %ax,%ax
80104f1f:	90                   	nop

80104f20 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80104f20:	1e                   	push   %ds
  pushl %es
80104f21:	06                   	push   %es
  pushl %fs
80104f22:	0f a0                	push   %fs
  pushl %gs
80104f24:	0f a8                	push   %gs
  pushal
80104f26:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80104f27:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80104f2b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80104f2d:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80104f2f:	54                   	push   %esp
  call trap
80104f30:	e8 bb 00 00 00       	call   80104ff0 <trap>
  addl $4, %esp
80104f35:	83 c4 04             	add    $0x4,%esp

80104f38 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80104f38:	61                   	popa   
  popl %gs
80104f39:	0f a9                	pop    %gs
  popl %fs
80104f3b:	0f a1                	pop    %fs
  popl %es
80104f3d:	07                   	pop    %es
  popl %ds
80104f3e:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80104f3f:	83 c4 08             	add    $0x8,%esp
  iret
80104f42:	cf                   	iret   
80104f43:	90                   	nop

80104f44 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80104f44:	31 c0                	xor    %eax,%eax
80104f46:	66 90                	xchg   %ax,%ax
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80104f48:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80104f4f:	66 89 14 c5 e0 4e 11 	mov    %dx,-0x7feeb120(,%eax,8)
80104f56:	80 
80104f57:	66 c7 04 c5 e2 4e 11 	movw   $0x8,-0x7feeb11e(,%eax,8)
80104f5e:	80 08 00 
80104f61:	c6 04 c5 e4 4e 11 80 	movb   $0x0,-0x7feeb11c(,%eax,8)
80104f68:	00 
80104f69:	c6 04 c5 e5 4e 11 80 	movb   $0x8e,-0x7feeb11b(,%eax,8)
80104f70:	8e 
80104f71:	c1 ea 10             	shr    $0x10,%edx
80104f74:	66 89 14 c5 e6 4e 11 	mov    %dx,-0x7feeb11a(,%eax,8)
80104f7b:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80104f7c:	40                   	inc    %eax
80104f7d:	3d 00 01 00 00       	cmp    $0x100,%eax
80104f82:	75 c4                	jne    80104f48 <tvinit+0x4>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80104f84:	55                   	push   %ebp
80104f85:	89 e5                	mov    %esp,%ebp
80104f87:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80104f8a:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80104f8f:	66 a3 e0 50 11 80    	mov    %ax,0x801150e0
80104f95:	66 c7 05 e2 50 11 80 	movw   $0x8,0x801150e2
80104f9c:	08 00 
80104f9e:	c6 05 e4 50 11 80 00 	movb   $0x0,0x801150e4
80104fa5:	c6 05 e5 50 11 80 ef 	movb   $0xef,0x801150e5
80104fac:	c1 e8 10             	shr    $0x10,%eax
80104faf:	66 a3 e6 50 11 80    	mov    %ax,0x801150e6

  initlock(&tickslock, "time");
80104fb5:	c7 44 24 04 d9 6d 10 	movl   $0x80106dd9,0x4(%esp)
80104fbc:	80 
80104fbd:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104fc4:	e8 8b ed ff ff       	call   80103d54 <initlock>
}
80104fc9:	c9                   	leave  
80104fca:	c3                   	ret    
80104fcb:	90                   	nop

80104fcc <idtinit>:

void
idtinit(void)
{
80104fcc:	55                   	push   %ebp
80104fcd:	89 e5                	mov    %esp,%ebp
80104fcf:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80104fd2:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80104fd8:	b8 e0 4e 11 80       	mov    $0x80114ee0,%eax
80104fdd:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80104fe1:	c1 e8 10             	shr    $0x10,%eax
80104fe4:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80104fe8:	8d 45 fa             	lea    -0x6(%ebp),%eax
80104feb:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80104fee:	c9                   	leave  
80104fef:	c3                   	ret    

80104ff0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
80104ff5:	53                   	push   %ebx
80104ff6:	83 ec 3c             	sub    $0x3c,%esp
80104ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80104ffc:	8b 43 30             	mov    0x30(%ebx),%eax
80104fff:	83 f8 40             	cmp    $0x40,%eax
80105002:	0f 84 84 01 00 00    	je     8010518c <trap+0x19c>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105008:	83 e8 20             	sub    $0x20,%eax
8010500b:	83 f8 1f             	cmp    $0x1f,%eax
8010500e:	77 08                	ja     80105018 <trap+0x28>
80105010:	ff 24 85 80 6e 10 80 	jmp    *-0x7fef9180(,%eax,4)
80105017:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105018:	e8 4f e4 ff ff       	call   8010346c <myproc>
8010501d:	85 c0                	test   %eax,%eax
8010501f:	0f 84 d6 01 00 00    	je     801051fb <trap+0x20b>
80105025:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105029:	0f 84 cc 01 00 00    	je     801051fb <trap+0x20b>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010502f:	0f 20 d1             	mov    %cr2,%ecx
80105032:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105035:	8b 53 38             	mov    0x38(%ebx),%edx
80105038:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010503b:	e8 f8 e3 ff ff       	call   80103438 <cpuid>
80105040:	89 c7                	mov    %eax,%edi
80105042:	8b 73 34             	mov    0x34(%ebx),%esi
80105045:	8b 43 30             	mov    0x30(%ebx),%eax
80105048:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010504b:	e8 1c e4 ff ff       	call   8010346c <myproc>
80105050:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105053:	e8 14 e4 ff ff       	call   8010346c <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105058:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010505b:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
8010505f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105062:	89 54 24 18          	mov    %edx,0x18(%esp)
80105066:	89 7c 24 14          	mov    %edi,0x14(%esp)
8010506a:	89 74 24 10          	mov    %esi,0x10(%esp)
8010506e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105071:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105075:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105078:	83 c2 6c             	add    $0x6c,%edx
8010507b:	89 54 24 08          	mov    %edx,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010507f:	8b 40 10             	mov    0x10(%eax),%eax
80105082:	89 44 24 04          	mov    %eax,0x4(%esp)
80105086:	c7 04 24 3c 6e 10 80 	movl   $0x80106e3c,(%esp)
8010508d:	e8 32 b5 ff ff       	call   801005c4 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105092:	e8 d5 e3 ff ff       	call   8010346c <myproc>
80105097:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010509e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801050a0:	e8 c7 e3 ff ff       	call   8010346c <myproc>
801050a5:	85 c0                	test   %eax,%eax
801050a7:	74 0c                	je     801050b5 <trap+0xc5>
801050a9:	e8 be e3 ff ff       	call   8010346c <myproc>
801050ae:	8b 50 24             	mov    0x24(%eax),%edx
801050b1:	85 d2                	test   %edx,%edx
801050b3:	75 43                	jne    801050f8 <trap+0x108>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801050b5:	e8 b2 e3 ff ff       	call   8010346c <myproc>
801050ba:	85 c0                	test   %eax,%eax
801050bc:	74 0b                	je     801050c9 <trap+0xd9>
801050be:	e8 a9 e3 ff ff       	call   8010346c <myproc>
801050c3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801050c7:	74 43                	je     8010510c <trap+0x11c>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801050c9:	e8 9e e3 ff ff       	call   8010346c <myproc>
801050ce:	85 c0                	test   %eax,%eax
801050d0:	74 1c                	je     801050ee <trap+0xfe>
801050d2:	e8 95 e3 ff ff       	call   8010346c <myproc>
801050d7:	8b 40 24             	mov    0x24(%eax),%eax
801050da:	85 c0                	test   %eax,%eax
801050dc:	74 10                	je     801050ee <trap+0xfe>
801050de:	8b 43 3c             	mov    0x3c(%ebx),%eax
801050e1:	83 e0 03             	and    $0x3,%eax
801050e4:	66 83 f8 03          	cmp    $0x3,%ax
801050e8:	0f 84 c7 00 00 00    	je     801051b5 <trap+0x1c5>
    exit();
}
801050ee:	83 c4 3c             	add    $0x3c,%esp
801050f1:	5b                   	pop    %ebx
801050f2:	5e                   	pop    %esi
801050f3:	5f                   	pop    %edi
801050f4:	5d                   	pop    %ebp
801050f5:	c3                   	ret    
801050f6:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801050f8:	8b 43 3c             	mov    0x3c(%ebx),%eax
801050fb:	83 e0 03             	and    $0x3,%eax
801050fe:	66 83 f8 03          	cmp    $0x3,%ax
80105102:	75 b1                	jne    801050b5 <trap+0xc5>
    exit();
80105104:	e8 23 e7 ff ff       	call   8010382c <exit>
80105109:	eb aa                	jmp    801050b5 <trap+0xc5>
8010510b:	90                   	nop

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010510c:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105110:	75 b7                	jne    801050c9 <trap+0xd9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105112:	e8 1d e8 ff ff       	call   80103934 <yield>
80105117:	eb b0                	jmp    801050c9 <trap+0xd9>
80105119:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
8010511c:	e8 17 e3 ff ff       	call   80103438 <cpuid>
80105121:	85 c0                	test   %eax,%eax
80105123:	0f 84 a3 00 00 00    	je     801051cc <trap+0x1dc>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105129:	e8 22 d5 ff ff       	call   80102650 <lapiceoi>
    break;
8010512e:	e9 6d ff ff ff       	jmp    801050a0 <trap+0xb0>
80105133:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105134:	e8 a7 d3 ff ff       	call   801024e0 <kbdintr>
    lapiceoi();
80105139:	e8 12 d5 ff ff       	call   80102650 <lapiceoi>
    break;
8010513e:	e9 5d ff ff ff       	jmp    801050a0 <trap+0xb0>
80105143:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105144:	e8 d7 01 00 00       	call   80105320 <uartintr>
    lapiceoi();
80105149:	e8 02 d5 ff ff       	call   80102650 <lapiceoi>
    break;
8010514e:	e9 4d ff ff ff       	jmp    801050a0 <trap+0xb0>
80105153:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105154:	8b 7b 38             	mov    0x38(%ebx),%edi
80105157:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010515b:	e8 d8 e2 ff ff       	call   80103438 <cpuid>
80105160:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105164:	89 74 24 08          	mov    %esi,0x8(%esp)
80105168:	89 44 24 04          	mov    %eax,0x4(%esp)
8010516c:	c7 04 24 e4 6d 10 80 	movl   $0x80106de4,(%esp)
80105173:	e8 4c b4 ff ff       	call   801005c4 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105178:	e8 d3 d4 ff ff       	call   80102650 <lapiceoi>
    break;
8010517d:	e9 1e ff ff ff       	jmp    801050a0 <trap+0xb0>
80105182:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105184:	e8 e3 cc ff ff       	call   80101e6c <ideintr>
80105189:	eb 9e                	jmp    80105129 <trap+0x139>
8010518b:	90                   	nop
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
8010518c:	e8 db e2 ff ff       	call   8010346c <myproc>
80105191:	8b 70 24             	mov    0x24(%eax),%esi
80105194:	85 f6                	test   %esi,%esi
80105196:	75 2c                	jne    801051c4 <trap+0x1d4>
      exit();
    myproc()->tf = tf;
80105198:	e8 cf e2 ff ff       	call   8010346c <myproc>
8010519d:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801051a0:	e8 df f0 ff ff       	call   80104284 <syscall>
    if(myproc()->killed)
801051a5:	e8 c2 e2 ff ff       	call   8010346c <myproc>
801051aa:	8b 48 24             	mov    0x24(%eax),%ecx
801051ad:	85 c9                	test   %ecx,%ecx
801051af:	0f 84 39 ff ff ff    	je     801050ee <trap+0xfe>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801051b5:	83 c4 3c             	add    $0x3c,%esp
801051b8:	5b                   	pop    %ebx
801051b9:	5e                   	pop    %esi
801051ba:	5f                   	pop    %edi
801051bb:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
801051bc:	e9 6b e6 ff ff       	jmp    8010382c <exit>
801051c1:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
801051c4:	e8 63 e6 ff ff       	call   8010382c <exit>
801051c9:	eb cd                	jmp    80105198 <trap+0x1a8>
801051cb:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801051cc:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
801051d3:	e8 44 ec ff ff       	call   80103e1c <acquire>
      ticks++;
801051d8:	ff 05 e0 56 11 80    	incl   0x801156e0
      wakeup(&ticks);
801051de:	c7 04 24 e0 56 11 80 	movl   $0x801156e0,(%esp)
801051e5:	e8 fa e8 ff ff       	call   80103ae4 <wakeup>
      release(&tickslock);
801051ea:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
801051f1:	e8 fe ec ff ff       	call   80103ef4 <release>
801051f6:	e9 2e ff ff ff       	jmp    80105129 <trap+0x139>
801051fb:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801051fe:	8b 73 38             	mov    0x38(%ebx),%esi
80105201:	e8 32 e2 ff ff       	call   80103438 <cpuid>
80105206:	89 7c 24 10          	mov    %edi,0x10(%esp)
8010520a:	89 74 24 0c          	mov    %esi,0xc(%esp)
8010520e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105212:	8b 43 30             	mov    0x30(%ebx),%eax
80105215:	89 44 24 04          	mov    %eax,0x4(%esp)
80105219:	c7 04 24 08 6e 10 80 	movl   $0x80106e08,(%esp)
80105220:	e8 9f b3 ff ff       	call   801005c4 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105225:	c7 04 24 de 6d 10 80 	movl   $0x80106dde,(%esp)
8010522c:	e8 e3 b0 ff ff       	call   80100314 <panic>
80105231:	66 90                	xchg   %ax,%ax
80105233:	90                   	nop

80105234 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105234:	55                   	push   %ebp
80105235:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105237:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
8010523c:	85 c0                	test   %eax,%eax
8010523e:	74 14                	je     80105254 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105240:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105245:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105246:	a8 01                	test   $0x1,%al
80105248:	74 0a                	je     80105254 <uartgetc+0x20>
8010524a:	b2 f8                	mov    $0xf8,%dl
8010524c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010524d:	0f b6 c0             	movzbl %al,%eax
}
80105250:	5d                   	pop    %ebp
80105251:	c3                   	ret    
80105252:	66 90                	xchg   %ax,%ax

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105254:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105259:	5d                   	pop    %ebp
8010525a:	c3                   	ret    
8010525b:	90                   	nop

8010525c <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
8010525c:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105262:	85 d2                	test   %edx,%edx
80105264:	74 3c                	je     801052a2 <uartputc+0x46>
    uartputc(*p);
}

void
uartputc(int c)
{
80105266:	55                   	push   %ebp
80105267:	89 e5                	mov    %esp,%ebp
80105269:	56                   	push   %esi
8010526a:	53                   	push   %ebx
8010526b:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
8010526e:	bb 80 00 00 00       	mov    $0x80,%ebx
80105273:	be fd 03 00 00       	mov    $0x3fd,%esi
80105278:	eb 11                	jmp    8010528b <uartputc+0x2f>
8010527a:	66 90                	xchg   %ax,%ax
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
8010527c:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105283:	e8 e4 d3 ff ff       	call   8010266c <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105288:	4b                   	dec    %ebx
80105289:	74 07                	je     80105292 <uartputc+0x36>
8010528b:	89 f2                	mov    %esi,%edx
8010528d:	ec                   	in     (%dx),%al
8010528e:	a8 20                	test   $0x20,%al
80105290:	74 ea                	je     8010527c <uartputc+0x20>
    microdelay(10);
  outb(COM1+0, c);
80105292:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105296:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010529b:	ee                   	out    %al,(%dx)
}
8010529c:	83 c4 10             	add    $0x10,%esp
8010529f:	5b                   	pop    %ebx
801052a0:	5e                   	pop    %esi
801052a1:	5d                   	pop    %ebp
801052a2:	c3                   	ret    
801052a3:	90                   	nop

801052a4 <uartinit>:
801052a4:	ba fa 03 00 00       	mov    $0x3fa,%edx
801052a9:	31 c0                	xor    %eax,%eax
801052ab:	ee                   	out    %al,(%dx)
801052ac:	b2 fb                	mov    $0xfb,%dl
801052ae:	b0 80                	mov    $0x80,%al
801052b0:	ee                   	out    %al,(%dx)
801052b1:	b2 f8                	mov    $0xf8,%dl
801052b3:	b0 0c                	mov    $0xc,%al
801052b5:	ee                   	out    %al,(%dx)
801052b6:	b2 f9                	mov    $0xf9,%dl
801052b8:	31 c0                	xor    %eax,%eax
801052ba:	ee                   	out    %al,(%dx)
801052bb:	b2 fb                	mov    $0xfb,%dl
801052bd:	b0 03                	mov    $0x3,%al
801052bf:	ee                   	out    %al,(%dx)
801052c0:	b2 fc                	mov    $0xfc,%dl
801052c2:	31 c0                	xor    %eax,%eax
801052c4:	ee                   	out    %al,(%dx)
801052c5:	b2 f9                	mov    $0xf9,%dl
801052c7:	b0 01                	mov    $0x1,%al
801052c9:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801052ca:	b2 fd                	mov    $0xfd,%dl
801052cc:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801052cd:	fe c0                	inc    %al
801052cf:	74 4c                	je     8010531d <uartinit+0x79>

static int uart;    // is there a uart?

void
uartinit(void)
{
801052d1:	55                   	push   %ebp
801052d2:	89 e5                	mov    %esp,%ebp
801052d4:	53                   	push   %ebx
801052d5:	83 ec 14             	sub    $0x14,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
  uart = 1;
801052d8:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
801052df:	00 00 00 
801052e2:	b2 fa                	mov    $0xfa,%dl
801052e4:	ec                   	in     (%dx),%al
801052e5:	b2 f8                	mov    $0xf8,%dl
801052e7:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801052e8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801052ef:	00 
801052f0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801052f7:	e8 7c cd ff ff       	call   80102078 <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801052fc:	b8 78 00 00 00       	mov    $0x78,%eax
80105301:	bb 00 6f 10 80       	mov    $0x80106f00,%ebx
80105306:	66 90                	xchg   %ax,%ax
    uartputc(*p);
80105308:	89 04 24             	mov    %eax,(%esp)
8010530b:	e8 4c ff ff ff       	call   8010525c <uartputc>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105310:	43                   	inc    %ebx
80105311:	0f be 03             	movsbl (%ebx),%eax
80105314:	84 c0                	test   %al,%al
80105316:	75 f0                	jne    80105308 <uartinit+0x64>
    uartputc(*p);
}
80105318:	83 c4 14             	add    $0x14,%esp
8010531b:	5b                   	pop    %ebx
8010531c:	5d                   	pop    %ebp
8010531d:	c3                   	ret    
8010531e:	66 90                	xchg   %ax,%ax

80105320 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105326:	c7 04 24 34 52 10 80 	movl   $0x80105234,(%esp)
8010532d:	e8 da b3 ff ff       	call   8010070c <consoleintr>
}
80105332:	c9                   	leave  
80105333:	c3                   	ret    

80105334 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105334:	6a 00                	push   $0x0
  pushl $0
80105336:	6a 00                	push   $0x0
  jmp alltraps
80105338:	e9 e3 fb ff ff       	jmp    80104f20 <alltraps>

8010533d <vector1>:
.globl vector1
vector1:
  pushl $0
8010533d:	6a 00                	push   $0x0
  pushl $1
8010533f:	6a 01                	push   $0x1
  jmp alltraps
80105341:	e9 da fb ff ff       	jmp    80104f20 <alltraps>

80105346 <vector2>:
.globl vector2
vector2:
  pushl $0
80105346:	6a 00                	push   $0x0
  pushl $2
80105348:	6a 02                	push   $0x2
  jmp alltraps
8010534a:	e9 d1 fb ff ff       	jmp    80104f20 <alltraps>

8010534f <vector3>:
.globl vector3
vector3:
  pushl $0
8010534f:	6a 00                	push   $0x0
  pushl $3
80105351:	6a 03                	push   $0x3
  jmp alltraps
80105353:	e9 c8 fb ff ff       	jmp    80104f20 <alltraps>

80105358 <vector4>:
.globl vector4
vector4:
  pushl $0
80105358:	6a 00                	push   $0x0
  pushl $4
8010535a:	6a 04                	push   $0x4
  jmp alltraps
8010535c:	e9 bf fb ff ff       	jmp    80104f20 <alltraps>

80105361 <vector5>:
.globl vector5
vector5:
  pushl $0
80105361:	6a 00                	push   $0x0
  pushl $5
80105363:	6a 05                	push   $0x5
  jmp alltraps
80105365:	e9 b6 fb ff ff       	jmp    80104f20 <alltraps>

8010536a <vector6>:
.globl vector6
vector6:
  pushl $0
8010536a:	6a 00                	push   $0x0
  pushl $6
8010536c:	6a 06                	push   $0x6
  jmp alltraps
8010536e:	e9 ad fb ff ff       	jmp    80104f20 <alltraps>

80105373 <vector7>:
.globl vector7
vector7:
  pushl $0
80105373:	6a 00                	push   $0x0
  pushl $7
80105375:	6a 07                	push   $0x7
  jmp alltraps
80105377:	e9 a4 fb ff ff       	jmp    80104f20 <alltraps>

8010537c <vector8>:
.globl vector8
vector8:
  pushl $8
8010537c:	6a 08                	push   $0x8
  jmp alltraps
8010537e:	e9 9d fb ff ff       	jmp    80104f20 <alltraps>

80105383 <vector9>:
.globl vector9
vector9:
  pushl $0
80105383:	6a 00                	push   $0x0
  pushl $9
80105385:	6a 09                	push   $0x9
  jmp alltraps
80105387:	e9 94 fb ff ff       	jmp    80104f20 <alltraps>

8010538c <vector10>:
.globl vector10
vector10:
  pushl $10
8010538c:	6a 0a                	push   $0xa
  jmp alltraps
8010538e:	e9 8d fb ff ff       	jmp    80104f20 <alltraps>

80105393 <vector11>:
.globl vector11
vector11:
  pushl $11
80105393:	6a 0b                	push   $0xb
  jmp alltraps
80105395:	e9 86 fb ff ff       	jmp    80104f20 <alltraps>

8010539a <vector12>:
.globl vector12
vector12:
  pushl $12
8010539a:	6a 0c                	push   $0xc
  jmp alltraps
8010539c:	e9 7f fb ff ff       	jmp    80104f20 <alltraps>

801053a1 <vector13>:
.globl vector13
vector13:
  pushl $13
801053a1:	6a 0d                	push   $0xd
  jmp alltraps
801053a3:	e9 78 fb ff ff       	jmp    80104f20 <alltraps>

801053a8 <vector14>:
.globl vector14
vector14:
  pushl $14
801053a8:	6a 0e                	push   $0xe
  jmp alltraps
801053aa:	e9 71 fb ff ff       	jmp    80104f20 <alltraps>

801053af <vector15>:
.globl vector15
vector15:
  pushl $0
801053af:	6a 00                	push   $0x0
  pushl $15
801053b1:	6a 0f                	push   $0xf
  jmp alltraps
801053b3:	e9 68 fb ff ff       	jmp    80104f20 <alltraps>

801053b8 <vector16>:
.globl vector16
vector16:
  pushl $0
801053b8:	6a 00                	push   $0x0
  pushl $16
801053ba:	6a 10                	push   $0x10
  jmp alltraps
801053bc:	e9 5f fb ff ff       	jmp    80104f20 <alltraps>

801053c1 <vector17>:
.globl vector17
vector17:
  pushl $17
801053c1:	6a 11                	push   $0x11
  jmp alltraps
801053c3:	e9 58 fb ff ff       	jmp    80104f20 <alltraps>

801053c8 <vector18>:
.globl vector18
vector18:
  pushl $0
801053c8:	6a 00                	push   $0x0
  pushl $18
801053ca:	6a 12                	push   $0x12
  jmp alltraps
801053cc:	e9 4f fb ff ff       	jmp    80104f20 <alltraps>

801053d1 <vector19>:
.globl vector19
vector19:
  pushl $0
801053d1:	6a 00                	push   $0x0
  pushl $19
801053d3:	6a 13                	push   $0x13
  jmp alltraps
801053d5:	e9 46 fb ff ff       	jmp    80104f20 <alltraps>

801053da <vector20>:
.globl vector20
vector20:
  pushl $0
801053da:	6a 00                	push   $0x0
  pushl $20
801053dc:	6a 14                	push   $0x14
  jmp alltraps
801053de:	e9 3d fb ff ff       	jmp    80104f20 <alltraps>

801053e3 <vector21>:
.globl vector21
vector21:
  pushl $0
801053e3:	6a 00                	push   $0x0
  pushl $21
801053e5:	6a 15                	push   $0x15
  jmp alltraps
801053e7:	e9 34 fb ff ff       	jmp    80104f20 <alltraps>

801053ec <vector22>:
.globl vector22
vector22:
  pushl $0
801053ec:	6a 00                	push   $0x0
  pushl $22
801053ee:	6a 16                	push   $0x16
  jmp alltraps
801053f0:	e9 2b fb ff ff       	jmp    80104f20 <alltraps>

801053f5 <vector23>:
.globl vector23
vector23:
  pushl $0
801053f5:	6a 00                	push   $0x0
  pushl $23
801053f7:	6a 17                	push   $0x17
  jmp alltraps
801053f9:	e9 22 fb ff ff       	jmp    80104f20 <alltraps>

801053fe <vector24>:
.globl vector24
vector24:
  pushl $0
801053fe:	6a 00                	push   $0x0
  pushl $24
80105400:	6a 18                	push   $0x18
  jmp alltraps
80105402:	e9 19 fb ff ff       	jmp    80104f20 <alltraps>

80105407 <vector25>:
.globl vector25
vector25:
  pushl $0
80105407:	6a 00                	push   $0x0
  pushl $25
80105409:	6a 19                	push   $0x19
  jmp alltraps
8010540b:	e9 10 fb ff ff       	jmp    80104f20 <alltraps>

80105410 <vector26>:
.globl vector26
vector26:
  pushl $0
80105410:	6a 00                	push   $0x0
  pushl $26
80105412:	6a 1a                	push   $0x1a
  jmp alltraps
80105414:	e9 07 fb ff ff       	jmp    80104f20 <alltraps>

80105419 <vector27>:
.globl vector27
vector27:
  pushl $0
80105419:	6a 00                	push   $0x0
  pushl $27
8010541b:	6a 1b                	push   $0x1b
  jmp alltraps
8010541d:	e9 fe fa ff ff       	jmp    80104f20 <alltraps>

80105422 <vector28>:
.globl vector28
vector28:
  pushl $0
80105422:	6a 00                	push   $0x0
  pushl $28
80105424:	6a 1c                	push   $0x1c
  jmp alltraps
80105426:	e9 f5 fa ff ff       	jmp    80104f20 <alltraps>

8010542b <vector29>:
.globl vector29
vector29:
  pushl $0
8010542b:	6a 00                	push   $0x0
  pushl $29
8010542d:	6a 1d                	push   $0x1d
  jmp alltraps
8010542f:	e9 ec fa ff ff       	jmp    80104f20 <alltraps>

80105434 <vector30>:
.globl vector30
vector30:
  pushl $0
80105434:	6a 00                	push   $0x0
  pushl $30
80105436:	6a 1e                	push   $0x1e
  jmp alltraps
80105438:	e9 e3 fa ff ff       	jmp    80104f20 <alltraps>

8010543d <vector31>:
.globl vector31
vector31:
  pushl $0
8010543d:	6a 00                	push   $0x0
  pushl $31
8010543f:	6a 1f                	push   $0x1f
  jmp alltraps
80105441:	e9 da fa ff ff       	jmp    80104f20 <alltraps>

80105446 <vector32>:
.globl vector32
vector32:
  pushl $0
80105446:	6a 00                	push   $0x0
  pushl $32
80105448:	6a 20                	push   $0x20
  jmp alltraps
8010544a:	e9 d1 fa ff ff       	jmp    80104f20 <alltraps>

8010544f <vector33>:
.globl vector33
vector33:
  pushl $0
8010544f:	6a 00                	push   $0x0
  pushl $33
80105451:	6a 21                	push   $0x21
  jmp alltraps
80105453:	e9 c8 fa ff ff       	jmp    80104f20 <alltraps>

80105458 <vector34>:
.globl vector34
vector34:
  pushl $0
80105458:	6a 00                	push   $0x0
  pushl $34
8010545a:	6a 22                	push   $0x22
  jmp alltraps
8010545c:	e9 bf fa ff ff       	jmp    80104f20 <alltraps>

80105461 <vector35>:
.globl vector35
vector35:
  pushl $0
80105461:	6a 00                	push   $0x0
  pushl $35
80105463:	6a 23                	push   $0x23
  jmp alltraps
80105465:	e9 b6 fa ff ff       	jmp    80104f20 <alltraps>

8010546a <vector36>:
.globl vector36
vector36:
  pushl $0
8010546a:	6a 00                	push   $0x0
  pushl $36
8010546c:	6a 24                	push   $0x24
  jmp alltraps
8010546e:	e9 ad fa ff ff       	jmp    80104f20 <alltraps>

80105473 <vector37>:
.globl vector37
vector37:
  pushl $0
80105473:	6a 00                	push   $0x0
  pushl $37
80105475:	6a 25                	push   $0x25
  jmp alltraps
80105477:	e9 a4 fa ff ff       	jmp    80104f20 <alltraps>

8010547c <vector38>:
.globl vector38
vector38:
  pushl $0
8010547c:	6a 00                	push   $0x0
  pushl $38
8010547e:	6a 26                	push   $0x26
  jmp alltraps
80105480:	e9 9b fa ff ff       	jmp    80104f20 <alltraps>

80105485 <vector39>:
.globl vector39
vector39:
  pushl $0
80105485:	6a 00                	push   $0x0
  pushl $39
80105487:	6a 27                	push   $0x27
  jmp alltraps
80105489:	e9 92 fa ff ff       	jmp    80104f20 <alltraps>

8010548e <vector40>:
.globl vector40
vector40:
  pushl $0
8010548e:	6a 00                	push   $0x0
  pushl $40
80105490:	6a 28                	push   $0x28
  jmp alltraps
80105492:	e9 89 fa ff ff       	jmp    80104f20 <alltraps>

80105497 <vector41>:
.globl vector41
vector41:
  pushl $0
80105497:	6a 00                	push   $0x0
  pushl $41
80105499:	6a 29                	push   $0x29
  jmp alltraps
8010549b:	e9 80 fa ff ff       	jmp    80104f20 <alltraps>

801054a0 <vector42>:
.globl vector42
vector42:
  pushl $0
801054a0:	6a 00                	push   $0x0
  pushl $42
801054a2:	6a 2a                	push   $0x2a
  jmp alltraps
801054a4:	e9 77 fa ff ff       	jmp    80104f20 <alltraps>

801054a9 <vector43>:
.globl vector43
vector43:
  pushl $0
801054a9:	6a 00                	push   $0x0
  pushl $43
801054ab:	6a 2b                	push   $0x2b
  jmp alltraps
801054ad:	e9 6e fa ff ff       	jmp    80104f20 <alltraps>

801054b2 <vector44>:
.globl vector44
vector44:
  pushl $0
801054b2:	6a 00                	push   $0x0
  pushl $44
801054b4:	6a 2c                	push   $0x2c
  jmp alltraps
801054b6:	e9 65 fa ff ff       	jmp    80104f20 <alltraps>

801054bb <vector45>:
.globl vector45
vector45:
  pushl $0
801054bb:	6a 00                	push   $0x0
  pushl $45
801054bd:	6a 2d                	push   $0x2d
  jmp alltraps
801054bf:	e9 5c fa ff ff       	jmp    80104f20 <alltraps>

801054c4 <vector46>:
.globl vector46
vector46:
  pushl $0
801054c4:	6a 00                	push   $0x0
  pushl $46
801054c6:	6a 2e                	push   $0x2e
  jmp alltraps
801054c8:	e9 53 fa ff ff       	jmp    80104f20 <alltraps>

801054cd <vector47>:
.globl vector47
vector47:
  pushl $0
801054cd:	6a 00                	push   $0x0
  pushl $47
801054cf:	6a 2f                	push   $0x2f
  jmp alltraps
801054d1:	e9 4a fa ff ff       	jmp    80104f20 <alltraps>

801054d6 <vector48>:
.globl vector48
vector48:
  pushl $0
801054d6:	6a 00                	push   $0x0
  pushl $48
801054d8:	6a 30                	push   $0x30
  jmp alltraps
801054da:	e9 41 fa ff ff       	jmp    80104f20 <alltraps>

801054df <vector49>:
.globl vector49
vector49:
  pushl $0
801054df:	6a 00                	push   $0x0
  pushl $49
801054e1:	6a 31                	push   $0x31
  jmp alltraps
801054e3:	e9 38 fa ff ff       	jmp    80104f20 <alltraps>

801054e8 <vector50>:
.globl vector50
vector50:
  pushl $0
801054e8:	6a 00                	push   $0x0
  pushl $50
801054ea:	6a 32                	push   $0x32
  jmp alltraps
801054ec:	e9 2f fa ff ff       	jmp    80104f20 <alltraps>

801054f1 <vector51>:
.globl vector51
vector51:
  pushl $0
801054f1:	6a 00                	push   $0x0
  pushl $51
801054f3:	6a 33                	push   $0x33
  jmp alltraps
801054f5:	e9 26 fa ff ff       	jmp    80104f20 <alltraps>

801054fa <vector52>:
.globl vector52
vector52:
  pushl $0
801054fa:	6a 00                	push   $0x0
  pushl $52
801054fc:	6a 34                	push   $0x34
  jmp alltraps
801054fe:	e9 1d fa ff ff       	jmp    80104f20 <alltraps>

80105503 <vector53>:
.globl vector53
vector53:
  pushl $0
80105503:	6a 00                	push   $0x0
  pushl $53
80105505:	6a 35                	push   $0x35
  jmp alltraps
80105507:	e9 14 fa ff ff       	jmp    80104f20 <alltraps>

8010550c <vector54>:
.globl vector54
vector54:
  pushl $0
8010550c:	6a 00                	push   $0x0
  pushl $54
8010550e:	6a 36                	push   $0x36
  jmp alltraps
80105510:	e9 0b fa ff ff       	jmp    80104f20 <alltraps>

80105515 <vector55>:
.globl vector55
vector55:
  pushl $0
80105515:	6a 00                	push   $0x0
  pushl $55
80105517:	6a 37                	push   $0x37
  jmp alltraps
80105519:	e9 02 fa ff ff       	jmp    80104f20 <alltraps>

8010551e <vector56>:
.globl vector56
vector56:
  pushl $0
8010551e:	6a 00                	push   $0x0
  pushl $56
80105520:	6a 38                	push   $0x38
  jmp alltraps
80105522:	e9 f9 f9 ff ff       	jmp    80104f20 <alltraps>

80105527 <vector57>:
.globl vector57
vector57:
  pushl $0
80105527:	6a 00                	push   $0x0
  pushl $57
80105529:	6a 39                	push   $0x39
  jmp alltraps
8010552b:	e9 f0 f9 ff ff       	jmp    80104f20 <alltraps>

80105530 <vector58>:
.globl vector58
vector58:
  pushl $0
80105530:	6a 00                	push   $0x0
  pushl $58
80105532:	6a 3a                	push   $0x3a
  jmp alltraps
80105534:	e9 e7 f9 ff ff       	jmp    80104f20 <alltraps>

80105539 <vector59>:
.globl vector59
vector59:
  pushl $0
80105539:	6a 00                	push   $0x0
  pushl $59
8010553b:	6a 3b                	push   $0x3b
  jmp alltraps
8010553d:	e9 de f9 ff ff       	jmp    80104f20 <alltraps>

80105542 <vector60>:
.globl vector60
vector60:
  pushl $0
80105542:	6a 00                	push   $0x0
  pushl $60
80105544:	6a 3c                	push   $0x3c
  jmp alltraps
80105546:	e9 d5 f9 ff ff       	jmp    80104f20 <alltraps>

8010554b <vector61>:
.globl vector61
vector61:
  pushl $0
8010554b:	6a 00                	push   $0x0
  pushl $61
8010554d:	6a 3d                	push   $0x3d
  jmp alltraps
8010554f:	e9 cc f9 ff ff       	jmp    80104f20 <alltraps>

80105554 <vector62>:
.globl vector62
vector62:
  pushl $0
80105554:	6a 00                	push   $0x0
  pushl $62
80105556:	6a 3e                	push   $0x3e
  jmp alltraps
80105558:	e9 c3 f9 ff ff       	jmp    80104f20 <alltraps>

8010555d <vector63>:
.globl vector63
vector63:
  pushl $0
8010555d:	6a 00                	push   $0x0
  pushl $63
8010555f:	6a 3f                	push   $0x3f
  jmp alltraps
80105561:	e9 ba f9 ff ff       	jmp    80104f20 <alltraps>

80105566 <vector64>:
.globl vector64
vector64:
  pushl $0
80105566:	6a 00                	push   $0x0
  pushl $64
80105568:	6a 40                	push   $0x40
  jmp alltraps
8010556a:	e9 b1 f9 ff ff       	jmp    80104f20 <alltraps>

8010556f <vector65>:
.globl vector65
vector65:
  pushl $0
8010556f:	6a 00                	push   $0x0
  pushl $65
80105571:	6a 41                	push   $0x41
  jmp alltraps
80105573:	e9 a8 f9 ff ff       	jmp    80104f20 <alltraps>

80105578 <vector66>:
.globl vector66
vector66:
  pushl $0
80105578:	6a 00                	push   $0x0
  pushl $66
8010557a:	6a 42                	push   $0x42
  jmp alltraps
8010557c:	e9 9f f9 ff ff       	jmp    80104f20 <alltraps>

80105581 <vector67>:
.globl vector67
vector67:
  pushl $0
80105581:	6a 00                	push   $0x0
  pushl $67
80105583:	6a 43                	push   $0x43
  jmp alltraps
80105585:	e9 96 f9 ff ff       	jmp    80104f20 <alltraps>

8010558a <vector68>:
.globl vector68
vector68:
  pushl $0
8010558a:	6a 00                	push   $0x0
  pushl $68
8010558c:	6a 44                	push   $0x44
  jmp alltraps
8010558e:	e9 8d f9 ff ff       	jmp    80104f20 <alltraps>

80105593 <vector69>:
.globl vector69
vector69:
  pushl $0
80105593:	6a 00                	push   $0x0
  pushl $69
80105595:	6a 45                	push   $0x45
  jmp alltraps
80105597:	e9 84 f9 ff ff       	jmp    80104f20 <alltraps>

8010559c <vector70>:
.globl vector70
vector70:
  pushl $0
8010559c:	6a 00                	push   $0x0
  pushl $70
8010559e:	6a 46                	push   $0x46
  jmp alltraps
801055a0:	e9 7b f9 ff ff       	jmp    80104f20 <alltraps>

801055a5 <vector71>:
.globl vector71
vector71:
  pushl $0
801055a5:	6a 00                	push   $0x0
  pushl $71
801055a7:	6a 47                	push   $0x47
  jmp alltraps
801055a9:	e9 72 f9 ff ff       	jmp    80104f20 <alltraps>

801055ae <vector72>:
.globl vector72
vector72:
  pushl $0
801055ae:	6a 00                	push   $0x0
  pushl $72
801055b0:	6a 48                	push   $0x48
  jmp alltraps
801055b2:	e9 69 f9 ff ff       	jmp    80104f20 <alltraps>

801055b7 <vector73>:
.globl vector73
vector73:
  pushl $0
801055b7:	6a 00                	push   $0x0
  pushl $73
801055b9:	6a 49                	push   $0x49
  jmp alltraps
801055bb:	e9 60 f9 ff ff       	jmp    80104f20 <alltraps>

801055c0 <vector74>:
.globl vector74
vector74:
  pushl $0
801055c0:	6a 00                	push   $0x0
  pushl $74
801055c2:	6a 4a                	push   $0x4a
  jmp alltraps
801055c4:	e9 57 f9 ff ff       	jmp    80104f20 <alltraps>

801055c9 <vector75>:
.globl vector75
vector75:
  pushl $0
801055c9:	6a 00                	push   $0x0
  pushl $75
801055cb:	6a 4b                	push   $0x4b
  jmp alltraps
801055cd:	e9 4e f9 ff ff       	jmp    80104f20 <alltraps>

801055d2 <vector76>:
.globl vector76
vector76:
  pushl $0
801055d2:	6a 00                	push   $0x0
  pushl $76
801055d4:	6a 4c                	push   $0x4c
  jmp alltraps
801055d6:	e9 45 f9 ff ff       	jmp    80104f20 <alltraps>

801055db <vector77>:
.globl vector77
vector77:
  pushl $0
801055db:	6a 00                	push   $0x0
  pushl $77
801055dd:	6a 4d                	push   $0x4d
  jmp alltraps
801055df:	e9 3c f9 ff ff       	jmp    80104f20 <alltraps>

801055e4 <vector78>:
.globl vector78
vector78:
  pushl $0
801055e4:	6a 00                	push   $0x0
  pushl $78
801055e6:	6a 4e                	push   $0x4e
  jmp alltraps
801055e8:	e9 33 f9 ff ff       	jmp    80104f20 <alltraps>

801055ed <vector79>:
.globl vector79
vector79:
  pushl $0
801055ed:	6a 00                	push   $0x0
  pushl $79
801055ef:	6a 4f                	push   $0x4f
  jmp alltraps
801055f1:	e9 2a f9 ff ff       	jmp    80104f20 <alltraps>

801055f6 <vector80>:
.globl vector80
vector80:
  pushl $0
801055f6:	6a 00                	push   $0x0
  pushl $80
801055f8:	6a 50                	push   $0x50
  jmp alltraps
801055fa:	e9 21 f9 ff ff       	jmp    80104f20 <alltraps>

801055ff <vector81>:
.globl vector81
vector81:
  pushl $0
801055ff:	6a 00                	push   $0x0
  pushl $81
80105601:	6a 51                	push   $0x51
  jmp alltraps
80105603:	e9 18 f9 ff ff       	jmp    80104f20 <alltraps>

80105608 <vector82>:
.globl vector82
vector82:
  pushl $0
80105608:	6a 00                	push   $0x0
  pushl $82
8010560a:	6a 52                	push   $0x52
  jmp alltraps
8010560c:	e9 0f f9 ff ff       	jmp    80104f20 <alltraps>

80105611 <vector83>:
.globl vector83
vector83:
  pushl $0
80105611:	6a 00                	push   $0x0
  pushl $83
80105613:	6a 53                	push   $0x53
  jmp alltraps
80105615:	e9 06 f9 ff ff       	jmp    80104f20 <alltraps>

8010561a <vector84>:
.globl vector84
vector84:
  pushl $0
8010561a:	6a 00                	push   $0x0
  pushl $84
8010561c:	6a 54                	push   $0x54
  jmp alltraps
8010561e:	e9 fd f8 ff ff       	jmp    80104f20 <alltraps>

80105623 <vector85>:
.globl vector85
vector85:
  pushl $0
80105623:	6a 00                	push   $0x0
  pushl $85
80105625:	6a 55                	push   $0x55
  jmp alltraps
80105627:	e9 f4 f8 ff ff       	jmp    80104f20 <alltraps>

8010562c <vector86>:
.globl vector86
vector86:
  pushl $0
8010562c:	6a 00                	push   $0x0
  pushl $86
8010562e:	6a 56                	push   $0x56
  jmp alltraps
80105630:	e9 eb f8 ff ff       	jmp    80104f20 <alltraps>

80105635 <vector87>:
.globl vector87
vector87:
  pushl $0
80105635:	6a 00                	push   $0x0
  pushl $87
80105637:	6a 57                	push   $0x57
  jmp alltraps
80105639:	e9 e2 f8 ff ff       	jmp    80104f20 <alltraps>

8010563e <vector88>:
.globl vector88
vector88:
  pushl $0
8010563e:	6a 00                	push   $0x0
  pushl $88
80105640:	6a 58                	push   $0x58
  jmp alltraps
80105642:	e9 d9 f8 ff ff       	jmp    80104f20 <alltraps>

80105647 <vector89>:
.globl vector89
vector89:
  pushl $0
80105647:	6a 00                	push   $0x0
  pushl $89
80105649:	6a 59                	push   $0x59
  jmp alltraps
8010564b:	e9 d0 f8 ff ff       	jmp    80104f20 <alltraps>

80105650 <vector90>:
.globl vector90
vector90:
  pushl $0
80105650:	6a 00                	push   $0x0
  pushl $90
80105652:	6a 5a                	push   $0x5a
  jmp alltraps
80105654:	e9 c7 f8 ff ff       	jmp    80104f20 <alltraps>

80105659 <vector91>:
.globl vector91
vector91:
  pushl $0
80105659:	6a 00                	push   $0x0
  pushl $91
8010565b:	6a 5b                	push   $0x5b
  jmp alltraps
8010565d:	e9 be f8 ff ff       	jmp    80104f20 <alltraps>

80105662 <vector92>:
.globl vector92
vector92:
  pushl $0
80105662:	6a 00                	push   $0x0
  pushl $92
80105664:	6a 5c                	push   $0x5c
  jmp alltraps
80105666:	e9 b5 f8 ff ff       	jmp    80104f20 <alltraps>

8010566b <vector93>:
.globl vector93
vector93:
  pushl $0
8010566b:	6a 00                	push   $0x0
  pushl $93
8010566d:	6a 5d                	push   $0x5d
  jmp alltraps
8010566f:	e9 ac f8 ff ff       	jmp    80104f20 <alltraps>

80105674 <vector94>:
.globl vector94
vector94:
  pushl $0
80105674:	6a 00                	push   $0x0
  pushl $94
80105676:	6a 5e                	push   $0x5e
  jmp alltraps
80105678:	e9 a3 f8 ff ff       	jmp    80104f20 <alltraps>

8010567d <vector95>:
.globl vector95
vector95:
  pushl $0
8010567d:	6a 00                	push   $0x0
  pushl $95
8010567f:	6a 5f                	push   $0x5f
  jmp alltraps
80105681:	e9 9a f8 ff ff       	jmp    80104f20 <alltraps>

80105686 <vector96>:
.globl vector96
vector96:
  pushl $0
80105686:	6a 00                	push   $0x0
  pushl $96
80105688:	6a 60                	push   $0x60
  jmp alltraps
8010568a:	e9 91 f8 ff ff       	jmp    80104f20 <alltraps>

8010568f <vector97>:
.globl vector97
vector97:
  pushl $0
8010568f:	6a 00                	push   $0x0
  pushl $97
80105691:	6a 61                	push   $0x61
  jmp alltraps
80105693:	e9 88 f8 ff ff       	jmp    80104f20 <alltraps>

80105698 <vector98>:
.globl vector98
vector98:
  pushl $0
80105698:	6a 00                	push   $0x0
  pushl $98
8010569a:	6a 62                	push   $0x62
  jmp alltraps
8010569c:	e9 7f f8 ff ff       	jmp    80104f20 <alltraps>

801056a1 <vector99>:
.globl vector99
vector99:
  pushl $0
801056a1:	6a 00                	push   $0x0
  pushl $99
801056a3:	6a 63                	push   $0x63
  jmp alltraps
801056a5:	e9 76 f8 ff ff       	jmp    80104f20 <alltraps>

801056aa <vector100>:
.globl vector100
vector100:
  pushl $0
801056aa:	6a 00                	push   $0x0
  pushl $100
801056ac:	6a 64                	push   $0x64
  jmp alltraps
801056ae:	e9 6d f8 ff ff       	jmp    80104f20 <alltraps>

801056b3 <vector101>:
.globl vector101
vector101:
  pushl $0
801056b3:	6a 00                	push   $0x0
  pushl $101
801056b5:	6a 65                	push   $0x65
  jmp alltraps
801056b7:	e9 64 f8 ff ff       	jmp    80104f20 <alltraps>

801056bc <vector102>:
.globl vector102
vector102:
  pushl $0
801056bc:	6a 00                	push   $0x0
  pushl $102
801056be:	6a 66                	push   $0x66
  jmp alltraps
801056c0:	e9 5b f8 ff ff       	jmp    80104f20 <alltraps>

801056c5 <vector103>:
.globl vector103
vector103:
  pushl $0
801056c5:	6a 00                	push   $0x0
  pushl $103
801056c7:	6a 67                	push   $0x67
  jmp alltraps
801056c9:	e9 52 f8 ff ff       	jmp    80104f20 <alltraps>

801056ce <vector104>:
.globl vector104
vector104:
  pushl $0
801056ce:	6a 00                	push   $0x0
  pushl $104
801056d0:	6a 68                	push   $0x68
  jmp alltraps
801056d2:	e9 49 f8 ff ff       	jmp    80104f20 <alltraps>

801056d7 <vector105>:
.globl vector105
vector105:
  pushl $0
801056d7:	6a 00                	push   $0x0
  pushl $105
801056d9:	6a 69                	push   $0x69
  jmp alltraps
801056db:	e9 40 f8 ff ff       	jmp    80104f20 <alltraps>

801056e0 <vector106>:
.globl vector106
vector106:
  pushl $0
801056e0:	6a 00                	push   $0x0
  pushl $106
801056e2:	6a 6a                	push   $0x6a
  jmp alltraps
801056e4:	e9 37 f8 ff ff       	jmp    80104f20 <alltraps>

801056e9 <vector107>:
.globl vector107
vector107:
  pushl $0
801056e9:	6a 00                	push   $0x0
  pushl $107
801056eb:	6a 6b                	push   $0x6b
  jmp alltraps
801056ed:	e9 2e f8 ff ff       	jmp    80104f20 <alltraps>

801056f2 <vector108>:
.globl vector108
vector108:
  pushl $0
801056f2:	6a 00                	push   $0x0
  pushl $108
801056f4:	6a 6c                	push   $0x6c
  jmp alltraps
801056f6:	e9 25 f8 ff ff       	jmp    80104f20 <alltraps>

801056fb <vector109>:
.globl vector109
vector109:
  pushl $0
801056fb:	6a 00                	push   $0x0
  pushl $109
801056fd:	6a 6d                	push   $0x6d
  jmp alltraps
801056ff:	e9 1c f8 ff ff       	jmp    80104f20 <alltraps>

80105704 <vector110>:
.globl vector110
vector110:
  pushl $0
80105704:	6a 00                	push   $0x0
  pushl $110
80105706:	6a 6e                	push   $0x6e
  jmp alltraps
80105708:	e9 13 f8 ff ff       	jmp    80104f20 <alltraps>

8010570d <vector111>:
.globl vector111
vector111:
  pushl $0
8010570d:	6a 00                	push   $0x0
  pushl $111
8010570f:	6a 6f                	push   $0x6f
  jmp alltraps
80105711:	e9 0a f8 ff ff       	jmp    80104f20 <alltraps>

80105716 <vector112>:
.globl vector112
vector112:
  pushl $0
80105716:	6a 00                	push   $0x0
  pushl $112
80105718:	6a 70                	push   $0x70
  jmp alltraps
8010571a:	e9 01 f8 ff ff       	jmp    80104f20 <alltraps>

8010571f <vector113>:
.globl vector113
vector113:
  pushl $0
8010571f:	6a 00                	push   $0x0
  pushl $113
80105721:	6a 71                	push   $0x71
  jmp alltraps
80105723:	e9 f8 f7 ff ff       	jmp    80104f20 <alltraps>

80105728 <vector114>:
.globl vector114
vector114:
  pushl $0
80105728:	6a 00                	push   $0x0
  pushl $114
8010572a:	6a 72                	push   $0x72
  jmp alltraps
8010572c:	e9 ef f7 ff ff       	jmp    80104f20 <alltraps>

80105731 <vector115>:
.globl vector115
vector115:
  pushl $0
80105731:	6a 00                	push   $0x0
  pushl $115
80105733:	6a 73                	push   $0x73
  jmp alltraps
80105735:	e9 e6 f7 ff ff       	jmp    80104f20 <alltraps>

8010573a <vector116>:
.globl vector116
vector116:
  pushl $0
8010573a:	6a 00                	push   $0x0
  pushl $116
8010573c:	6a 74                	push   $0x74
  jmp alltraps
8010573e:	e9 dd f7 ff ff       	jmp    80104f20 <alltraps>

80105743 <vector117>:
.globl vector117
vector117:
  pushl $0
80105743:	6a 00                	push   $0x0
  pushl $117
80105745:	6a 75                	push   $0x75
  jmp alltraps
80105747:	e9 d4 f7 ff ff       	jmp    80104f20 <alltraps>

8010574c <vector118>:
.globl vector118
vector118:
  pushl $0
8010574c:	6a 00                	push   $0x0
  pushl $118
8010574e:	6a 76                	push   $0x76
  jmp alltraps
80105750:	e9 cb f7 ff ff       	jmp    80104f20 <alltraps>

80105755 <vector119>:
.globl vector119
vector119:
  pushl $0
80105755:	6a 00                	push   $0x0
  pushl $119
80105757:	6a 77                	push   $0x77
  jmp alltraps
80105759:	e9 c2 f7 ff ff       	jmp    80104f20 <alltraps>

8010575e <vector120>:
.globl vector120
vector120:
  pushl $0
8010575e:	6a 00                	push   $0x0
  pushl $120
80105760:	6a 78                	push   $0x78
  jmp alltraps
80105762:	e9 b9 f7 ff ff       	jmp    80104f20 <alltraps>

80105767 <vector121>:
.globl vector121
vector121:
  pushl $0
80105767:	6a 00                	push   $0x0
  pushl $121
80105769:	6a 79                	push   $0x79
  jmp alltraps
8010576b:	e9 b0 f7 ff ff       	jmp    80104f20 <alltraps>

80105770 <vector122>:
.globl vector122
vector122:
  pushl $0
80105770:	6a 00                	push   $0x0
  pushl $122
80105772:	6a 7a                	push   $0x7a
  jmp alltraps
80105774:	e9 a7 f7 ff ff       	jmp    80104f20 <alltraps>

80105779 <vector123>:
.globl vector123
vector123:
  pushl $0
80105779:	6a 00                	push   $0x0
  pushl $123
8010577b:	6a 7b                	push   $0x7b
  jmp alltraps
8010577d:	e9 9e f7 ff ff       	jmp    80104f20 <alltraps>

80105782 <vector124>:
.globl vector124
vector124:
  pushl $0
80105782:	6a 00                	push   $0x0
  pushl $124
80105784:	6a 7c                	push   $0x7c
  jmp alltraps
80105786:	e9 95 f7 ff ff       	jmp    80104f20 <alltraps>

8010578b <vector125>:
.globl vector125
vector125:
  pushl $0
8010578b:	6a 00                	push   $0x0
  pushl $125
8010578d:	6a 7d                	push   $0x7d
  jmp alltraps
8010578f:	e9 8c f7 ff ff       	jmp    80104f20 <alltraps>

80105794 <vector126>:
.globl vector126
vector126:
  pushl $0
80105794:	6a 00                	push   $0x0
  pushl $126
80105796:	6a 7e                	push   $0x7e
  jmp alltraps
80105798:	e9 83 f7 ff ff       	jmp    80104f20 <alltraps>

8010579d <vector127>:
.globl vector127
vector127:
  pushl $0
8010579d:	6a 00                	push   $0x0
  pushl $127
8010579f:	6a 7f                	push   $0x7f
  jmp alltraps
801057a1:	e9 7a f7 ff ff       	jmp    80104f20 <alltraps>

801057a6 <vector128>:
.globl vector128
vector128:
  pushl $0
801057a6:	6a 00                	push   $0x0
  pushl $128
801057a8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801057ad:	e9 6e f7 ff ff       	jmp    80104f20 <alltraps>

801057b2 <vector129>:
.globl vector129
vector129:
  pushl $0
801057b2:	6a 00                	push   $0x0
  pushl $129
801057b4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801057b9:	e9 62 f7 ff ff       	jmp    80104f20 <alltraps>

801057be <vector130>:
.globl vector130
vector130:
  pushl $0
801057be:	6a 00                	push   $0x0
  pushl $130
801057c0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801057c5:	e9 56 f7 ff ff       	jmp    80104f20 <alltraps>

801057ca <vector131>:
.globl vector131
vector131:
  pushl $0
801057ca:	6a 00                	push   $0x0
  pushl $131
801057cc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801057d1:	e9 4a f7 ff ff       	jmp    80104f20 <alltraps>

801057d6 <vector132>:
.globl vector132
vector132:
  pushl $0
801057d6:	6a 00                	push   $0x0
  pushl $132
801057d8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801057dd:	e9 3e f7 ff ff       	jmp    80104f20 <alltraps>

801057e2 <vector133>:
.globl vector133
vector133:
  pushl $0
801057e2:	6a 00                	push   $0x0
  pushl $133
801057e4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801057e9:	e9 32 f7 ff ff       	jmp    80104f20 <alltraps>

801057ee <vector134>:
.globl vector134
vector134:
  pushl $0
801057ee:	6a 00                	push   $0x0
  pushl $134
801057f0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801057f5:	e9 26 f7 ff ff       	jmp    80104f20 <alltraps>

801057fa <vector135>:
.globl vector135
vector135:
  pushl $0
801057fa:	6a 00                	push   $0x0
  pushl $135
801057fc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105801:	e9 1a f7 ff ff       	jmp    80104f20 <alltraps>

80105806 <vector136>:
.globl vector136
vector136:
  pushl $0
80105806:	6a 00                	push   $0x0
  pushl $136
80105808:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010580d:	e9 0e f7 ff ff       	jmp    80104f20 <alltraps>

80105812 <vector137>:
.globl vector137
vector137:
  pushl $0
80105812:	6a 00                	push   $0x0
  pushl $137
80105814:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105819:	e9 02 f7 ff ff       	jmp    80104f20 <alltraps>

8010581e <vector138>:
.globl vector138
vector138:
  pushl $0
8010581e:	6a 00                	push   $0x0
  pushl $138
80105820:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105825:	e9 f6 f6 ff ff       	jmp    80104f20 <alltraps>

8010582a <vector139>:
.globl vector139
vector139:
  pushl $0
8010582a:	6a 00                	push   $0x0
  pushl $139
8010582c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105831:	e9 ea f6 ff ff       	jmp    80104f20 <alltraps>

80105836 <vector140>:
.globl vector140
vector140:
  pushl $0
80105836:	6a 00                	push   $0x0
  pushl $140
80105838:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010583d:	e9 de f6 ff ff       	jmp    80104f20 <alltraps>

80105842 <vector141>:
.globl vector141
vector141:
  pushl $0
80105842:	6a 00                	push   $0x0
  pushl $141
80105844:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105849:	e9 d2 f6 ff ff       	jmp    80104f20 <alltraps>

8010584e <vector142>:
.globl vector142
vector142:
  pushl $0
8010584e:	6a 00                	push   $0x0
  pushl $142
80105850:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105855:	e9 c6 f6 ff ff       	jmp    80104f20 <alltraps>

8010585a <vector143>:
.globl vector143
vector143:
  pushl $0
8010585a:	6a 00                	push   $0x0
  pushl $143
8010585c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105861:	e9 ba f6 ff ff       	jmp    80104f20 <alltraps>

80105866 <vector144>:
.globl vector144
vector144:
  pushl $0
80105866:	6a 00                	push   $0x0
  pushl $144
80105868:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010586d:	e9 ae f6 ff ff       	jmp    80104f20 <alltraps>

80105872 <vector145>:
.globl vector145
vector145:
  pushl $0
80105872:	6a 00                	push   $0x0
  pushl $145
80105874:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105879:	e9 a2 f6 ff ff       	jmp    80104f20 <alltraps>

8010587e <vector146>:
.globl vector146
vector146:
  pushl $0
8010587e:	6a 00                	push   $0x0
  pushl $146
80105880:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105885:	e9 96 f6 ff ff       	jmp    80104f20 <alltraps>

8010588a <vector147>:
.globl vector147
vector147:
  pushl $0
8010588a:	6a 00                	push   $0x0
  pushl $147
8010588c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105891:	e9 8a f6 ff ff       	jmp    80104f20 <alltraps>

80105896 <vector148>:
.globl vector148
vector148:
  pushl $0
80105896:	6a 00                	push   $0x0
  pushl $148
80105898:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010589d:	e9 7e f6 ff ff       	jmp    80104f20 <alltraps>

801058a2 <vector149>:
.globl vector149
vector149:
  pushl $0
801058a2:	6a 00                	push   $0x0
  pushl $149
801058a4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801058a9:	e9 72 f6 ff ff       	jmp    80104f20 <alltraps>

801058ae <vector150>:
.globl vector150
vector150:
  pushl $0
801058ae:	6a 00                	push   $0x0
  pushl $150
801058b0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801058b5:	e9 66 f6 ff ff       	jmp    80104f20 <alltraps>

801058ba <vector151>:
.globl vector151
vector151:
  pushl $0
801058ba:	6a 00                	push   $0x0
  pushl $151
801058bc:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801058c1:	e9 5a f6 ff ff       	jmp    80104f20 <alltraps>

801058c6 <vector152>:
.globl vector152
vector152:
  pushl $0
801058c6:	6a 00                	push   $0x0
  pushl $152
801058c8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801058cd:	e9 4e f6 ff ff       	jmp    80104f20 <alltraps>

801058d2 <vector153>:
.globl vector153
vector153:
  pushl $0
801058d2:	6a 00                	push   $0x0
  pushl $153
801058d4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801058d9:	e9 42 f6 ff ff       	jmp    80104f20 <alltraps>

801058de <vector154>:
.globl vector154
vector154:
  pushl $0
801058de:	6a 00                	push   $0x0
  pushl $154
801058e0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801058e5:	e9 36 f6 ff ff       	jmp    80104f20 <alltraps>

801058ea <vector155>:
.globl vector155
vector155:
  pushl $0
801058ea:	6a 00                	push   $0x0
  pushl $155
801058ec:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801058f1:	e9 2a f6 ff ff       	jmp    80104f20 <alltraps>

801058f6 <vector156>:
.globl vector156
vector156:
  pushl $0
801058f6:	6a 00                	push   $0x0
  pushl $156
801058f8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801058fd:	e9 1e f6 ff ff       	jmp    80104f20 <alltraps>

80105902 <vector157>:
.globl vector157
vector157:
  pushl $0
80105902:	6a 00                	push   $0x0
  pushl $157
80105904:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105909:	e9 12 f6 ff ff       	jmp    80104f20 <alltraps>

8010590e <vector158>:
.globl vector158
vector158:
  pushl $0
8010590e:	6a 00                	push   $0x0
  pushl $158
80105910:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105915:	e9 06 f6 ff ff       	jmp    80104f20 <alltraps>

8010591a <vector159>:
.globl vector159
vector159:
  pushl $0
8010591a:	6a 00                	push   $0x0
  pushl $159
8010591c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105921:	e9 fa f5 ff ff       	jmp    80104f20 <alltraps>

80105926 <vector160>:
.globl vector160
vector160:
  pushl $0
80105926:	6a 00                	push   $0x0
  pushl $160
80105928:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010592d:	e9 ee f5 ff ff       	jmp    80104f20 <alltraps>

80105932 <vector161>:
.globl vector161
vector161:
  pushl $0
80105932:	6a 00                	push   $0x0
  pushl $161
80105934:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105939:	e9 e2 f5 ff ff       	jmp    80104f20 <alltraps>

8010593e <vector162>:
.globl vector162
vector162:
  pushl $0
8010593e:	6a 00                	push   $0x0
  pushl $162
80105940:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105945:	e9 d6 f5 ff ff       	jmp    80104f20 <alltraps>

8010594a <vector163>:
.globl vector163
vector163:
  pushl $0
8010594a:	6a 00                	push   $0x0
  pushl $163
8010594c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105951:	e9 ca f5 ff ff       	jmp    80104f20 <alltraps>

80105956 <vector164>:
.globl vector164
vector164:
  pushl $0
80105956:	6a 00                	push   $0x0
  pushl $164
80105958:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010595d:	e9 be f5 ff ff       	jmp    80104f20 <alltraps>

80105962 <vector165>:
.globl vector165
vector165:
  pushl $0
80105962:	6a 00                	push   $0x0
  pushl $165
80105964:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105969:	e9 b2 f5 ff ff       	jmp    80104f20 <alltraps>

8010596e <vector166>:
.globl vector166
vector166:
  pushl $0
8010596e:	6a 00                	push   $0x0
  pushl $166
80105970:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80105975:	e9 a6 f5 ff ff       	jmp    80104f20 <alltraps>

8010597a <vector167>:
.globl vector167
vector167:
  pushl $0
8010597a:	6a 00                	push   $0x0
  pushl $167
8010597c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105981:	e9 9a f5 ff ff       	jmp    80104f20 <alltraps>

80105986 <vector168>:
.globl vector168
vector168:
  pushl $0
80105986:	6a 00                	push   $0x0
  pushl $168
80105988:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010598d:	e9 8e f5 ff ff       	jmp    80104f20 <alltraps>

80105992 <vector169>:
.globl vector169
vector169:
  pushl $0
80105992:	6a 00                	push   $0x0
  pushl $169
80105994:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105999:	e9 82 f5 ff ff       	jmp    80104f20 <alltraps>

8010599e <vector170>:
.globl vector170
vector170:
  pushl $0
8010599e:	6a 00                	push   $0x0
  pushl $170
801059a0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801059a5:	e9 76 f5 ff ff       	jmp    80104f20 <alltraps>

801059aa <vector171>:
.globl vector171
vector171:
  pushl $0
801059aa:	6a 00                	push   $0x0
  pushl $171
801059ac:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801059b1:	e9 6a f5 ff ff       	jmp    80104f20 <alltraps>

801059b6 <vector172>:
.globl vector172
vector172:
  pushl $0
801059b6:	6a 00                	push   $0x0
  pushl $172
801059b8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801059bd:	e9 5e f5 ff ff       	jmp    80104f20 <alltraps>

801059c2 <vector173>:
.globl vector173
vector173:
  pushl $0
801059c2:	6a 00                	push   $0x0
  pushl $173
801059c4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801059c9:	e9 52 f5 ff ff       	jmp    80104f20 <alltraps>

801059ce <vector174>:
.globl vector174
vector174:
  pushl $0
801059ce:	6a 00                	push   $0x0
  pushl $174
801059d0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801059d5:	e9 46 f5 ff ff       	jmp    80104f20 <alltraps>

801059da <vector175>:
.globl vector175
vector175:
  pushl $0
801059da:	6a 00                	push   $0x0
  pushl $175
801059dc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801059e1:	e9 3a f5 ff ff       	jmp    80104f20 <alltraps>

801059e6 <vector176>:
.globl vector176
vector176:
  pushl $0
801059e6:	6a 00                	push   $0x0
  pushl $176
801059e8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801059ed:	e9 2e f5 ff ff       	jmp    80104f20 <alltraps>

801059f2 <vector177>:
.globl vector177
vector177:
  pushl $0
801059f2:	6a 00                	push   $0x0
  pushl $177
801059f4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801059f9:	e9 22 f5 ff ff       	jmp    80104f20 <alltraps>

801059fe <vector178>:
.globl vector178
vector178:
  pushl $0
801059fe:	6a 00                	push   $0x0
  pushl $178
80105a00:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80105a05:	e9 16 f5 ff ff       	jmp    80104f20 <alltraps>

80105a0a <vector179>:
.globl vector179
vector179:
  pushl $0
80105a0a:	6a 00                	push   $0x0
  pushl $179
80105a0c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80105a11:	e9 0a f5 ff ff       	jmp    80104f20 <alltraps>

80105a16 <vector180>:
.globl vector180
vector180:
  pushl $0
80105a16:	6a 00                	push   $0x0
  pushl $180
80105a18:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80105a1d:	e9 fe f4 ff ff       	jmp    80104f20 <alltraps>

80105a22 <vector181>:
.globl vector181
vector181:
  pushl $0
80105a22:	6a 00                	push   $0x0
  pushl $181
80105a24:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80105a29:	e9 f2 f4 ff ff       	jmp    80104f20 <alltraps>

80105a2e <vector182>:
.globl vector182
vector182:
  pushl $0
80105a2e:	6a 00                	push   $0x0
  pushl $182
80105a30:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80105a35:	e9 e6 f4 ff ff       	jmp    80104f20 <alltraps>

80105a3a <vector183>:
.globl vector183
vector183:
  pushl $0
80105a3a:	6a 00                	push   $0x0
  pushl $183
80105a3c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80105a41:	e9 da f4 ff ff       	jmp    80104f20 <alltraps>

80105a46 <vector184>:
.globl vector184
vector184:
  pushl $0
80105a46:	6a 00                	push   $0x0
  pushl $184
80105a48:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80105a4d:	e9 ce f4 ff ff       	jmp    80104f20 <alltraps>

80105a52 <vector185>:
.globl vector185
vector185:
  pushl $0
80105a52:	6a 00                	push   $0x0
  pushl $185
80105a54:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80105a59:	e9 c2 f4 ff ff       	jmp    80104f20 <alltraps>

80105a5e <vector186>:
.globl vector186
vector186:
  pushl $0
80105a5e:	6a 00                	push   $0x0
  pushl $186
80105a60:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80105a65:	e9 b6 f4 ff ff       	jmp    80104f20 <alltraps>

80105a6a <vector187>:
.globl vector187
vector187:
  pushl $0
80105a6a:	6a 00                	push   $0x0
  pushl $187
80105a6c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80105a71:	e9 aa f4 ff ff       	jmp    80104f20 <alltraps>

80105a76 <vector188>:
.globl vector188
vector188:
  pushl $0
80105a76:	6a 00                	push   $0x0
  pushl $188
80105a78:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80105a7d:	e9 9e f4 ff ff       	jmp    80104f20 <alltraps>

80105a82 <vector189>:
.globl vector189
vector189:
  pushl $0
80105a82:	6a 00                	push   $0x0
  pushl $189
80105a84:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80105a89:	e9 92 f4 ff ff       	jmp    80104f20 <alltraps>

80105a8e <vector190>:
.globl vector190
vector190:
  pushl $0
80105a8e:	6a 00                	push   $0x0
  pushl $190
80105a90:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80105a95:	e9 86 f4 ff ff       	jmp    80104f20 <alltraps>

80105a9a <vector191>:
.globl vector191
vector191:
  pushl $0
80105a9a:	6a 00                	push   $0x0
  pushl $191
80105a9c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80105aa1:	e9 7a f4 ff ff       	jmp    80104f20 <alltraps>

80105aa6 <vector192>:
.globl vector192
vector192:
  pushl $0
80105aa6:	6a 00                	push   $0x0
  pushl $192
80105aa8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80105aad:	e9 6e f4 ff ff       	jmp    80104f20 <alltraps>

80105ab2 <vector193>:
.globl vector193
vector193:
  pushl $0
80105ab2:	6a 00                	push   $0x0
  pushl $193
80105ab4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80105ab9:	e9 62 f4 ff ff       	jmp    80104f20 <alltraps>

80105abe <vector194>:
.globl vector194
vector194:
  pushl $0
80105abe:	6a 00                	push   $0x0
  pushl $194
80105ac0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80105ac5:	e9 56 f4 ff ff       	jmp    80104f20 <alltraps>

80105aca <vector195>:
.globl vector195
vector195:
  pushl $0
80105aca:	6a 00                	push   $0x0
  pushl $195
80105acc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80105ad1:	e9 4a f4 ff ff       	jmp    80104f20 <alltraps>

80105ad6 <vector196>:
.globl vector196
vector196:
  pushl $0
80105ad6:	6a 00                	push   $0x0
  pushl $196
80105ad8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105add:	e9 3e f4 ff ff       	jmp    80104f20 <alltraps>

80105ae2 <vector197>:
.globl vector197
vector197:
  pushl $0
80105ae2:	6a 00                	push   $0x0
  pushl $197
80105ae4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80105ae9:	e9 32 f4 ff ff       	jmp    80104f20 <alltraps>

80105aee <vector198>:
.globl vector198
vector198:
  pushl $0
80105aee:	6a 00                	push   $0x0
  pushl $198
80105af0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80105af5:	e9 26 f4 ff ff       	jmp    80104f20 <alltraps>

80105afa <vector199>:
.globl vector199
vector199:
  pushl $0
80105afa:	6a 00                	push   $0x0
  pushl $199
80105afc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80105b01:	e9 1a f4 ff ff       	jmp    80104f20 <alltraps>

80105b06 <vector200>:
.globl vector200
vector200:
  pushl $0
80105b06:	6a 00                	push   $0x0
  pushl $200
80105b08:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80105b0d:	e9 0e f4 ff ff       	jmp    80104f20 <alltraps>

80105b12 <vector201>:
.globl vector201
vector201:
  pushl $0
80105b12:	6a 00                	push   $0x0
  pushl $201
80105b14:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80105b19:	e9 02 f4 ff ff       	jmp    80104f20 <alltraps>

80105b1e <vector202>:
.globl vector202
vector202:
  pushl $0
80105b1e:	6a 00                	push   $0x0
  pushl $202
80105b20:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80105b25:	e9 f6 f3 ff ff       	jmp    80104f20 <alltraps>

80105b2a <vector203>:
.globl vector203
vector203:
  pushl $0
80105b2a:	6a 00                	push   $0x0
  pushl $203
80105b2c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80105b31:	e9 ea f3 ff ff       	jmp    80104f20 <alltraps>

80105b36 <vector204>:
.globl vector204
vector204:
  pushl $0
80105b36:	6a 00                	push   $0x0
  pushl $204
80105b38:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80105b3d:	e9 de f3 ff ff       	jmp    80104f20 <alltraps>

80105b42 <vector205>:
.globl vector205
vector205:
  pushl $0
80105b42:	6a 00                	push   $0x0
  pushl $205
80105b44:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80105b49:	e9 d2 f3 ff ff       	jmp    80104f20 <alltraps>

80105b4e <vector206>:
.globl vector206
vector206:
  pushl $0
80105b4e:	6a 00                	push   $0x0
  pushl $206
80105b50:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80105b55:	e9 c6 f3 ff ff       	jmp    80104f20 <alltraps>

80105b5a <vector207>:
.globl vector207
vector207:
  pushl $0
80105b5a:	6a 00                	push   $0x0
  pushl $207
80105b5c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80105b61:	e9 ba f3 ff ff       	jmp    80104f20 <alltraps>

80105b66 <vector208>:
.globl vector208
vector208:
  pushl $0
80105b66:	6a 00                	push   $0x0
  pushl $208
80105b68:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80105b6d:	e9 ae f3 ff ff       	jmp    80104f20 <alltraps>

80105b72 <vector209>:
.globl vector209
vector209:
  pushl $0
80105b72:	6a 00                	push   $0x0
  pushl $209
80105b74:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80105b79:	e9 a2 f3 ff ff       	jmp    80104f20 <alltraps>

80105b7e <vector210>:
.globl vector210
vector210:
  pushl $0
80105b7e:	6a 00                	push   $0x0
  pushl $210
80105b80:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80105b85:	e9 96 f3 ff ff       	jmp    80104f20 <alltraps>

80105b8a <vector211>:
.globl vector211
vector211:
  pushl $0
80105b8a:	6a 00                	push   $0x0
  pushl $211
80105b8c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80105b91:	e9 8a f3 ff ff       	jmp    80104f20 <alltraps>

80105b96 <vector212>:
.globl vector212
vector212:
  pushl $0
80105b96:	6a 00                	push   $0x0
  pushl $212
80105b98:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80105b9d:	e9 7e f3 ff ff       	jmp    80104f20 <alltraps>

80105ba2 <vector213>:
.globl vector213
vector213:
  pushl $0
80105ba2:	6a 00                	push   $0x0
  pushl $213
80105ba4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80105ba9:	e9 72 f3 ff ff       	jmp    80104f20 <alltraps>

80105bae <vector214>:
.globl vector214
vector214:
  pushl $0
80105bae:	6a 00                	push   $0x0
  pushl $214
80105bb0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80105bb5:	e9 66 f3 ff ff       	jmp    80104f20 <alltraps>

80105bba <vector215>:
.globl vector215
vector215:
  pushl $0
80105bba:	6a 00                	push   $0x0
  pushl $215
80105bbc:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105bc1:	e9 5a f3 ff ff       	jmp    80104f20 <alltraps>

80105bc6 <vector216>:
.globl vector216
vector216:
  pushl $0
80105bc6:	6a 00                	push   $0x0
  pushl $216
80105bc8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105bcd:	e9 4e f3 ff ff       	jmp    80104f20 <alltraps>

80105bd2 <vector217>:
.globl vector217
vector217:
  pushl $0
80105bd2:	6a 00                	push   $0x0
  pushl $217
80105bd4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105bd9:	e9 42 f3 ff ff       	jmp    80104f20 <alltraps>

80105bde <vector218>:
.globl vector218
vector218:
  pushl $0
80105bde:	6a 00                	push   $0x0
  pushl $218
80105be0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80105be5:	e9 36 f3 ff ff       	jmp    80104f20 <alltraps>

80105bea <vector219>:
.globl vector219
vector219:
  pushl $0
80105bea:	6a 00                	push   $0x0
  pushl $219
80105bec:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105bf1:	e9 2a f3 ff ff       	jmp    80104f20 <alltraps>

80105bf6 <vector220>:
.globl vector220
vector220:
  pushl $0
80105bf6:	6a 00                	push   $0x0
  pushl $220
80105bf8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105bfd:	e9 1e f3 ff ff       	jmp    80104f20 <alltraps>

80105c02 <vector221>:
.globl vector221
vector221:
  pushl $0
80105c02:	6a 00                	push   $0x0
  pushl $221
80105c04:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105c09:	e9 12 f3 ff ff       	jmp    80104f20 <alltraps>

80105c0e <vector222>:
.globl vector222
vector222:
  pushl $0
80105c0e:	6a 00                	push   $0x0
  pushl $222
80105c10:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80105c15:	e9 06 f3 ff ff       	jmp    80104f20 <alltraps>

80105c1a <vector223>:
.globl vector223
vector223:
  pushl $0
80105c1a:	6a 00                	push   $0x0
  pushl $223
80105c1c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80105c21:	e9 fa f2 ff ff       	jmp    80104f20 <alltraps>

80105c26 <vector224>:
.globl vector224
vector224:
  pushl $0
80105c26:	6a 00                	push   $0x0
  pushl $224
80105c28:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80105c2d:	e9 ee f2 ff ff       	jmp    80104f20 <alltraps>

80105c32 <vector225>:
.globl vector225
vector225:
  pushl $0
80105c32:	6a 00                	push   $0x0
  pushl $225
80105c34:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80105c39:	e9 e2 f2 ff ff       	jmp    80104f20 <alltraps>

80105c3e <vector226>:
.globl vector226
vector226:
  pushl $0
80105c3e:	6a 00                	push   $0x0
  pushl $226
80105c40:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80105c45:	e9 d6 f2 ff ff       	jmp    80104f20 <alltraps>

80105c4a <vector227>:
.globl vector227
vector227:
  pushl $0
80105c4a:	6a 00                	push   $0x0
  pushl $227
80105c4c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80105c51:	e9 ca f2 ff ff       	jmp    80104f20 <alltraps>

80105c56 <vector228>:
.globl vector228
vector228:
  pushl $0
80105c56:	6a 00                	push   $0x0
  pushl $228
80105c58:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80105c5d:	e9 be f2 ff ff       	jmp    80104f20 <alltraps>

80105c62 <vector229>:
.globl vector229
vector229:
  pushl $0
80105c62:	6a 00                	push   $0x0
  pushl $229
80105c64:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80105c69:	e9 b2 f2 ff ff       	jmp    80104f20 <alltraps>

80105c6e <vector230>:
.globl vector230
vector230:
  pushl $0
80105c6e:	6a 00                	push   $0x0
  pushl $230
80105c70:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80105c75:	e9 a6 f2 ff ff       	jmp    80104f20 <alltraps>

80105c7a <vector231>:
.globl vector231
vector231:
  pushl $0
80105c7a:	6a 00                	push   $0x0
  pushl $231
80105c7c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105c81:	e9 9a f2 ff ff       	jmp    80104f20 <alltraps>

80105c86 <vector232>:
.globl vector232
vector232:
  pushl $0
80105c86:	6a 00                	push   $0x0
  pushl $232
80105c88:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105c8d:	e9 8e f2 ff ff       	jmp    80104f20 <alltraps>

80105c92 <vector233>:
.globl vector233
vector233:
  pushl $0
80105c92:	6a 00                	push   $0x0
  pushl $233
80105c94:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105c99:	e9 82 f2 ff ff       	jmp    80104f20 <alltraps>

80105c9e <vector234>:
.globl vector234
vector234:
  pushl $0
80105c9e:	6a 00                	push   $0x0
  pushl $234
80105ca0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105ca5:	e9 76 f2 ff ff       	jmp    80104f20 <alltraps>

80105caa <vector235>:
.globl vector235
vector235:
  pushl $0
80105caa:	6a 00                	push   $0x0
  pushl $235
80105cac:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105cb1:	e9 6a f2 ff ff       	jmp    80104f20 <alltraps>

80105cb6 <vector236>:
.globl vector236
vector236:
  pushl $0
80105cb6:	6a 00                	push   $0x0
  pushl $236
80105cb8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105cbd:	e9 5e f2 ff ff       	jmp    80104f20 <alltraps>

80105cc2 <vector237>:
.globl vector237
vector237:
  pushl $0
80105cc2:	6a 00                	push   $0x0
  pushl $237
80105cc4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105cc9:	e9 52 f2 ff ff       	jmp    80104f20 <alltraps>

80105cce <vector238>:
.globl vector238
vector238:
  pushl $0
80105cce:	6a 00                	push   $0x0
  pushl $238
80105cd0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105cd5:	e9 46 f2 ff ff       	jmp    80104f20 <alltraps>

80105cda <vector239>:
.globl vector239
vector239:
  pushl $0
80105cda:	6a 00                	push   $0x0
  pushl $239
80105cdc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105ce1:	e9 3a f2 ff ff       	jmp    80104f20 <alltraps>

80105ce6 <vector240>:
.globl vector240
vector240:
  pushl $0
80105ce6:	6a 00                	push   $0x0
  pushl $240
80105ce8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105ced:	e9 2e f2 ff ff       	jmp    80104f20 <alltraps>

80105cf2 <vector241>:
.globl vector241
vector241:
  pushl $0
80105cf2:	6a 00                	push   $0x0
  pushl $241
80105cf4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105cf9:	e9 22 f2 ff ff       	jmp    80104f20 <alltraps>

80105cfe <vector242>:
.globl vector242
vector242:
  pushl $0
80105cfe:	6a 00                	push   $0x0
  pushl $242
80105d00:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105d05:	e9 16 f2 ff ff       	jmp    80104f20 <alltraps>

80105d0a <vector243>:
.globl vector243
vector243:
  pushl $0
80105d0a:	6a 00                	push   $0x0
  pushl $243
80105d0c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105d11:	e9 0a f2 ff ff       	jmp    80104f20 <alltraps>

80105d16 <vector244>:
.globl vector244
vector244:
  pushl $0
80105d16:	6a 00                	push   $0x0
  pushl $244
80105d18:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105d1d:	e9 fe f1 ff ff       	jmp    80104f20 <alltraps>

80105d22 <vector245>:
.globl vector245
vector245:
  pushl $0
80105d22:	6a 00                	push   $0x0
  pushl $245
80105d24:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105d29:	e9 f2 f1 ff ff       	jmp    80104f20 <alltraps>

80105d2e <vector246>:
.globl vector246
vector246:
  pushl $0
80105d2e:	6a 00                	push   $0x0
  pushl $246
80105d30:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105d35:	e9 e6 f1 ff ff       	jmp    80104f20 <alltraps>

80105d3a <vector247>:
.globl vector247
vector247:
  pushl $0
80105d3a:	6a 00                	push   $0x0
  pushl $247
80105d3c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105d41:	e9 da f1 ff ff       	jmp    80104f20 <alltraps>

80105d46 <vector248>:
.globl vector248
vector248:
  pushl $0
80105d46:	6a 00                	push   $0x0
  pushl $248
80105d48:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105d4d:	e9 ce f1 ff ff       	jmp    80104f20 <alltraps>

80105d52 <vector249>:
.globl vector249
vector249:
  pushl $0
80105d52:	6a 00                	push   $0x0
  pushl $249
80105d54:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105d59:	e9 c2 f1 ff ff       	jmp    80104f20 <alltraps>

80105d5e <vector250>:
.globl vector250
vector250:
  pushl $0
80105d5e:	6a 00                	push   $0x0
  pushl $250
80105d60:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105d65:	e9 b6 f1 ff ff       	jmp    80104f20 <alltraps>

80105d6a <vector251>:
.globl vector251
vector251:
  pushl $0
80105d6a:	6a 00                	push   $0x0
  pushl $251
80105d6c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105d71:	e9 aa f1 ff ff       	jmp    80104f20 <alltraps>

80105d76 <vector252>:
.globl vector252
vector252:
  pushl $0
80105d76:	6a 00                	push   $0x0
  pushl $252
80105d78:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105d7d:	e9 9e f1 ff ff       	jmp    80104f20 <alltraps>

80105d82 <vector253>:
.globl vector253
vector253:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $253
80105d84:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105d89:	e9 92 f1 ff ff       	jmp    80104f20 <alltraps>

80105d8e <vector254>:
.globl vector254
vector254:
  pushl $0
80105d8e:	6a 00                	push   $0x0
  pushl $254
80105d90:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105d95:	e9 86 f1 ff ff       	jmp    80104f20 <alltraps>

80105d9a <vector255>:
.globl vector255
vector255:
  pushl $0
80105d9a:	6a 00                	push   $0x0
  pushl $255
80105d9c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105da1:	e9 7a f1 ff ff       	jmp    80104f20 <alltraps>
80105da6:	66 90                	xchg   %ax,%ax

80105da8 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80105da8:	55                   	push   %ebp
80105da9:	89 e5                	mov    %esp,%ebp
80105dab:	57                   	push   %edi
80105dac:	56                   	push   %esi
80105dad:	53                   	push   %ebx
80105dae:	83 ec 1c             	sub    $0x1c,%esp
80105db1:	89 d7                	mov    %edx,%edi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80105db3:	89 d3                	mov    %edx,%ebx
80105db5:	c1 eb 16             	shr    $0x16,%ebx
80105db8:	8d 34 98             	lea    (%eax,%ebx,4),%esi
  if(*pde & PTE_P){
80105dbb:	8b 1e                	mov    (%esi),%ebx
80105dbd:	f6 c3 01             	test   $0x1,%bl
80105dc0:	74 22                	je     80105de4 <walkpgdir+0x3c>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105dc2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80105dc8:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80105dce:	c1 ef 0a             	shr    $0xa,%edi
80105dd1:	89 fa                	mov    %edi,%edx
80105dd3:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80105dd9:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80105ddc:	83 c4 1c             	add    $0x1c,%esp
80105ddf:	5b                   	pop    %ebx
80105de0:	5e                   	pop    %esi
80105de1:	5f                   	pop    %edi
80105de2:	5d                   	pop    %ebp
80105de3:	c3                   	ret    

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80105de4:	85 c9                	test   %ecx,%ecx
80105de6:	74 30                	je     80105e18 <walkpgdir+0x70>
80105de8:	e8 8f c5 ff ff       	call   8010237c <kalloc>
80105ded:	89 c3                	mov    %eax,%ebx
80105def:	85 c0                	test   %eax,%eax
80105df1:	74 25                	je     80105e18 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80105df3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80105dfa:	00 
80105dfb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105e02:	00 
80105e03:	89 04 24             	mov    %eax,(%esp)
80105e06:	e8 39 e1 ff ff       	call   80103f44 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80105e0b:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80105e11:	83 c8 07             	or     $0x7,%eax
80105e14:	89 06                	mov    %eax,(%esi)
80105e16:	eb b6                	jmp    80105dce <walkpgdir+0x26>
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80105e18:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80105e1a:	83 c4 1c             	add    $0x1c,%esp
80105e1d:	5b                   	pop    %ebx
80105e1e:	5e                   	pop    %esi
80105e1f:	5f                   	pop    %edi
80105e20:	5d                   	pop    %ebp
80105e21:	c3                   	ret    
80105e22:	66 90                	xchg   %ax,%ax

80105e24 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80105e24:	55                   	push   %ebp
80105e25:	89 e5                	mov    %esp,%ebp
80105e27:	57                   	push   %edi
80105e28:	56                   	push   %esi
80105e29:	53                   	push   %ebx
80105e2a:	83 ec 1c             	sub    $0x1c,%esp
80105e2d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105e30:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80105e33:	89 d3                	mov    %edx,%ebx
80105e35:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80105e3b:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80105e3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105e42:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
80105e49:	29 df                	sub    %ebx,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80105e4b:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
80105e4f:	eb 18                	jmp    80105e69 <mappages+0x45>
80105e51:	8d 76 00             	lea    0x0(%esi),%esi
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80105e54:	f6 00 01             	testb  $0x1,(%eax)
80105e57:	75 3d                	jne    80105e96 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80105e59:	0b 75 0c             	or     0xc(%ebp),%esi
80105e5c:	89 30                	mov    %esi,(%eax)
    if(a == last)
80105e5e:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80105e61:	74 29                	je     80105e8c <mappages+0x68>
      break;
    a += PGSIZE;
80105e63:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105e69:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105e6c:	b9 01 00 00 00       	mov    $0x1,%ecx
80105e71:	89 da                	mov    %ebx,%edx
80105e73:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e76:	e8 2d ff ff ff       	call   80105da8 <walkpgdir>
80105e7b:	85 c0                	test   %eax,%eax
80105e7d:	75 d5                	jne    80105e54 <mappages+0x30>
      return -1;
80105e7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80105e84:	83 c4 1c             	add    $0x1c,%esp
80105e87:	5b                   	pop    %ebx
80105e88:	5e                   	pop    %esi
80105e89:	5f                   	pop    %edi
80105e8a:	5d                   	pop    %ebp
80105e8b:	c3                   	ret    
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80105e8c:	31 c0                	xor    %eax,%eax
}
80105e8e:	83 c4 1c             	add    $0x1c,%esp
80105e91:	5b                   	pop    %ebx
80105e92:	5e                   	pop    %esi
80105e93:	5f                   	pop    %edi
80105e94:	5d                   	pop    %ebp
80105e95:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80105e96:	c7 04 24 08 6f 10 80 	movl   $0x80106f08,(%esp)
80105e9d:	e8 72 a4 ff ff       	call   80100314 <panic>
80105ea2:	66 90                	xchg   %ax,%ax

80105ea4 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80105ea4:	55                   	push   %ebp
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	57                   	push   %edi
80105ea8:	56                   	push   %esi
80105ea9:	53                   	push   %ebx
80105eaa:	83 ec 1c             	sub    $0x1c,%esp
80105ead:	89 c7                	mov    %eax,%edi
80105eaf:	89 d6                	mov    %edx,%esi
80105eb1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80105eb4:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80105eba:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105ec0:	39 d3                	cmp    %edx,%ebx
80105ec2:	72 37                	jb     80105efb <deallocuvm.part.0+0x57>
80105ec4:	eb 5a                	jmp    80105f20 <deallocuvm.part.0+0x7c>
80105ec6:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80105ec8:	8b 10                	mov    (%eax),%edx
80105eca:	f6 c2 01             	test   $0x1,%dl
80105ecd:	74 22                	je     80105ef1 <deallocuvm.part.0+0x4d>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80105ecf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80105ed5:	74 54                	je     80105f2b <deallocuvm.part.0+0x87>
80105ed7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        panic("kfree");
      char *v = P2V(pa);
80105eda:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80105ee0:	89 14 24             	mov    %edx,(%esp)
80105ee3:	e8 5c c2 ff ff       	call   80102144 <kfree>
      *pte = 0;
80105ee8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105eeb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80105ef1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105ef7:	39 f3                	cmp    %esi,%ebx
80105ef9:	73 25                	jae    80105f20 <deallocuvm.part.0+0x7c>
    pte = walkpgdir(pgdir, (char*)a, 0);
80105efb:	31 c9                	xor    %ecx,%ecx
80105efd:	89 da                	mov    %ebx,%edx
80105eff:	89 f8                	mov    %edi,%eax
80105f01:	e8 a2 fe ff ff       	call   80105da8 <walkpgdir>
    if(!pte)
80105f06:	85 c0                	test   %eax,%eax
80105f08:	75 be                	jne    80105ec8 <deallocuvm.part.0+0x24>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80105f0a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80105f10:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80105f16:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105f1c:	39 f3                	cmp    %esi,%ebx
80105f1e:	72 db                	jb     80105efb <deallocuvm.part.0+0x57>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80105f20:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105f23:	83 c4 1c             	add    $0x1c,%esp
80105f26:	5b                   	pop    %ebx
80105f27:	5e                   	pop    %esi
80105f28:	5f                   	pop    %edi
80105f29:	5d                   	pop    %ebp
80105f2a:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80105f2b:	c7 04 24 a6 68 10 80 	movl   $0x801068a6,(%esp)
80105f32:	e8 dd a3 ff ff       	call   80100314 <panic>
80105f37:	90                   	nop

80105f38 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80105f38:	55                   	push   %ebp
80105f39:	89 e5                	mov    %esp,%ebp
80105f3b:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80105f3e:	e8 f5 d4 ff ff       	call   80103438 <cpuid>
80105f43:	8d 14 80             	lea    (%eax,%eax,4),%edx
80105f46:	01 d2                	add    %edx,%edx
80105f48:	01 d0                	add    %edx,%eax
80105f4a:	c1 e0 04             	shl    $0x4,%eax
80105f4d:	05 a0 29 11 80       	add    $0x801129a0,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80105f52:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80105f58:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80105f5e:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80105f62:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
80105f66:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
80105f6a:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80105f6e:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80105f75:	ff ff 
80105f77:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80105f7e:	00 00 
80105f80:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80105f87:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
80105f8e:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
80105f95:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80105f9c:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80105fa3:	ff ff 
80105fa5:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
80105fac:	00 00 
80105fae:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
80105fb5:	c6 80 8d 00 00 00 fa 	movb   $0xfa,0x8d(%eax)
80105fbc:	c6 80 8e 00 00 00 cf 	movb   $0xcf,0x8e(%eax)
80105fc3:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80105fca:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80105fd1:	ff ff 
80105fd3:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80105fda:	00 00 
80105fdc:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80105fe3:	c6 80 95 00 00 00 f2 	movb   $0xf2,0x95(%eax)
80105fea:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
80105ff1:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80105ff8:	83 c0 70             	add    $0x70,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105ffb:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
80106001:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106005:	c1 e8 10             	shr    $0x10,%eax
80106008:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010600c:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010600f:	0f 01 10             	lgdtl  (%eax)
}
80106012:	c9                   	leave  
80106013:	c3                   	ret    

80106014 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106014:	55                   	push   %ebp
80106015:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106017:	a1 e4 56 11 80       	mov    0x801156e4,%eax
8010601c:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106021:	0f 22 d8             	mov    %eax,%cr3
}
80106024:	5d                   	pop    %ebp
80106025:	c3                   	ret    
80106026:	66 90                	xchg   %ax,%ax

80106028 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106028:	55                   	push   %ebp
80106029:	89 e5                	mov    %esp,%ebp
8010602b:	57                   	push   %edi
8010602c:	56                   	push   %esi
8010602d:	53                   	push   %ebx
8010602e:	83 ec 1c             	sub    $0x1c,%esp
80106031:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106034:	85 f6                	test   %esi,%esi
80106036:	0f 84 c4 00 00 00    	je     80106100 <switchuvm+0xd8>
    panic("switchuvm: no process");
  if(p->kstack == 0)
8010603c:	8b 56 08             	mov    0x8(%esi),%edx
8010603f:	85 d2                	test   %edx,%edx
80106041:	0f 84 d1 00 00 00    	je     80106118 <switchuvm+0xf0>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106047:	8b 46 04             	mov    0x4(%esi),%eax
8010604a:	85 c0                	test   %eax,%eax
8010604c:	0f 84 ba 00 00 00    	je     8010610c <switchuvm+0xe4>
    panic("switchuvm: no pgdir");

  pushcli();
80106052:	e8 8d dd ff ff       	call   80103de4 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106057:	e8 64 d3 ff ff       	call   801033c0 <mycpu>
8010605c:	89 c3                	mov    %eax,%ebx
8010605e:	e8 5d d3 ff ff       	call   801033c0 <mycpu>
80106063:	89 c7                	mov    %eax,%edi
80106065:	e8 56 d3 ff ff       	call   801033c0 <mycpu>
8010606a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010606d:	e8 4e d3 ff ff       	call   801033c0 <mycpu>
80106072:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80106079:	67 00 
8010607b:	83 c7 08             	add    $0x8,%edi
8010607e:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106085:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106088:	83 c1 08             	add    $0x8,%ecx
8010608b:	c1 e9 10             	shr    $0x10,%ecx
8010608e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106094:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010609b:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
801060a2:	83 c0 08             	add    $0x8,%eax
801060a5:	c1 e8 18             	shr    $0x18,%eax
801060a8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
801060ae:	e8 0d d3 ff ff       	call   801033c0 <mycpu>
801060b3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801060ba:	e8 01 d3 ff ff       	call   801033c0 <mycpu>
801060bf:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801060c5:	e8 f6 d2 ff ff       	call   801033c0 <mycpu>
801060ca:	8b 56 08             	mov    0x8(%esi),%edx
801060cd:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801060d3:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801060d6:	e8 e5 d2 ff ff       	call   801033c0 <mycpu>
801060db:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801060e1:	b8 28 00 00 00       	mov    $0x28,%eax
801060e6:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801060e9:	8b 46 04             	mov    0x4(%esi),%eax
801060ec:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801060f1:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801060f4:	83 c4 1c             	add    $0x1c,%esp
801060f7:	5b                   	pop    %ebx
801060f8:	5e                   	pop    %esi
801060f9:	5f                   	pop    %edi
801060fa:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801060fb:	e9 90 dd ff ff       	jmp    80103e90 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106100:	c7 04 24 0e 6f 10 80 	movl   $0x80106f0e,(%esp)
80106107:	e8 08 a2 ff ff       	call   80100314 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
8010610c:	c7 04 24 39 6f 10 80 	movl   $0x80106f39,(%esp)
80106113:	e8 fc a1 ff ff       	call   80100314 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106118:	c7 04 24 24 6f 10 80 	movl   $0x80106f24,(%esp)
8010611f:	e8 f0 a1 ff ff       	call   80100314 <panic>

80106124 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106124:	55                   	push   %ebp
80106125:	89 e5                	mov    %esp,%ebp
80106127:	57                   	push   %edi
80106128:	56                   	push   %esi
80106129:	53                   	push   %ebx
8010612a:	83 ec 1c             	sub    $0x1c,%esp
8010612d:	8b 45 08             	mov    0x8(%ebp),%eax
80106130:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106133:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106136:	8b 75 10             	mov    0x10(%ebp),%esi
  char *mem;

  if(sz >= PGSIZE)
80106139:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010613f:	77 54                	ja     80106195 <inituvm+0x71>
    panic("inituvm: more than a page");
  mem = kalloc();
80106141:	e8 36 c2 ff ff       	call   8010237c <kalloc>
80106146:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106148:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010614f:	00 
80106150:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106157:	00 
80106158:	89 04 24             	mov    %eax,(%esp)
8010615b:	e8 e4 dd ff ff       	call   80103f44 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106160:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106167:	00 
80106168:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010616e:	89 04 24             	mov    %eax,(%esp)
80106171:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106176:	31 d2                	xor    %edx,%edx
80106178:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010617b:	e8 a4 fc ff ff       	call   80105e24 <mappages>
  memmove(mem, init, sz);
80106180:	89 75 10             	mov    %esi,0x10(%ebp)
80106183:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106186:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106189:	83 c4 1c             	add    $0x1c,%esp
8010618c:	5b                   	pop    %ebx
8010618d:	5e                   	pop    %esi
8010618e:	5f                   	pop    %edi
8010618f:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106190:	e9 43 de ff ff       	jmp    80103fd8 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106195:	c7 04 24 4d 6f 10 80 	movl   $0x80106f4d,(%esp)
8010619c:	e8 73 a1 ff ff       	call   80100314 <panic>
801061a1:	8d 76 00             	lea    0x0(%esi),%esi

801061a4 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801061a4:	55                   	push   %ebp
801061a5:	89 e5                	mov    %esp,%ebp
801061a7:	57                   	push   %edi
801061a8:	56                   	push   %esi
801061a9:	53                   	push   %ebx
801061aa:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801061ad:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801061b4:	0f 85 97 00 00 00    	jne    80106251 <loaduvm+0xad>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801061ba:	8b 4d 18             	mov    0x18(%ebp),%ecx
801061bd:	85 c9                	test   %ecx,%ecx
801061bf:	74 6b                	je     8010622c <loaduvm+0x88>
801061c1:	8b 75 18             	mov    0x18(%ebp),%esi
801061c4:	31 db                	xor    %ebx,%ebx
801061c6:	eb 3b                	jmp    80106203 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
801061c8:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801061cd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801061d1:	8b 4d 14             	mov    0x14(%ebp),%ecx
801061d4:	01 d9                	add    %ebx,%ecx
801061d6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801061da:	05 00 00 00 80       	add    $0x80000000,%eax
801061df:	89 44 24 04          	mov    %eax,0x4(%esp)
801061e3:	8b 45 10             	mov    0x10(%ebp),%eax
801061e6:	89 04 24             	mov    %eax,(%esp)
801061e9:	e8 da b5 ff ff       	call   801017c8 <readi>
801061ee:	39 f8                	cmp    %edi,%eax
801061f0:	75 46                	jne    80106238 <loaduvm+0x94>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801061f2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801061f8:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801061fe:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106201:	76 29                	jbe    8010622c <loaduvm+0x88>
80106203:	8b 55 0c             	mov    0xc(%ebp),%edx
80106206:	01 da                	add    %ebx,%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106208:	31 c9                	xor    %ecx,%ecx
8010620a:	8b 45 08             	mov    0x8(%ebp),%eax
8010620d:	e8 96 fb ff ff       	call   80105da8 <walkpgdir>
80106212:	85 c0                	test   %eax,%eax
80106214:	74 2f                	je     80106245 <loaduvm+0xa1>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106216:	8b 00                	mov    (%eax),%eax
80106218:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010621d:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106223:	77 a3                	ja     801061c8 <loaduvm+0x24>
80106225:	89 f7                	mov    %esi,%edi
80106227:	eb a4                	jmp    801061cd <loaduvm+0x29>
80106229:	8d 76 00             	lea    0x0(%esi),%esi
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010622c:	31 c0                	xor    %eax,%eax
}
8010622e:	83 c4 1c             	add    $0x1c,%esp
80106231:	5b                   	pop    %ebx
80106232:	5e                   	pop    %esi
80106233:	5f                   	pop    %edi
80106234:	5d                   	pop    %ebp
80106235:	c3                   	ret    
80106236:	66 90                	xchg   %ax,%ax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010623d:	83 c4 1c             	add    $0x1c,%esp
80106240:	5b                   	pop    %ebx
80106241:	5e                   	pop    %esi
80106242:	5f                   	pop    %edi
80106243:	5d                   	pop    %ebp
80106244:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106245:	c7 04 24 67 6f 10 80 	movl   $0x80106f67,(%esp)
8010624c:	e8 c3 a0 ff ff       	call   80100314 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106251:	c7 04 24 08 70 10 80 	movl   $0x80107008,(%esp)
80106258:	e8 b7 a0 ff ff       	call   80100314 <panic>
8010625d:	8d 76 00             	lea    0x0(%esi),%esi

80106260 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	57                   	push   %edi
80106264:	56                   	push   %esi
80106265:	53                   	push   %ebx
80106266:	83 ec 1c             	sub    $0x1c,%esp
80106269:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010626c:	85 ff                	test   %edi,%edi
8010626e:	78 7e                	js     801062ee <allocuvm+0x8e>
    return 0;
  if(newsz < oldsz)
    return oldsz;
80106270:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106273:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106276:	72 78                	jb     801062f0 <allocuvm+0x90>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106278:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010627e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106284:	39 df                	cmp    %ebx,%edi
80106286:	77 4a                	ja     801062d2 <allocuvm+0x72>
80106288:	eb 6e                	jmp    801062f8 <allocuvm+0x98>
8010628a:	66 90                	xchg   %ax,%ax
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
8010628c:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106293:	00 
80106294:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010629b:	00 
8010629c:	89 04 24             	mov    %eax,(%esp)
8010629f:	e8 a0 dc ff ff       	call   80103f44 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801062a4:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801062ab:	00 
801062ac:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801062b2:	89 04 24             	mov    %eax,(%esp)
801062b5:	b9 00 10 00 00       	mov    $0x1000,%ecx
801062ba:	89 da                	mov    %ebx,%edx
801062bc:	8b 45 08             	mov    0x8(%ebp),%eax
801062bf:	e8 60 fb ff ff       	call   80105e24 <mappages>
801062c4:	85 c0                	test   %eax,%eax
801062c6:	78 3c                	js     80106304 <allocuvm+0xa4>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801062c8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801062ce:	39 df                	cmp    %ebx,%edi
801062d0:	76 26                	jbe    801062f8 <allocuvm+0x98>
    mem = kalloc();
801062d2:	e8 a5 c0 ff ff       	call   8010237c <kalloc>
801062d7:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801062d9:	85 c0                	test   %eax,%eax
801062db:	75 af                	jne    8010628c <allocuvm+0x2c>
      cprintf("allocuvm out of memory\n");
801062dd:	c7 04 24 85 6f 10 80 	movl   $0x80106f85,(%esp)
801062e4:	e8 db a2 ff ff       	call   801005c4 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801062e9:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801062ec:	77 40                	ja     8010632e <allocuvm+0xce>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
801062ee:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
801062f0:	83 c4 1c             	add    $0x1c,%esp
801062f3:	5b                   	pop    %ebx
801062f4:	5e                   	pop    %esi
801062f5:	5f                   	pop    %edi
801062f6:	5d                   	pop    %ebp
801062f7:	c3                   	ret    
801062f8:	89 f8                	mov    %edi,%eax
801062fa:	83 c4 1c             	add    $0x1c,%esp
801062fd:	5b                   	pop    %ebx
801062fe:	5e                   	pop    %esi
801062ff:	5f                   	pop    %edi
80106300:	5d                   	pop    %ebp
80106301:	c3                   	ret    
80106302:	66 90                	xchg   %ax,%ax
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106304:	c7 04 24 9d 6f 10 80 	movl   $0x80106f9d,(%esp)
8010630b:	e8 b4 a2 ff ff       	call   801005c4 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106310:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106313:	76 0d                	jbe    80106322 <allocuvm+0xc2>
80106315:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106318:	89 fa                	mov    %edi,%edx
8010631a:	8b 45 08             	mov    0x8(%ebp),%eax
8010631d:	e8 82 fb ff ff       	call   80105ea4 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106322:	89 34 24             	mov    %esi,(%esp)
80106325:	e8 1a be ff ff       	call   80102144 <kfree>
      return 0;
8010632a:	31 c0                	xor    %eax,%eax
8010632c:	eb c2                	jmp    801062f0 <allocuvm+0x90>
8010632e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106331:	89 fa                	mov    %edi,%edx
80106333:	8b 45 08             	mov    0x8(%ebp),%eax
80106336:	e8 69 fb ff ff       	call   80105ea4 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
8010633b:	31 c0                	xor    %eax,%eax
8010633d:	eb b1                	jmp    801062f0 <allocuvm+0x90>
8010633f:	90                   	nop

80106340 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
80106343:	8b 45 08             	mov    0x8(%ebp),%eax
80106346:	8b 55 0c             	mov    0xc(%ebp),%edx
80106349:	8b 4d 10             	mov    0x10(%ebp),%ecx
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010634c:	39 d1                	cmp    %edx,%ecx
8010634e:	73 08                	jae    80106358 <deallocuvm+0x18>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106350:	5d                   	pop    %ebp
80106351:	e9 4e fb ff ff       	jmp    80105ea4 <deallocuvm.part.0>
80106356:	66 90                	xchg   %ax,%ax
80106358:	89 d0                	mov    %edx,%eax
8010635a:	5d                   	pop    %ebp
8010635b:	c3                   	ret    

8010635c <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010635c:	55                   	push   %ebp
8010635d:	89 e5                	mov    %esp,%ebp
8010635f:	56                   	push   %esi
80106360:	53                   	push   %ebx
80106361:	83 ec 10             	sub    $0x10,%esp
80106364:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106367:	85 f6                	test   %esi,%esi
80106369:	74 51                	je     801063bc <freevm+0x60>
8010636b:	31 c9                	xor    %ecx,%ecx
8010636d:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106372:	89 f0                	mov    %esi,%eax
80106374:	e8 2b fb ff ff       	call   80105ea4 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106379:	31 db                	xor    %ebx,%ebx
8010637b:	eb 0c                	jmp    80106389 <freevm+0x2d>
8010637d:	8d 76 00             	lea    0x0(%esi),%esi
80106380:	43                   	inc    %ebx
80106381:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106387:	74 25                	je     801063ae <freevm+0x52>
    if(pgdir[i] & PTE_P){
80106389:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
8010638c:	f6 c2 01             	test   $0x1,%dl
8010638f:	74 ef                	je     80106380 <freevm+0x24>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106391:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106397:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
8010639d:	89 14 24             	mov    %edx,(%esp)
801063a0:	e8 9f bd ff ff       	call   80102144 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801063a5:	43                   	inc    %ebx
801063a6:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
801063ac:	75 db                	jne    80106389 <freevm+0x2d>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801063ae:	89 75 08             	mov    %esi,0x8(%ebp)
}
801063b1:	83 c4 10             	add    $0x10,%esp
801063b4:	5b                   	pop    %ebx
801063b5:	5e                   	pop    %esi
801063b6:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801063b7:	e9 88 bd ff ff       	jmp    80102144 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801063bc:	c7 04 24 b9 6f 10 80 	movl   $0x80106fb9,(%esp)
801063c3:	e8 4c 9f ff ff       	call   80100314 <panic>

801063c8 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801063c8:	55                   	push   %ebp
801063c9:	89 e5                	mov    %esp,%ebp
801063cb:	56                   	push   %esi
801063cc:	53                   	push   %ebx
801063cd:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801063d0:	e8 a7 bf ff ff       	call   8010237c <kalloc>
801063d5:	89 c6                	mov    %eax,%esi
801063d7:	85 c0                	test   %eax,%eax
801063d9:	74 65                	je     80106440 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
801063db:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801063e2:	00 
801063e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801063ea:	00 
801063eb:	89 04 24             	mov    %eax,(%esp)
801063ee:	e8 51 db ff ff       	call   80103f44 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801063f3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801063f8:	8b 43 04             	mov    0x4(%ebx),%eax
801063fb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801063fe:	29 c1                	sub    %eax,%ecx
80106400:	8b 53 0c             	mov    0xc(%ebx),%edx
80106403:	89 54 24 04          	mov    %edx,0x4(%esp)
80106407:	89 04 24             	mov    %eax,(%esp)
8010640a:	8b 13                	mov    (%ebx),%edx
8010640c:	89 f0                	mov    %esi,%eax
8010640e:	e8 11 fa ff ff       	call   80105e24 <mappages>
80106413:	85 c0                	test   %eax,%eax
80106415:	78 15                	js     8010642c <setupkvm+0x64>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106417:	83 c3 10             	add    $0x10,%ebx
8010641a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106420:	72 d6                	jb     801063f8 <setupkvm+0x30>
80106422:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106424:	83 c4 10             	add    $0x10,%esp
80106427:	5b                   	pop    %ebx
80106428:	5e                   	pop    %esi
80106429:	5d                   	pop    %ebp
8010642a:	c3                   	ret    
8010642b:	90                   	nop
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
8010642c:	89 34 24             	mov    %esi,(%esp)
8010642f:	e8 28 ff ff ff       	call   8010635c <freevm>
      return 0;
80106434:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106436:	83 c4 10             	add    $0x10,%esp
80106439:	5b                   	pop    %ebx
8010643a:	5e                   	pop    %esi
8010643b:	5d                   	pop    %ebp
8010643c:	c3                   	ret    
8010643d:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106440:	31 c0                	xor    %eax,%eax
80106442:	eb e0                	jmp    80106424 <setupkvm+0x5c>

80106444 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106444:	55                   	push   %ebp
80106445:	89 e5                	mov    %esp,%ebp
80106447:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010644a:	e8 79 ff ff ff       	call   801063c8 <setupkvm>
8010644f:	a3 e4 56 11 80       	mov    %eax,0x801156e4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106454:	05 00 00 00 80       	add    $0x80000000,%eax
80106459:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
8010645c:	c9                   	leave  
8010645d:	c3                   	ret    
8010645e:	66 90                	xchg   %ax,%ax

80106460 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106466:	31 c9                	xor    %ecx,%ecx
80106468:	8b 55 0c             	mov    0xc(%ebp),%edx
8010646b:	8b 45 08             	mov    0x8(%ebp),%eax
8010646e:	e8 35 f9 ff ff       	call   80105da8 <walkpgdir>
  if(pte == 0)
80106473:	85 c0                	test   %eax,%eax
80106475:	74 05                	je     8010647c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106477:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010647a:	c9                   	leave  
8010647b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010647c:	c7 04 24 ca 6f 10 80 	movl   $0x80106fca,(%esp)
80106483:	e8 8c 9e ff ff       	call   80100314 <panic>

80106488 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106488:	55                   	push   %ebp
80106489:	89 e5                	mov    %esp,%ebp
8010648b:	57                   	push   %edi
8010648c:	56                   	push   %esi
8010648d:	53                   	push   %ebx
8010648e:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106491:	e8 32 ff ff ff       	call   801063c8 <setupkvm>
80106496:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106499:	85 c0                	test   %eax,%eax
8010649b:	0f 84 ae 00 00 00    	je     8010654f <copyuvm+0xc7>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801064a1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801064a4:	85 db                	test   %ebx,%ebx
801064a6:	0f 84 98 00 00 00    	je     80106544 <copyuvm+0xbc>
801064ac:	31 db                	xor    %ebx,%ebx
801064ae:	eb 48                	jmp    801064f8 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801064b0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801064b7:	00 
801064b8:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801064be:	89 7c 24 04          	mov    %edi,0x4(%esp)
801064c2:	89 04 24             	mov    %eax,(%esp)
801064c5:	e8 0e db ff ff       	call   80103fd8 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801064ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064cd:	89 44 24 04          	mov    %eax,0x4(%esp)
801064d1:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
801064d7:	89 14 24             	mov    %edx,(%esp)
801064da:	b9 00 10 00 00       	mov    $0x1000,%ecx
801064df:	89 da                	mov    %ebx,%edx
801064e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801064e4:	e8 3b f9 ff ff       	call   80105e24 <mappages>
801064e9:	85 c0                	test   %eax,%eax
801064eb:	78 41                	js     8010652e <copyuvm+0xa6>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801064ed:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801064f3:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801064f6:	76 4c                	jbe    80106544 <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801064f8:	31 c9                	xor    %ecx,%ecx
801064fa:	89 da                	mov    %ebx,%edx
801064fc:	8b 45 08             	mov    0x8(%ebp),%eax
801064ff:	e8 a4 f8 ff ff       	call   80105da8 <walkpgdir>
80106504:	85 c0                	test   %eax,%eax
80106506:	74 57                	je     8010655f <copyuvm+0xd7>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106508:	8b 30                	mov    (%eax),%esi
8010650a:	f7 c6 01 00 00 00    	test   $0x1,%esi
80106510:	74 41                	je     80106553 <copyuvm+0xcb>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106512:	89 f7                	mov    %esi,%edi
80106514:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
8010651a:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106520:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106523:	e8 54 be ff ff       	call   8010237c <kalloc>
80106528:	89 c6                	mov    %eax,%esi
8010652a:	85 c0                	test   %eax,%eax
8010652c:	75 82                	jne    801064b0 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
8010652e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106531:	89 04 24             	mov    %eax,(%esp)
80106534:	e8 23 fe ff ff       	call   8010635c <freevm>
  return 0;
80106539:	31 c0                	xor    %eax,%eax
}
8010653b:	83 c4 2c             	add    $0x2c,%esp
8010653e:	5b                   	pop    %ebx
8010653f:	5e                   	pop    %esi
80106540:	5f                   	pop    %edi
80106541:	5d                   	pop    %ebp
80106542:	c3                   	ret    
80106543:	90                   	nop
80106544:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106547:	83 c4 2c             	add    $0x2c,%esp
8010654a:	5b                   	pop    %ebx
8010654b:	5e                   	pop    %esi
8010654c:	5f                   	pop    %edi
8010654d:	5d                   	pop    %ebp
8010654e:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010654f:	31 c0                	xor    %eax,%eax
80106551:	eb e8                	jmp    8010653b <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106553:	c7 04 24 ee 6f 10 80 	movl   $0x80106fee,(%esp)
8010655a:	e8 b5 9d ff ff       	call   80100314 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010655f:	c7 04 24 d4 6f 10 80 	movl   $0x80106fd4,(%esp)
80106566:	e8 a9 9d ff ff       	call   80100314 <panic>
8010656b:	90                   	nop

8010656c <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010656c:	55                   	push   %ebp
8010656d:	89 e5                	mov    %esp,%ebp
8010656f:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106572:	31 c9                	xor    %ecx,%ecx
80106574:	8b 55 0c             	mov    0xc(%ebp),%edx
80106577:	8b 45 08             	mov    0x8(%ebp),%eax
8010657a:	e8 29 f8 ff ff       	call   80105da8 <walkpgdir>
  if((*pte & PTE_P) == 0)
8010657f:	8b 00                	mov    (%eax),%eax
80106581:	89 c2                	mov    %eax,%edx
80106583:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106586:	83 fa 05             	cmp    $0x5,%edx
80106589:	75 0d                	jne    80106598 <uva2ka+0x2c>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010658b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106590:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106595:	c9                   	leave  
80106596:	c3                   	ret    
80106597:	90                   	nop

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106598:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
8010659a:	c9                   	leave  
8010659b:	c3                   	ret    

8010659c <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
8010659c:	55                   	push   %ebp
8010659d:	89 e5                	mov    %esp,%ebp
8010659f:	57                   	push   %edi
801065a0:	56                   	push   %esi
801065a1:	53                   	push   %ebx
801065a2:	83 ec 1c             	sub    $0x1c,%esp
801065a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801065a8:	8b 7d 14             	mov    0x14(%ebp),%edi
801065ab:	85 ff                	test   %edi,%edi
801065ad:	74 69                	je     80106618 <copyout+0x7c>
801065af:	89 f7                	mov    %esi,%edi
801065b1:	eb 3a                	jmp    801065ed <copyout+0x51>
801065b3:	90                   	nop
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801065b4:	89 da                	mov    %ebx,%edx
801065b6:	29 fa                	sub    %edi,%edx
801065b8:	8d b2 00 10 00 00    	lea    0x1000(%edx),%esi
801065be:	3b 75 14             	cmp    0x14(%ebp),%esi
801065c1:	76 03                	jbe    801065c6 <copyout+0x2a>
801065c3:	8b 75 14             	mov    0x14(%ebp),%esi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801065c6:	89 74 24 08          	mov    %esi,0x8(%esp)
801065ca:	8b 55 10             	mov    0x10(%ebp),%edx
801065cd:	89 54 24 04          	mov    %edx,0x4(%esp)
801065d1:	89 f9                	mov    %edi,%ecx
801065d3:	29 d9                	sub    %ebx,%ecx
801065d5:	01 c8                	add    %ecx,%eax
801065d7:	89 04 24             	mov    %eax,(%esp)
801065da:	e8 f9 d9 ff ff       	call   80103fd8 <memmove>
    len -= n;
    buf += n;
801065df:	01 75 10             	add    %esi,0x10(%ebp)
    va = va0 + PGSIZE;
801065e2:	8d bb 00 10 00 00    	lea    0x1000(%ebx),%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801065e8:	29 75 14             	sub    %esi,0x14(%ebp)
801065eb:	74 2b                	je     80106618 <copyout+0x7c>
    va0 = (uint)PGROUNDDOWN(va);
801065ed:	89 fb                	mov    %edi,%ebx
801065ef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801065f5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801065f9:	8b 45 08             	mov    0x8(%ebp),%eax
801065fc:	89 04 24             	mov    %eax,(%esp)
801065ff:	e8 68 ff ff ff       	call   8010656c <uva2ka>
    if(pa0 == 0)
80106604:	85 c0                	test   %eax,%eax
80106606:	75 ac                	jne    801065b4 <copyout+0x18>
      return -1;
80106608:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010660d:	83 c4 1c             	add    $0x1c,%esp
80106610:	5b                   	pop    %ebx
80106611:	5e                   	pop    %esi
80106612:	5f                   	pop    %edi
80106613:	5d                   	pop    %ebp
80106614:	c3                   	ret    
80106615:	8d 76 00             	lea    0x0(%esi),%esi
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106618:	31 c0                	xor    %eax,%eax
}
8010661a:	83 c4 1c             	add    $0x1c,%esp
8010661d:	5b                   	pop    %ebx
8010661e:	5e                   	pop    %esi
8010661f:	5f                   	pop    %edi
80106620:	5d                   	pop    %ebp
80106621:	c3                   	ret    
