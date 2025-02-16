	.text
	.file	"LLVMDialectModule"
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0                          # -- Begin function softmax_kernel
.LCPI0_0:
	.long	1024                            # 0x400
	.long	1025                            # 0x401
	.long	1026                            # 0x402
	.long	1027                            # 0x403
	.long	1028                            # 0x404
	.long	1029                            # 0x405
	.long	1030                            # 0x406
	.long	1031                            # 0x407
	.long	1032                            # 0x408
	.long	1033                            # 0x409
	.long	1034                            # 0x40a
	.long	1035                            # 0x40b
	.long	1036                            # 0x40c
	.long	1037                            # 0x40d
	.long	1038                            # 0x40e
	.long	1039                            # 0x40f
.LCPI0_1:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
.LCPI0_2:
	.long	1536                            # 0x600
	.long	1537                            # 0x601
	.long	1538                            # 0x602
	.long	1539                            # 0x603
	.long	1540                            # 0x604
	.long	1541                            # 0x605
	.long	1542                            # 0x606
	.long	1543                            # 0x607
	.long	1544                            # 0x608
	.long	1545                            # 0x609
	.long	1546                            # 0x60a
	.long	1547                            # 0x60b
	.long	1548                            # 0x60c
	.long	1549                            # 0x60d
	.long	1550                            # 0x60e
	.long	1551                            # 0x60f
.LCPI0_3:
	.long	512                             # 0x200
	.long	513                             # 0x201
	.long	514                             # 0x202
	.long	515                             # 0x203
	.long	516                             # 0x204
	.long	517                             # 0x205
	.long	518                             # 0x206
	.long	519                             # 0x207
	.long	520                             # 0x208
	.long	521                             # 0x209
	.long	522                             # 0x20a
	.long	523                             # 0x20b
	.long	524                             # 0x20c
	.long	525                             # 0x20d
	.long	526                             # 0x20e
	.long	527                             # 0x20f
.LCPI0_4:
	.long	1280                            # 0x500
	.long	1281                            # 0x501
	.long	1282                            # 0x502
	.long	1283                            # 0x503
	.long	1284                            # 0x504
	.long	1285                            # 0x505
	.long	1286                            # 0x506
	.long	1287                            # 0x507
	.long	1288                            # 0x508
	.long	1289                            # 0x509
	.long	1290                            # 0x50a
	.long	1291                            # 0x50b
	.long	1292                            # 0x50c
	.long	1293                            # 0x50d
	.long	1294                            # 0x50e
	.long	1295                            # 0x50f
.LCPI0_5:
	.long	256                             # 0x100
	.long	257                             # 0x101
	.long	258                             # 0x102
	.long	259                             # 0x103
	.long	260                             # 0x104
	.long	261                             # 0x105
	.long	262                             # 0x106
	.long	263                             # 0x107
	.long	264                             # 0x108
	.long	265                             # 0x109
	.long	266                             # 0x10a
	.long	267                             # 0x10b
	.long	268                             # 0x10c
	.long	269                             # 0x10d
	.long	270                             # 0x10e
	.long	271                             # 0x10f
.LCPI0_6:
	.long	1792                            # 0x700
	.long	1793                            # 0x701
	.long	1794                            # 0x702
	.long	1795                            # 0x703
	.long	1796                            # 0x704
	.long	1797                            # 0x705
	.long	1798                            # 0x706
	.long	1799                            # 0x707
	.long	1800                            # 0x708
	.long	1801                            # 0x709
	.long	1802                            # 0x70a
	.long	1803                            # 0x70b
	.long	1804                            # 0x70c
	.long	1805                            # 0x70d
	.long	1806                            # 0x70e
	.long	1807                            # 0x70f
.LCPI0_7:
	.long	768                             # 0x300
	.long	769                             # 0x301
	.long	770                             # 0x302
	.long	771                             # 0x303
	.long	772                             # 0x304
	.long	773                             # 0x305
	.long	774                             # 0x306
	.long	775                             # 0x307
	.long	776                             # 0x308
	.long	777                             # 0x309
	.long	778                             # 0x30a
	.long	779                             # 0x30b
	.long	780                             # 0x30c
	.long	781                             # 0x30d
	.long	782                             # 0x30e
	.long	783                             # 0x30f
.LCPI0_8:
	.long	1152                            # 0x480
	.long	1153                            # 0x481
	.long	1154                            # 0x482
	.long	1155                            # 0x483
	.long	1156                            # 0x484
	.long	1157                            # 0x485
	.long	1158                            # 0x486
	.long	1159                            # 0x487
	.long	1160                            # 0x488
	.long	1161                            # 0x489
	.long	1162                            # 0x48a
	.long	1163                            # 0x48b
	.long	1164                            # 0x48c
	.long	1165                            # 0x48d
	.long	1166                            # 0x48e
	.long	1167                            # 0x48f
.LCPI0_9:
	.long	128                             # 0x80
	.long	129                             # 0x81
	.long	130                             # 0x82
	.long	131                             # 0x83
	.long	132                             # 0x84
	.long	133                             # 0x85
	.long	134                             # 0x86
	.long	135                             # 0x87
	.long	136                             # 0x88
	.long	137                             # 0x89
	.long	138                             # 0x8a
	.long	139                             # 0x8b
	.long	140                             # 0x8c
	.long	141                             # 0x8d
	.long	142                             # 0x8e
	.long	143                             # 0x8f
.LCPI0_10:
	.long	1664                            # 0x680
	.long	1665                            # 0x681
	.long	1666                            # 0x682
	.long	1667                            # 0x683
	.long	1668                            # 0x684
	.long	1669                            # 0x685
	.long	1670                            # 0x686
	.long	1671                            # 0x687
	.long	1672                            # 0x688
	.long	1673                            # 0x689
	.long	1674                            # 0x68a
	.long	1675                            # 0x68b
	.long	1676                            # 0x68c
	.long	1677                            # 0x68d
	.long	1678                            # 0x68e
	.long	1679                            # 0x68f
.LCPI0_11:
	.long	640                             # 0x280
	.long	641                             # 0x281
	.long	642                             # 0x282
	.long	643                             # 0x283
	.long	644                             # 0x284
	.long	645                             # 0x285
	.long	646                             # 0x286
	.long	647                             # 0x287
	.long	648                             # 0x288
	.long	649                             # 0x289
	.long	650                             # 0x28a
	.long	651                             # 0x28b
	.long	652                             # 0x28c
	.long	653                             # 0x28d
	.long	654                             # 0x28e
	.long	655                             # 0x28f
.LCPI0_12:
	.long	1408                            # 0x580
	.long	1409                            # 0x581
	.long	1410                            # 0x582
	.long	1411                            # 0x583
	.long	1412                            # 0x584
	.long	1413                            # 0x585
	.long	1414                            # 0x586
	.long	1415                            # 0x587
	.long	1416                            # 0x588
	.long	1417                            # 0x589
	.long	1418                            # 0x58a
	.long	1419                            # 0x58b
	.long	1420                            # 0x58c
	.long	1421                            # 0x58d
	.long	1422                            # 0x58e
	.long	1423                            # 0x58f
.LCPI0_13:
	.long	384                             # 0x180
	.long	385                             # 0x181
	.long	386                             # 0x182
	.long	387                             # 0x183
	.long	388                             # 0x184
	.long	389                             # 0x185
	.long	390                             # 0x186
	.long	391                             # 0x187
	.long	392                             # 0x188
	.long	393                             # 0x189
	.long	394                             # 0x18a
	.long	395                             # 0x18b
	.long	396                             # 0x18c
	.long	397                             # 0x18d
	.long	398                             # 0x18e
	.long	399                             # 0x18f
.LCPI0_14:
	.long	1920                            # 0x780
	.long	1921                            # 0x781
	.long	1922                            # 0x782
	.long	1923                            # 0x783
	.long	1924                            # 0x784
	.long	1925                            # 0x785
	.long	1926                            # 0x786
	.long	1927                            # 0x787
	.long	1928                            # 0x788
	.long	1929                            # 0x789
	.long	1930                            # 0x78a
	.long	1931                            # 0x78b
	.long	1932                            # 0x78c
	.long	1933                            # 0x78d
	.long	1934                            # 0x78e
	.long	1935                            # 0x78f
.LCPI0_15:
	.long	896                             # 0x380
	.long	897                             # 0x381
	.long	898                             # 0x382
	.long	899                             # 0x383
	.long	900                             # 0x384
	.long	901                             # 0x385
	.long	902                             # 0x386
	.long	903                             # 0x387
	.long	904                             # 0x388
	.long	905                             # 0x389
	.long	906                             # 0x38a
	.long	907                             # 0x38b
	.long	908                             # 0x38c
	.long	909                             # 0x38d
	.long	910                             # 0x38e
	.long	911                             # 0x38f
.LCPI0_16:
	.long	1088                            # 0x440
	.long	1089                            # 0x441
	.long	1090                            # 0x442
	.long	1091                            # 0x443
	.long	1092                            # 0x444
	.long	1093                            # 0x445
	.long	1094                            # 0x446
	.long	1095                            # 0x447
	.long	1096                            # 0x448
	.long	1097                            # 0x449
	.long	1098                            # 0x44a
	.long	1099                            # 0x44b
	.long	1100                            # 0x44c
	.long	1101                            # 0x44d
	.long	1102                            # 0x44e
	.long	1103                            # 0x44f
.LCPI0_17:
	.long	64                              # 0x40
	.long	65                              # 0x41
	.long	66                              # 0x42
	.long	67                              # 0x43
	.long	68                              # 0x44
	.long	69                              # 0x45
	.long	70                              # 0x46
	.long	71                              # 0x47
	.long	72                              # 0x48
	.long	73                              # 0x49
	.long	74                              # 0x4a
	.long	75                              # 0x4b
	.long	76                              # 0x4c
	.long	77                              # 0x4d
	.long	78                              # 0x4e
	.long	79                              # 0x4f
.LCPI0_18:
	.long	1600                            # 0x640
	.long	1601                            # 0x641
	.long	1602                            # 0x642
	.long	1603                            # 0x643
	.long	1604                            # 0x644
	.long	1605                            # 0x645
	.long	1606                            # 0x646
	.long	1607                            # 0x647
	.long	1608                            # 0x648
	.long	1609                            # 0x649
	.long	1610                            # 0x64a
	.long	1611                            # 0x64b
	.long	1612                            # 0x64c
	.long	1613                            # 0x64d
	.long	1614                            # 0x64e
	.long	1615                            # 0x64f
.LCPI0_19:
	.long	576                             # 0x240
	.long	577                             # 0x241
	.long	578                             # 0x242
	.long	579                             # 0x243
	.long	580                             # 0x244
	.long	581                             # 0x245
	.long	582                             # 0x246
	.long	583                             # 0x247
	.long	584                             # 0x248
	.long	585                             # 0x249
	.long	586                             # 0x24a
	.long	587                             # 0x24b
	.long	588                             # 0x24c
	.long	589                             # 0x24d
	.long	590                             # 0x24e
	.long	591                             # 0x24f
.LCPI0_20:
	.long	1344                            # 0x540
	.long	1345                            # 0x541
	.long	1346                            # 0x542
	.long	1347                            # 0x543
	.long	1348                            # 0x544
	.long	1349                            # 0x545
	.long	1350                            # 0x546
	.long	1351                            # 0x547
	.long	1352                            # 0x548
	.long	1353                            # 0x549
	.long	1354                            # 0x54a
	.long	1355                            # 0x54b
	.long	1356                            # 0x54c
	.long	1357                            # 0x54d
	.long	1358                            # 0x54e
	.long	1359                            # 0x54f
.LCPI0_21:
	.long	320                             # 0x140
	.long	321                             # 0x141
	.long	322                             # 0x142
	.long	323                             # 0x143
	.long	324                             # 0x144
	.long	325                             # 0x145
	.long	326                             # 0x146
	.long	327                             # 0x147
	.long	328                             # 0x148
	.long	329                             # 0x149
	.long	330                             # 0x14a
	.long	331                             # 0x14b
	.long	332                             # 0x14c
	.long	333                             # 0x14d
	.long	334                             # 0x14e
	.long	335                             # 0x14f
.LCPI0_22:
	.long	1856                            # 0x740
	.long	1857                            # 0x741
	.long	1858                            # 0x742
	.long	1859                            # 0x743
	.long	1860                            # 0x744
	.long	1861                            # 0x745
	.long	1862                            # 0x746
	.long	1863                            # 0x747
	.long	1864                            # 0x748
	.long	1865                            # 0x749
	.long	1866                            # 0x74a
	.long	1867                            # 0x74b
	.long	1868                            # 0x74c
	.long	1869                            # 0x74d
	.long	1870                            # 0x74e
	.long	1871                            # 0x74f
.LCPI0_23:
	.long	832                             # 0x340
	.long	833                             # 0x341
	.long	834                             # 0x342
	.long	835                             # 0x343
	.long	836                             # 0x344
	.long	837                             # 0x345
	.long	838                             # 0x346
	.long	839                             # 0x347
	.long	840                             # 0x348
	.long	841                             # 0x349
	.long	842                             # 0x34a
	.long	843                             # 0x34b
	.long	844                             # 0x34c
	.long	845                             # 0x34d
	.long	846                             # 0x34e
	.long	847                             # 0x34f
.LCPI0_24:
	.long	1216                            # 0x4c0
	.long	1217                            # 0x4c1
	.long	1218                            # 0x4c2
	.long	1219                            # 0x4c3
	.long	1220                            # 0x4c4
	.long	1221                            # 0x4c5
	.long	1222                            # 0x4c6
	.long	1223                            # 0x4c7
	.long	1224                            # 0x4c8
	.long	1225                            # 0x4c9
	.long	1226                            # 0x4ca
	.long	1227                            # 0x4cb
	.long	1228                            # 0x4cc
	.long	1229                            # 0x4cd
	.long	1230                            # 0x4ce
	.long	1231                            # 0x4cf
.LCPI0_25:
	.long	192                             # 0xc0
	.long	193                             # 0xc1
	.long	194                             # 0xc2
	.long	195                             # 0xc3
	.long	196                             # 0xc4
	.long	197                             # 0xc5
	.long	198                             # 0xc6
	.long	199                             # 0xc7
	.long	200                             # 0xc8
	.long	201                             # 0xc9
	.long	202                             # 0xca
	.long	203                             # 0xcb
	.long	204                             # 0xcc
	.long	205                             # 0xcd
	.long	206                             # 0xce
	.long	207                             # 0xcf
.LCPI0_26:
	.long	1728                            # 0x6c0
	.long	1729                            # 0x6c1
	.long	1730                            # 0x6c2
	.long	1731                            # 0x6c3
	.long	1732                            # 0x6c4
	.long	1733                            # 0x6c5
	.long	1734                            # 0x6c6
	.long	1735                            # 0x6c7
	.long	1736                            # 0x6c8
	.long	1737                            # 0x6c9
	.long	1738                            # 0x6ca
	.long	1739                            # 0x6cb
	.long	1740                            # 0x6cc
	.long	1741                            # 0x6cd
	.long	1742                            # 0x6ce
	.long	1743                            # 0x6cf
.LCPI0_27:
	.long	704                             # 0x2c0
	.long	705                             # 0x2c1
	.long	706                             # 0x2c2
	.long	707                             # 0x2c3
	.long	708                             # 0x2c4
	.long	709                             # 0x2c5
	.long	710                             # 0x2c6
	.long	711                             # 0x2c7
	.long	712                             # 0x2c8
	.long	713                             # 0x2c9
	.long	714                             # 0x2ca
	.long	715                             # 0x2cb
	.long	716                             # 0x2cc
	.long	717                             # 0x2cd
	.long	718                             # 0x2ce
	.long	719                             # 0x2cf
.LCPI0_28:
	.long	1472                            # 0x5c0
	.long	1473                            # 0x5c1
	.long	1474                            # 0x5c2
	.long	1475                            # 0x5c3
	.long	1476                            # 0x5c4
	.long	1477                            # 0x5c5
	.long	1478                            # 0x5c6
	.long	1479                            # 0x5c7
	.long	1480                            # 0x5c8
	.long	1481                            # 0x5c9
	.long	1482                            # 0x5ca
	.long	1483                            # 0x5cb
	.long	1484                            # 0x5cc
	.long	1485                            # 0x5cd
	.long	1486                            # 0x5ce
	.long	1487                            # 0x5cf
.LCPI0_29:
	.long	448                             # 0x1c0
	.long	449                             # 0x1c1
	.long	450                             # 0x1c2
	.long	451                             # 0x1c3
	.long	452                             # 0x1c4
	.long	453                             # 0x1c5
	.long	454                             # 0x1c6
	.long	455                             # 0x1c7
	.long	456                             # 0x1c8
	.long	457                             # 0x1c9
	.long	458                             # 0x1ca
	.long	459                             # 0x1cb
	.long	460                             # 0x1cc
	.long	461                             # 0x1cd
	.long	462                             # 0x1ce
	.long	463                             # 0x1cf
.LCPI0_30:
	.long	1984                            # 0x7c0
	.long	1985                            # 0x7c1
	.long	1986                            # 0x7c2
	.long	1987                            # 0x7c3
	.long	1988                            # 0x7c4
	.long	1989                            # 0x7c5
	.long	1990                            # 0x7c6
	.long	1991                            # 0x7c7
	.long	1992                            # 0x7c8
	.long	1993                            # 0x7c9
	.long	1994                            # 0x7ca
	.long	1995                            # 0x7cb
	.long	1996                            # 0x7cc
	.long	1997                            # 0x7cd
	.long	1998                            # 0x7ce
	.long	1999                            # 0x7cf
.LCPI0_31:
	.long	960                             # 0x3c0
	.long	961                             # 0x3c1
	.long	962                             # 0x3c2
	.long	963                             # 0x3c3
	.long	964                             # 0x3c4
	.long	965                             # 0x3c5
	.long	966                             # 0x3c6
	.long	967                             # 0x3c7
	.long	968                             # 0x3c8
	.long	969                             # 0x3c9
	.long	970                             # 0x3ca
	.long	971                             # 0x3cb
	.long	972                             # 0x3cc
	.long	973                             # 0x3cd
	.long	974                             # 0x3ce
	.long	975                             # 0x3cf
.LCPI0_32:
	.long	1056                            # 0x420
	.long	1057                            # 0x421
	.long	1058                            # 0x422
	.long	1059                            # 0x423
	.long	1060                            # 0x424
	.long	1061                            # 0x425
	.long	1062                            # 0x426
	.long	1063                            # 0x427
	.long	1064                            # 0x428
	.long	1065                            # 0x429
	.long	1066                            # 0x42a
	.long	1067                            # 0x42b
	.long	1068                            # 0x42c
	.long	1069                            # 0x42d
	.long	1070                            # 0x42e
	.long	1071                            # 0x42f
.LCPI0_33:
	.long	32                              # 0x20
	.long	33                              # 0x21
	.long	34                              # 0x22
	.long	35                              # 0x23
	.long	36                              # 0x24
	.long	37                              # 0x25
	.long	38                              # 0x26
	.long	39                              # 0x27
	.long	40                              # 0x28
	.long	41                              # 0x29
	.long	42                              # 0x2a
	.long	43                              # 0x2b
	.long	44                              # 0x2c
	.long	45                              # 0x2d
	.long	46                              # 0x2e
	.long	47                              # 0x2f
.LCPI0_34:
	.long	1568                            # 0x620
	.long	1569                            # 0x621
	.long	1570                            # 0x622
	.long	1571                            # 0x623
	.long	1572                            # 0x624
	.long	1573                            # 0x625
	.long	1574                            # 0x626
	.long	1575                            # 0x627
	.long	1576                            # 0x628
	.long	1577                            # 0x629
	.long	1578                            # 0x62a
	.long	1579                            # 0x62b
	.long	1580                            # 0x62c
	.long	1581                            # 0x62d
	.long	1582                            # 0x62e
	.long	1583                            # 0x62f
