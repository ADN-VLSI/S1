# UART Register Map and Bit-Field Definitions

This document defines the UART register map and bit-field assignments. All register offsets are relative to the UART base address.

## Register Map

| Offset  | Register                | Type | Reset Value | Description                                                          |
| ------- | ----------------------- | ---- | ----------- | -------------------------------------------------------------------- |
| `0x000` | [UART_CTRL](#uart_ctrl) | RW   | 0x00000000  | Control Register. UART reset, FIFO flush, and enable control bits    |
| `0x004` | [UART_CFG](#uart_cfg)   | RW   | 0x0003405B  | Configuration Register. Baud-rate and frame format configuration     |
| `0x008` | [UART_STAT](#uart_stat) | RO   | 0x00500000  | Status Register. FIFO fill-level and FIFO state indicators           |
| `0x010` | [UART_TXR](#uart_txr)   | WO   | -           | TX Access Request ID Queue. Transmit-side access request identifier  |
| `0x014` | [UART_TXGP](#uart_txgp) | RO   | 0x00000000  | TX Access Grant ID Peek. Non-consuming view of the transmit grant ID |
| `0x018` | [UART_TXG](#uart_txg)   | RO   | 0x00000000  | TX Access Grant ID. Consuming read of the transmit grant ID          |
| `0x01C` | [UART_TXD](#uart_txd)   | WO   | -           | TX Data. Transmit data byte                                          |
| `0x020` | [UART_RXR](#uart_rxr)   | WO   | -           | RX Access Request ID Queue. Receive-side access request identifier   |
| `0x024` | [UART_RXGP](#uart_rxgp) | RO   | 0x00000000  | RX Access Grant ID Peek. Non-consuming view of the receive grant ID  |
| `0x028` | [UART_RXG](#uart_rxg)   | RO   | 0x00000000  | RX Access Grant ID. Consuming read of the receive grant ID           |
| `0x02C` | [UART_RXD](#uart_rxd)   | RO   | 0x00000000  | RX Data. Receive data byte                                           |
| `0x030` | [UART_INT](#uart_int)   | RW   | 0x00000000  | Interrupt Control. Interrupt enable bits                             |

## UART_CTRL

`Offset:0x000` `Type:RW`

Controls UART reset behavior, FIFO flushing, and transmitter and receiver enable state.

| Bits   | Field         | Reset Value | Description               |
| ------ | ------------- | ----------- | ------------------------- |
| `0`    | uart_rst      | 0x0         | Software reset control    |
| `1`    | tx_fifo_flush | 0x0         | Flushes the transmit FIFO |
| `2`    | rx_fifo_flush | 0x0         | Flushes the receive FIFO  |
| `3`    | tx_en         | 0x0         | Enables the transmitter   |
| `4`    | rx_en         | 0x0         | Enables the receiver      |
| `31:5` | reserved      | 0x0         | Reserved                  |

## UART_CFG

`Offset:0x004` `Type:RW`

Configures the baud-rate generation path and serial frame format.

| Bits    | Field    | Reset Value | Description                                                                           |
| ------- | -------- | ----------- | ------------------------------------------------------------------------------------- |
| `11:0`  | clk_div  | 0x05B       | UART clock-divider value                                                              |
| `15:12` | psclr    | 0x4         | UART prescaler value                                                                  |
| `17:16` | db       | 0x3         | Number of data bits per frame: `0` = 5 bits, `1` = 6 bits, `2` = 7 bits, `3` = 8 bits |
| `18`    | pen      | 0x0         | Enables parity generation and parity checking                                         |
| `19`    | ptp      | 0x0         | Parity Type: `0` = even, `1` = odd                                                    |
| `20`    | sb       | 0x0         | Extra stop bit: `0` = 1 stop bit, `1` = 2 stop bits                                   |
| `31:21` | reserved | 0x0         | Reserved                                                                              |

## UART_STAT

`Offset:0x008 ` `Type:RO`

Reports FIFO fill levels and FIFO full and empty status.

| Bits    | Field    | Reset Value | Description                                             |
| ------- | -------- | ----------- | ------------------------------------------------------- |
| `9:0`   | tx_cnt   | 0x000       | Number of entries currently stored in the transmit FIFO |
| `19:10` | rx_cnt   | 0x000       | Number of entries currently stored in the receive FIFO  |
| `20`    | tx_empty | 0x1         | Indicates the transmit FIFO is empty                    |
| `21`    | tx_full  | 0x0         | Indicates the transmit FIFO is full                     |
| `22`    | rx_empty | 0x1         | Indicates the receive FIFO is empty                     |
| `23`    | rx_full  | 0x0         | Indicates the receive FIFO is full                      |
| `31:24` | reserved | 0x0         | Reserved                                                |

## UART_TXR

`Offset:0x010` `Type:WO`

Transmit-side request register for multi-master arbitration. Writing a master ID to this register enqueues that ID once in the internal request FIFO, preserving request order.

| Bits   | Field    | Description                        |
| ------ | -------- | ---------------------------------- |
| `7:0`  | id       | Transmit access request identifier |
| `30:8` | reserved | Reserved                           |
| `31`   | valid    | Indicates if the request is valid  |

## UART_TXGP

`Offset:0x014` `Type:RO`

Provides a non-consuming view of the current transmit-side granted master ID. Software must compare this value against its own master ID before taking control of the transmit path. Reading this register does not complete or advance the grant.

| Bits   | Field    | Reset Value | Description                                                     |
| ------ | -------- | ----------- | --------------------------------------------------------------- |
| `7:0`  | id       | 0x00        | Current granted transmit master ID without completing the grant |
| `30:8` | reserved | 0x00000000  | Reserved                                                        |
| `31`   | valid    | 0x0         | Indicates if the grant is valid                                 |

## UART_TXG

`Offset:0x018` `Type:RO`

Provides the current transmit-side granted master ID. Reading this register completes the grant by consuming the current FIFO output. Only after this read can the next queued master, if any, be granted access.

| Bits   | Field    | Reset Value | Description                                                                |
| ------ | -------- | ----------- | -------------------------------------------------------------------------- |
| `7:0`  | id       | 0x00        | Current granted transmit master ID; reading this field completes the grant |
| `30:8` | reserved | 0x00000000  | Reserved                                                                   |
| `31`   | valid    | 0x0         | Indicates if the grant is valid                                            |

## UART_TXD

`Offset:0x01C` `Type:WO`

Transmit data register.

| Bits   | Field    | Description        |
| ------ | -------- | ------------------ |
| `7:0`  | data     | Transmit data byte |
| `31:8` | reserved | Reserved           |

## UART_RXR

`Offset:0x020` `Type:WO`

Receive-side request register for multi-master arbitration. Writing a master ID to this register enqueues that ID once in the internal request FIFO, preserving request order.

| Bits   | Field    | Description                       |
| ------ | -------- | --------------------------------- |
| `7:0`  | id       | Receive access request identifier |
| `30:8` | reserved | Reserved                          |
| `31`   | valid    | Indicates if the request is valid |

## UART_RXGP

`Offset:0x024` `Type:RO`

Provides a non-consuming view of the current receive-side granted master ID. Software must compare this value against its own master ID before taking control of the receive path. Reading this register does not complete or advance the grant.

| Bits   | Field    | Reset Value | Description                                                    |
| ------ | -------- | ----------- | -------------------------------------------------------------- |
| `7:0`  | id       | 0x00        | Current granted receive master ID without completing the grant |
| `30:8` | reserved | 0x00000000  | Reserved                                                       |
| `31`   | valid    | 0x0         | Indicates if the grant is valid                                |

## UART_RXG

`Offset:0x028` `Type:RO`

Provides the current receive-side granted master ID. Reading this register completes the grant by consuming the current FIFO output. Only after this read can the next queued master, if any, be granted access.

| Bits   | Field    | Reset Value | Description                                                               |
| ------ | -------- | ----------- | ------------------------------------------------------------------------- |
| `7:0`  | id       | 0x00        | Current granted receive master ID; reading this field completes the grant |
| `30:8` | reserved | 0x00000000  | Reserved                                                                  |
| `31`   | valid    | 0x0         | Indicates if the grant is valid                                           |

## UART_RXD

`Offset:0x02C` `Type:RO`

Receive data register.

| Bits   | Field    | Reset Value | Description       |
| ------ | -------- | ----------- | ----------------- |
| `7:0`  | data     | 0x00        | Receive data byte |
| `31:8` | reserved | 0x00000000  | Reserved          |

## UART_INT

`Offset:0x030` `Type:RW`

Enable interrupts for various UART events. Writing a `1` to any bit in this register enables the corresponding interrupt, while writing a `0` disables it.

| Bit | Field    | Reset Value | Description                                                                       |
| --- | -------- | ----------- | --------------------------------------------------------------------------------- |
| `1` | tx_full  | 0x0         | Generates an interrupt when the transmit FIFO transitions from non-full to full   |
| `0` | tx_empty | 0x0         | Generates an interrupt when the transmit FIFO transitions from non-empty to empty |
| `2` | rx_empty | 0x0         | Generates an interrupt when the receive FIFO transitions from non-empty to empty  |
| `3` | rx_full  | 0x0         | Generates an interrupt when the receive FIFO transitions from non-full to full    |
