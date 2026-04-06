# Address Map

| Device  | Base Address | Last Address | Size  |
| ------- | ------------ | ------------ | ----- |
| DEBUG   | 0x0000_0000  | 0x0000_FFFF  | 64KB  |
| CTRL_SS | 0x0001_0000  | 0x0001_0FFF  | 4KB   |
| UART    | 0x0001_1000  | 0x0001_1FFF  | 4KB   |
| GPIO    | 0x0001_2000  | 0x0001_2FFF  | 4KB   |
| PLIC    | 0x0001_3000  | 0x0001_3FFF  | 4KB   |
| CLINT   | 0x0001_4000  | 0x0001_4FFF  | 4KB   |
| TCM     | 0x0100_0000  | 0x01FF_FFFF  | 16MB  |
| APB     | 0x1000_0000  | 0x1FFF_FFFF  | 256MB |
| RAM     | 0x2000_0000  | 0x5FFF_FFFF  | 1GB   |

# TCM Address Map

| Region   | Base Address | Last Address | Size   |
| -------- | ------------ | ------------ | ------ |
| TCM0     | 0x0100_0000  | 0x0107_FFFF  | 512KB  |
| TCM1     | 0x0108_0000  | 0x010F_FFFF  | 512KB  |
| Reserved | 0x0110_0000  | 0x01FF_FFFF  | 15.5MB |

> TCMn = TCM Base Address + n * 512KB, where n = 0, 1