.LCPI0_35:
	.long	544                             # 0x220
	.long	545                             # 0x221
	.long	546                             # 0x222
	.long	547                             # 0x223
	.long	548                             # 0x224
	.long	549                             # 0x225
	.long	550                             # 0x226
	.long	551                             # 0x227
	.long	552                             # 0x228
	.long	553                             # 0x229
	.long	554                             # 0x22a
	.long	555                             # 0x22b
	.long	556                             # 0x22c
	.long	557                             # 0x22d
	.long	558                             # 0x22e
	.long	559                             # 0x22f
.LCPI0_36:
	.long	1312                            # 0x520
	.long	1313                            # 0x521
	.long	1314                            # 0x522
	.long	1315                            # 0x523
	.long	1316                            # 0x524
	.long	1317                            # 0x525
	.long	1318                            # 0x526
	.long	1319                            # 0x527
	.long	1320                            # 0x528
	.long	1321                            # 0x529
	.long	1322                            # 0x52a
	.long	1323                            # 0x52b
	.long	1324                            # 0x52c
	.long	1325                            # 0x52d
	.long	1326                            # 0x52e
	.long	1327                            # 0x52f
.LCPI0_37:
	.long	288                             # 0x120
	.long	289                             # 0x121
	.long	290                             # 0x122
	.long	291                             # 0x123
	.long	292                             # 0x124
	.long	293                             # 0x125
	.long	294                             # 0x126
	.long	295                             # 0x127
	.long	296                             # 0x128
	.long	297                             # 0x129
	.long	298                             # 0x12a
	.long	299                             # 0x12b
	.long	300                             # 0x12c
	.long	301                             # 0x12d
	.long	302                             # 0x12e
	.long	303                             # 0x12f
.LCPI0_38:
	.long	1824                            # 0x720
	.long	1825                            # 0x721
	.long	1826                            # 0x722
	.long	1827                            # 0x723
	.long	1828                            # 0x724
	.long	1829                            # 0x725
	.long	1830                            # 0x726
	.long	1831                            # 0x727
	.long	1832                            # 0x728
	.long	1833                            # 0x729
	.long	1834                            # 0x72a
	.long	1835                            # 0x72b
	.long	1836                            # 0x72c
	.long	1837                            # 0x72d
	.long	1838                            # 0x72e
	.long	1839                            # 0x72f
.LCPI0_39:
	.long	800                             # 0x320
	.long	801                             # 0x321
	.long	802                             # 0x322
	.long	803                             # 0x323
	.long	804                             # 0x324
	.long	805                             # 0x325
	.long	806                             # 0x326
	.long	807                             # 0x327
	.long	808                             # 0x328
	.long	809                             # 0x329
	.long	810                             # 0x32a
	.long	811                             # 0x32b
	.long	812                             # 0x32c
	.long	813                             # 0x32d
	.long	814                             # 0x32e
	.long	815                             # 0x32f
.LCPI0_40:
	.long	1184                            # 0x4a0
	.long	1185                            # 0x4a1
	.long	1186                            # 0x4a2
	.long	1187                            # 0x4a3
	.long	1188                            # 0x4a4
	.long	1189                            # 0x4a5
	.long	1190                            # 0x4a6
	.long	1191                            # 0x4a7
	.long	1192                            # 0x4a8
	.long	1193                            # 0x4a9
	.long	1194                            # 0x4aa
	.long	1195                            # 0x4ab
	.long	1196                            # 0x4ac
	.long	1197                            # 0x4ad
	.long	1198                            # 0x4ae
	.long	1199                            # 0x4af
.LCPI0_41:
	.long	160                             # 0xa0
	.long	161                             # 0xa1
	.long	162                             # 0xa2
	.long	163                             # 0xa3
	.long	164                             # 0xa4
	.long	165                             # 0xa5
	.long	166                             # 0xa6
	.long	167                             # 0xa7
	.long	168                             # 0xa8
	.long	169                             # 0xa9
	.long	170                             # 0xaa
	.long	171                             # 0xab
	.long	172                             # 0xac
	.long	173                             # 0xad
	.long	174                             # 0xae
	.long	175                             # 0xaf
.LCPI0_42:
	.long	1696                            # 0x6a0
	.long	1697                            # 0x6a1
	.long	1698                            # 0x6a2
	.long	1699                            # 0x6a3
	.long	1700                            # 0x6a4
	.long	1701                            # 0x6a5
	.long	1702                            # 0x6a6
	.long	1703                            # 0x6a7
	.long	1704                            # 0x6a8
	.long	1705                            # 0x6a9
	.long	1706                            # 0x6aa
	.long	1707                            # 0x6ab
	.long	1708                            # 0x6ac
	.long	1709                            # 0x6ad
	.long	1710                            # 0x6ae
	.long	1711                            # 0x6af
.LCPI0_43:
	.long	672                             # 0x2a0
	.long	673                             # 0x2a1
	.long	674                             # 0x2a2
	.long	675                             # 0x2a3
	.long	676                             # 0x2a4
	.long	677                             # 0x2a5
	.long	678                             # 0x2a6
	.long	679                             # 0x2a7
	.long	680                             # 0x2a8
	.long	681                             # 0x2a9
	.long	682                             # 0x2aa
	.long	683                             # 0x2ab
	.long	684                             # 0x2ac
	.long	685                             # 0x2ad
	.long	686                             # 0x2ae
	.long	687                             # 0x2af
.LCPI0_44:
	.long	1440                            # 0x5a0
	.long	1441                            # 0x5a1
	.long	1442                            # 0x5a2
	.long	1443                            # 0x5a3
	.long	1444                            # 0x5a4
	.long	1445                            # 0x5a5
	.long	1446                            # 0x5a6
	.long	1447                            # 0x5a7
	.long	1448                            # 0x5a8
	.long	1449                            # 0x5a9
	.long	1450                            # 0x5aa
	.long	1451                            # 0x5ab
	.long	1452                            # 0x5ac
	.long	1453                            # 0x5ad
	.long	1454                            # 0x5ae
	.long	1455                            # 0x5af
.LCPI0_45:
	.long	416                             # 0x1a0
	.long	417                             # 0x1a1
	.long	418                             # 0x1a2
	.long	419                             # 0x1a3
	.long	420                             # 0x1a4
	.long	421                             # 0x1a5
	.long	422                             # 0x1a6
	.long	423                             # 0x1a7
	.long	424                             # 0x1a8
	.long	425                             # 0x1a9
	.long	426                             # 0x1aa
	.long	427                             # 0x1ab
	.long	428                             # 0x1ac
	.long	429                             # 0x1ad
	.long	430                             # 0x1ae
	.long	431                             # 0x1af
.LCPI0_46:
	.long	1952                            # 0x7a0
	.long	1953                            # 0x7a1
	.long	1954                            # 0x7a2
	.long	1955                            # 0x7a3
	.long	1956                            # 0x7a4
	.long	1957                            # 0x7a5
	.long	1958                            # 0x7a6
	.long	1959                            # 0x7a7
	.long	1960                            # 0x7a8
	.long	1961                            # 0x7a9
	.long	1962                            # 0x7aa
	.long	1963                            # 0x7ab
	.long	1964                            # 0x7ac
	.long	1965                            # 0x7ad
	.long	1966                            # 0x7ae
	.long	1967                            # 0x7af
.LCPI0_47:
	.long	928                             # 0x3a0
	.long	929                             # 0x3a1
	.long	930                             # 0x3a2
	.long	931                             # 0x3a3
	.long	932                             # 0x3a4
	.long	933                             # 0x3a5
	.long	934                             # 0x3a6
	.long	935                             # 0x3a7
	.long	936                             # 0x3a8
	.long	937                             # 0x3a9
	.long	938                             # 0x3aa
	.long	939                             # 0x3ab
	.long	940                             # 0x3ac
	.long	941                             # 0x3ad
	.long	942                             # 0x3ae
	.long	943                             # 0x3af
.LCPI0_48:
	.long	1120                            # 0x460
	.long	1121                            # 0x461
	.long	1122                            # 0x462
	.long	1123                            # 0x463
	.long	1124                            # 0x464
	.long	1125                            # 0x465
	.long	1126                            # 0x466
	.long	1127                            # 0x467
	.long	1128                            # 0x468
	.long	1129                            # 0x469
	.long	1130                            # 0x46a
	.long	1131                            # 0x46b
	.long	1132                            # 0x46c
	.long	1133                            # 0x46d
	.long	1134                            # 0x46e
	.long	1135                            # 0x46f
.LCPI0_49:
	.long	96                              # 0x60
	.long	97                              # 0x61
	.long	98                              # 0x62
	.long	99                              # 0x63
	.long	100                             # 0x64
	.long	101                             # 0x65
	.long	102                             # 0x66
	.long	103                             # 0x67
	.long	104                             # 0x68
	.long	105                             # 0x69
	.long	106                             # 0x6a
	.long	107                             # 0x6b
	.long	108                             # 0x6c
	.long	109                             # 0x6d
	.long	110                             # 0x6e
	.long	111                             # 0x6f
.LCPI0_50:
	.long	1632                            # 0x660
	.long	1633                            # 0x661
	.long	1634                            # 0x662
	.long	1635                            # 0x663
	.long	1636                            # 0x664
	.long	1637                            # 0x665
	.long	1638                            # 0x666
	.long	1639                            # 0x667
	.long	1640                            # 0x668
	.long	1641                            # 0x669
	.long	1642                            # 0x66a
	.long	1643                            # 0x66b
	.long	1644                            # 0x66c
	.long	1645                            # 0x66d
	.long	1646                            # 0x66e
	.long	1647                            # 0x66f
.LCPI0_51:
	.long	608                             # 0x260
	.long	609                             # 0x261
	.long	610                             # 0x262
	.long	611                             # 0x263
	.long	612                             # 0x264
	.long	613                             # 0x265
	.long	614                             # 0x266
	.long	615                             # 0x267
	.long	616                             # 0x268
	.long	617                             # 0x269
	.long	618                             # 0x26a
	.long	619                             # 0x26b
	.long	620                             # 0x26c
	.long	621                             # 0x26d
	.long	622                             # 0x26e
	.long	623                             # 0x26f
.LCPI0_52:
	.long	1376                            # 0x560
	.long	1377                            # 0x561
	.long	1378                            # 0x562
	.long	1379                            # 0x563
	.long	1380                            # 0x564
	.long	1381                            # 0x565
	.long	1382                            # 0x566
	.long	1383                            # 0x567
	.long	1384                            # 0x568
	.long	1385                            # 0x569
	.long	1386                            # 0x56a
	.long	1387                            # 0x56b
	.long	1388                            # 0x56c
	.long	1389                            # 0x56d
	.long	1390                            # 0x56e
	.long	1391                            # 0x56f
.LCPI0_53:
	.long	352                             # 0x160
	.long	353                             # 0x161
	.long	354                             # 0x162
	.long	355                             # 0x163
	.long	356                             # 0x164
	.long	357                             # 0x165
	.long	358                             # 0x166
	.long	359                             # 0x167
	.long	360                             # 0x168
	.long	361                             # 0x169
	.long	362                             # 0x16a
	.long	363                             # 0x16b
	.long	364                             # 0x16c
	.long	365                             # 0x16d
	.long	366                             # 0x16e
	.long	367                             # 0x16f
.LCPI0_54:
	.long	1888                            # 0x760
	.long	1889                            # 0x761
	.long	1890                            # 0x762
	.long	1891                            # 0x763
	.long	1892                            # 0x764
	.long	1893                            # 0x765
	.long	1894                            # 0x766
	.long	1895                            # 0x767
	.long	1896                            # 0x768
	.long	1897                            # 0x769
	.long	1898                            # 0x76a
	.long	1899                            # 0x76b
	.long	1900                            # 0x76c
	.long	1901                            # 0x76d
	.long	1902                            # 0x76e
	.long	1903                            # 0x76f
.LCPI0_55:
	.long	864                             # 0x360
	.long	865                             # 0x361
	.long	866                             # 0x362
	.long	867                             # 0x363
	.long	868                             # 0x364
	.long	869                             # 0x365
	.long	870                             # 0x366
	.long	871                             # 0x367
	.long	872                             # 0x368
	.long	873                             # 0x369
	.long	874                             # 0x36a
	.long	875                             # 0x36b
	.long	876                             # 0x36c
	.long	877                             # 0x36d
	.long	878                             # 0x36e
	.long	879                             # 0x36f
.LCPI0_56:
	.long	1248                            # 0x4e0
	.long	1249                            # 0x4e1
	.long	1250                            # 0x4e2
	.long	1251                            # 0x4e3
	.long	1252                            # 0x4e4
	.long	1253                            # 0x4e5
	.long	1254                            # 0x4e6
	.long	1255                            # 0x4e7
	.long	1256                            # 0x4e8
	.long	1257                            # 0x4e9
	.long	1258                            # 0x4ea
	.long	1259                            # 0x4eb
	.long	1260                            # 0x4ec
	.long	1261                            # 0x4ed
	.long	1262                            # 0x4ee
	.long	1263                            # 0x4ef
.LCPI0_57:
	.long	224                             # 0xe0
	.long	225                             # 0xe1
	.long	226                             # 0xe2
	.long	227                             # 0xe3
	.long	228                             # 0xe4
	.long	229                             # 0xe5
	.long	230                             # 0xe6
	.long	231                             # 0xe7
	.long	232                             # 0xe8
	.long	233                             # 0xe9
	.long	234                             # 0xea
	.long	235                             # 0xeb
	.long	236                             # 0xec
	.long	237                             # 0xed
	.long	238                             # 0xee
	.long	239                             # 0xef
.LCPI0_58:
	.long	1760                            # 0x6e0
	.long	1761                            # 0x6e1
	.long	1762                            # 0x6e2
	.long	1763                            # 0x6e3
	.long	1764                            # 0x6e4
	.long	1765                            # 0x6e5
	.long	1766                            # 0x6e6
	.long	1767                            # 0x6e7
	.long	1768                            # 0x6e8
	.long	1769                            # 0x6e9
	.long	1770                            # 0x6ea
	.long	1771                            # 0x6eb
	.long	1772                            # 0x6ec
	.long	1773                            # 0x6ed
	.long	1774                            # 0x6ee
	.long	1775                            # 0x6ef
.LCPI0_59:
	.long	736                             # 0x2e0
	.long	737                             # 0x2e1
	.long	738                             # 0x2e2
	.long	739                             # 0x2e3
	.long	740                             # 0x2e4
	.long	741                             # 0x2e5
	.long	742                             # 0x2e6
	.long	743                             # 0x2e7
	.long	744                             # 0x2e8
	.long	745                             # 0x2e9
	.long	746                             # 0x2ea
	.long	747                             # 0x2eb
	.long	748                             # 0x2ec
	.long	749                             # 0x2ed
	.long	750                             # 0x2ee
	.long	751                             # 0x2ef
.LCPI0_60:
	.long	1504                            # 0x5e0
	.long	1505                            # 0x5e1
	.long	1506                            # 0x5e2
	.long	1507                            # 0x5e3
	.long	1508                            # 0x5e4
	.long	1509                            # 0x5e5
	.long	1510                            # 0x5e6
	.long	1511                            # 0x5e7
	.long	1512                            # 0x5e8
	.long	1513                            # 0x5e9
	.long	1514                            # 0x5ea
	.long	1515                            # 0x5eb
	.long	1516                            # 0x5ec
	.long	1517                            # 0x5ed
	.long	1518                            # 0x5ee
	.long	1519                            # 0x5ef
.LCPI0_61:
	.long	480                             # 0x1e0
	.long	481                             # 0x1e1
	.long	482                             # 0x1e2
	.long	483                             # 0x1e3
	.long	484                             # 0x1e4
	.long	485                             # 0x1e5
	.long	486                             # 0x1e6
	.long	487                             # 0x1e7
	.long	488                             # 0x1e8
	.long	489                             # 0x1e9
	.long	490                             # 0x1ea
	.long	491                             # 0x1eb
	.long	492                             # 0x1ec
	.long	493                             # 0x1ed
	.long	494                             # 0x1ee
	.long	495                             # 0x1ef
.LCPI0_62:
	.long	2016                            # 0x7e0
	.long	2017                            # 0x7e1
	.long	2018                            # 0x7e2
	.long	2019                            # 0x7e3
	.long	2020                            # 0x7e4
	.long	2021                            # 0x7e5
	.long	2022                            # 0x7e6
	.long	2023                            # 0x7e7
	.long	2024                            # 0x7e8
	.long	2025                            # 0x7e9
	.long	2026                            # 0x7ea
	.long	2027                            # 0x7eb
	.long	2028                            # 0x7ec
	.long	2029                            # 0x7ed
	.long	2030                            # 0x7ee
	.long	2031                            # 0x7ef
.LCPI0_63:
	.long	992                             # 0x3e0
	.long	993                             # 0x3e1
	.long	994                             # 0x3e2
	.long	995                             # 0x3e3
	.long	996                             # 0x3e4
	.long	997                             # 0x3e5
	.long	998                             # 0x3e6
	.long	999                             # 0x3e7
	.long	1000                            # 0x3e8
	.long	1001                            # 0x3e9
	.long	1002                            # 0x3ea
	.long	1003                            # 0x3eb
	.long	1004                            # 0x3ec
	.long	1005                            # 0x3ed
	.long	1006                            # 0x3ee
	.long	1007                            # 0x3ef
.LCPI0_64:
	.long	1040                            # 0x410
	.long	1041                            # 0x411
	.long	1042                            # 0x412
	.long	1043                            # 0x413
	.long	1044                            # 0x414
	.long	1045                            # 0x415
	.long	1046                            # 0x416
	.long	1047                            # 0x417
	.long	1048                            # 0x418
	.long	1049                            # 0x419
	.long	1050                            # 0x41a
	.long	1051                            # 0x41b
	.long	1052                            # 0x41c
	.long	1053                            # 0x41d
	.long	1054                            # 0x41e
	.long	1055                            # 0x41f
.LCPI0_65:
	.long	16                              # 0x10
	.long	17                              # 0x11
	.long	18                              # 0x12
	.long	19                              # 0x13
	.long	20                              # 0x14
	.long	21                              # 0x15
	.long	22                              # 0x16
	.long	23                              # 0x17
	.long	24                              # 0x18
	.long	25                              # 0x19
	.long	26                              # 0x1a
	.long	27                              # 0x1b
	.long	28                              # 0x1c
	.long	29                              # 0x1d
	.long	30                              # 0x1e
	.long	31                              # 0x1f
.LCPI0_66:
	.long	1552                            # 0x610
	.long	1553                            # 0x611
	.long	1554                            # 0x612
	.long	1555                            # 0x613
	.long	1556                            # 0x614
	.long	1557                            # 0x615
	.long	1558                            # 0x616
	.long	1559                            # 0x617
	.long	1560                            # 0x618
	.long	1561                            # 0x619
	.long	1562                            # 0x61a
	.long	1563                            # 0x61b
	.long	1564                            # 0x61c
	.long	1565                            # 0x61d
	.long	1566                            # 0x61e
	.long	1567                            # 0x61f
.LCPI0_67:
	.long	528                             # 0x210
	.long	529                             # 0x211
	.long	530                             # 0x212
	.long	531                             # 0x213
	.long	532                             # 0x214
	.long	533                             # 0x215
	.long	534                             # 0x216
	.long	535                             # 0x217
	.long	536                             # 0x218
	.long	537                             # 0x219
	.long	538                             # 0x21a
	.long	539                             # 0x21b
	.long	540                             # 0x21c
	.long	541                             # 0x21d
	.long	542                             # 0x21e
	.long	543                             # 0x21f
.LCPI0_68:
	.long	1296                            # 0x510
	.long	1297                            # 0x511
	.long	1298                            # 0x512
	.long	1299                            # 0x513
	.long	1300                            # 0x514
	.long	1301                            # 0x515
	.long	1302                            # 0x516
	.long	1303                            # 0x517
	.long	1304                            # 0x518
	.long	1305                            # 0x519
	.long	1306                            # 0x51a
	.long	1307                            # 0x51b
	.long	1308                            # 0x51c
	.long	1309                            # 0x51d
	.long	1310                            # 0x51e
	.long	1311                            # 0x51f
.LCPI0_69:
	.long	272                             # 0x110
	.long	273                             # 0x111
	.long	274                             # 0x112
	.long	275                             # 0x113
	.long	276                             # 0x114
	.long	277                             # 0x115
	.long	278                             # 0x116
	.long	279                             # 0x117
	.long	280                             # 0x118
	.long	281                             # 0x119
	.long	282                             # 0x11a
	.long	283                             # 0x11b
	.long	284                             # 0x11c
	.long	285                             # 0x11d
	.long	286                             # 0x11e
	.long	287                             # 0x11f
.LCPI0_70:
	.long	1808                            # 0x710
	.long	1809                            # 0x711
	.long	1810                            # 0x712
	.long	1811                            # 0x713
	.long	1812                            # 0x714
	.long	1813                            # 0x715
	.long	1814                            # 0x716
	.long	1815                            # 0x717
	.long	1816                            # 0x718
	.long	1817                            # 0x719
	.long	1818                            # 0x71a
	.long	1819                            # 0x71b
	.long	1820                            # 0x71c
	.long	1821                            # 0x71d
	.long	1822                            # 0x71e
	.long	1823                            # 0x71f
.LCPI0_71:
	.long	784                             # 0x310
	.long	785                             # 0x311
	.long	786                             # 0x312
	.long	787                             # 0x313
	.long	788                             # 0x314
	.long	789                             # 0x315
	.long	790                             # 0x316
	.long	791                             # 0x317
	.long	792                             # 0x318
	.long	793                             # 0x319
	.long	794                             # 0x31a
	.long	795                             # 0x31b
	.long	796                             # 0x31c
	.long	797                             # 0x31d
	.long	798                             # 0x31e
	.long	799                             # 0x31f
.LCPI0_72:
	.long	1168                            # 0x490
	.long	1169                            # 0x491
	.long	1170                            # 0x492
	.long	1171                            # 0x493
	.long	1172                            # 0x494
	.long	1173                            # 0x495
	.long	1174                            # 0x496
	.long	1175                            # 0x497
	.long	1176                            # 0x498
	.long	1177                            # 0x499
	.long	1178                            # 0x49a
	.long	1179                            # 0x49b
	.long	1180                            # 0x49c
	.long	1181                            # 0x49d
	.long	1182                            # 0x49e
	.long	1183                            # 0x49f
.LCPI0_73:
	.long	144                             # 0x90
	.long	145                             # 0x91
	.long	146                             # 0x92
	.long	147                             # 0x93
	.long	148                             # 0x94
	.long	149                             # 0x95
	.long	150                             # 0x96
	.long	151                             # 0x97
	.long	152                             # 0x98
	.long	153                             # 0x99
	.long	154                             # 0x9a
	.long	155                             # 0x9b
	.long	156                             # 0x9c
	.long	157                             # 0x9d
	.long	158                             # 0x9e
	.long	159                             # 0x9f
.LCPI0_74:
	.long	1680                            # 0x690
	.long	1681                            # 0x691
	.long	1682                            # 0x692
	.long	1683                            # 0x693
	.long	1684                            # 0x694
	.long	1685                            # 0x695
	.long	1686                            # 0x696
	.long	1687                            # 0x697
	.long	1688                            # 0x698
	.long	1689                            # 0x699
	.long	1690                            # 0x69a
	.long	1691                            # 0x69b
	.long	1692                            # 0x69c
	.long	1693                            # 0x69d
	.long	1694                            # 0x69e
	.long	1695                            # 0x69f
.LCPI0_75:
	.long	656                             # 0x290
	.long	657                             # 0x291
	.long	658                             # 0x292
	.long	659                             # 0x293
	.long	660                             # 0x294
	.long	661                             # 0x295
	.long	662                             # 0x296
	.long	663                             # 0x297
	.long	664                             # 0x298
	.long	665                             # 0x299
	.long	666                             # 0x29a
	.long	667                             # 0x29b
	.long	668                             # 0x29c
	.long	669                             # 0x29d
	.long	670                             # 0x29e
	.long	671                             # 0x29f
.LCPI0_76:
	.long	1424                            # 0x590
	.long	1425                            # 0x591
	.long	1426                            # 0x592
	.long	1427                            # 0x593
	.long	1428                            # 0x594
	.long	1429                            # 0x595
	.long	1430                            # 0x596
	.long	1431                            # 0x597
	.long	1432                            # 0x598
	.long	1433                            # 0x599
	.long	1434                            # 0x59a
	.long	1435                            # 0x59b
	.long	1436                            # 0x59c
	.long	1437                            # 0x59d
	.long	1438                            # 0x59e
	.long	1439                            # 0x59f
.LCPI0_77:
	.long	400                             # 0x190
	.long	401                             # 0x191
	.long	402                             # 0x192
	.long	403                             # 0x193
	.long	404                             # 0x194
	.long	405                             # 0x195
	.long	406                             # 0x196
	.long	407                             # 0x197
	.long	408                             # 0x198
	.long	409                             # 0x199
	.long	410                             # 0x19a
	.long	411                             # 0x19b
	.long	412                             # 0x19c
	.long	413                             # 0x19d
	.long	414                             # 0x19e
	.long	415                             # 0x19f
.LCPI0_78:
	.long	1936                            # 0x790
	.long	1937                            # 0x791
	.long	1938                            # 0x792
	.long	1939                            # 0x793
	.long	1940                            # 0x794
	.long	1941                            # 0x795
	.long	1942                            # 0x796
	.long	1943                            # 0x797
	.long	1944                            # 0x798
	.long	1945                            # 0x799
	.long	1946                            # 0x79a
	.long	1947                            # 0x79b
	.long	1948                            # 0x79c
	.long	1949                            # 0x79d
	.long	1950                            # 0x79e
	.long	1951                            # 0x79f
.LCPI0_79:
	.long	912                             # 0x390
	.long	913                             # 0x391
	.long	914                             # 0x392
	.long	915                             # 0x393
	.long	916                             # 0x394
	.long	917                             # 0x395
	.long	918                             # 0x396
	.long	919                             # 0x397
	.long	920                             # 0x398
	.long	921                             # 0x399
	.long	922                             # 0x39a
	.long	923                             # 0x39b
	.long	924                             # 0x39c
	.long	925                             # 0x39d
	.long	926                             # 0x39e
	.long	927                             # 0x39f
.LCPI0_80:
	.long	1104                            # 0x450
	.long	1105                            # 0x451
	.long	1106                            # 0x452
	.long	1107                            # 0x453
	.long	1108                            # 0x454
	.long	1109                            # 0x455
	.long	1110                            # 0x456
	.long	1111                            # 0x457
	.long	1112                            # 0x458
	.long	1113                            # 0x459
	.long	1114                            # 0x45a
	.long	1115                            # 0x45b
	.long	1116                            # 0x45c
	.long	1117                            # 0x45d
	.long	1118                            # 0x45e
	.long	1119                            # 0x45f
.LCPI0_81:
	.long	80                              # 0x50
	.long	81                              # 0x51
	.long	82                              # 0x52
	.long	83                              # 0x53
	.long	84                              # 0x54
	.long	85                              # 0x55
	.long	86                              # 0x56
	.long	87                              # 0x57
	.long	88                              # 0x58
	.long	89                              # 0x59
	.long	90                              # 0x5a
	.long	91                              # 0x5b
	.long	92                              # 0x5c
	.long	93                              # 0x5d
	.long	94                              # 0x5e
	.long	95                              # 0x5f
.LCPI0_82:
	.long	1616                            # 0x650
	.long	1617                            # 0x651
	.long	1618                            # 0x652
	.long	1619                            # 0x653
	.long	1620                            # 0x654
	.long	1621                            # 0x655
	.long	1622                            # 0x656
	.long	1623                            # 0x657
	.long	1624                            # 0x658
	.long	1625                            # 0x659
	.long	1626                            # 0x65a
	.long	1627                            # 0x65b
	.long	1628                            # 0x65c
	.long	1629                            # 0x65d
	.long	1630                            # 0x65e
	.long	1631                            # 0x65f
.LCPI0_83:
	.long	592                             # 0x250
	.long	593                             # 0x251
	.long	594                             # 0x252
	.long	595                             # 0x253
	.long	596                             # 0x254
	.long	597                             # 0x255
	.long	598                             # 0x256
	.long	599                             # 0x257
	.long	600                             # 0x258
	.long	601                             # 0x259
	.long	602                             # 0x25a
	.long	603                             # 0x25b
	.long	604                             # 0x25c
	.long	605                             # 0x25d
	.long	606                             # 0x25e
	.long	607                             # 0x25f
.LCPI0_84:
	.long	1360                            # 0x550
	.long	1361                            # 0x551
	.long	1362                            # 0x552
	.long	1363                            # 0x553
	.long	1364                            # 0x554
	.long	1365                            # 0x555
	.long	1366                            # 0x556
	.long	1367                            # 0x557
	.long	1368                            # 0x558
	.long	1369                            # 0x559
	.long	1370                            # 0x55a
	.long	1371                            # 0x55b
	.long	1372                            # 0x55c
	.long	1373                            # 0x55d
	.long	1374                            # 0x55e
	.long	1375                            # 0x55f
.LCPI0_85:
	.long	336                             # 0x150
	.long	337                             # 0x151
	.long	338                             # 0x152
	.long	339                             # 0x153
	.long	340                             # 0x154
	.long	341                             # 0x155
	.long	342                             # 0x156
	.long	343                             # 0x157
	.long	344                             # 0x158
	.long	345                             # 0x159
	.long	346                             # 0x15a
	.long	347                             # 0x15b
	.long	348                             # 0x15c
	.long	349                             # 0x15d
	.long	350                             # 0x15e
	.long	351                             # 0x15f
.LCPI0_86:
	.long	1872                            # 0x750
	.long	1873                            # 0x751
	.long	1874                            # 0x752
	.long	1875                            # 0x753
	.long	1876                            # 0x754
	.long	1877                            # 0x755
	.long	1878                            # 0x756
	.long	1879                            # 0x757
	.long	1880                            # 0x758
	.long	1881                            # 0x759
	.long	1882                            # 0x75a
	.long	1883                            # 0x75b
	.long	1884                            # 0x75c
	.long	1885                            # 0x75d
	.long	1886                            # 0x75e
	.long	1887                            # 0x75f
.LCPI0_87:
	.long	848                             # 0x350
	.long	849                             # 0x351
	.long	850                             # 0x352
	.long	851                             # 0x353
	.long	852                             # 0x354
	.long	853                             # 0x355
	.long	854                             # 0x356
	.long	855                             # 0x357
	.long	856                             # 0x358
	.long	857                             # 0x359
	.long	858                             # 0x35a
	.long	859                             # 0x35b
	.long	860                             # 0x35c
	.long	861                             # 0x35d
	.long	862                             # 0x35e
	.long	863                             # 0x35f
.LCPI0_88:
	.long	1232                            # 0x4d0
	.long	1233                            # 0x4d1
	.long	1234                            # 0x4d2
	.long	1235                            # 0x4d3
	.long	1236                            # 0x4d4
	.long	1237                            # 0x4d5
	.long	1238                            # 0x4d6
	.long	1239                            # 0x4d7
	.long	1240                            # 0x4d8
	.long	1241                            # 0x4d9
	.long	1242                            # 0x4da
	.long	1243                            # 0x4db
	.long	1244                            # 0x4dc
	.long	1245                            # 0x4dd
	.long	1246                            # 0x4de
	.long	1247                            # 0x4df
.LCPI0_89:
	.long	208                             # 0xd0
	.long	209                             # 0xd1
	.long	210                             # 0xd2
	.long	211                             # 0xd3
	.long	212                             # 0xd4
	.long	213                             # 0xd5
	.long	214                             # 0xd6
	.long	215                             # 0xd7
	.long	216                             # 0xd8
	.long	217                             # 0xd9
	.long	218                             # 0xda
	.long	219                             # 0xdb
	.long	220                             # 0xdc
	.long	221                             # 0xdd
	.long	222                             # 0xde
	.long	223                             # 0xdf
.LCPI0_90:
	.long	1744                            # 0x6d0
	.long	1745                            # 0x6d1
	.long	1746                            # 0x6d2
	.long	1747                            # 0x6d3
	.long	1748                            # 0x6d4
	.long	1749                            # 0x6d5
	.long	1750                            # 0x6d6
	.long	1751                            # 0x6d7
	.long	1752                            # 0x6d8
	.long	1753                            # 0x6d9
	.long	1754                            # 0x6da
	.long	1755                            # 0x6db
	.long	1756                            # 0x6dc
	.long	1757                            # 0x6dd
	.long	1758                            # 0x6de
	.long	1759                            # 0x6df
.LCPI0_91:
	.long	720                             # 0x2d0
	.long	721                             # 0x2d1
	.long	722                             # 0x2d2
	.long	723                             # 0x2d3
	.long	724                             # 0x2d4
	.long	725                             # 0x2d5
	.long	726                             # 0x2d6
	.long	727                             # 0x2d7
	.long	728                             # 0x2d8
	.long	729                             # 0x2d9
	.long	730                             # 0x2da
	.long	731                             # 0x2db
	.long	732                             # 0x2dc
	.long	733                             # 0x2dd
	.long	734                             # 0x2de
	.long	735                             # 0x2df
.LCPI0_92:
	.long	1488                            # 0x5d0
	.long	1489                            # 0x5d1
	.long	1490                            # 0x5d2
	.long	1491                            # 0x5d3
	.long	1492                            # 0x5d4
	.long	1493                            # 0x5d5
	.long	1494                            # 0x5d6
	.long	1495                            # 0x5d7
	.long	1496                            # 0x5d8
	.long	1497                            # 0x5d9
	.long	1498                            # 0x5da
	.long	1499                            # 0x5db
	.long	1500                            # 0x5dc
	.long	1501                            # 0x5dd
	.long	1502                            # 0x5de
	.long	1503                            # 0x5df
.LCPI0_93:
	.long	464                             # 0x1d0
	.long	465                             # 0x1d1
	.long	466                             # 0x1d2
	.long	467                             # 0x1d3
	.long	468                             # 0x1d4
	.long	469                             # 0x1d5
	.long	470                             # 0x1d6
	.long	471                             # 0x1d7
	.long	472                             # 0x1d8
	.long	473                             # 0x1d9
	.long	474                             # 0x1da
	.long	475                             # 0x1db
	.long	476                             # 0x1dc
	.long	477                             # 0x1dd
	.long	478                             # 0x1de
	.long	479                             # 0x1df
.LCPI0_94:
	.long	2000                            # 0x7d0
	.long	2001                            # 0x7d1
	.long	2002                            # 0x7d2
	.long	2003                            # 0x7d3
	.long	2004                            # 0x7d4
	.long	2005                            # 0x7d5
	.long	2006                            # 0x7d6
	.long	2007                            # 0x7d7
	.long	2008                            # 0x7d8
	.long	2009                            # 0x7d9
	.long	2010                            # 0x7da
	.long	2011                            # 0x7db
	.long	2012                            # 0x7dc
	.long	2013                            # 0x7dd
	.long	2014                            # 0x7de
	.long	2015                            # 0x7df
.LCPI0_95:
	.long	976                             # 0x3d0
	.long	977                             # 0x3d1
	.long	978                             # 0x3d2
	.long	979                             # 0x3d3
	.long	980                             # 0x3d4
	.long	981                             # 0x3d5
	.long	982                             # 0x3d6
	.long	983                             # 0x3d7
	.long	984                             # 0x3d8
	.long	985                             # 0x3d9
	.long	986                             # 0x3da
	.long	987                             # 0x3db
	.long	988                             # 0x3dc
	.long	989                             # 0x3dd
	.long	990                             # 0x3de
	.long	991                             # 0x3df
.LCPI0_96:
	.long	1072                            # 0x430
	.long	1073                            # 0x431
	.long	1074                            # 0x432
	.long	1075                            # 0x433
	.long	1076                            # 0x434
	.long	1077                            # 0x435
	.long	1078                            # 0x436
	.long	1079                            # 0x437
	.long	1080                            # 0x438
	.long	1081                            # 0x439
	.long	1082                            # 0x43a
	.long	1083                            # 0x43b
	.long	1084                            # 0x43c
	.long	1085                            # 0x43d
	.long	1086                            # 0x43e
	.long	1087                            # 0x43f
.LCPI0_97:
	.long	48                              # 0x30
	.long	49                              # 0x31
	.long	50                              # 0x32
	.long	51                              # 0x33
	.long	52                              # 0x34
	.long	53                              # 0x35
	.long	54                              # 0x36
	.long	55                              # 0x37
	.long	56                              # 0x38
	.long	57                              # 0x39
	.long	58                              # 0x3a
	.long	59                              # 0x3b
	.long	60                              # 0x3c
	.long	61                              # 0x3d
	.long	62                              # 0x3e
	.long	63                              # 0x3f
.LCPI0_98:
	.long	1584                            # 0x630
	.long	1585                            # 0x631
	.long	1586                            # 0x632
	.long	1587                            # 0x633
	.long	1588                            # 0x634
	.long	1589                            # 0x635
	.long	1590                            # 0x636
	.long	1591                            # 0x637
	.long	1592                            # 0x638
	.long	1593                            # 0x639
	.long	1594                            # 0x63a
	.long	1595                            # 0x63b
	.long	1596                            # 0x63c
	.long	1597                            # 0x63d
	.long	1598                            # 0x63e
	.long	1599                            # 0x63f
.LCPI0_99:
	.long	560                             # 0x230
	.long	561                             # 0x231
	.long	562                             # 0x232
	.long	563                             # 0x233
	.long	564                             # 0x234
	.long	565                             # 0x235
	.long	566                             # 0x236
	.long	567                             # 0x237
	.long	568                             # 0x238
	.long	569                             # 0x239
	.long	570                             # 0x23a
	.long	571                             # 0x23b
	.long	572                             # 0x23c
	.long	573                             # 0x23d
	.long	574                             # 0x23e
	.long	575                             # 0x23f
.LCPI0_100:
	.long	1328                            # 0x530
	.long	1329                            # 0x531
	.long	1330                            # 0x532
	.long	1331                            # 0x533
	.long	1332                            # 0x534
	.long	1333                            # 0x535
	.long	1334                            # 0x536
	.long	1335                            # 0x537
	.long	1336                            # 0x538
	.long	1337                            # 0x539
	.long	1338                            # 0x53a
	.long	1339                            # 0x53b
	.long	1340                            # 0x53c
	.long	1341                            # 0x53d
	.long	1342                            # 0x53e
	.long	1343                            # 0x53f
.LCPI0_101:
	.long	304                             # 0x130
	.long	305                             # 0x131
	.long	306                             # 0x132
	.long	307                             # 0x133
	.long	308                             # 0x134
	.long	309                             # 0x135
	.long	310                             # 0x136
	.long	311                             # 0x137
	.long	312                             # 0x138
	.long	313                             # 0x139
	.long	314                             # 0x13a
	.long	315                             # 0x13b
	.long	316                             # 0x13c
	.long	317                             # 0x13d
	.long	318                             # 0x13e
	.long	319                             # 0x13f
.LCPI0_102:
	.long	1840                            # 0x730
	.long	1841                            # 0x731
	.long	1842                            # 0x732
	.long	1843                            # 0x733
	.long	1844                            # 0x734
	.long	1845                            # 0x735
	.long	1846                            # 0x736
	.long	1847                            # 0x737
	.long	1848                            # 0x738
	.long	1849                            # 0x739
	.long	1850                            # 0x73a
	.long	1851                            # 0x73b
	.long	1852                            # 0x73c
	.long	1853                            # 0x73d
	.long	1854                            # 0x73e
	.long	1855                            # 0x73f
.LCPI0_103:
	.long	816                             # 0x330
	.long	817                             # 0x331
	.long	818                             # 0x332
	.long	819                             # 0x333
	.long	820                             # 0x334
	.long	821                             # 0x335
	.long	822                             # 0x336
	.long	823                             # 0x337
	.long	824                             # 0x338
	.long	825                             # 0x339
	.long	826                             # 0x33a
	.long	827                             # 0x33b
	.long	828                             # 0x33c
	.long	829                             # 0x33d
	.long	830                             # 0x33e
	.long	831                             # 0x33f
.LCPI0_104:
	.long	1200                            # 0x4b0
	.long	1201                            # 0x4b1
	.long	1202                            # 0x4b2
	.long	1203                            # 0x4b3
	.long	1204                            # 0x4b4
	.long	1205                            # 0x4b5
	.long	1206                            # 0x4b6
	.long	1207                            # 0x4b7
	.long	1208                            # 0x4b8
	.long	1209                            # 0x4b9
	.long	1210                            # 0x4ba
	.long	1211                            # 0x4bb
	.long	1212                            # 0x4bc
	.long	1213                            # 0x4bd
	.long	1214                            # 0x4be
	.long	1215                            # 0x4bf
.LCPI0_105:
	.long	176                             # 0xb0
	.long	177                             # 0xb1
	.long	178                             # 0xb2
	.long	179                             # 0xb3
	.long	180                             # 0xb4
	.long	181                             # 0xb5
	.long	182                             # 0xb6
	.long	183                             # 0xb7
	.long	184                             # 0xb8
	.long	185                             # 0xb9
	.long	186                             # 0xba
	.long	187                             # 0xbb
	.long	188                             # 0xbc
	.long	189                             # 0xbd
	.long	190                             # 0xbe
	.long	191                             # 0xbf
.LCPI0_106:
	.long	1712                            # 0x6b0
	.long	1713                            # 0x6b1
	.long	1714                            # 0x6b2
	.long	1715                            # 0x6b3
	.long	1716                            # 0x6b4
	.long	1717                            # 0x6b5
	.long	1718                            # 0x6b6
	.long	1719                            # 0x6b7
	.long	1720                            # 0x6b8
	.long	1721                            # 0x6b9
	.long	1722                            # 0x6ba
	.long	1723                            # 0x6bb
	.long	1724                            # 0x6bc
	.long	1725                            # 0x6bd
	.long	1726                            # 0x6be
	.long	1727                            # 0x6bf
.LCPI0_107:
	.long	688                             # 0x2b0
	.long	689                             # 0x2b1
	.long	690                             # 0x2b2
	.long	691                             # 0x2b3
	.long	692                             # 0x2b4
	.long	693                             # 0x2b5
	.long	694                             # 0x2b6
	.long	695                             # 0x2b7
	.long	696                             # 0x2b8
	.long	697                             # 0x2b9
	.long	698                             # 0x2ba
	.long	699                             # 0x2bb
	.long	700                             # 0x2bc
	.long	701                             # 0x2bd
	.long	702                             # 0x2be
	.long	703                             # 0x2bf
.LCPI0_108:
	.long	1456                            # 0x5b0
	.long	1457                            # 0x5b1
	.long	1458                            # 0x5b2
	.long	1459                            # 0x5b3
	.long	1460                            # 0x5b4
	.long	1461                            # 0x5b5
	.long	1462                            # 0x5b6
	.long	1463                            # 0x5b7
	.long	1464                            # 0x5b8
	.long	1465                            # 0x5b9
	.long	1466                            # 0x5ba
	.long	1467                            # 0x5bb
	.long	1468                            # 0x5bc
	.long	1469                            # 0x5bd
	.long	1470                            # 0x5be
	.long	1471                            # 0x5bf
.LCPI0_109:
	.long	432                             # 0x1b0
	.long	433                             # 0x1b1
	.long	434                             # 0x1b2
	.long	435                             # 0x1b3
	.long	436                             # 0x1b4
	.long	437                             # 0x1b5
	.long	438                             # 0x1b6
	.long	439                             # 0x1b7
	.long	440                             # 0x1b8
	.long	441                             # 0x1b9
	.long	442                             # 0x1ba
	.long	443                             # 0x1bb
	.long	444                             # 0x1bc
	.long	445                             # 0x1bd
	.long	446                             # 0x1be
	.long	447                             # 0x1bf
.LCPI0_110:
	.long	1968                            # 0x7b0
	.long	1969                            # 0x7b1
	.long	1970                            # 0x7b2
	.long	1971                            # 0x7b3
	.long	1972                            # 0x7b4
	.long	1973                            # 0x7b5
	.long	1974                            # 0x7b6
	.long	1975                            # 0x7b7
	.long	1976                            # 0x7b8
	.long	1977                            # 0x7b9
	.long	1978                            # 0x7ba
	.long	1979                            # 0x7bb
	.long	1980                            # 0x7bc
	.long	1981                            # 0x7bd
	.long	1982                            # 0x7be
	.long	1983                            # 0x7bf
.LCPI0_111:
	.long	944                             # 0x3b0
	.long	945                             # 0x3b1
	.long	946                             # 0x3b2
	.long	947                             # 0x3b3
	.long	948                             # 0x3b4
	.long	949                             # 0x3b5
	.long	950                             # 0x3b6
	.long	951                             # 0x3b7
	.long	952                             # 0x3b8
	.long	953                             # 0x3b9
	.long	954                             # 0x3ba
	.long	955                             # 0x3bb
	.long	956                             # 0x3bc
	.long	957                             # 0x3bd
	.long	958                             # 0x3be
	.long	959                             # 0x3bf
.LCPI0_112:
	.long	1136                            # 0x470
	.long	1137                            # 0x471
	.long	1138                            # 0x472
	.long	1139                            # 0x473
	.long	1140                            # 0x474
	.long	1141                            # 0x475
	.long	1142                            # 0x476
	.long	1143                            # 0x477
	.long	1144                            # 0x478
	.long	1145                            # 0x479
	.long	1146                            # 0x47a
	.long	1147                            # 0x47b
	.long	1148                            # 0x47c
	.long	1149                            # 0x47d
	.long	1150                            # 0x47e
	.long	1151                            # 0x47f
.LCPI0_113:
	.long	112                             # 0x70
	.long	113                             # 0x71
	.long	114                             # 0x72
	.long	115                             # 0x73
	.long	116                             # 0x74
	.long	117                             # 0x75
	.long	118                             # 0x76
	.long	119                             # 0x77
	.long	120                             # 0x78
	.long	121                             # 0x79
	.long	122                             # 0x7a
	.long	123                             # 0x7b
	.long	124                             # 0x7c
	.long	125                             # 0x7d
	.long	126                             # 0x7e
	.long	127                             # 0x7f
.LCPI0_114:
	.long	1648                            # 0x670
	.long	1649                            # 0x671
	.long	1650                            # 0x672
	.long	1651                            # 0x673
	.long	1652                            # 0x674
	.long	1653                            # 0x675
	.long	1654                            # 0x676
	.long	1655                            # 0x677
	.long	1656                            # 0x678
	.long	1657                            # 0x679
	.long	1658                            # 0x67a
	.long	1659                            # 0x67b
	.long	1660                            # 0x67c
	.long	1661                            # 0x67d
	.long	1662                            # 0x67e
	.long	1663                            # 0x67f
.LCPI0_115:
	.long	624                             # 0x270
	.long	625                             # 0x271
	.long	626                             # 0x272
	.long	627                             # 0x273
	.long	628                             # 0x274
	.long	629                             # 0x275
	.long	630                             # 0x276
	.long	631                             # 0x277
	.long	632                             # 0x278
	.long	633                             # 0x279
	.long	634                             # 0x27a
	.long	635                             # 0x27b
	.long	636                             # 0x27c
	.long	637                             # 0x27d
	.long	638                             # 0x27e
	.long	639                             # 0x27f
.LCPI0_116:
	.long	1392                            # 0x570
	.long	1393                            # 0x571
	.long	1394                            # 0x572
	.long	1395                            # 0x573
	.long	1396                            # 0x574
	.long	1397                            # 0x575
	.long	1398                            # 0x576
	.long	1399                            # 0x577
	.long	1400                            # 0x578
	.long	1401                            # 0x579
	.long	1402                            # 0x57a
	.long	1403                            # 0x57b
	.long	1404                            # 0x57c
	.long	1405                            # 0x57d
	.long	1406                            # 0x57e
	.long	1407                            # 0x57f
.LCPI0_117:
	.long	368                             # 0x170
	.long	369                             # 0x171
	.long	370                             # 0x172
	.long	371                             # 0x173
	.long	372                             # 0x174
	.long	373                             # 0x175
	.long	374                             # 0x176
	.long	375                             # 0x177
	.long	376                             # 0x178
	.long	377                             # 0x179
	.long	378                             # 0x17a
	.long	379                             # 0x17b
	.long	380                             # 0x17c
	.long	381                             # 0x17d
	.long	382                             # 0x17e
	.long	383                             # 0x17f
.LCPI0_118:
	.long	1904                            # 0x770
	.long	1905                            # 0x771
	.long	1906                            # 0x772
	.long	1907                            # 0x773
	.long	1908                            # 0x774
	.long	1909                            # 0x775
	.long	1910                            # 0x776
	.long	1911                            # 0x777
	.long	1912                            # 0x778
	.long	1913                            # 0x779
	.long	1914                            # 0x77a
	.long	1915                            # 0x77b
	.long	1916                            # 0x77c
	.long	1917                            # 0x77d
	.long	1918                            # 0x77e
	.long	1919                            # 0x77f
.LCPI0_119:
	.long	880                             # 0x370
	.long	881                             # 0x371
	.long	882                             # 0x372
	.long	883                             # 0x373
	.long	884                             # 0x374
	.long	885                             # 0x375
	.long	886                             # 0x376
	.long	887                             # 0x377
	.long	888                             # 0x378
	.long	889                             # 0x379
	.long	890                             # 0x37a
	.long	891                             # 0x37b
	.long	892                             # 0x37c
	.long	893                             # 0x37d
	.long	894                             # 0x37e
	.long	895                             # 0x37f
.LCPI0_120:
	.long	1264                            # 0x4f0
	.long	1265                            # 0x4f1
	.long	1266                            # 0x4f2
	.long	1267                            # 0x4f3
	.long	1268                            # 0x4f4
	.long	1269                            # 0x4f5
	.long	1270                            # 0x4f6
	.long	1271                            # 0x4f7
	.long	1272                            # 0x4f8
	.long	1273                            # 0x4f9
	.long	1274                            # 0x4fa
	.long	1275                            # 0x4fb
	.long	1276                            # 0x4fc
	.long	1277                            # 0x4fd
	.long	1278                            # 0x4fe
	.long	1279                            # 0x4ff
.LCPI0_121:
	.long	240                             # 0xf0
	.long	241                             # 0xf1
	.long	242                             # 0xf2
	.long	243                             # 0xf3
	.long	244                             # 0xf4
	.long	245                             # 0xf5
	.long	246                             # 0xf6
	.long	247                             # 0xf7
	.long	248                             # 0xf8
	.long	249                             # 0xf9
	.long	250                             # 0xfa
	.long	251                             # 0xfb
	.long	252                             # 0xfc
	.long	253                             # 0xfd
	.long	254                             # 0xfe
	.long	255                             # 0xff
.LCPI0_122:
	.long	1776                            # 0x6f0
	.long	1777                            # 0x6f1
	.long	1778                            # 0x6f2
	.long	1779                            # 0x6f3
	.long	1780                            # 0x6f4
	.long	1781                            # 0x6f5
	.long	1782                            # 0x6f6
	.long	1783                            # 0x6f7
	.long	1784                            # 0x6f8
	.long	1785                            # 0x6f9
	.long	1786                            # 0x6fa
	.long	1787                            # 0x6fb
	.long	1788                            # 0x6fc
	.long	1789                            # 0x6fd
	.long	1790                            # 0x6fe
	.long	1791                            # 0x6ff
.LCPI0_123:
	.long	752                             # 0x2f0
	.long	753                             # 0x2f1
	.long	754                             # 0x2f2
	.long	755                             # 0x2f3
	.long	756                             # 0x2f4
	.long	757                             # 0x2f5
	.long	758                             # 0x2f6
	.long	759                             # 0x2f7
	.long	760                             # 0x2f8
	.long	761                             # 0x2f9
	.long	762                             # 0x2fa
	.long	763                             # 0x2fb
	.long	764                             # 0x2fc
	.long	765                             # 0x2fd
	.long	766                             # 0x2fe
	.long	767                             # 0x2ff
.LCPI0_124:
	.long	1520                            # 0x5f0
	.long	1521                            # 0x5f1
	.long	1522                            # 0x5f2
	.long	1523                            # 0x5f3
	.long	1524                            # 0x5f4
	.long	1525                            # 0x5f5
	.long	1526                            # 0x5f6
	.long	1527                            # 0x5f7
	.long	1528                            # 0x5f8
	.long	1529                            # 0x5f9
	.long	1530                            # 0x5fa
	.long	1531                            # 0x5fb
	.long	1532                            # 0x5fc
	.long	1533                            # 0x5fd
	.long	1534                            # 0x5fe
	.long	1535                            # 0x5ff
.LCPI0_125:
	.long	496                             # 0x1f0
	.long	497                             # 0x1f1
	.long	498                             # 0x1f2
	.long	499                             # 0x1f3
	.long	500                             # 0x1f4
	.long	501                             # 0x1f5
	.long	502                             # 0x1f6
	.long	503                             # 0x1f7
	.long	504                             # 0x1f8
	.long	505                             # 0x1f9
	.long	506                             # 0x1fa
	.long	507                             # 0x1fb
	.long	508                             # 0x1fc
	.long	509                             # 0x1fd
	.long	510                             # 0x1fe
	.long	511                             # 0x1ff
.LCPI0_126:
	.long	2032                            # 0x7f0
	.long	2033                            # 0x7f1
	.long	2034                            # 0x7f2
	.long	2035                            # 0x7f3
	.long	2036                            # 0x7f4
	.long	2037                            # 0x7f5
	.long	2038                            # 0x7f6
	.long	2039                            # 0x7f7
	.long	2040                            # 0x7f8
	.long	2041                            # 0x7f9
	.long	2042                            # 0x7fa
	.long	2043                            # 0x7fb
	.long	2044                            # 0x7fc
	.long	2045                            # 0x7fd
	.long	2046                            # 0x7fe
	.long	2047                            # 0x7ff
.LCPI0_127:
	.long	1008                            # 0x3f0
	.long	1009                            # 0x3f1
	.long	1010                            # 0x3f2
	.long	1011                            # 0x3f3
	.long	1012                            # 0x3f4
	.long	1013                            # 0x3f5
	.long	1014                            # 0x3f6
	.long	1015                            # 0x3f7
	.long	1016                            # 0x3f8
	.long	1017                            # 0x3f9
	.long	1018                            # 0x3fa
	.long	1019                            # 0x3fb
	.long	1020                            # 0x3fc
	.long	1021                            # 0x3fd
	.long	1022                            # 0x3fe
	.long	1023                            # 0x3ff
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI0_128:
	.long	0xff800000                      # float -Inf
	.text
	.globl	softmax_kernel
	.p2align	4
	.type	softmax_kernel,@function
softmax_kernel:                         # @softmax_kernel
.Lfunc_begin0:
	.file	1 "/root/triton/triton-cpu/./python/tutorials" "02-fused-softmax-cpu.py"
	.loc	1 76 0                          # 02-fused-softmax-cpu.py:76:0
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$10048, %rsp                    # imm = 0x2740
	.cfi_def_cfa_offset 10080
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movl	%r9d, %ebp
	movl	%ecx, %r14d
	movq	%rdi, %rbx
.Ltmp0:
	.loc	1 80 42 prologue_end            # 02-fused-softmax-cpu.py:80:42
	imull	%r9d, %edx
	.loc	1 80 32 is_stmt 0               # 02-fused-softmax-cpu.py:80:32
	movslq	%edx, %rax
	.loc	1 86 49 is_stmt 1               # 02-fused-softmax-cpu.py:86:49
	vpbroadcastd	%r8d, %zmm0
	vpcmpgtd	.LCPI0_120(%rip), %zmm0, %k1
	kmovw	%k1, (%rsp)                     # 2-byte Spill
	vpcmpgtd	.LCPI0_121(%rip), %zmm0, %k5
	kmovw	%k5, 252(%rsp)                  # 2-byte Spill
	vpcmpgtd	.LCPI0_122(%rip), %zmm0, %k7
	kmovw	%k7, 146(%rsp)                  # 2-byte Spill
	vpcmpgtd	.LCPI0_123(%rip), %zmm0, %k3
	kmovw	%k3, 232(%rsp)                  # 2-byte Spill
	vpcmpgtd	.LCPI0_124(%rip), %zmm0, %k6
	kmovw	%k6, 174(%rsp)                  # 2-byte Spill
	vpcmpgtd	.LCPI0_125(%rip), %zmm0, %k2
	kmovw	%k2, 244(%rsp)                  # 2-byte Spill
	vpcmpgtd	.LCPI0_126(%rip), %zmm0, %k1
	kmovw	%k1, 114(%rsp)                  # 2-byte Spill
	vpcmpgtd	.LCPI0_127(%rip), %zmm0, %k4
	kmovw	%k4, 216(%rsp)                  # 2-byte Spill
	.loc	1 86 18 is_stmt 0               # 02-fused-softmax-cpu.py:86:18
	vbroadcastss	.LCPI0_128(%rip), %zmm10 # zmm10 = [-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,-Inf]
	vblendmps	4032(%rsi,%rax,4), %zmm10, %zmm1 {%k4}
	vmovups	%zmm1, 5504(%rsp)               # 64-byte Spill
	vblendmps	8128(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5440(%rsp)               # 64-byte Spill
	vblendmps	1984(%rsi,%rax,4), %zmm10, %zmm1 {%k2}
	vmovups	%zmm1, 7488(%rsp)               # 64-byte Spill
	vblendmps	6080(%rsi,%rax,4), %zmm10, %zmm1 {%k6}
	vmovups	%zmm1, 5376(%rsp)               # 64-byte Spill
	vblendmps	3008(%rsi,%rax,4), %zmm10, %zmm1 {%k3}
	vmovups	%zmm1, 5312(%rsp)               # 64-byte Spill
	vblendmps	7104(%rsi,%rax,4), %zmm10, %zmm1 {%k7}
	vmovups	%zmm1, 5248(%rsp)               # 64-byte Spill
	vblendmps	960(%rsi,%rax,4), %zmm10, %zmm1 {%k5}
	vmovups	%zmm1, 7360(%rsp)               # 64-byte Spill
	kmovw	(%rsp), %k1                     # 2-byte Reload
	vblendmps	5056(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5184(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_119(%rip), %zmm0, %k1
	kmovw	%k1, 218(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3520(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5120(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_118(%rip), %zmm0, %k1
	kmovw	%k1, 116(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7616(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5056(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_117(%rip), %zmm0, %k1
	kmovw	%k1, 246(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1472(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4288(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_116(%rip), %zmm0, %k1
	kmovw	%k1, 176(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5568(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4992(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_115(%rip), %zmm0, %k1
	kmovw	%k1, 234(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2496(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4800(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_114(%rip), %zmm0, %k1
	kmovw	%k1, 148(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6592(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4736(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_113(%rip), %zmm0, %k1
	kmovw	%k1, 254(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	448(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4224(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_112(%rip), %zmm0, %k1
	kmovw	%k1, 198(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4544(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4544(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_111(%rip), %zmm0, %k1
	kmovw	%k1, 208(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3776(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5952(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_110(%rip), %zmm0, %k1
	kmovw	%k1, 98(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7872(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4928(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_109(%rip), %zmm0, %k1
	kmovw	%k1, 240(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1728(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4160(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_108(%rip), %zmm0, %k1
	kmovw	%k1, 162(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5824(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5696(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_107(%rip), %zmm0, %k1
	kmovw	%k1, 220(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2752(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4096(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_106(%rip), %zmm0, %k1
	kmovw	%k1, 118(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6848(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6016(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_105(%rip), %zmm0, %k1
	kmovw	%k1, 248(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	704(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4032(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_104(%rip), %zmm0, %k1
	kmovw	%k1, 178(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4800(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 5568(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_103(%rip), %zmm0, %k1
	kmovw	%k1, 210(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3264(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3904(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_102(%rip), %zmm0, %k1
	kmovw	%k1, 100(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7360(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6144(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_101(%rip), %zmm0, %k1
	kmovw	%k1, 242(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1216(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3840(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_100(%rip), %zmm0, %k1
	kmovw	%k1, 164(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5312(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 7744(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_99(%rip), %zmm0, %k1
	kmovw	%k1, 222(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2240(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3712(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_98(%rip), %zmm0, %k1
	kmovw	%k1, 120(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6336(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 7808(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_97(%rip), %zmm0, %k1
	kmovw	%k1, 250(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	192(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6912(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_96(%rip), %zmm0, %k1
	kmovw	%k1, 180(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4288(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3456(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_95(%rip), %zmm0, %k1
	kmovw	%k1, 190(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3904(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3200(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_94(%rip), %zmm0, %k1
	kmovw	%k1, 70(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	8000(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 4480(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_93(%rip), %zmm0, %k1
	kmovw	%k1, 224(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1856(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3072(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_92(%rip), %zmm0, %k1
	kmovw	%k1, 122(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5952(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3008(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_91(%rip), %zmm0, %k1
	kmovw	%k1, 204(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2880(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2944(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_90(%rip), %zmm0, %k1
	kmovw	%k1, 90(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6976(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2880(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_89(%rip), %zmm0, %k1
	kmovw	%k1, 236(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	832(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2752(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_88(%rip), %zmm0, %k1
	kmovw	%k1, 150(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4928(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2688(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_87(%rip), %zmm0, %k1
	kmovw	%k1, 192(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3392(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2368(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_86(%rip), %zmm0, %k1
	kmovw	%k1, 72(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7488(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2304(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_85(%rip), %zmm0, %k1
	kmovw	%k1, 226(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1344(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2240(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_84(%rip), %zmm0, %k1
	kmovw	%k1, 124(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5440(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2176(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_83(%rip), %zmm0, %k1
	kmovw	%k1, 206(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2368(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1856(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_82(%rip), %zmm0, %k1
	kmovw	%k1, 92(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6464(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1792(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_81(%rip), %zmm0, %k1
	kmovw	%k1, 238(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	320(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6528(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_80(%rip), %zmm0, %k1
	kmovw	%k1, 152(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4416(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1600(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_79(%rip), %zmm0, %k1
	kmovw	%k1, 170(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3648(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1472(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_78(%rip), %zmm0, %k1
	kmovw	%k1, 54(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7744(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1408(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_77(%rip), %zmm0, %k1
	kmovw	%k1, 212(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1600(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6336(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_76(%rip), %zmm0, %k1
	kmovw	%k1, 102(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5696(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1024(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_75(%rip), %zmm0, %k1
	kmovw	%k1, 194(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2624(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 960(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_74(%rip), %zmm0, %k1
	kmovw	%k1, 74(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6720(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 896(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_73(%rip), %zmm0, %k1
	kmovw	%k1, 228(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	576(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6400(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_72(%rip), %zmm0, %k1
	kmovw	%k1, 126(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4672(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 832(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_71(%rip), %zmm0, %k1
	kmovw	%k1, 172(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3136(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 768(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_70(%rip), %zmm0, %k1
	kmovw	%k1, 56(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7232(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 448(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_69(%rip), %zmm0, %k1
	kmovw	%k1, 214(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1088(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6464(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_68(%rip), %zmm0, %k1
	kmovw	%k1, 104(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5184(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 384(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_67(%rip), %zmm0, %k1
	kmovw	%k1, 196(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2112(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1344(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_66(%rip), %zmm0, %k1
	kmovw	%k1, 76(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6208(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 320(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_65(%rip), %zmm0, %k1
	kmovw	%k1, 230(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	64(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6656(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_64(%rip), %zmm0, %k1
	kmovw	%k1, 128(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4160(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 704(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_63(%rip), %zmm0, %k1
	kmovw	%k1, 130(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3968(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1280(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_62(%rip), %zmm0, %k1
	kmovw	%k1, 28(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	8064(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 256(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_61(%rip), %zmm0, %k1
	kmovw	%k1, 182(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1920(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2112(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_60(%rip), %zmm0, %k1
	kmovw	%k1, 62(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6016(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 640(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_59(%rip), %zmm0, %k1
	kmovw	%k1, 154(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2944(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1728(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_58(%rip), %zmm0, %k1
	kmovw	%k1, 42(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7040(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 512(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_57(%rip), %zmm0, %k1
	kmovw	%k1, 200(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	896(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2624(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_56(%rip), %zmm0, %k1
	kmovw	%k1, 86(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4992(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1216(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_55(%rip), %zmm0, %k1
	kmovw	%k1, 132(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3456(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6592(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_54(%rip), %zmm0, %k1
	kmovw	%k1, 30(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7552(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 576(%rsp)                # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_53(%rip), %zmm0, %k1
	kmovw	%k1, 184(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1408(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2816(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_52(%rip), %zmm0, %k1
	kmovw	%k1, 64(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5504(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1536(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_51(%rip), %zmm0, %k1
	kmovw	%k1, 156(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2432(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6720(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_50(%rip), %zmm0, %k1
	kmovw	%k1, 44(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6528(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1152(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_49(%rip), %zmm0, %k1
	kmovw	%k1, 202(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	384(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3392(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_48(%rip), %zmm0, %k1
	kmovw	%k1, 88(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4480(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2048(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_47(%rip), %zmm0, %k1
	kmovw	%k1, 106(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3712(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2560(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_46(%rip), %zmm0, %k1
	kmovw	%k1, 18(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7808(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1088(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_45(%rip), %zmm0, %k1
	kmovw	%k1, 166(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1664(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6848(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_44(%rip), %zmm0, %k1
	kmovw	%k1, 50(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5760(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1984(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_43(%rip), %zmm0, %k1
	kmovw	%k1, 134(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2688(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3136(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_42(%rip), %zmm0, %k1
	kmovw	%k1, 32(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6784(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1664(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_41(%rip), %zmm0, %k1
	kmovw	%k1, 186(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	640(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3648(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_40(%rip), %zmm0, %k1
	kmovw	%k1, 66(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4736(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2496(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_39(%rip), %zmm0, %k1
	kmovw	%k1, 108(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3200(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3328(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_38(%rip), %zmm0, %k1
	kmovw	%k1, 20(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7296(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 1920(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_37(%rip), %zmm0, %k1
	kmovw	%k1, 168(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1152(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3776(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_36(%rip), %zmm0, %k1
	kmovw	%k1, 52(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5248(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 6784(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_35(%rip), %zmm0, %k1
	kmovw	%k1, 136(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2176(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3584(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_34(%rip), %zmm0, %k1
	kmovw	%k1, 34(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6272(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 2432(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_33(%rip), %zmm0, %k1
	kmovw	%k1, 188(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	128(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3968(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_32(%rip), %zmm0, %k1
	kmovw	%k1, 68(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4224(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3264(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_31(%rip), %zmm0, %k1
	kmovw	%k1, 78(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3840(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 3520(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_30(%rip), %zmm0, %k1
	kmovw	%k1, 6(%rsp)                    # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7936(%rsi,%rax,4), %zmm10, %zmm31 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_29(%rip), %zmm0, %k1
	kmovw	%k1, 138(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1792(%rsi,%rax,4), %zmm10, %zmm30 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_28(%rip), %zmm0, %k1
	kmovw	%k1, 36(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5888(%rsi,%rax,4), %zmm10, %zmm29 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_27(%rip), %zmm0, %k1
	kmovw	%k1, 94(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2816(%rsi,%rax,4), %zmm10, %zmm28 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_26(%rip), %zmm0, %k1
	kmovw	%k1, 14(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6912(%rsi,%rax,4), %zmm10, %zmm27 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_25(%rip), %zmm0, %k1
	kmovw	%k1, 158(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	768(%rsi,%rax,4), %zmm10, %zmm26 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_24(%rip), %zmm0, %k1
	kmovw	%k1, 46(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4864(%rsi,%rax,4), %zmm10, %zmm25 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_23(%rip), %zmm0, %k1
	kmovw	%k1, 80(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3328(%rsi,%rax,4), %zmm10, %zmm24 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_22(%rip), %zmm0, %k1
	kmovw	%k1, 8(%rsp)                    # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7424(%rsi,%rax,4), %zmm10, %zmm23 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_21(%rip), %zmm0, %k1
	kmovw	%k1, 140(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1280(%rsi,%rax,4), %zmm10, %zmm21 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_20(%rip), %zmm0, %k1
	kmovw	%k1, 38(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5376(%rsi,%rax,4), %zmm10, %zmm22 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_19(%rip), %zmm0, %k1
	kmovw	%k1, 96(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2304(%rsi,%rax,4), %zmm10, %zmm20 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_18(%rip), %zmm0, %k1
	kmovw	%k1, 16(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6400(%rsi,%rax,4), %zmm10, %zmm19 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_17(%rip), %zmm0, %k1
	kmovw	%k1, 160(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	256(%rsi,%rax,4), %zmm10, %zmm18 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_16(%rip), %zmm0, %k1
	kmovw	%k1, 48(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4352(%rsi,%rax,4), %zmm10, %zmm17 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_15(%rip), %zmm0, %k1
	kmovw	%k1, 58(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3584(%rsi,%rax,4), %zmm10, %zmm16 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_14(%rip), %zmm0, %k1
	kmovw	%k1, 2(%rsp)                    # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7680(%rsi,%rax,4), %zmm10, %zmm15 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_13(%rip), %zmm0, %k1
	kmovw	%k1, 110(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1536(%rsi,%rax,4), %zmm10, %zmm14 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_12(%rip), %zmm0, %k1
	kmovw	%k1, 22(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5632(%rsi,%rax,4), %zmm10, %zmm13 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_11(%rip), %zmm0, %k1
	kmovw	%k1, 82(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2560(%rsi,%rax,4), %zmm10, %zmm12 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_10(%rip), %zmm0, %k1
	kmovw	%k1, 10(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6656(%rsi,%rax,4), %zmm10, %zmm11 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_9(%rip), %zmm0, %k1
	kmovw	%k1, 142(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	512(%rsi,%rax,4), %zmm10, %zmm9 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_8(%rip), %zmm0, %k1
	kmovw	%k1, 40(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	4608(%rsi,%rax,4), %zmm10, %zmm8 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_7(%rip), %zmm0, %k1
	kmovw	%k1, 60(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	3072(%rsi,%rax,4), %zmm10, %zmm7 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_6(%rip), %zmm0, %k1
	kmovw	%k1, 4(%rsp)                    # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	7168(%rsi,%rax,4), %zmm10, %zmm6 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_5(%rip), %zmm0, %k1
	kmovw	%k1, 112(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	1024(%rsi,%rax,4), %zmm10, %zmm5 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_4(%rip), %zmm0, %k1
	kmovw	%k1, 24(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	5120(%rsi,%rax,4), %zmm10, %zmm4 {%k1}
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_3(%rip), %zmm0, %k1
	kmovw	%k1, 84(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	2048(%rsi,%rax,4), %zmm10, %zmm3 {%k1}
	vmovups	%zmm3, 7232(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_2(%rip), %zmm0, %k1
	kmovw	%k1, 12(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	6144(%rsi,%rax,4), %zmm10, %zmm2 {%k1}
	vmovups	%zmm2, 5760(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_1(%rip), %zmm0, %k1
	kmovw	%k1, 144(%rsp)                  # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vblendmps	(%rsi,%rax,4), %zmm10, %zmm1 {%k1}
	vmovups	%zmm1, 7552(%rsp)               # 64-byte Spill
	.loc	1 86 49                         # 02-fused-softmax-cpu.py:86:49
	vpcmpgtd	.LCPI0_0(%rip), %zmm0, %k1
	kmovw	%k1, 26(%rsp)                   # 2-byte Spill
	.loc	1 86 18                         # 02-fused-softmax-cpu.py:86:18
	vmovups	4096(%rsi,%rax,4), %zmm10 {%k1}
.Ltmp1:
	.file	2 "/root/triton/triton-cpu/python/triton/language" "standard.py"
	.loc	2 184 40 is_stmt 1              # standard.py:184:40
	vmaxps	%zmm1, %zmm10, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm10, %zmm0 {%k1}
	vmaxps	%zmm3, %zmm2, %zmm1
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm2, %zmm1 {%k1}
	vmaxps	%zmm0, %zmm1, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm1, %zmm3 {%k1}
	vmovups	%zmm5, 7424(%rsp)               # 64-byte Spill
	vmovups	%zmm4, 4416(%rsp)               # 64-byte Spill
	vmaxps	%zmm5, %zmm4, %zmm2
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm4, %zmm2 {%k1}
	vmovups	%zmm7, 4864(%rsp)               # 64-byte Spill
	vmovups	%zmm6, 4352(%rsp)               # 64-byte Spill
	vmaxps	%zmm7, %zmm6, %zmm1
	vcmpunordps	%zmm7, %zmm7, %k1
	vmovaps	%zmm6, %zmm1 {%k1}
	vmaxps	%zmm2, %zmm1, %zmm0
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm1, %zmm0 {%k1}
	vmaxps	%zmm3, %zmm0, %zmm4
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm0, %zmm4 {%k1}
	vmovups	%zmm9, 7296(%rsp)               # 64-byte Spill
	vmovups	%zmm8, 8064(%rsp)               # 64-byte Spill
	vmaxps	%zmm9, %zmm8, %zmm0
	vcmpunordps	%zmm9, %zmm9, %k1
	vmovaps	%zmm8, %zmm0 {%k1}
	vmovups	%zmm12, 4608(%rsp)              # 64-byte Spill
	vmovups	%zmm11, 5632(%rsp)              # 64-byte Spill
	vmaxps	%zmm12, %zmm11, %zmm1
	vcmpunordps	%zmm12, %zmm12, %k1
	vmovaps	%zmm11, %zmm1 {%k1}
	vmaxps	%zmm0, %zmm1, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm1, %zmm3 {%k1}
	vmovups	%zmm14, 7104(%rsp)              # 64-byte Spill
	vmovups	%zmm13, 7936(%rsp)              # 64-byte Spill
	vmaxps	%zmm14, %zmm13, %zmm2
	vcmpunordps	%zmm14, %zmm14, %k1
	vmovaps	%zmm13, %zmm2 {%k1}
	vmovups	%zmm16, 5824(%rsp)              # 64-byte Spill
	vmovups	%zmm15, 4672(%rsp)              # 64-byte Spill
	vmaxps	%zmm16, %zmm15, %zmm1
	vcmpunordps	%zmm16, %zmm16, %k1
	vmovaps	%zmm15, %zmm1 {%k1}
	vmaxps	%zmm2, %zmm1, %zmm0
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm1, %zmm0 {%k1}
	vmaxps	%zmm3, %zmm0, %zmm2
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm0, %zmm2 {%k1}
	vmaxps	%zmm4, %zmm2, %zmm5
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm2, %zmm5 {%k1}
	vmovups	%zmm18, 7168(%rsp)              # 64-byte Spill
	vmovups	%zmm17, 9664(%rsp)              # 64-byte Spill
	vmaxps	%zmm18, %zmm17, %zmm0
	vcmpunordps	%zmm18, %zmm18, %k1
	vmovaps	%zmm17, %zmm0 {%k1}
	vmovups	%zmm20, 5888(%rsp)              # 64-byte Spill
	vmovups	%zmm19, 7872(%rsp)              # 64-byte Spill
	vmaxps	%zmm20, %zmm19, %zmm2
	vcmpunordps	%zmm20, %zmm20, %k1
	vmovaps	%zmm19, %zmm2 {%k1}
	vmaxps	%zmm0, %zmm2, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm2, %zmm3 {%k1}
	vmovups	%zmm21, 7040(%rsp)              # 64-byte Spill
	vmovups	%zmm22, 7680(%rsp)              # 64-byte Spill
	vmaxps	%zmm21, %zmm22, %zmm0
	vcmpunordps	%zmm21, %zmm21, %k1
	vmovaps	%zmm22, %zmm0 {%k1}
	vmovups	%zmm24, 9728(%rsp)              # 64-byte Spill
	vmovups	%zmm23, 6208(%rsp)              # 64-byte Spill
	vmaxps	%zmm24, %zmm23, %zmm2
	vcmpunordps	%zmm24, %zmm24, %k1
	vmovaps	%zmm23, %zmm2 {%k1}
	vmaxps	%zmm0, %zmm2, %zmm4
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm2, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm1
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm1 {%k1}
	vmovups	%zmm26, 8128(%rsp)              # 64-byte Spill
	vmovups	%zmm25, 9344(%rsp)              # 64-byte Spill
	vmaxps	%zmm26, %zmm25, %zmm2
	vcmpunordps	%zmm26, %zmm26, %k1
	vmovaps	%zmm25, %zmm2 {%k1}
	vmovups	%zmm28, 9536(%rsp)              # 64-byte Spill
	vmovups	%zmm27, 6080(%rsp)              # 64-byte Spill
	vmaxps	%zmm28, %zmm27, %zmm3
	vcmpunordps	%zmm28, %zmm28, %k1
	vmovaps	%zmm27, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm4
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmovups	%zmm30, 9792(%rsp)              # 64-byte Spill
	vmovups	%zmm29, 7616(%rsp)              # 64-byte Spill
	vmaxps	%zmm30, %zmm29, %zmm2
	vcmpunordps	%zmm30, %zmm30, %k1
	vmovaps	%zmm29, %zmm2 {%k1}
	vmovups	3520(%rsp), %zmm0               # 64-byte Reload
	vmovups	%zmm31, 6272(%rsp)              # 64-byte Spill
	vmaxps	%zmm0, %zmm31, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm31, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm0
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm0 {%k1}
	vmaxps	%zmm4, %zmm0, %zmm2
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm0, %zmm2 {%k1}
	vmaxps	%zmm1, %zmm2, %zmm3
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm2, %zmm3 {%k1}
	vmaxps	%zmm5, %zmm3, %zmm6
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm3, %zmm6 {%k1}
	vmovups	3968(%rsp), %zmm0               # 64-byte Reload
	vmovups	3264(%rsp), %zmm2               # 64-byte Reload
	vmaxps	%zmm0, %zmm2, %zmm1
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm2, %zmm1 {%k1}
	vmovups	3584(%rsp), %zmm0               # 64-byte Reload
	vmovups	2432(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm0, %zmm3, %zmm2
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm2 {%k1}
	vmaxps	%zmm1, %zmm2, %zmm3
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm2, %zmm3 {%k1}
	vmovups	3776(%rsp), %zmm0               # 64-byte Reload
	vmovups	6784(%rsp), %zmm2               # 64-byte Reload
	vmaxps	%zmm0, %zmm2, %zmm1
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm2, %zmm1 {%k1}
	vmovups	3328(%rsp), %zmm0               # 64-byte Reload
	vmovups	1920(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm0, %zmm4, %zmm2
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm2 {%k1}
	vmaxps	%zmm1, %zmm2, %zmm4
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm2, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm2
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm2 {%k1}
	vmovups	3648(%rsp), %zmm0               # 64-byte Reload
	vmovups	2496(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm0, %zmm3, %zmm1
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmovups	3136(%rsp), %zmm0               # 64-byte Reload
	vmovups	1664(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm0, %zmm4, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmaxps	%zmm1, %zmm3, %zmm4
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmovups	6848(%rsp), %zmm0               # 64-byte Reload
	vmovups	1984(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm0, %zmm3, %zmm1
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmovups	2560(%rsp), %zmm0               # 64-byte Reload
	vmovups	1088(%rsp), %zmm5               # 64-byte Reload
	vmaxps	%zmm0, %zmm5, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm5, %zmm3 {%k1}
	vmaxps	%zmm1, %zmm3, %zmm5
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm3
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm1
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmovups	3392(%rsp), %zmm0               # 64-byte Reload
	vmovups	2048(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm0, %zmm3, %zmm2
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm2 {%k1}
	vmovups	6720(%rsp), %zmm0               # 64-byte Reload
	vmovups	1152(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm0, %zmm4, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm4
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmovups	2816(%rsp), %zmm0               # 64-byte Reload
	vmovups	1536(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm0, %zmm3, %zmm2
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm2 {%k1}
	vmovups	6592(%rsp), %zmm5               # 64-byte Reload
	vmovups	576(%rsp), %zmm0                # 64-byte Reload
	vmaxps	%zmm5, %zmm0, %zmm3
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm0, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm5
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm2
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm2 {%k1}
	vmovups	2624(%rsp), %zmm0               # 64-byte Reload
	vmovups	1216(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm0, %zmm4, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmovups	1728(%rsp), %zmm0               # 64-byte Reload
	vmovups	512(%rsp), %zmm5                # 64-byte Reload
	vmaxps	%zmm0, %zmm5, %zmm4
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm5, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm5
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm5 {%k1}
	vmovups	2112(%rsp), %zmm0               # 64-byte Reload
	vmovups	640(%rsp), %zmm4                # 64-byte Reload
	vmaxps	%zmm0, %zmm4, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmovups	1280(%rsp), %zmm7               # 64-byte Reload
	vmovups	256(%rsp), %zmm0                # 64-byte Reload
	vmaxps	%zmm7, %zmm0, %zmm4
	vcmpunordps	%zmm7, %zmm7, %k1
	vmovaps	%zmm0, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm0
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm0 {%k1}
	vmaxps	%zmm5, %zmm0, %zmm3
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm0, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm0
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm0 {%k1}
	vmaxps	%zmm1, %zmm0, %zmm3
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm0, %zmm3 {%k1}
	vmaxps	%zmm6, %zmm3, %zmm7
	vcmpunordps	%zmm6, %zmm6, %k1
	vmovaps	%zmm3, %zmm7 {%k1}
	vmovups	6656(%rsp), %zmm1               # 64-byte Reload
	vmovups	704(%rsp), %zmm2                # 64-byte Reload
	vmaxps	%zmm1, %zmm2, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm2, %zmm0 {%k1}
	vmovups	1344(%rsp), %zmm2               # 64-byte Reload
	vmovups	320(%rsp), %zmm3                # 64-byte Reload
	vmaxps	%zmm2, %zmm3, %zmm1
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmaxps	%zmm0, %zmm1, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm1, %zmm3 {%k1}
	vmovups	6464(%rsp), %zmm1               # 64-byte Reload
	vmovups	384(%rsp), %zmm2                # 64-byte Reload
	vmaxps	%zmm1, %zmm2, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm2, %zmm0 {%k1}
	vmovups	768(%rsp), %zmm4                # 64-byte Reload
	vmovups	448(%rsp), %zmm2                # 64-byte Reload
	vmaxps	%zmm4, %zmm2, %zmm1
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm2, %zmm1 {%k1}
	vmaxps	%zmm0, %zmm1, %zmm4
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm1, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm1
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm1 {%k1}
	vmovups	6400(%rsp), %zmm2               # 64-byte Reload
	vmovups	832(%rsp), %zmm3                # 64-byte Reload
	vmaxps	%zmm2, %zmm3, %zmm0
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm0 {%k1}
	vmovups	960(%rsp), %zmm2                # 64-byte Reload
	vmovups	896(%rsp), %zmm4                # 64-byte Reload
	vmaxps	%zmm2, %zmm4, %zmm3
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmaxps	%zmm0, %zmm3, %zmm4
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmovups	6336(%rsp), %zmm2               # 64-byte Reload
	vmovups	1024(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm2, %zmm3, %zmm0
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm0 {%k1}
	vmovups	1472(%rsp), %zmm5               # 64-byte Reload
	vmovups	1408(%rsp), %zmm2               # 64-byte Reload
	vmaxps	%zmm5, %zmm2, %zmm3
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm2, %zmm3 {%k1}
	vmaxps	%zmm0, %zmm3, %zmm5
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm3
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm3 {%k1}
	vmaxps	%zmm1, %zmm3, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm0 {%k1}
	vmovups	6528(%rsp), %zmm2               # 64-byte Reload
	vmovups	1600(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm2, %zmm3, %zmm1
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmovups	1856(%rsp), %zmm2               # 64-byte Reload
	vmovups	1792(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm2, %zmm4, %zmm3
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmaxps	%zmm1, %zmm3, %zmm4
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmovups	2240(%rsp), %zmm2               # 64-byte Reload
	vmovups	2176(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm2, %zmm3, %zmm1
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmovups	2368(%rsp), %zmm5               # 64-byte Reload
	vmovups	2304(%rsp), %zmm2               # 64-byte Reload
	vmaxps	%zmm5, %zmm2, %zmm3
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm2, %zmm3 {%k1}
	vmaxps	%zmm1, %zmm3, %zmm5
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm1
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm1 {%k1}
	vmovups	2752(%rsp), %zmm2               # 64-byte Reload
	vmovups	2688(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm2, %zmm4, %zmm3
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmovups	2944(%rsp), %zmm2               # 64-byte Reload
	vmovups	2880(%rsp), %zmm5               # 64-byte Reload
	vmaxps	%zmm2, %zmm5, %zmm4
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm5, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm5
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm5 {%k1}
	vmovups	3072(%rsp), %zmm2               # 64-byte Reload
	vmovups	3008(%rsp), %zmm4               # 64-byte Reload
	vmaxps	%zmm2, %zmm4, %zmm3
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm4, %zmm3 {%k1}
	vmovups	3200(%rsp), %zmm2               # 64-byte Reload
	vmovups	4480(%rsp), %zmm25              # 64-byte Reload
	vmaxps	%zmm2, %zmm25, %zmm4
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm25, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm6
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm6 {%k1}
	vmaxps	%zmm5, %zmm6, %zmm3
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm6, %zmm3 {%k1}
	vmaxps	%zmm1, %zmm3, %zmm4
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmaxps	%zmm0, %zmm4, %zmm2
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm2 {%k1}
	vmovups	6912(%rsp), %zmm1               # 64-byte Reload
	vmovups	3456(%rsp), %zmm3               # 64-byte Reload
	vmaxps	%zmm1, %zmm3, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm3, %zmm0 {%k1}
	vmovups	3712(%rsp), %zmm1               # 64-byte Reload
	vmovups	7808(%rsp), %zmm26              # 64-byte Reload
	vmaxps	%zmm1, %zmm26, %zmm3
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm26, %zmm3 {%k1}
	vmaxps	%zmm0, %zmm3, %zmm4
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm4 {%k1}
	vmovups	3840(%rsp), %zmm1               # 64-byte Reload
	vmovups	7744(%rsp), %zmm31              # 64-byte Reload
	vmaxps	%zmm1, %zmm31, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm31, %zmm0 {%k1}
	vmovups	3904(%rsp), %zmm1               # 64-byte Reload
	vmovups	6144(%rsp), %zmm20              # 64-byte Reload
	vmaxps	%zmm1, %zmm20, %zmm3
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm20, %zmm3 {%k1}
	vmaxps	%zmm0, %zmm3, %zmm5
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm3, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm3
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm3 {%k1}
	vmovups	4032(%rsp), %zmm1               # 64-byte Reload
	vmovups	5568(%rsp), %zmm27              # 64-byte Reload
	vmaxps	%zmm1, %zmm27, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm27, %zmm0 {%k1}
	vmovups	4096(%rsp), %zmm1               # 64-byte Reload
	vmovups	6016(%rsp), %zmm19              # 64-byte Reload
	vmaxps	%zmm1, %zmm19, %zmm4
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm19, %zmm4 {%k1}
	vmaxps	%zmm0, %zmm4, %zmm5
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm5 {%k1}
	vmovups	4160(%rsp), %zmm1               # 64-byte Reload
	vmovups	5696(%rsp), %zmm21              # 64-byte Reload
	vmaxps	%zmm1, %zmm21, %zmm0
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm21, %zmm0 {%k1}
	vmovups	5952(%rsp), %zmm28              # 64-byte Reload
	vmovups	4928(%rsp), %zmm15              # 64-byte Reload
	vmaxps	%zmm28, %zmm15, %zmm4
	vcmpunordps	%zmm28, %zmm28, %k1
	vmovaps	%zmm15, %zmm4 {%k1}
	vmaxps	%zmm0, %zmm4, %zmm6
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm4, %zmm6 {%k1}
	vmaxps	%zmm5, %zmm6, %zmm4
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm6, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm1
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm1 {%k1}
	vmovups	4224(%rsp), %zmm0               # 64-byte Reload
	vmovups	4544(%rsp), %zmm22              # 64-byte Reload
	vmaxps	%zmm0, %zmm22, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm22, %zmm3 {%k1}
	vmovups	4800(%rsp), %zmm29              # 64-byte Reload
	vmovups	4736(%rsp), %zmm14              # 64-byte Reload
	vmaxps	%zmm29, %zmm14, %zmm4
	vcmpunordps	%zmm29, %zmm29, %k1
	vmovaps	%zmm14, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm5
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm5 {%k1}
	vmovups	4288(%rsp), %zmm0               # 64-byte Reload
	vmovups	4992(%rsp), %zmm17              # 64-byte Reload
	vmaxps	%zmm0, %zmm17, %zmm3
	vcmpunordps	%zmm0, %zmm0, %k1
	vmovaps	%zmm17, %zmm3 {%k1}
	vmovups	5120(%rsp), %zmm23              # 64-byte Reload
	vmovups	5056(%rsp), %zmm12              # 64-byte Reload
	vmaxps	%zmm23, %zmm12, %zmm4
	vcmpunordps	%zmm23, %zmm23, %k1
	vmovaps	%zmm12, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm6
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm6 {%k1}
	vmaxps	%zmm5, %zmm6, %zmm3
	vcmpunordps	%zmm5, %zmm5, %k1
	vmovaps	%zmm6, %zmm3 {%k1}
	vmovups	7360(%rsp), %zmm30              # 64-byte Reload
	vmovups	5184(%rsp), %zmm13              # 64-byte Reload
	vmaxps	%zmm30, %zmm13, %zmm4
	vcmpunordps	%zmm30, %zmm30, %k1
	vmovaps	%zmm13, %zmm4 {%k1}
	vmovups	5312(%rsp), %zmm18              # 64-byte Reload
	vmovups	5248(%rsp), %zmm11              # 64-byte Reload
	vmaxps	%zmm18, %zmm11, %zmm5
	vcmpunordps	%zmm18, %zmm18, %k1
	vmovaps	%zmm11, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm6
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm6 {%k1}
	vmovups	7488(%rsp), %zmm24              # 64-byte Reload
	vmovups	5376(%rsp), %zmm9               # 64-byte Reload
	vmaxps	%zmm24, %zmm9, %zmm4
	vcmpunordps	%zmm24, %zmm24, %k1
	vmovaps	%zmm9, %zmm4 {%k1}
	vmovups	5504(%rsp), %zmm16              # 64-byte Reload
	vmovups	5440(%rsp), %zmm8               # 64-byte Reload
	vmaxps	%zmm16, %zmm8, %zmm5
	vcmpunordps	%zmm16, %zmm16, %k1
	vmovaps	%zmm8, %zmm5 {%k1}
	vmaxps	%zmm4, %zmm5, %zmm0
	vcmpunordps	%zmm4, %zmm4, %k1
	vmovaps	%zmm5, %zmm0 {%k1}
	vmaxps	%zmm6, %zmm0, %zmm4
	vcmpunordps	%zmm6, %zmm6, %k1
	vmovaps	%zmm0, %zmm4 {%k1}
	vmaxps	%zmm3, %zmm4, %zmm0
	vcmpunordps	%zmm3, %zmm3, %k1
	vmovaps	%zmm4, %zmm0 {%k1}
	vmaxps	%zmm1, %zmm0, %zmm3
	vcmpunordps	%zmm1, %zmm1, %k1
	vmovaps	%zmm0, %zmm3 {%k1}
	vmaxps	%zmm2, %zmm3, %zmm1
	vcmpunordps	%zmm2, %zmm2, %k1
	vmovaps	%zmm3, %zmm1 {%k1}
	vmaxps	%zmm7, %zmm1, %zmm0
	vcmpunordps	%zmm7, %zmm7, %k1
	vmovaps	%zmm1, %zmm0 {%k1}
	vmovshdup	%xmm0, %xmm1            # xmm1 = xmm0[1,1,3,3]
	vmaxss	%xmm0, %xmm1, %xmm2
	vcmpunordss	%xmm0, %xmm0, %k1
	vmovss	%xmm1, %xmm2, %xmm2 {%k1}
	vshufpd	$1, %xmm0, %xmm0, %xmm1         # xmm1 = xmm0[1,0]
	vmaxss	%xmm2, %xmm1, %xmm3
	vcmpunordss	%xmm2, %xmm2, %k1
	vmovss	%xmm1, %xmm3, %xmm3 {%k1}
	vshufps	$255, %xmm0, %xmm0, %xmm1       # xmm1 = xmm0[3,3,3,3]
	vmaxss	%xmm3, %xmm1, %xmm2
	vcmpunordss	%xmm3, %xmm3, %k1
	vmovss	%xmm1, %xmm2, %xmm2 {%k1}
	vextractf128	$1, %ymm0, %xmm1
	vmaxss	%xmm2, %xmm1, %xmm3
	vcmpunordss	%xmm2, %xmm2, %k1
	vmovss	%xmm1, %xmm3, %xmm3 {%k1}
	vmovshdup	%xmm1, %xmm2            # xmm2 = xmm1[1,1,3,3]
	vmaxss	%xmm3, %xmm2, %xmm4
	vcmpunordss	%xmm3, %xmm3, %k1
	vmovss	%xmm2, %xmm4, %xmm4 {%k1}
	vshufpd	$1, %xmm1, %xmm1, %xmm2         # xmm2 = xmm1[1,0]
	vmaxss	%xmm4, %xmm2, %xmm3
	vcmpunordss	%xmm4, %xmm4, %k1
	vmovss	%xmm2, %xmm3, %xmm3 {%k1}
	vshufps	$255, %xmm1, %xmm1, %xmm1       # xmm1 = xmm1[3,3,3,3]
	vmaxss	%xmm3, %xmm1, %xmm2
	vcmpunordss	%xmm3, %xmm3, %k1
	vmovss	%xmm1, %xmm2, %xmm2 {%k1}
	vextractf32x4	$2, %zmm0, %xmm1
	vmaxss	%xmm2, %xmm1, %xmm3
	vcmpunordss	%xmm2, %xmm2, %k1
	vmovss	%xmm1, %xmm3, %xmm3 {%k1}
	vmovshdup	%xmm1, %xmm2            # xmm2 = xmm1[1,1,3,3]
	vmaxss	%xmm3, %xmm2, %xmm4
	vcmpunordss	%xmm3, %xmm3, %k1
	vmovss	%xmm2, %xmm4, %xmm4 {%k1}
	vshufpd	$1, %xmm1, %xmm1, %xmm2         # xmm2 = xmm1[1,0]
	vmaxss	%xmm4, %xmm2, %xmm3
	vcmpunordss	%xmm4, %xmm4, %k1
	vmovss	%xmm2, %xmm3, %xmm3 {%k1}
	vshufps	$255, %xmm1, %xmm1, %xmm1       # xmm1 = xmm1[3,3,3,3]
	vmaxss	%xmm3, %xmm1, %xmm2
	vcmpunordss	%xmm3, %xmm3, %k1
	vmovss	%xmm1, %xmm2, %xmm2 {%k1}
	vextractf32x4	$3, %zmm0, %xmm0
	vmaxss	%xmm2, %xmm0, %xmm1
	vcmpunordss	%xmm2, %xmm2, %k1
	vmovss	%xmm0, %xmm1, %xmm1 {%k1}
	vmovshdup	%xmm0, %xmm2            # xmm2 = xmm0[1,1,3,3]
	vmaxss	%xmm1, %xmm2, %xmm3
	vcmpunordss	%xmm1, %xmm1, %k1
	vmovss	%xmm2, %xmm3, %xmm3 {%k1}
	vshufpd	$1, %xmm0, %xmm0, %xmm1         # xmm1 = xmm0[1,0]
	vmaxss	%xmm3, %xmm1, %xmm2
	vcmpunordss	%xmm3, %xmm3, %k1
	vmovss	%xmm1, %xmm2, %xmm2 {%k1}
	vshufps	$255, %xmm0, %xmm0, %xmm0       # xmm0 = xmm0[3,3,3,3]
	vmaxss	%xmm2, %xmm0, %xmm1
	vcmpunordss	%xmm2, %xmm2, %k1
	vmovss	%xmm0, %xmm1, %xmm1 {%k1}
	vmaxss	.LCPI0_128(%rip), %xmm1, %xmm0
.Ltmp2:
	.loc	1 88 26                         # 02-fused-softmax-cpu.py:88:26
	vbroadcastss	%xmm0, %zmm0
	vsubps	%zmm0, %zmm8, %zmm1
	vmovups	%zmm1, 9984(%rsp)               # 64-byte Spill
	vmovups	256(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8704(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm25, %zmm1
	vmovups	%zmm1, 6976(%rsp)               # 64-byte Spill
	vmovups	6272(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 6272(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm15, %zmm1
	vmovups	%zmm1, 8640(%rsp)               # 64-byte Spill
	vmovups	1088(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8576(%rsp)               # 64-byte Spill
	vmovups	1408(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4480(%rsp)               # 64-byte Spill
	vmovups	4672(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8512(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm12, %zmm1
	vmovups	%zmm1, 8448(%rsp)               # 64-byte Spill
	vmovups	576(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8384(%rsp)               # 64-byte Spill
	vmovups	2304(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4672(%rsp)               # 64-byte Spill
	vmovups	6208(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 6208(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm20, %zmm1
	vmovups	%zmm1, 6144(%rsp)               # 64-byte Spill
	vmovups	1920(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8320(%rsp)               # 64-byte Spill
	vmovups	448(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4928(%rsp)               # 64-byte Spill
	vmovups	4352(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8256(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm11, %zmm1
	vmovups	%zmm1, 4352(%rsp)               # 64-byte Spill
	vmovups	512(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8192(%rsp)               # 64-byte Spill
	vmovups	2880(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5056(%rsp)               # 64-byte Spill
	vmovups	6080(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 6080(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm19, %zmm1
	vmovups	%zmm1, 6016(%rsp)               # 64-byte Spill
	vmovups	1664(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8000(%rsp)               # 64-byte Spill
	vmovups	896(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9920(%rsp)               # 64-byte Spill
	vmovups	5632(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5632(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm14, %zmm1
	vmovups	%zmm1, 4736(%rsp)               # 64-byte Spill
	vmovups	1152(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9856(%rsp)               # 64-byte Spill
	vmovups	1792(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9600(%rsp)               # 64-byte Spill
	vmovups	7872(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 7872(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm26, %zmm1
	vmovups	%zmm1, 7808(%rsp)               # 64-byte Spill
	vmovups	2432(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9472(%rsp)               # 64-byte Spill
	vmovups	320(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9408(%rsp)               # 64-byte Spill
	vmovups	5760(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5760(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm9, %zmm1
	vmovups	%zmm1, 9280(%rsp)               # 64-byte Spill
	vmovups	640(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9216(%rsp)               # 64-byte Spill
	vmovups	3008(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 448(%rsp)                # 64-byte Spill
	vmovups	7616(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 7616(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm21, %zmm1
	vmovups	%zmm1, 5696(%rsp)               # 64-byte Spill
	vmovups	1984(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9152(%rsp)               # 64-byte Spill
	vmovups	1024(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 9088(%rsp)               # 64-byte Spill
	vmovups	7936(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 7936(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm17, %zmm1
	vmovups	%zmm1, 9024(%rsp)               # 64-byte Spill
	vmovups	1536(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8960(%rsp)               # 64-byte Spill
	vmovups	2176(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8896(%rsp)               # 64-byte Spill
	vmovups	7680(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 7680(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm31, %zmm1
	vmovups	%zmm1, 7744(%rsp)               # 64-byte Spill
	vmovups	6784(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8832(%rsp)               # 64-byte Spill
	vmovups	384(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 8768(%rsp)               # 64-byte Spill
	vmovups	4416(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4416(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm13, %zmm1
	vmovups	%zmm1, 512(%rsp)                # 64-byte Spill
	vmovups	1216(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1216(%rsp)               # 64-byte Spill
	vmovups	2688(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1408(%rsp)               # 64-byte Spill
	vmovups	9344(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5248(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm27, %zmm1
	vmovups	%zmm1, 5440(%rsp)               # 64-byte Spill
	vmovups	2496(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5184(%rsp)               # 64-byte Spill
	vmovups	832(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5568(%rsp)               # 64-byte Spill
	vmovups	8064(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4992(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm22, %zmm1
	vmovups	%zmm1, 1024(%rsp)               # 64-byte Spill
	vmovups	2048(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4544(%rsp)               # 64-byte Spill
	vmovups	1600(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1792(%rsp)               # 64-byte Spill
	vmovups	9664(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1600(%rsp)               # 64-byte Spill
	vmovups	3456(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 896(%rsp)                # 64-byte Spill
	vmovups	3264(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 384(%rsp)                # 64-byte Spill
	vmovups	704(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2048(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm10, %zmm1
	vmovups	%zmm1, 704(%rsp)                # 64-byte Spill
	vsubps	%zmm0, %zmm16, %zmm1
	vmovups	%zmm1, 1536(%rsp)               # 64-byte Spill
	vmovups	1280(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5504(%rsp)               # 64-byte Spill
	vmovups	3200(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2176(%rsp)               # 64-byte Spill
	vmovups	3520(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5376(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm28, %zmm1
	vmovups	%zmm1, 1280(%rsp)               # 64-byte Spill
	vmovups	2560(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5952(%rsp)               # 64-byte Spill
	vmovups	1472(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2432(%rsp)               # 64-byte Spill
	vmovups	5824(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 576(%rsp)                # 64-byte Spill
	vsubps	%zmm0, %zmm23, %zmm1
	vmovups	%zmm1, 1984(%rsp)               # 64-byte Spill
	vmovups	6592(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 320(%rsp)                # 64-byte Spill
	vmovups	2368(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5120(%rsp)               # 64-byte Spill
	vmovups	9728(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1472(%rsp)               # 64-byte Spill
	vmovups	3904(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1664(%rsp)               # 64-byte Spill
	vmovups	3328(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 256(%rsp)                # 64-byte Spill
	vmovups	768(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 768(%rsp)                # 64-byte Spill
	vmovups	4864(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1088(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm18, %zmm1
	vmovups	%zmm1, 5312(%rsp)               # 64-byte Spill
	vmovups	1728(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 640(%rsp)                # 64-byte Spill
	vmovups	2944(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4864(%rsp)               # 64-byte Spill
	vmovups	9536(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5824(%rsp)               # 64-byte Spill
	vmovups	4096(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1920(%rsp)               # 64-byte Spill
	vmovups	3136(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 832(%rsp)                # 64-byte Spill
	vmovups	960(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2880(%rsp)               # 64-byte Spill
	vmovups	4608(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 960(%rsp)                # 64-byte Spill
	vsubps	%zmm0, %zmm29, %zmm1
	vmovups	%zmm1, 2688(%rsp)               # 64-byte Spill
	vmovups	6720(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1152(%rsp)               # 64-byte Spill
	vmovups	1856(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4800(%rsp)               # 64-byte Spill
	vmovups	5888(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4608(%rsp)               # 64-byte Spill
	vmovups	3712(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2560(%rsp)               # 64-byte Spill
	vmovups	3584(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 5888(%rsp)               # 64-byte Spill
	vmovups	1344(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3712(%rsp)               # 64-byte Spill
	vmovups	7232(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1728(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm24, %zmm1
	vmovups	%zmm1, 3200(%rsp)               # 64-byte Spill
	vmovups	2112(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2112(%rsp)               # 64-byte Spill
	vmovups	3072(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3072(%rsp)               # 64-byte Spill
	vmovups	9792(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2496(%rsp)               # 64-byte Spill
	vmovups	4160(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2944(%rsp)               # 64-byte Spill
	vmovups	6848(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 1344(%rsp)               # 64-byte Spill
	vmovups	6336(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3584(%rsp)               # 64-byte Spill
	vmovups	7104(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2304(%rsp)               # 64-byte Spill
	vmovups	4288(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3456(%rsp)               # 64-byte Spill
	vmovups	2816(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2816(%rsp)               # 64-byte Spill
	vmovups	2240(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4096(%rsp)               # 64-byte Spill
	vmovups	7040(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3136(%rsp)               # 64-byte Spill
	vmovups	3840(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3328(%rsp)               # 64-byte Spill
	vmovups	3776(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3776(%rsp)               # 64-byte Spill
	vmovups	6464(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3904(%rsp)               # 64-byte Spill
	vmovups	7424(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2240(%rsp)               # 64-byte Spill
	vsubps	%zmm0, %zmm30, %zmm1
	vmovups	%zmm1, 1856(%rsp)               # 64-byte Spill
	vmovups	2624(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2624(%rsp)               # 64-byte Spill
	vmovups	2752(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4160(%rsp)               # 64-byte Spill
	vmovups	8128(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3264(%rsp)               # 64-byte Spill
	vmovups	4032(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2752(%rsp)               # 64-byte Spill
	vmovups	3648(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3648(%rsp)               # 64-byte Spill
	vmovups	6400(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4032(%rsp)               # 64-byte Spill
	vmovups	7296(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3008(%rsp)               # 64-byte Spill
	vmovups	4224(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 2368(%rsp)               # 64-byte Spill
	vmovups	3392(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3392(%rsp)               # 64-byte Spill
	vmovups	6528(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4288(%rsp)               # 64-byte Spill
	vmovups	7168(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3520(%rsp)               # 64-byte Spill
	vmovups	6912(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3840(%rsp)               # 64-byte Spill
	vmovups	3968(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 3968(%rsp)               # 64-byte Spill
	vmovups	6656(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm1
	vmovups	%zmm1, 4224(%rsp)               # 64-byte Spill
	vmovups	7552(%rsp), %zmm1               # 64-byte Reload
	vsubps	%zmm0, %zmm1, %zmm0
	.loc	1 90 23                         # 02-fused-softmax-cpu.py:90:23
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6848(%rsp)               # 64-byte Spill
	vmovups	4224(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4224(%rsp)               # 64-byte Spill
	vmovups	3968(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6720(%rsp)               # 64-byte Spill
	vmovups	3840(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3840(%rsp)               # 64-byte Spill
	vmovups	3520(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3520(%rsp)               # 64-byte Spill
	vmovups	4288(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4288(%rsp)               # 64-byte Spill
	vmovups	3392(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6784(%rsp)               # 64-byte Spill
	vmovups	2368(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3968(%rsp)               # 64-byte Spill
	vmovups	3008(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3008(%rsp)               # 64-byte Spill
	vmovups	4032(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4032(%rsp)               # 64-byte Spill
	vmovups	3648(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6592(%rsp)               # 64-byte Spill
	vmovups	2752(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3392(%rsp)               # 64-byte Spill
	vmovups	3264(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3264(%rsp)               # 64-byte Spill
	vmovups	4160(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4160(%rsp)               # 64-byte Spill
	vmovups	2624(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2368(%rsp)               # 64-byte Spill
	vmovups	1856(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3648(%rsp)               # 64-byte Spill
	vmovups	2240(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2752(%rsp)               # 64-byte Spill
	vmovups	3904(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3904(%rsp)               # 64-byte Spill
	vmovups	3776(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1856(%rsp)               # 64-byte Spill
	vmovups	3328(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3328(%rsp)               # 64-byte Spill
	vmovups	3136(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3136(%rsp)               # 64-byte Spill
	vmovups	4096(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4096(%rsp)               # 64-byte Spill
	vmovups	2816(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6656(%rsp)               # 64-byte Spill
	vmovups	3456(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3456(%rsp)               # 64-byte Spill
	vmovups	2304(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2304(%rsp)               # 64-byte Spill
	vmovups	3584(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3584(%rsp)               # 64-byte Spill
	vmovups	1344(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6400(%rsp)               # 64-byte Spill
	vmovups	2944(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2944(%rsp)               # 64-byte Spill
	vmovups	2496(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2496(%rsp)               # 64-byte Spill
	vmovups	3072(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3776(%rsp)               # 64-byte Spill
	vmovups	2112(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6528(%rsp)               # 64-byte Spill
	vmovups	3200(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3200(%rsp)               # 64-byte Spill
	vmovups	1728(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1728(%rsp)               # 64-byte Spill
	vmovups	3712(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3712(%rsp)               # 64-byte Spill
	vmovups	5888(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6336(%rsp)               # 64-byte Spill
	vmovups	2560(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2560(%rsp)               # 64-byte Spill
	vmovups	4608(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2112(%rsp)               # 64-byte Spill
	vmovups	4800(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6912(%rsp)               # 64-byte Spill
	vmovups	1152(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1152(%rsp)               # 64-byte Spill
	vmovups	2688(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2688(%rsp)               # 64-byte Spill
	vmovups	960(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1344(%rsp)               # 64-byte Spill
	vmovups	2880(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2880(%rsp)               # 64-byte Spill
	vmovups	832(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 832(%rsp)                # 64-byte Spill
	vmovups	1920(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1920(%rsp)               # 64-byte Spill
	vmovups	5824(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6464(%rsp)               # 64-byte Spill
	vmovups	4864(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 3072(%rsp)               # 64-byte Spill
	vmovups	640(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 640(%rsp)                # 64-byte Spill
	vmovups	5312(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2240(%rsp)               # 64-byte Spill
	vmovups	1088(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1088(%rsp)               # 64-byte Spill
	vmovups	768(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2816(%rsp)               # 64-byte Spill
	vmovups	256(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 256(%rsp)                # 64-byte Spill
	vmovups	1664(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1664(%rsp)               # 64-byte Spill
	vmovups	1472(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1472(%rsp)               # 64-byte Spill
	vmovups	5120(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2624(%rsp)               # 64-byte Spill
	vmovups	320(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 320(%rsp)                # 64-byte Spill
	vmovups	1984(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1984(%rsp)               # 64-byte Spill
	vmovups	576(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 576(%rsp)                # 64-byte Spill
	vmovups	2432(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2432(%rsp)               # 64-byte Spill
	vmovups	5952(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7488(%rsp)               # 64-byte Spill
	vmovups	1280(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1280(%rsp)               # 64-byte Spill
	vmovups	5376(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 768(%rsp)                # 64-byte Spill
	vmovups	2176(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2176(%rsp)               # 64-byte Spill
	vmovups	5504(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7360(%rsp)               # 64-byte Spill
	vmovups	1536(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1536(%rsp)               # 64-byte Spill
	vmovups	704(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5376(%rsp)               # 64-byte Spill
	vmovups	2048(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 2048(%rsp)               # 64-byte Spill
	vmovups	384(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7296(%rsp)               # 64-byte Spill
	vmovups	896(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 896(%rsp)                # 64-byte Spill
	vmovups	1600(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 384(%rsp)                # 64-byte Spill
	vmovups	1792(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1792(%rsp)               # 64-byte Spill
	vmovups	4544(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7168(%rsp)               # 64-byte Spill
	vmovups	1024(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1024(%rsp)               # 64-byte Spill
	vmovups	4992(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4992(%rsp)               # 64-byte Spill
	vmovups	5568(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1600(%rsp)               # 64-byte Spill
	vmovups	5184(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5952(%rsp)               # 64-byte Spill
	vmovups	5440(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5440(%rsp)               # 64-byte Spill
	vmovups	5248(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5248(%rsp)               # 64-byte Spill
	vmovups	1408(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1408(%rsp)               # 64-byte Spill
	vmovups	1216(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4800(%rsp)               # 64-byte Spill
	vmovups	512(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 512(%rsp)                # 64-byte Spill
	vmovups	4416(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4864(%rsp)               # 64-byte Spill
	vmovups	8768(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 1216(%rsp)               # 64-byte Spill
	vmovups	8832(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8128(%rsp)               # 64-byte Spill
	vmovups	7744(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5312(%rsp)               # 64-byte Spill
	vmovups	7680(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5120(%rsp)               # 64-byte Spill
	vmovups	8896(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 960(%rsp)                # 64-byte Spill
	vmovups	8960(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4416(%rsp)               # 64-byte Spill
	vmovups	9024(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5504(%rsp)               # 64-byte Spill
	vmovups	7936(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7040(%rsp)               # 64-byte Spill
	vmovups	9088(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 704(%rsp)                # 64-byte Spill
	vmovups	9152(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5888(%rsp)               # 64-byte Spill
	vmovups	5696(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7104(%rsp)               # 64-byte Spill
	vmovups	7616(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4544(%rsp)               # 64-byte Spill
	vmovups	448(%rsp), %zmm0                # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 448(%rsp)                # 64-byte Spill
	vmovups	9216(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5824(%rsp)               # 64-byte Spill
	vmovups	9280(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7232(%rsp)               # 64-byte Spill
	vmovups	5760(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5760(%rsp)               # 64-byte Spill
	vmovups	9408(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7552(%rsp)               # 64-byte Spill
	vmovups	9472(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8064(%rsp)               # 64-byte Spill
	vmovups	7808(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4608(%rsp)               # 64-byte Spill
	vmovups	7872(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5568(%rsp)               # 64-byte Spill
	vmovups	9600(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 7424(%rsp)               # 64-byte Spill
	vmovups	9856(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5696(%rsp)               # 64-byte Spill
	vmovups	4736(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4736(%rsp)               # 64-byte Spill
	vmovups	5632(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5632(%rsp)               # 64-byte Spill
	vmovups	9920(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5184(%rsp)               # 64-byte Spill
	vmovups	8000(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8000(%rsp)               # 64-byte Spill
	vmovups	6016(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6016(%rsp)               # 64-byte Spill
	vmovups	6080(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6080(%rsp)               # 64-byte Spill
	vmovups	5056(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 5056(%rsp)               # 64-byte Spill
	vmovups	8192(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8192(%rsp)               # 64-byte Spill
	vmovups	4352(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4352(%rsp)               # 64-byte Spill
	vmovups	8256(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8256(%rsp)               # 64-byte Spill
	vmovups	4928(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4928(%rsp)               # 64-byte Spill
	vmovups	8320(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8320(%rsp)               # 64-byte Spill
	vmovups	6144(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6144(%rsp)               # 64-byte Spill
	vmovups	6208(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6208(%rsp)               # 64-byte Spill
	vmovups	4672(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4672(%rsp)               # 64-byte Spill
	vmovups	8384(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8384(%rsp)               # 64-byte Spill
	vmovups	8448(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8448(%rsp)               # 64-byte Spill
	vmovups	8512(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8512(%rsp)               # 64-byte Spill
	vmovups	4480(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 4480(%rsp)               # 64-byte Spill
	vmovups	8576(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8576(%rsp)               # 64-byte Spill
	vmovups	8640(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8640(%rsp)               # 64-byte Spill
	vmovups	6272(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6272(%rsp)               # 64-byte Spill
	vmovups	6976(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 6976(%rsp)               # 64-byte Spill
	vmovups	8704(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	%zmm0, 8704(%rsp)               # 64-byte Spill
	vmovups	9984(%rsp), %zmm0               # 64-byte Reload
	callq	Sleef_expf16_u10@PLT
	vmovups	960(%rsp), %zmm1                # 64-byte Reload
.Ltmp3:
	.loc	2 267 36                        # standard.py:267:36
	vaddps	4096(%rsp), %zmm1, %zmm1        # 64-byte Folded Reload
	vmovups	4672(%rsp), %zmm2               # 64-byte Reload
	vaddps	2624(%rsp), %zmm2, %zmm2        # 64-byte Folded Reload
	vaddps	%zmm2, %zmm1, %zmm1
	vmovups	1792(%rsp), %zmm2               # 64-byte Reload
	vaddps	4288(%rsp), %zmm2, %zmm2        # 64-byte Folded Reload
	vmovups	7424(%rsp), %zmm3               # 64-byte Reload
	vaddps	6912(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vaddps	%zmm3, %zmm2, %zmm2
	vaddps	%zmm1, %zmm2, %zmm1
	vmovups	448(%rsp), %zmm2                # 64-byte Reload
	vaddps	3776(%rsp), %zmm2, %zmm2        # 64-byte Folded Reload
	vmovups	6976(%rsp), %zmm3               # 64-byte Reload
	vaddps	2176(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	1408(%rsp), %zmm3               # 64-byte Reload
	vaddps	4160(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	5056(%rsp), %zmm4               # 64-byte Reload
	vaddps	3072(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vaddps	%zmm2, %zmm3, %zmm2
	vaddps	%zmm2, %zmm1, %zmm1
	vmovups	1216(%rsp), %zmm2               # 64-byte Reload
	vaddps	3904(%rsp), %zmm2, %zmm2        # 64-byte Folded Reload
	vmovups	4928(%rsp), %zmm3               # 64-byte Reload
	vaddps	2816(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	2048(%rsp), %zmm3               # 64-byte Reload
	vaddps	4224(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	7552(%rsp), %zmm4               # 64-byte Reload
	vaddps	3712(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vaddps	%zmm2, %zmm3, %zmm2
	vmovups	704(%rsp), %zmm3                # 64-byte Reload
	vaddps	3584(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	4480(%rsp), %zmm4               # 64-byte Reload
	vaddps	2432(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	1600(%rsp), %zmm4               # 64-byte Reload
	vaddps	4032(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	5184(%rsp), %zmm5               # 64-byte Reload
	vaddps	2880(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vaddps	%zmm3, %zmm2, %zmm2
	vaddps	%zmm1, %zmm2, %zmm1
	vmovups	5504(%rsp), %zmm2               # 64-byte Reload
	vaddps	3456(%rsp), %zmm2, %zmm2        # 64-byte Folded Reload
	vmovups	8448(%rsp), %zmm29              # 64-byte Reload
	vaddps	1984(%rsp), %zmm29, %zmm3       # 64-byte Folded Reload
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	1024(%rsp), %zmm3               # 64-byte Reload
	vaddps	3968(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	4736(%rsp), %zmm4               # 64-byte Reload
	vaddps	2688(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vaddps	%zmm2, %zmm3, %zmm2
	vmovups	7232(%rsp), %zmm3               # 64-byte Reload
	vaddps	3200(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vaddps	1536(%rsp), %zmm0, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	512(%rsp), %zmm4                # 64-byte Reload
	vaddps	3648(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	4352(%rsp), %zmm5               # 64-byte Reload
	vaddps	2240(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	5312(%rsp), %zmm3               # 64-byte Reload
	vaddps	3328(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	6144(%rsp), %zmm25              # 64-byte Reload
	vaddps	1664(%rsp), %zmm25, %zmm4       # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	896(%rsp), %zmm4                # 64-byte Reload
	vaddps	3840(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	4608(%rsp), %zmm5               # 64-byte Reload
	vaddps	2560(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vmovups	7104(%rsp), %zmm4               # 64-byte Reload
	vaddps	2944(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	8640(%rsp), %zmm17              # 64-byte Reload
	vaddps	1280(%rsp), %zmm17, %zmm5       # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vmovups	5440(%rsp), %zmm5               # 64-byte Reload
	vaddps	3392(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vmovups	6016(%rsp), %zmm28              # 64-byte Reload
	vaddps	1920(%rsp), %zmm28, %zmm6       # 64-byte Folded Reload
	vaddps	%zmm6, %zmm5, %zmm5
	vaddps	%zmm4, %zmm5, %zmm4
	vaddps	%zmm4, %zmm3, %zmm3
	vaddps	%zmm2, %zmm3, %zmm2
	vaddps	%zmm2, %zmm1, %zmm1
	vmovups	5120(%rsp), %zmm2               # 64-byte Reload
	vaddps	3136(%rsp), %zmm2, %zmm2        # 64-byte Folded Reload
	vmovups	6208(%rsp), %zmm21              # 64-byte Reload
	vaddps	1472(%rsp), %zmm21, %zmm3       # 64-byte Folded Reload
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	384(%rsp), %zmm3                # 64-byte Reload
	vaddps	3520(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	5568(%rsp), %zmm30              # 64-byte Reload
	vaddps	2112(%rsp), %zmm30, %zmm4       # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vaddps	%zmm2, %zmm3, %zmm2
	vmovups	4544(%rsp), %zmm3               # 64-byte Reload
	vaddps	2496(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	6272(%rsp), %zmm15              # 64-byte Reload
	vaddps	768(%rsp), %zmm15, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	5248(%rsp), %zmm4               # 64-byte Reload
	vaddps	3264(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	6080(%rsp), %zmm23              # 64-byte Reload
	vaddps	6464(%rsp), %zmm23, %zmm5       # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	4864(%rsp), %zmm3               # 64-byte Reload
	vaddps	2752(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	8256(%rsp), %zmm18              # 64-byte Reload
	vaddps	1088(%rsp), %zmm18, %zmm4       # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	5376(%rsp), %zmm4               # 64-byte Reload
	vaddps	6848(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	5760(%rsp), %zmm26              # 64-byte Reload
	vaddps	1728(%rsp), %zmm26, %zmm5       # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vmovups	7040(%rsp), %zmm4               # 64-byte Reload
	vaddps	2304(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	8512(%rsp), %zmm13              # 64-byte Reload
	vaddps	576(%rsp), %zmm13, %zmm5        # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vmovups	4992(%rsp), %zmm5               # 64-byte Reload
	vaddps	3008(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vmovups	5632(%rsp), %zmm20              # 64-byte Reload
	vaddps	1344(%rsp), %zmm20, %zmm6       # 64-byte Folded Reload
	vaddps	%zmm6, %zmm5, %zmm5
	vaddps	%zmm4, %zmm5, %zmm4
	vaddps	%zmm4, %zmm3, %zmm3
	vaddps	%zmm2, %zmm3, %zmm2
	vmovups	4416(%rsp), %zmm3               # 64-byte Reload
	vaddps	6656(%rsp), %zmm3, %zmm3        # 64-byte Folded Reload
	vmovups	8384(%rsp), %zmm11              # 64-byte Reload
	vaddps	320(%rsp), %zmm11, %zmm4        # 64-byte Folded Reload
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	7168(%rsp), %zmm4               # 64-byte Reload
	vaddps	6784(%rsp), %zmm4, %zmm4        # 64-byte Folded Reload
	vmovups	5696(%rsp), %zmm19              # 64-byte Reload
	vaddps	1152(%rsp), %zmm19, %zmm5       # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vmovups	5824(%rsp), %zmm24              # 64-byte Reload
	vaddps	6528(%rsp), %zmm24, %zmm4       # 64-byte Folded Reload
	vmovups	8704(%rsp), %zmm9               # 64-byte Reload
	vaddps	7360(%rsp), %zmm9, %zmm5        # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vmovups	4800(%rsp), %zmm5               # 64-byte Reload
	vaddps	2368(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vmovups	8192(%rsp), %zmm14              # 64-byte Reload
	vaddps	640(%rsp), %zmm14, %zmm6        # 64-byte Folded Reload
	vaddps	%zmm6, %zmm5, %zmm5
	vaddps	%zmm4, %zmm5, %zmm4
	vaddps	%zmm4, %zmm3, %zmm3
	vmovups	8128(%rsp), %zmm27              # 64-byte Reload
	vaddps	1856(%rsp), %zmm27, %zmm4       # 64-byte Folded Reload
	vmovups	8320(%rsp), %zmm10              # 64-byte Reload
	vaddps	256(%rsp), %zmm10, %zmm5        # 64-byte Folded Reload
	vaddps	%zmm5, %zmm4, %zmm4
	vmovups	7296(%rsp), %zmm5               # 64-byte Reload
	vaddps	6720(%rsp), %zmm5, %zmm5        # 64-byte Folded Reload
	vmovups	8064(%rsp), %zmm16              # 64-byte Reload
	vaddps	6336(%rsp), %zmm16, %zmm6       # 64-byte Folded Reload
	vaddps	%zmm6, %zmm5, %zmm5
	vaddps	%zmm4, %zmm5, %zmm4
	vmovups	5888(%rsp), %zmm22              # 64-byte Reload
	vaddps	6400(%rsp), %zmm22, %zmm5       # 64-byte Folded Reload
	vmovups	8576(%rsp), %zmm8               # 64-byte Reload
	vaddps	7488(%rsp), %zmm8, %zmm6        # 64-byte Folded Reload
	vaddps	%zmm6, %zmm5, %zmm5
	vmovups	5952(%rsp), %zmm31              # 64-byte Reload
	vaddps	6592(%rsp), %zmm31, %zmm6       # 64-byte Folded Reload
	vmovups	8000(%rsp), %zmm12              # 64-byte Reload
	vaddps	832(%rsp), %zmm12, %zmm7        # 64-byte Folded Reload
	vaddps	%zmm7, %zmm6, %zmm6
	vaddps	%zmm5, %zmm6, %zmm5
	vaddps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm3, %zmm4, %zmm3
	vaddps	%zmm3, %zmm2, %zmm2
	vaddps	%zmm1, %zmm2, %zmm1
	vextractf64x4	$1, %zmm1, %ymm2
	vaddps	%zmm2, %zmm1, %zmm1
	vextractf128	$1, %ymm1, %xmm2
	vaddps	%xmm2, %xmm1, %xmm1
	vshufpd	$1, %xmm1, %xmm1, %xmm2         # xmm2 = xmm1[1,0]
	vaddps	%xmm2, %xmm1, %xmm1
	vmovshdup	%xmm1, %xmm2            # xmm2 = xmm1[1,1,3,3]
	vaddss	%xmm2, %xmm1, %xmm1
	vxorps	%xmm2, %xmm2, %xmm2
	vaddss	%xmm2, %xmm1, %xmm1
.Ltmp4:
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vbroadcastss	%xmm1, %zmm1
	vdivps	%zmm1, %zmm0, %zmm0
	.loc	1 94 50                         # 02-fused-softmax-cpu.py:94:50
	imull	%ebp, %r14d
	.loc	1 94 40 is_stmt 0               # 02-fused-softmax-cpu.py:94:40
	movslq	%r14d, %rax
	kmovw	114(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26 is_stmt 1               # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 8128(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm9, %zmm0
	kmovw	28(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 8064(%rbx,%rax,4) {%k1}
	vmovups	6976(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	70(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 8000(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm15, %zmm0
	kmovw	6(%rsp), %k1                    # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7936(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm17, %zmm0
	kmovw	98(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7872(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm8, %zmm0
	kmovw	18(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7808(%rbx,%rax,4) {%k1}
	vmovups	4480(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	54(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7744(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm13, %zmm0
	kmovw	2(%rsp), %k1                    # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7680(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm29, %zmm0
	kmovw	116(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7616(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm11, %zmm0
	kmovw	30(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7552(%rbx,%rax,4) {%k1}
	vmovups	4672(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	72(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7488(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm21, %zmm0
	kmovw	8(%rsp), %k1                    # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7424(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm25, %zmm0
	kmovw	100(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7360(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm10, %zmm0
	kmovw	20(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7296(%rbx,%rax,4) {%k1}
	vmovups	4928(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	56(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7232(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm18, %zmm0
	kmovw	4(%rsp), %k1                    # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7168(%rbx,%rax,4) {%k1}
	vmovups	4352(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	146(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7104(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm14, %zmm0
	kmovw	42(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 7040(%rbx,%rax,4) {%k1}
	vmovups	5056(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	90(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6976(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm23, %zmm0
	kmovw	14(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6912(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm28, %zmm0
	kmovw	118(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6848(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm12, %zmm0
	kmovw	32(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6784(%rbx,%rax,4) {%k1}
	vmovups	5184(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	74(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6720(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm20, %zmm0
	kmovw	10(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6656(%rbx,%rax,4) {%k1}
	vmovups	4736(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	148(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6592(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm19, %zmm0
	kmovw	44(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6528(%rbx,%rax,4) {%k1}
	vmovups	7424(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	92(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6464(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm30, %zmm0
	kmovw	16(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6400(%rbx,%rax,4) {%k1}
	vmovups	4608(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	120(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6336(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm16, %zmm0
	kmovw	34(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6272(%rbx,%rax,4) {%k1}
	vmovups	7552(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	76(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6208(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm26, %zmm0
	kmovw	12(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6144(%rbx,%rax,4) {%k1}
	vmovups	7232(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	174(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6080(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm24, %zmm0
	kmovw	62(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 6016(%rbx,%rax,4) {%k1}
	vmovups	448(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	122(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5952(%rbx,%rax,4) {%k1}
	vmovups	4544(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	36(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5888(%rbx,%rax,4) {%k1}
	vmovups	7104(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	162(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5824(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm22, %zmm0
	kmovw	50(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5760(%rbx,%rax,4) {%k1}
	vmovups	704(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	102(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5696(%rbx,%rax,4) {%k1}
	vmovups	7040(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	22(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5632(%rbx,%rax,4) {%k1}
	vmovups	5504(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	176(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5568(%rbx,%rax,4) {%k1}
	vmovups	4416(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	64(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5504(%rbx,%rax,4) {%k1}
	vmovups	960(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	124(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5440(%rbx,%rax,4) {%k1}
	vmovups	5120(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	38(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5376(%rbx,%rax,4) {%k1}
	vmovups	5312(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	164(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5312(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm27, %zmm0
	kmovw	52(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5248(%rbx,%rax,4) {%k1}
	vmovups	1216(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	104(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5184(%rbx,%rax,4) {%k1}
	vmovups	4864(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	24(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5120(%rbx,%rax,4) {%k1}
	vmovups	512(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	(%rsp), %k1                     # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 5056(%rbx,%rax,4) {%k1}
	vmovups	4800(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	86(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4992(%rbx,%rax,4) {%k1}
	vmovups	1408(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	150(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4928(%rbx,%rax,4) {%k1}
	vmovups	5248(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	46(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4864(%rbx,%rax,4) {%k1}
	vmovups	5440(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	178(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4800(%rbx,%rax,4) {%k1}
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm31, %zmm0
	kmovw	66(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4736(%rbx,%rax,4) {%k1}
	vmovups	1600(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	126(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4672(%rbx,%rax,4) {%k1}
	vmovups	4992(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	40(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4608(%rbx,%rax,4) {%k1}
	vmovups	1024(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	198(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4544(%rbx,%rax,4) {%k1}
	vmovups	7168(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	88(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4480(%rbx,%rax,4) {%k1}
	vmovups	1792(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	152(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4416(%rbx,%rax,4) {%k1}
	vmovups	384(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	48(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4352(%rbx,%rax,4) {%k1}
	vmovups	896(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	180(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4288(%rbx,%rax,4) {%k1}
	vmovups	7296(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	68(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4224(%rbx,%rax,4) {%k1}
	vmovups	2048(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	128(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4160(%rbx,%rax,4) {%k1}
	vmovups	5376(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	26(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4096(%rbx,%rax,4) {%k1}
	vmovups	1536(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	216(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 4032(%rbx,%rax,4) {%k1}
	vmovups	7360(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	130(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3968(%rbx,%rax,4) {%k1}
	vmovups	2176(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	190(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3904(%rbx,%rax,4) {%k1}
	vmovups	768(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	78(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3840(%rbx,%rax,4) {%k1}
	vmovups	1280(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	208(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3776(%rbx,%rax,4) {%k1}
	vmovups	7488(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	106(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3712(%rbx,%rax,4) {%k1}
	vmovups	2432(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	170(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3648(%rbx,%rax,4) {%k1}
	vmovups	576(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	58(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3584(%rbx,%rax,4) {%k1}
	vmovups	1984(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	218(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3520(%rbx,%rax,4) {%k1}
	vmovups	320(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	132(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3456(%rbx,%rax,4) {%k1}
	vmovups	2624(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	192(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3392(%rbx,%rax,4) {%k1}
	vmovups	1472(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	80(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3328(%rbx,%rax,4) {%k1}
	vmovups	1664(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	210(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3264(%rbx,%rax,4) {%k1}
	vmovups	256(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	108(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3200(%rbx,%rax,4) {%k1}
	vmovups	2816(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	172(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3136(%rbx,%rax,4) {%k1}
	vmovups	1088(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	60(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3072(%rbx,%rax,4) {%k1}
	vmovups	2240(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	232(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 3008(%rbx,%rax,4) {%k1}
	vmovups	640(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	154(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2944(%rbx,%rax,4) {%k1}
	vmovups	3072(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	204(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2880(%rbx,%rax,4) {%k1}
	vmovups	6464(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	94(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2816(%rbx,%rax,4) {%k1}
	vmovups	1920(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	220(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2752(%rbx,%rax,4) {%k1}
	vmovups	832(%rsp), %zmm0                # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	134(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2688(%rbx,%rax,4) {%k1}
	vmovups	2880(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	194(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2624(%rbx,%rax,4) {%k1}
	vmovups	1344(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	82(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2560(%rbx,%rax,4) {%k1}
	vmovups	2688(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	234(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2496(%rbx,%rax,4) {%k1}
	vmovups	1152(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	156(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2432(%rbx,%rax,4) {%k1}
	vmovups	6912(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	206(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2368(%rbx,%rax,4) {%k1}
	vmovups	2112(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	96(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2304(%rbx,%rax,4) {%k1}
	vmovups	2560(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	222(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2240(%rbx,%rax,4) {%k1}
	vmovups	6336(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	136(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2176(%rbx,%rax,4) {%k1}
	vmovups	3712(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	196(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2112(%rbx,%rax,4) {%k1}
	vmovups	1728(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	84(%rsp), %k1                   # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 2048(%rbx,%rax,4) {%k1}
	vmovups	3200(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	244(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1984(%rbx,%rax,4) {%k1}
	vmovups	6528(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	182(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1920(%rbx,%rax,4) {%k1}
	vmovups	3776(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	224(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1856(%rbx,%rax,4) {%k1}
	vmovups	2496(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	138(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1792(%rbx,%rax,4) {%k1}
	vmovups	2944(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	240(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1728(%rbx,%rax,4) {%k1}
	vmovups	6400(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	166(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1664(%rbx,%rax,4) {%k1}
	vmovups	3584(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	212(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1600(%rbx,%rax,4) {%k1}
	vmovups	2304(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	110(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1536(%rbx,%rax,4) {%k1}
	vmovups	3456(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	246(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1472(%rbx,%rax,4) {%k1}
	vmovups	6656(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	184(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1408(%rbx,%rax,4) {%k1}
	vmovups	4096(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	226(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1344(%rbx,%rax,4) {%k1}
	vmovups	3136(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	140(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1280(%rbx,%rax,4) {%k1}
	vmovups	3328(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	242(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1216(%rbx,%rax,4) {%k1}
	vmovups	1856(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	168(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1152(%rbx,%rax,4) {%k1}
	vmovups	3904(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	214(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1088(%rbx,%rax,4) {%k1}
	vmovups	2752(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	112(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 1024(%rbx,%rax,4) {%k1}
	vmovups	3648(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	252(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 960(%rbx,%rax,4) {%k1}
	vmovups	2368(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	200(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 896(%rbx,%rax,4) {%k1}
	vmovups	4160(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	236(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 832(%rbx,%rax,4) {%k1}
	vmovups	3264(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	158(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 768(%rbx,%rax,4) {%k1}
	vmovups	3392(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	248(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 704(%rbx,%rax,4) {%k1}
	vmovups	6592(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	186(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 640(%rbx,%rax,4) {%k1}
	vmovups	4032(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	228(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 576(%rbx,%rax,4) {%k1}
	vmovups	3008(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	142(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 512(%rbx,%rax,4) {%k1}
	vmovups	3968(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	254(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 448(%rbx,%rax,4) {%k1}
	vmovups	6784(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	202(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 384(%rbx,%rax,4) {%k1}
	vmovups	4288(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	238(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 320(%rbx,%rax,4) {%k1}
	vmovups	3520(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	160(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 256(%rbx,%rax,4) {%k1}
	vmovups	3840(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	250(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 192(%rbx,%rax,4) {%k1}
	vmovups	6720(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	188(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 128(%rbx,%rax,4) {%k1}
	vmovups	4224(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	230(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, 64(%rbx,%rax,4) {%k1}
	vmovups	6848(%rsp), %zmm0               # 64-byte Reload
	.loc	1 92 33                         # 02-fused-softmax-cpu.py:92:33
	vdivps	%zmm1, %zmm0, %zmm0
	kmovw	144(%rsp), %k1                  # 2-byte Reload
	.loc	1 96 26                         # 02-fused-softmax-cpu.py:96:26
	vmovups	%zmm0, (%rbx,%rax,4) {%k1}
	.loc	1 96 4 epilogue_begin is_stmt 0 # 02-fused-softmax-cpu.py:96:4
	addq	$10048, %rsp                    # imm = 0x2740
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	vzeroupper
	retq
.Ltmp5:
.Lfunc_end0:
	.size	softmax_kernel, .Lfunc_end0-softmax_kernel
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	14                              # DW_FORM_strp
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	14                              # DW_FORM_strp
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	32                              # DW_AT_inline
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	29                              # DW_TAG_inlined_subroutine
	.byte	0                               # DW_CHILDREN_no
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	88                              # DW_AT_call_file
	.byte	11                              # DW_FORM_data1
	.byte	89                              # DW_AT_call_line
	.byte	11                              # DW_FORM_data1
	.byte	87                              # DW_AT_call_column
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.short	4                               # DWARF version number
	.long	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	8                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0x60 DW_TAG_compile_unit
	.long	.Linfo_string0                  # DW_AT_producer
	.short	2                               # DW_AT_language
	.long	.Linfo_string1                  # DW_AT_name
	.long	.Lline_table_start0             # DW_AT_stmt_list
	.long	.Linfo_string2                  # DW_AT_comp_dir
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.byte	2                               # Abbrev [2] 0x2a:0x6 DW_TAG_subprogram
	.long	.Linfo_string3                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	3                               # Abbrev [3] 0x30:0x3a DW_TAG_subprogram
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.long	42                              # DW_AT_abstract_origin
	.byte	4                               # Abbrev [4] 0x41:0x14 DW_TAG_inlined_subroutine
	.long	42                              # DW_AT_abstract_origin
	.quad	.Ltmp1                          # DW_AT_low_pc
	.long	.Ltmp2-.Ltmp1                   # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	88                              # DW_AT_call_line
	.byte	33                              # DW_AT_call_column
	.byte	4                               # Abbrev [4] 0x55:0x14 DW_TAG_inlined_subroutine
	.long	42                              # DW_AT_abstract_origin
	.quad	.Ltmp3                          # DW_AT_low_pc
	.long	.Ltmp4-.Ltmp3                   # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	91                              # DW_AT_call_line
	.byte	25                              # DW_AT_call_column
	.byte	0                               # End Of Children Mark
	.byte	0                               # End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"triton"                        # string offset=0
.Linfo_string1:
	.asciz	"02-fused-softmax-cpu.py"       # string offset=7
.Linfo_string2:
	.asciz	"/root/triton/triton-cpu/./python/tutorials" # string offset=31
.Linfo_string3:
	.asciz	"softmax_kernel"                # string offset=74
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
