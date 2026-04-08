
package single_file_rv32imf_pkg;
  parameter int OPCODE_SYSTEM = 7'h73;
  parameter int OPCODE_FENCE = 7'h0f;
  parameter int OPCODE_OP = 7'h33;
  parameter int OPCODE_OPIMM = 7'h13;
  parameter int OPCODE_STORE = 7'h23;
  parameter int OPCODE_LOAD = 7'h03;
  parameter int OPCODE_BRANCH = 7'h63;
  parameter int OPCODE_JALR = 7'h67;
  parameter int OPCODE_JAL = 7'h6f;
  parameter int OPCODE_AUIPC = 7'h17;
  parameter int OPCODE_LUI = 7'h37;
  parameter int OPCODE_OP_FP = 7'h53;
  parameter int OPCODE_OP_FMADD = 7'h43;
  parameter int OPCODE_OP_FNMADD = 7'h4f;
  parameter int OPCODE_OP_FMSUB = 7'h47;
  parameter int OPCODE_OP_FNMSUB = 7'h4b;
  parameter int OPCODE_STORE_FP = 7'h27;
  parameter int OPCODE_LOAD_FP = 7'h07;
  parameter int OPCODE_AMO = 7'h2F;
  parameter int OPCODE_CUSTOM_0 = 7'h0b;
  parameter int OPCODE_CUSTOM_1 = 7'h2b;
  parameter int OPCODE_CUSTOM_2 = 7'h5b;
  parameter int OPCODE_CUSTOM_3 = 7'h7b;
  parameter int REGC_S1 = 2'b10;
  parameter int REGC_S4 = 2'b00;
  parameter int REGC_RD = 2'b01;
  parameter int REGC_ZERO = 2'b11;
  parameter int ALU_OP_WIDTH = 7;
  typedef enum logic [ALU_OP_WIDTH-1:0] {
    ALU_ADD   = 7'b0011000,
    ALU_SUB   = 7'b0011001,
    ALU_ADDU  = 7'b0011010,
    ALU_SUBU  = 7'b0011011,
    ALU_ADDR  = 7'b0011100,
    ALU_SUBR  = 7'b0011101,
    ALU_ADDUR = 7'b0011110,
    ALU_SUBUR = 7'b0011111,
    ALU_XOR = 7'b0101111,
    ALU_OR  = 7'b0101110,
    ALU_AND = 7'b0010101,
    ALU_SRA = 7'b0100100,
    ALU_SRL = 7'b0100101,
    ALU_ROR = 7'b0100110,
    ALU_SLL = 7'b0100111,
    ALU_BEXT  = 7'b0101000,
    ALU_BEXTU = 7'b0101001,
    ALU_BINS  = 7'b0101010,
    ALU_BCLR  = 7'b0101011,
    ALU_BSET  = 7'b0101100,
    ALU_BREV  = 7'b1001001,
    ALU_FF1 = 7'b0110110,
    ALU_FL1 = 7'b0110111,
    ALU_CNT = 7'b0110100,
    ALU_CLB = 7'b0110101,
    ALU_EXTS = 7'b0111110,
    ALU_EXT  = 7'b0111111,
    ALU_LTS = 7'b0000000,
    ALU_LTU = 7'b0000001,
    ALU_LES = 7'b0000100,
    ALU_LEU = 7'b0000101,
    ALU_GTS = 7'b0001000,
    ALU_GTU = 7'b0001001,
    ALU_GES = 7'b0001010,
    ALU_GEU = 7'b0001011,
    ALU_EQ  = 7'b0001100,
    ALU_NE  = 7'b0001101,
    ALU_SLTS  = 7'b0000010,
    ALU_SLTU  = 7'b0000011,
    ALU_SLETS = 7'b0000110,
    ALU_SLETU = 7'b0000111,
    ALU_ABS   = 7'b0010100,
    ALU_CLIP  = 7'b0010110,
    ALU_CLIPU = 7'b0010111,
    ALU_INS = 7'b0101101,
    ALU_MIN  = 7'b0010000,
    ALU_MINU = 7'b0010001,
    ALU_MAX  = 7'b0010010,
    ALU_MAXU = 7'b0010011,
    ALU_DIVU = 7'b0110000,
    ALU_DIV  = 7'b0110001,
    ALU_REMU = 7'b0110010,
    ALU_REM  = 7'b0110011,
    ALU_SHUF  = 7'b0111010,
    ALU_SHUF2 = 7'b0111011,
    ALU_PCKLO = 7'b0111000,
    ALU_PCKHI = 7'b0111001
  } alu_opcode_e;
  parameter int MUL_OP_WIDTH = 3;
  typedef enum logic [MUL_OP_WIDTH-1:0] {
    MUL_MAC32 = 3'b000,
    MUL_MSU32 = 3'b001,
    MUL_I     = 3'b010,
    MUL_IR    = 3'b011,
    MUL_DOT8  = 3'b100,
    MUL_DOT16 = 3'b101,
    MUL_H     = 3'b110
  } mul_opcode_e;
  parameter int VEC_MODE32 = 2'b00;
  parameter int VEC_MODE16 = 2'b10;
  parameter int VEC_MODE8 = 2'b11;
  typedef enum logic [4:0] {
    RESET,
    BOOT_SET,
    SLEEP,
    WAIT_SLEEP,
    FIRST_FETCH,
    DECODE,
    IRQ_FLUSH_ELW,
    ELW_EXE,
    FLUSH_EX,
    FLUSH_WB,
    XRET_JUMP,
    DBG_TAKEN_ID,
    DBG_TAKEN_IF,
    DBG_FLUSH,
    DBG_WAIT_BRANCH,
    DECODE_HWLOOP
  } ctrl_state_e;
  parameter int HAVERESET_INDEX = 0;
  parameter int RUNNING_INDEX = 1;
  parameter int HALTED_INDEX = 2;
  typedef enum logic [2:0] {
    HAVERESET = 3'b001,
    RUNNING   = 3'b010,
    HALTED    = 3'b100
  } debug_state_e;
  typedef enum logic {
    IDLE,
    BRANCH_WAIT
  } prefetch_state_e;
  typedef enum logic [2:0] {
    IDLE_MULT,
    STEP0,
    STEP1,
    STEP2,
    FINISH
  } mult_state_e;
  typedef enum logic [11:0] {
    CSR_USTATUS  = 12'h000,
    CSR_FFLAGS   = 12'h001,
    CSR_FRM      = 12'h002,
    CSR_FCSR     = 12'h003,
    CSR_UTVEC    = 12'h005,
    CSR_UEPC     = 12'h041,
    CSR_UCAUSE   = 12'h042,
    CSR_LPSTART0 = 12'hCC0,
    CSR_LPEND0   = 12'hCC1,
    CSR_LPCOUNT0 = 12'hCC2,
    CSR_LPSTART1 = 12'hCC4,
    CSR_LPEND1   = 12'hCC5,
    CSR_LPCOUNT1 = 12'hCC6,
    CSR_UHARTID  = 12'hCD0,
    CSR_PRIVLV   = 12'hCD1,
    CSR_ZFINX    = 12'hCD2,
    CSR_MSTATUS       = 12'h300,
    CSR_MISA          = 12'h301,
    CSR_MIE           = 12'h304,
    CSR_MTVEC         = 12'h305,
    CSR_MCOUNTEREN    = 12'h306,
    CSR_MCOUNTINHIBIT = 12'h320,
    CSR_MHPMEVENT3  = 12'h323,
    CSR_MHPMEVENT4  = 12'h324,
    CSR_MHPMEVENT5  = 12'h325,
    CSR_MHPMEVENT6  = 12'h326,
    CSR_MHPMEVENT7  = 12'h327,
    CSR_MHPMEVENT8  = 12'h328,
    CSR_MHPMEVENT9  = 12'h329,
    CSR_MHPMEVENT10 = 12'h32A,
    CSR_MHPMEVENT11 = 12'h32B,
    CSR_MHPMEVENT12 = 12'h32C,
    CSR_MHPMEVENT13 = 12'h32D,
    CSR_MHPMEVENT14 = 12'h32E,
    CSR_MHPMEVENT15 = 12'h32F,
    CSR_MHPMEVENT16 = 12'h330,
    CSR_MHPMEVENT17 = 12'h331,
    CSR_MHPMEVENT18 = 12'h332,
    CSR_MHPMEVENT19 = 12'h333,
    CSR_MHPMEVENT20 = 12'h334,
    CSR_MHPMEVENT21 = 12'h335,
    CSR_MHPMEVENT22 = 12'h336,
    CSR_MHPMEVENT23 = 12'h337,
    CSR_MHPMEVENT24 = 12'h338,
    CSR_MHPMEVENT25 = 12'h339,
    CSR_MHPMEVENT26 = 12'h33A,
    CSR_MHPMEVENT27 = 12'h33B,
    CSR_MHPMEVENT28 = 12'h33C,
    CSR_MHPMEVENT29 = 12'h33D,
    CSR_MHPMEVENT30 = 12'h33E,
    CSR_MHPMEVENT31 = 12'h33F,
    CSR_MSCRATCH = 12'h340,
    CSR_MEPC     = 12'h341,
    CSR_MCAUSE   = 12'h342,
    CSR_MTVAL    = 12'h343,
    CSR_MIP      = 12'h344,
    CSR_PMPCFG0 = 12'h3A0,
    CSR_PMPCFG1 = 12'h3A1,
    CSR_PMPCFG2 = 12'h3A2,
    CSR_PMPCFG3 = 12'h3A3,
    CSR_PMPADDR0  = 12'h3B0,
    CSR_PMPADDR1  = 12'h3B1,
    CSR_PMPADDR2  = 12'h3B2,
    CSR_PMPADDR3  = 12'h3B3,
    CSR_PMPADDR4  = 12'h3B4,
    CSR_PMPADDR5  = 12'h3B5,
    CSR_PMPADDR6  = 12'h3B6,
    CSR_PMPADDR7  = 12'h3B7,
    CSR_PMPADDR8  = 12'h3B8,
    CSR_PMPADDR9  = 12'h3B9,
    CSR_PMPADDR10 = 12'h3BA,
    CSR_PMPADDR11 = 12'h3BB,
    CSR_PMPADDR12 = 12'h3BC,
    CSR_PMPADDR13 = 12'h3BD,
    CSR_PMPADDR14 = 12'h3BE,
    CSR_PMPADDR15 = 12'h3BF,
    CSR_TSELECT   = 12'h7A0,
    CSR_TDATA1    = 12'h7A1,
    CSR_TDATA2    = 12'h7A2,
    CSR_TDATA3    = 12'h7A3,
    CSR_TINFO     = 12'h7A4,
    CSR_MCONTEXT  = 12'h7A8,
    CSR_SCONTEXT  = 12'h7AA,
    CSR_DCSR      = 12'h7B0,
    CSR_DPC       = 12'h7B1,
    CSR_DSCRATCH0 = 12'h7B2,
    CSR_DSCRATCH1 = 12'h7B3,
    CSR_MCYCLE = 12'hB00,
    CSR_MTIME = 12'hB01,
    CSR_MINSTRET = 12'hB02,
    CSR_MHPMCOUNTER3 = 12'hB03,
    CSR_MHPMCOUNTER4 = 12'hB04,
    CSR_MHPMCOUNTER5 = 12'hB05,
    CSR_MHPMCOUNTER6 = 12'hB06,
    CSR_MHPMCOUNTER7 = 12'hB07,
    CSR_MHPMCOUNTER8 = 12'hB08,
    CSR_MHPMCOUNTER9 = 12'hB09,
    CSR_MHPMCOUNTER10 = 12'hB0A,
    CSR_MHPMCOUNTER11 = 12'hB0B,
    CSR_MHPMCOUNTER12 = 12'hB0C,
    CSR_MHPMCOUNTER13 = 12'hB0D,
    CSR_MHPMCOUNTER14 = 12'hB0E,
    CSR_MHPMCOUNTER15 = 12'hB0F,
    CSR_MHPMCOUNTER16 = 12'hB10,
    CSR_MHPMCOUNTER17 = 12'hB11,
    CSR_MHPMCOUNTER18 = 12'hB12,
    CSR_MHPMCOUNTER19 = 12'hB13,
    CSR_MHPMCOUNTER20 = 12'hB14,
    CSR_MHPMCOUNTER21 = 12'hB15,
    CSR_MHPMCOUNTER22 = 12'hB16,
    CSR_MHPMCOUNTER23 = 12'hB17,
    CSR_MHPMCOUNTER24 = 12'hB18,
    CSR_MHPMCOUNTER25 = 12'hB19,
    CSR_MHPMCOUNTER26 = 12'hB1A,
    CSR_MHPMCOUNTER27 = 12'hB1B,
    CSR_MHPMCOUNTER28 = 12'hB1C,
    CSR_MHPMCOUNTER29 = 12'hB1D,
    CSR_MHPMCOUNTER30 = 12'hB1E,
    CSR_MHPMCOUNTER31 = 12'hB1F,
    CSR_MCYCLEH = 12'hB80,
    CSR_MTIMEH = 12'hB81,
    CSR_MINSTRETH = 12'hB82,
    CSR_MHPMCOUNTER3H = 12'hB83,
    CSR_MHPMCOUNTER4H = 12'hB84,
    CSR_MHPMCOUNTER5H = 12'hB85,
    CSR_MHPMCOUNTER6H = 12'hB86,
    CSR_MHPMCOUNTER7H = 12'hB87,
    CSR_MHPMCOUNTER8H = 12'hB88,
    CSR_MHPMCOUNTER9H = 12'hB89,
    CSR_MHPMCOUNTER10H = 12'hB8A,
    CSR_MHPMCOUNTER11H = 12'hB8B,
    CSR_MHPMCOUNTER12H = 12'hB8C,
    CSR_MHPMCOUNTER13H = 12'hB8D,
    CSR_MHPMCOUNTER14H = 12'hB8E,
    CSR_MHPMCOUNTER15H = 12'hB8F,
    CSR_MHPMCOUNTER16H = 12'hB90,
    CSR_MHPMCOUNTER17H = 12'hB91,
    CSR_MHPMCOUNTER18H = 12'hB92,
    CSR_MHPMCOUNTER19H = 12'hB93,
    CSR_MHPMCOUNTER20H = 12'hB94,
    CSR_MHPMCOUNTER21H = 12'hB95,
    CSR_MHPMCOUNTER22H = 12'hB96,
    CSR_MHPMCOUNTER23H = 12'hB97,
    CSR_MHPMCOUNTER24H = 12'hB98,
    CSR_MHPMCOUNTER25H = 12'hB99,
    CSR_MHPMCOUNTER26H = 12'hB9A,
    CSR_MHPMCOUNTER27H = 12'hB9B,
    CSR_MHPMCOUNTER28H = 12'hB9C,
    CSR_MHPMCOUNTER29H = 12'hB9D,
    CSR_MHPMCOUNTER30H = 12'hB9E,
    CSR_MHPMCOUNTER31H = 12'hB9F,
    CSR_CYCLE   = 12'hC00,
    CSR_TIME    = 12'hC01,
    CSR_INSTRET = 12'hC02,
    CSR_HPMCOUNTER3  = 12'hC03,
    CSR_HPMCOUNTER4  = 12'hC04,
    CSR_HPMCOUNTER5  = 12'hC05,
    CSR_HPMCOUNTER6  = 12'hC06,
    CSR_HPMCOUNTER7  = 12'hC07,
    CSR_HPMCOUNTER8  = 12'hC08,
    CSR_HPMCOUNTER9  = 12'hC09,
    CSR_HPMCOUNTER10 = 12'hC0A,
    CSR_HPMCOUNTER11 = 12'hC0B,
    CSR_HPMCOUNTER12 = 12'hC0C,
    CSR_HPMCOUNTER13 = 12'hC0D,
    CSR_HPMCOUNTER14 = 12'hC0E,
    CSR_HPMCOUNTER15 = 12'hC0F,
    CSR_HPMCOUNTER16 = 12'hC10,
    CSR_HPMCOUNTER17 = 12'hC11,
    CSR_HPMCOUNTER18 = 12'hC12,
    CSR_HPMCOUNTER19 = 12'hC13,
    CSR_HPMCOUNTER20 = 12'hC14,
    CSR_HPMCOUNTER21 = 12'hC15,
    CSR_HPMCOUNTER22 = 12'hC16,
    CSR_HPMCOUNTER23 = 12'hC17,
    CSR_HPMCOUNTER24 = 12'hC18,
    CSR_HPMCOUNTER25 = 12'hC19,
    CSR_HPMCOUNTER26 = 12'hC1A,
    CSR_HPMCOUNTER27 = 12'hC1B,
    CSR_HPMCOUNTER28 = 12'hC1C,
    CSR_HPMCOUNTER29 = 12'hC1D,
    CSR_HPMCOUNTER30 = 12'hC1E,
    CSR_HPMCOUNTER31 = 12'hC1F,
    CSR_CYCLEH = 12'hC80,
    CSR_TIMEH = 12'hC81,
    CSR_INSTRETH = 12'hC82,
    CSR_HPMCOUNTER3H = 12'hC83,
    CSR_HPMCOUNTER4H = 12'hC84,
    CSR_HPMCOUNTER5H = 12'hC85,
    CSR_HPMCOUNTER6H = 12'hC86,
    CSR_HPMCOUNTER7H = 12'hC87,
    CSR_HPMCOUNTER8H = 12'hC88,
    CSR_HPMCOUNTER9H = 12'hC89,
    CSR_HPMCOUNTER10H = 12'hC8A,
    CSR_HPMCOUNTER11H = 12'hC8B,
    CSR_HPMCOUNTER12H = 12'hC8C,
    CSR_HPMCOUNTER13H = 12'hC8D,
    CSR_HPMCOUNTER14H = 12'hC8E,
    CSR_HPMCOUNTER15H = 12'hC8F,
    CSR_HPMCOUNTER16H = 12'hC90,
    CSR_HPMCOUNTER17H = 12'hC91,
    CSR_HPMCOUNTER18H = 12'hC92,
    CSR_HPMCOUNTER19H = 12'hC93,
    CSR_HPMCOUNTER20H = 12'hC94,
    CSR_HPMCOUNTER21H = 12'hC95,
    CSR_HPMCOUNTER22H = 12'hC96,
    CSR_HPMCOUNTER23H = 12'hC97,
    CSR_HPMCOUNTER24H = 12'hC98,
    CSR_HPMCOUNTER25H = 12'hC99,
    CSR_HPMCOUNTER26H = 12'hC9A,
    CSR_HPMCOUNTER27H = 12'hC9B,
    CSR_HPMCOUNTER28H = 12'hC9C,
    CSR_HPMCOUNTER29H = 12'hC9D,
    CSR_HPMCOUNTER30H = 12'hC9E,
    CSR_HPMCOUNTER31H = 12'hC9F,
    CSR_MVENDORID = 12'hF11,
    CSR_MARCHID   = 12'hF12,
    CSR_MIMPID    = 12'hF13,
    CSR_MHARTID   = 12'hF14
  } csr_num_e;
  parameter int CSR_OP_WIDTH = 2;
  typedef enum logic [CSR_OP_WIDTH-1:0] {
    CSR_OP_READ  = 2'b00,
    CSR_OP_WRITE = 2'b01,
    CSR_OP_SET   = 2'b10,
    CSR_OP_CLEAR = 2'b11
  } csr_opcode_e;
  parameter int unsigned CSR_MSIX_BIT = 3;
  parameter int unsigned CSR_MTIX_BIT = 7;
  parameter int unsigned CSR_MEIX_BIT = 11;
  parameter int unsigned CSR_MFIX_BIT_LOW = 16;
  parameter int unsigned CSR_MFIX_BIT_HIGH = 31;
  parameter int SP_DCR0 = 16'h3008;
  parameter int SP_DVR0 = 16'h3000;
  parameter int SP_DMR1 = 16'h3010;
  parameter int SP_DMR2 = 16'h3011;
  parameter int SP_DVR_MSB = 8'h00;
  parameter int SP_DCR_MSB = 8'h01;
  parameter int SP_DMR_MSB = 8'h02;
  parameter int SP_DSR_MSB = 8'h04;
  typedef enum logic [1:0] {
    PRIV_LVL_M = 2'b11,
    PRIV_LVL_H = 2'b10,
    PRIV_LVL_S = 2'b01,
    PRIV_LVL_U = 2'b00
  } priv_lvl_t;
  typedef struct packed {
    logic uie;
    logic mie;
    logic upie;
    logic mpie;
    priv_lvl_t mpp;
    logic mprv;
  } status_t;
  typedef struct packed {
    logic [31:28] xdebugver;
    logic [27:16] zero2;
    logic         ebreakm;
    logic         zero1;
    logic         ebreaks;
    logic         ebreaku;
    logic         stepie;
    logic         stopcount;
    logic         stoptime;
    logic [8:6]   cause;
    logic         zero0;
    logic         mprven;
    logic         nmip;
    logic         step;
    priv_lvl_t    prv;
  } dcsr_t;
  typedef enum logic [1:0] {
    FS_OFF    = 2'b00,
    FS_INITIAL = 2'b01,
    FS_CLEAN   = 2'b10,
    FS_DIRTY   = 2'b11
  } fs_t;
  parameter int MVENDORID_OFFSET = 7'h2;
  parameter int MVENDORID_BANK = 25'hC;
  parameter int MARCHID = 32'h4;
  parameter int MHPMCOUNTER_WIDTH = 64;
  parameter int SEL_REGFILE = 2'b00;
  parameter int SEL_FW_EX = 2'b01;
  parameter int SEL_FW_WB = 2'b10;
  parameter int OP_A_REGA_OR_FWD = 3'b000;
  parameter int OP_A_CURRPC = 3'b001;
  parameter int OP_A_IMM = 3'b010;
  parameter int OP_A_REGB_OR_FWD = 3'b011;
  parameter int OP_A_REGC_OR_FWD = 3'b100;
  parameter int IMMA_Z = 1'b0;
  parameter int IMMA_ZERO = 1'b1;
  parameter int OP_B_REGB_OR_FWD = 3'b000;
  parameter int OP_B_REGC_OR_FWD = 3'b001;
  parameter int OP_B_IMM = 3'b010;
  parameter int OP_B_REGA_OR_FWD = 3'b011;
  parameter int OP_B_BMASK = 3'b100;
  parameter int IMMB_I = 4'b0000;
  parameter int IMMB_S = 4'b0001;
  parameter int IMMB_U = 4'b0010;
  parameter int IMMB_PCINCR = 4'b0011;
  parameter int IMMB_S2 = 4'b0100;
  parameter int IMMB_S3 = 4'b0101;
  parameter int IMMB_VS = 4'b0110;
  parameter int IMMB_VU = 4'b0111;
  parameter int IMMB_SHUF = 4'b1000;
  parameter int IMMB_CLIP = 4'b1001;
  parameter int IMMB_BI = 4'b1011;
  parameter int BMASK_A_ZERO = 1'b0;
  parameter int BMASK_A_S3 = 1'b1;
  parameter int BMASK_B_S2 = 2'b00;
  parameter int BMASK_B_S3 = 2'b01;
  parameter int BMASK_B_ZERO = 2'b10;
  parameter int BMASK_B_ONE = 2'b11;
  parameter int BMASK_A_REG = 1'b0;
  parameter int BMASK_A_IMM = 1'b1;
  parameter int BMASK_B_REG = 1'b0;
  parameter int BMASK_B_IMM = 1'b1;
  parameter int MIMM_ZERO = 1'b0;
  parameter int MIMM_S3 = 1'b1;
  parameter int OP_C_REGC_OR_FWD = 2'b00;
  parameter int OP_C_REGB_OR_FWD = 2'b01;
  parameter int OP_C_JT = 2'b10;
  parameter int BRANCH_NONE = 2'b00;
  parameter int BRANCH_JAL = 2'b01;
  parameter int BRANCH_JALR = 2'b10;
  parameter int BRANCH_COND = 2'b11;
  parameter int JT_JAL = 2'b01;
  parameter int JT_JALR = 2'b10;
  parameter int JT_COND = 2'b11;
  parameter int AMO_LR = 5'b00010;
  parameter int AMO_SC = 5'b00011;
  parameter int AMO_SWAP = 5'b00001;
  parameter int AMO_ADD = 5'b00000;
  parameter int AMO_XOR = 5'b00100;
  parameter int AMO_AND = 5'b01100;
  parameter int AMO_OR = 5'b01000;
  parameter int AMO_MIN = 5'b10000;
  parameter int AMO_MAX = 5'b10100;
  parameter int AMO_MINU = 5'b11000;
  parameter int AMO_MAXU = 5'b11100;
  parameter int PC_BOOT = 4'b0000;
  parameter int PC_JUMP = 4'b0010;
  parameter int PC_BRANCH = 4'b0011;
  parameter int PC_EXCEPTION = 4'b0100;
  parameter int PC_FENCEI = 4'b0001;
  parameter int PC_MRET = 4'b0101;
  parameter int PC_URET = 4'b0110;
  parameter int PC_DRET = 4'b0111;
  parameter int PC_HWLOOP = 4'b1000;
  parameter int EXC_PC_EXCEPTION = 3'b000;
  parameter int EXC_PC_IRQ = 3'b001;
  parameter int EXC_PC_DBD = 3'b010;
  parameter int EXC_PC_DBE = 3'b011;
  parameter int EXC_CAUSE_INSTR_FAULT = 5'h01;
  parameter int EXC_CAUSE_ILLEGAL_INSN = 5'h02;
  parameter int EXC_CAUSE_BREAKPOINT = 5'h03;
  parameter int EXC_CAUSE_LOAD_FAULT = 5'h05;
  parameter int EXC_CAUSE_STORE_FAULT = 5'h07;
  parameter int EXC_CAUSE_ECALL_UMODE = 5'h08;
  parameter int EXC_CAUSE_ECALL_MMODE = 5'h0B;
  parameter int IRQ_MASK = 32'hFFFF0888;
  parameter int TRAP_MACHINE = 2'b00;
  parameter int TRAP_USER = 2'b01;
  parameter int DBG_CAUSE_NONE = 3'h0;
  parameter int DBG_CAUSE_EBREAK = 3'h1;
  parameter int DBG_CAUSE_TRIGGER = 3'h2;
  parameter int DBG_CAUSE_HALTREQ = 3'h3;
  parameter int DBG_CAUSE_STEP = 3'h4;
  parameter int DBG_CAUSE_RSTHALTREQ = 3'h5;
  parameter int DBG_SETS_W = 6;
  parameter int DBG_SETS_IRQ = 5;
  parameter int DBG_SETS_ECALL = 4;
  parameter int DBG_SETS_EILL = 3;
  parameter int DBG_SETS_ELSU = 2;
  parameter int DBG_SETS_EBRK = 1;
  parameter int DBG_SETS_SSTE = 0;
  parameter int DBG_CAUSE_HALT = 6'h1F;
  typedef enum logic [3:0] {
    XDEBUGVER_NO     = 4'd0,
    XDEBUGVER_STD    = 4'd4,
    XDEBUGVER_NONSTD = 4'd15
  } x_debug_ver_e;
  typedef enum logic [3:0] {
    TTYPE_MCONTROL = 4'h2,
    TTYPE_ICOUNT   = 4'h3,
    TTYPE_ITRIGGER = 4'h4,
    TTYPE_ETRIGGER = 4'h5
  } trigger_type_e;
  parameter bit C_RVF = 1'b1;
  parameter bit C_RVD = 1'b0;
  parameter bit C_XF16 = 1'b0;
  parameter bit C_XF16ALT = 1'b0;
  parameter bit C_XF8 = 1'b0;
  parameter bit C_XFVEC = 1'b0;
  parameter int unsigned C_LAT_FP64 = 'd0;
  parameter int unsigned C_LAT_FP16 = 'd0;
  parameter int unsigned C_LAT_FP16ALT = 'd0;
  parameter int unsigned C_LAT_FP8 = 'd0;
  parameter int unsigned C_LAT_DIVSQRT = 'd1;
  parameter int C_FLEN = C_RVD ? 64 : C_RVF ? 32 : C_XF16 ? 16 : C_XF16ALT ? 16 : C_XF8 ? 8 : 0;
  parameter int C_FFLAG = 5;
  parameter int C_RM = 3;
endpackage


package single_file_rv32imf_fpu_pkg;
  parameter int unsigned NUM_FP_FORMATS = 5;
  parameter int unsigned FP_FORMAT_BITS = $clog2(NUM_FP_FORMATS);
  typedef enum logic [FP_FORMAT_BITS-1:0] {
    FP32    = 'd0,
    FP64    = 'd1,
    FP16    = 'd2,
    FP8     = 'd3,
    FP16ALT = 'd4
  } fp_format_e;
  parameter int unsigned NUM_INT_FORMATS = 4;
  parameter int unsigned INT_FORMAT_BITS = $clog2(NUM_INT_FORMATS);
  typedef enum logic [INT_FORMAT_BITS-1:0] {
    INT8,
    INT16,
    INT32,
    INT64
  } int_format_e;
  parameter int unsigned OP_BITS = 4;
  typedef enum logic [OP_BITS-1:0] {
    FMADD,
    FNMSUB,
    ADD,
    MUL,
    DIV,
    SQRT,
    SGNJ,
    MINMAX,
    CMP,
    CLASSIFY,
    F2F,
    F2I,
    I2F,
    CPKAB,
    CPKCD
  } operation_e;
endpackage


package single_file_fpnew_pkg;
  typedef struct packed {
    int unsigned exp_bits;
    int unsigned man_bits;
  } fp_encoding_t;
  parameter int unsigned NUM_FP_FORMATS = 5;
  parameter int unsigned FP_FORMAT_BITS = $clog2(NUM_FP_FORMATS);
  typedef enum logic [FP_FORMAT_BITS-1:0] {
    FP32    = 'd0,
    FP64    = 'd1,
    FP16    = 'd2,
    FP8     = 'd3,
    FP16ALT = 'd4
  } fp_format_e;
  typedef logic [0:NUM_FP_FORMATS-1] fmt_logic_t;
  typedef logic [0:NUM_FP_FORMATS-1][31:0] fmt_unsigned_t;
  parameter fmt_logic_t CPK_FORMATS = 5'b11000;
  parameter int unsigned NUM_INT_FORMATS = 4;
  parameter int unsigned INT_FORMAT_BITS = $clog2(NUM_INT_FORMATS);
  typedef enum logic [INT_FORMAT_BITS-1:0] {
    INT8,
    INT16,
    INT32,
    INT64
  } int_format_e;
  function automatic int unsigned int_width(int_format_e ifmt);
    unique case (ifmt)
      INT8:  return 8;
      INT16: return 16;
      INT32: return 32;
      INT64: return 64;
      default: begin
        $fatal(1, "Invalid INT format supplied");
        return INT8;
      end
    endcase
  endfunction
  typedef logic [0:NUM_INT_FORMATS-1] ifmt_logic_t;
  parameter int unsigned NUM_OPGROUPS = 4;
  typedef enum logic [1:0] {
    ADDMUL,
    DIVSQRT,
    NONCOMP,
    CONV
  } opgroup_e;
  parameter int unsigned OP_BITS = 4;
  typedef enum logic [OP_BITS-1:0] {
    FMADD,
    FNMSUB,
    ADD,
    MUL,
    DIV,
    SQRT,
    SGNJ,
    MINMAX,
    CMP,
    CLASSIFY,
    F2F,
    F2I,
    I2F,
    CPKAB,
    CPKCD
  } operation_e;
  typedef enum logic [2:0] {
    RNE = 3'b000,
    RTZ = 3'b001,
    RDN = 3'b010,
    RUP = 3'b011,
    RMM = 3'b100,
    ROD = 3'b101,
    DYN = 3'b111
  } roundmode_e;
  typedef struct packed {
    logic NV;
    logic DZ;
    logic OF;
    logic UF;
    logic NX;
  } status_t;
  typedef struct packed {
    logic is_normal;
    logic is_subnormal;
    logic is_zero;
    logic is_inf;
    logic is_nan;
    logic is_signalling;
    logic is_quiet;
    logic is_boxed;
  } fp_info_t;
  typedef enum logic [9:0] {
    NEGINF     = 10'b00_0000_0001,
    NEGNORM    = 10'b00_0000_0010,
    NEGSUBNORM = 10'b00_0000_0100,
    NEGZERO    = 10'b00_0000_1000,
    POSZERO    = 10'b00_0001_0000,
    POSSUBNORM = 10'b00_0010_0000,
    POSNORM    = 10'b00_0100_0000,
    POSINF     = 10'b00_1000_0000,
    SNAN       = 10'b01_0000_0000,
    QNAN       = 10'b10_0000_0000
  } classmask_e;
  typedef enum logic [1:0] {
    BEFORE,
    AFTER,
    INSIDE,
    DISTRIBUTED
  } pipe_config_t;
  typedef enum logic [1:0] {
    DISABLED,
    PARALLEL,
    MERGED
  } unit_type_t;
  typedef unit_type_t [0:NUM_FP_FORMATS-1] fmt_unit_types_t;
  typedef fmt_unit_types_t [0:NUM_OPGROUPS-1] opgrp_fmt_unit_types_t;
  typedef fmt_unsigned_t [0:NUM_OPGROUPS-1] opgrp_fmt_unsigned_t;
  typedef struct packed {
    int unsigned Width;
    logic        EnableVectors;
    logic        EnableNanBox;
    fmt_logic_t  FpFmtMask;
    ifmt_logic_t IntFmtMask;
  } fpu_features_t;
  parameter fpu_features_t RV64D = '{
      Width: 64,
      EnableVectors: 1'b0,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b11000,
      IntFmtMask: 4'b0011
  };
  parameter fpu_features_t RV32D = '{
      Width: 64,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b11000,
      IntFmtMask: 4'b0010
  };
  parameter fpu_features_t RV32F = '{
      Width: 32,
      EnableVectors: 1'b0,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b10000,
      IntFmtMask: 4'b0010
  };
  parameter fpu_features_t RV64D_XSFLT = '{
      Width: 64,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b11111,
      IntFmtMask: 4'b1111
  };
  parameter fpu_features_t RV32F_XSFLT = '{
      Width: 32,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b10111,
      IntFmtMask: 4'b1110
  };
  parameter fpu_features_t RV32F_XF16ALT_XFVEC = '{
      Width: 32,
      EnableVectors: 1'b1,
      EnableNanBox: 1'b1,
      FpFmtMask: 5'b10001,
      IntFmtMask: 4'b0110
  };
  typedef struct packed {
    opgrp_fmt_unsigned_t PipeRegs;
    opgrp_fmt_unit_types_t UnitTypes;
    pipe_config_t PipeConfig;
  } fpu_implementation_t;
  parameter fpu_implementation_t DEFAULT_NOREGS = '{
      PipeRegs: '{default: 0},
      UnitTypes: '{
          '{default: PARALLEL},
          '{default: MERGED},
          '{default: PARALLEL},
          '{default: MERGED}
      },
      PipeConfig: BEFORE
  };
  parameter fpu_implementation_t DEFAULT_SNITCH = '{
      PipeRegs: '{default: 1},
      UnitTypes: '{
          '{default: PARALLEL},
          '{default: DISABLED},
          '{default: PARALLEL},
          '{default: MERGED}
      },
      PipeConfig: BEFORE
  };
  parameter logic DONT_CARE = 1'b1;
  function automatic int minimum(int a, int b);
    return (a < b) ? a : b;
  endfunction
  function automatic int maximum(int a, int b);
    return (a > b) ? a : b;
  endfunction
  function automatic int unsigned fp_width(fp_format_e fmt);
    case (fmt)
      default: return 32;
      FP64:    return 64;
      FP16:    return 16;
      FP8:     return 8;
      FP16ALT: return 16;
    endcase
  endfunction
  function automatic int unsigned max_fp_width(fmt_logic_t cfg);
    automatic int unsigned res = 0;
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++)
    if (cfg[i]) res = unsigned'(maximum(res, fp_width(fp_format_e'(i))));
    return res;
  endfunction
  function automatic int unsigned min_fp_width(fmt_logic_t cfg);
    automatic int unsigned res = max_fp_width(cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++)
    if (cfg[i]) res = unsigned'(minimum(res, fp_width(fp_format_e'(i))));
    return res;
  endfunction
  function automatic int unsigned exp_bits(fp_format_e fmt);
    case (fmt)
      default: return 8;
      FP64:    return 11;
      FP16:    return 5;
      FP8:     return 5;
      FP16ALT: return 8;
    endcase
  endfunction
  function automatic int unsigned man_bits(fp_format_e fmt);
    case (fmt)
      default: return 23;
      FP64:    return 52;
      FP16:    return 10;
      FP8:     return 2;
      FP16ALT: return 7;
    endcase
  endfunction
  function automatic int unsigned bias(fp_format_e fmt);
    case (fmt)
      default: return 127;
      FP64:    return 1023;
      FP16:    return 15;
      FP8:     return 15;
      FP16ALT: return 127;
    endcase
  endfunction
  function automatic fp_encoding_t super_format(fmt_logic_t cfg);
    automatic fp_encoding_t res;
    res = '0;
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)
    if (cfg[fmt]) begin
      res.exp_bits = unsigned'(maximum(res.exp_bits, exp_bits(fp_format_e'(fmt))));
      res.man_bits = unsigned'(maximum(res.man_bits, man_bits(fp_format_e'(fmt))));
    end
    return res;
  endfunction
  function automatic int unsigned max_int_width(ifmt_logic_t cfg);
    automatic int unsigned res = 0;
    for (int ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++) begin
      if (cfg[ifmt]) res = maximum(res, int_width(int_format_e'(ifmt)));
    end
    return res;
  endfunction
  function automatic opgroup_e get_opgroup(operation_e op);
    unique case (op)
      FMADD, FNMSUB, ADD, MUL:     return ADDMUL;
      DIV, SQRT:                   return DIVSQRT;
      SGNJ, MINMAX, CMP, CLASSIFY: return NONCOMP;
      F2F, F2I, I2F, CPKAB, CPKCD: return CONV;
      default:                     return NONCOMP;
    endcase
  endfunction
  function automatic int unsigned num_operands(opgroup_e grp);
    unique case (grp)
      ADDMUL:  return 3;
      DIVSQRT: return 2;
      NONCOMP: return 2;
      CONV:    return 3;
      default: return 0;
    endcase
  endfunction
  function automatic int unsigned num_lanes(int unsigned width, fp_format_e fmt, logic vec);
    return vec ? width / fp_width(fmt) : 1;
  endfunction
  function automatic int unsigned max_num_lanes(int unsigned width, fmt_logic_t cfg, logic vec);
    return vec ? width / min_fp_width(cfg) : 1;
  endfunction
  function automatic fmt_logic_t get_lane_formats(int unsigned width, fmt_logic_t cfg,
                                                  int unsigned lane_no);
    automatic fmt_logic_t res;
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)
    res[fmt] = cfg[fmt] & (width / fp_width(fp_format_e'(fmt)) > lane_no);
    return res;
  endfunction
  function automatic ifmt_logic_t get_lane_int_formats(int unsigned width, fmt_logic_t cfg,
                                                       ifmt_logic_t icfg, int unsigned lane_no);
    automatic ifmt_logic_t res;
    automatic fmt_logic_t  lanefmts;
    res = '0;
    lanefmts = get_lane_formats(width, cfg, lane_no);
    for (int unsigned ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++)
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)
    if ((fp_width(fp_format_e'(fmt)) == int_width(int_format_e'(ifmt))))
      res[ifmt] |= icfg[ifmt] && lanefmts[fmt];
    return res;
  endfunction
  function automatic fmt_logic_t get_conv_lane_formats(int unsigned width, fmt_logic_t cfg,
                                                       int unsigned lane_no);
    automatic fmt_logic_t res;
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)
    res[fmt] = cfg[fmt] &&
        ((width / fp_width(fp_format_e'(fmt)) > lane_no) || (CPK_FORMATS[fmt] && (lane_no < 2)));
    return res;
  endfunction
  function automatic ifmt_logic_t get_conv_lane_int_formats(
      int unsigned width, fmt_logic_t cfg, ifmt_logic_t icfg, int unsigned lane_no);
    automatic ifmt_logic_t res;
    automatic fmt_logic_t  lanefmts;
    res = '0;
    lanefmts = get_conv_lane_formats(width, cfg, lane_no);
    for (int unsigned ifmt = 0; ifmt < NUM_INT_FORMATS; ifmt++)
    for (int unsigned fmt = 0; fmt < NUM_FP_FORMATS; fmt++)
    res[ifmt] |= icfg[ifmt] && lanefmts[fmt] && (fp_width(
        fp_format_e'(fmt)
    ) == int_width(
        int_format_e'(ifmt)
    ));
    return res;
  endfunction
  function automatic logic any_enabled_multi(fmt_unit_types_t types, fmt_logic_t cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++) begin
      if (cfg[i] && types[i] == MERGED) return 1'b1;
    end
    return 1'b0;
  endfunction
  function automatic logic is_first_enabled_multi(fp_format_e fmt, fmt_unit_types_t types,
                                                  fmt_logic_t cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++) begin
      if (cfg[i] && types[i] == MERGED) return (fp_format_e'(i) == fmt);
    end
    return 1'b0;
  endfunction
  function automatic fp_format_e get_first_enabled_multi(fmt_unit_types_t types, fmt_logic_t cfg);
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++)
    if (cfg[i] && types[i] == MERGED) return fp_format_e'(i);
    return fp_format_e'(0);
  endfunction
  function automatic int unsigned get_num_regs_multi(fmt_unsigned_t regs, fmt_unit_types_t types,
                                                     fmt_logic_t cfg);
    automatic int unsigned res = 0;
    for (int unsigned i = 0; i < NUM_FP_FORMATS; i++) begin
      if (cfg[i] && types[i] == MERGED) res = maximum(res, regs[i]);
    end
    return res;
  endfunction
endpackage


module single_file_rv32imf_clock_gate (
    input  logic clk_i,
    input  logic en_i,
    output logic clk_o
);
  logic clk_en;
  always_ff @(posedge clk_i) begin
    clk_en <= en_i;
  end
  assign clk_o = clk_i & clk_en;
endmodule


module single_file_rv32imf_sleep_unit (
    input  logic clk_i,
    input  logic rst_n,
    output logic clk_gated_o,
    output logic fetch_enable_o,
    input logic if_busy_i,
    input logic ctrl_busy_i,
    input logic lsu_busy_i,
    input logic apu_busy_i,
    input logic wake_from_sleep_i
);
  import single_file_rv32imf_pkg::*;
  logic fetch_enable_q;
  logic core_busy_q;
  logic core_busy_d;
  logic clock_en;
  assign core_busy_d = if_busy_i || ctrl_busy_i || lsu_busy_i || apu_busy_i;
  assign clock_en = fetch_enable_q && (wake_from_sleep_i || core_busy_q);
  always_ff @(posedge clk_i, negedge rst_n) begin
    if (!rst_n) begin
      core_busy_q <= 1'b0;
      fetch_enable_q <= 1'b1;
    end else begin
      core_busy_q    <= core_busy_d;
      fetch_enable_q <= 1'b1;
    end
  end
  assign fetch_enable_o = fetch_enable_q;
  single_file_rv32imf_clock_gate core_clock_gate_i (
      .clk_i(clk_i),
      .en_i (clock_en),
      .clk_o(clk_gated_o)
  );
endmodule


module single_file_rv32imf_prefetch_controller #(
    parameter int DEPTH           = 4,
    parameter int FIFO_ADDR_DEPTH = (DEPTH > 1) ? $clog2(DEPTH) : 1
) (
    input logic clk,
    input logic rst_n,
    input  logic        req_i,
    input  logic        branch_i,
    input  logic [31:0] branch_addr_i,
    output logic        busy_o,
    input logic [31:0] hwlp_target_i,
    output logic        trans_valid_o,
    input  logic        trans_ready_i,
    output logic [31:0] trans_addr_o,
    input logic resp_valid_i,
    input  logic fetch_ready_i,
    output logic fetch_valid_o,
    output logic                     fifo_push_o,
    output logic                     fifo_pop_o,
    output logic                     fifo_flush_o,
    input  logic [FIFO_ADDR_DEPTH:0] fifo_cnt_i,
    input  logic                     fifo_empty_i
);
  import single_file_rv32imf_pkg::*;
  typedef enum logic [1:0] {
    IDLE,
    BRANCH_WAIT
  } prefetch_state_e;
  prefetch_state_e state_q, next_state;
  logic [FIFO_ADDR_DEPTH:0] cnt_q;
  logic [FIFO_ADDR_DEPTH:0] next_cnt;
  logic                     count_up;
  logic                     count_down;
  logic [FIFO_ADDR_DEPTH:0] flush_cnt_q;
  logic [FIFO_ADDR_DEPTH:0] next_flush_cnt;
  logic [31:0] trans_addr_q, trans_addr_incr;
  logic [             31:0] aligned_branch_addr;
  logic                     fifo_valid;
  logic [FIFO_ADDR_DEPTH:0] fifo_cnt_masked;
  assign busy_o = (cnt_q != '0) || trans_valid_o;
  assign fetch_valid_o = (fifo_valid || resp_valid_i) && !(branch_i || (flush_cnt_q > '0));
  assign aligned_branch_addr = {branch_addr_i[31:2], 2'b00};
  assign trans_addr_incr = {trans_addr_q[31:2], 2'b00} + 32'd4;
  assign trans_valid_o = req_i && (fifo_cnt_masked + cnt_q < DEPTH);
  assign fifo_cnt_masked = (branch_i) ? '0 : fifo_cnt_i;
  always_comb begin
    next_state   = state_q;
    trans_addr_o = trans_addr_q;
    case (state_q)
      default: begin
        if (branch_i) begin
          trans_addr_o = aligned_branch_addr;
        end else begin
          trans_addr_o = trans_addr_incr;
        end
        if ((branch_i) && !(trans_valid_o && trans_ready_i)) begin
          next_state = BRANCH_WAIT;
        end
      end
      BRANCH_WAIT: begin
        trans_addr_o = branch_i ? aligned_branch_addr : trans_addr_q;
        if (trans_valid_o && trans_ready_i) begin
          next_state = IDLE;
        end
      end
    endcase
  end
  assign fifo_valid = !fifo_empty_i;
  assign fifo_push_o = resp_valid_i &&
                       (fifo_valid || !fetch_ready_i) && !(branch_i || (flush_cnt_q > '0));
  assign fifo_pop_o = fifo_valid && fetch_ready_i;
  assign count_up = trans_valid_o && trans_ready_i;
  assign count_down = resp_valid_i;
  always_comb begin
    case ({
      count_up, count_down
    })
      2'b01:   next_cnt = cnt_q - 1'b1;
      2'b10:   next_cnt = cnt_q + 1'b1;
      default: next_cnt = cnt_q;
    endcase
  end
  assign fifo_flush_o = branch_i;
  always_comb begin
    next_flush_cnt = flush_cnt_q;
    if (branch_i) begin
      next_flush_cnt = cnt_q;
      if (resp_valid_i && (cnt_q > '0)) begin
        next_flush_cnt = cnt_q - 1'b1;
      end
    end else if (resp_valid_i && (flush_cnt_q > '0)) begin
      next_flush_cnt = flush_cnt_q - 1'b1;
    end
  end
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      state_q      <= IDLE;
      cnt_q        <= '0;
      flush_cnt_q  <= '0;
      trans_addr_q <= '0;
    end else begin
      state_q     <= next_state;
      cnt_q       <= next_cnt;
      flush_cnt_q <= next_flush_cnt;
      if (branch_i || (trans_valid_o && trans_ready_i)) begin
        trans_addr_q <= trans_addr_o;
      end
    end
  end
endmodule


module single_file_rv32imf_fifo #(
    parameter bit FALL_THROUGH = 1'b0,
    parameter int unsigned DATA_WIDTH = 32,
    parameter int unsigned DEPTH = 8,
    parameter int unsigned ADDR_DEPTH = (DEPTH > 1) ? $clog2(DEPTH) : 1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic flush_i,
    input logic flush_but_first_i,
    input logic testmode_i,
    output logic full_o,
    output logic empty_o,
    output logic [ADDR_DEPTH:0] cnt_o,
    input logic [DATA_WIDTH-1:0] data_i,
    input logic push_i,
    output logic [DATA_WIDTH-1:0] data_o,
    input logic pop_i
);
  localparam int unsigned FifoDepth = (DEPTH > 0) ? DEPTH : 1;
  logic gate_clock;
  logic [ADDR_DEPTH - 1:0] read_pointer_n, read_pointer_q, write_pointer_n, write_pointer_q;
  logic [ADDR_DEPTH:0] status_cnt_n, status_cnt_q;
  logic [FifoDepth - 1:0][DATA_WIDTH-1:0] mem_n, mem_q;
  assign cnt_o = status_cnt_q;
  generate
    if (DEPTH == 0) begin : gen_zero_depth
      assign empty_o = ~push_i;
      assign full_o  = ~pop_i;
    end else begin : gen_non_zero_depth
      assign full_o  = (status_cnt_q == FifoDepth[ADDR_DEPTH:0]);
      assign empty_o = (status_cnt_q == 0) & ~(FALL_THROUGH & push_i);
    end
  endgenerate
  always_comb begin : read_write_comb
    read_pointer_n  = read_pointer_q;
    write_pointer_n = write_pointer_q;
    status_cnt_n    = status_cnt_q;
    data_o          = (DEPTH == 0) ? data_i : mem_q[read_pointer_q];
    mem_n           = mem_q;
    gate_clock      = 1'b1;
    if (push_i && ~full_o) begin
      mem_n[write_pointer_q] = data_i;
      gate_clock = 1'b0;
      if (write_pointer_q == FifoDepth[ADDR_DEPTH-1:0] - 1) write_pointer_n = '0;
      else write_pointer_n = write_pointer_q + 1;
      status_cnt_n = status_cnt_q + 1;
    end
    if (pop_i && ~empty_o) begin
      if (read_pointer_n == FifoDepth[ADDR_DEPTH-1:0] - 1) read_pointer_n = '0;
      else read_pointer_n = read_pointer_q + 1;
      status_cnt_n = status_cnt_q - 1;
    end
    if (push_i && pop_i && ~full_o && ~empty_o) status_cnt_n = status_cnt_q;
    if (FALL_THROUGH && (status_cnt_q == 0) && push_i) begin
      data_o = data_i;
      if (pop_i) begin
        status_cnt_n = status_cnt_q;
        read_pointer_n = read_pointer_q;
        write_pointer_n = write_pointer_q;
      end
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      read_pointer_q  <= '0;
      write_pointer_q <= '0;
      status_cnt_q    <= '0;
    end else begin
      unique case (1'b1)
        flush_i: begin
          read_pointer_q  <= '0;
          write_pointer_q <= '0;
          status_cnt_q    <= '0;
        end
        flush_but_first_i: begin
          read_pointer_q  <= (status_cnt_q > 0) ? read_pointer_q : '0;
          write_pointer_q <= (status_cnt_q > 0) ? read_pointer_q + 1 : '0;
          status_cnt_q    <= (status_cnt_q > 0) ? 1'b1 : '0;
        end
        default: begin
          read_pointer_q  <= read_pointer_n;
          write_pointer_q <= write_pointer_n;
          status_cnt_q    <= status_cnt_n;
        end
      endcase
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      mem_q <= '0;
    end else if (!gate_clock) begin
      mem_q <= mem_n;
    end
  end
endmodule


module single_file_rv32imf_obi_interface #(
    parameter int TRANS_STABLE = 0
) (
    input logic clk,
    input logic rst_n,
    input logic trans_valid_i,
    output logic trans_ready_o,
    input logic [31:0] trans_addr_i,
    input logic trans_we_i,
    input logic [3:0] trans_be_i,
    input logic [31:0] trans_wdata_i,
    input logic [5:0] trans_atop_i,
    output logic resp_valid_o,
    output logic [31:0] resp_rdata_o,
    output logic resp_err_o,
    output logic        obi_req_o,
    input  logic        obi_gnt_i,
    output logic [31:0] obi_addr_o,
    output logic        obi_we_o,
    output logic [ 3:0] obi_be_o,
    output logic [31:0] obi_wdata_o,
    output logic [ 5:0] obi_atop_o,
    input  logic [31:0] obi_rdata_i,
    input  logic        obi_rvalid_i,
    input  logic        obi_err_i
);
  typedef enum logic {
    TRANSPARENT,
    REGISTERED
  } state_t;
  state_t state_q, next_state;
  assign resp_valid_o = obi_rvalid_i;
  assign resp_rdata_o = obi_rdata_i;
  assign resp_err_o   = obi_err_i;
  generate
    if (TRANS_STABLE) begin : gen_trans_stable
      assign obi_req_o     = trans_valid_i;
      assign obi_addr_o    = trans_addr_i;
      assign obi_we_o      = trans_we_i;
      assign obi_be_o      = trans_be_i;
      assign obi_wdata_o   = trans_wdata_i;
      assign obi_atop_o    = trans_atop_i;
      assign trans_ready_o = obi_gnt_i;
      assign state_q       = TRANSPARENT;
      assign next_state    = TRANSPARENT;
    end else begin : gen_no_trans_stable
      logic [31:0] obi_addr_q;
      logic        obi_we_q;
      logic [ 3:0] obi_be_q;
      logic [31:0] obi_wdata_q;
      logic [ 5:0] obi_atop_q;
      always_comb begin
        next_state = state_q;
        case (state_q)
          default: begin
            if (obi_req_o && !obi_gnt_i) begin
              next_state = REGISTERED;
            end
          end
          REGISTERED: begin
            if (obi_gnt_i) begin
              next_state = TRANSPARENT;
            end
          end
        endcase
      end
      always_comb begin
        if (state_q == TRANSPARENT) begin
          obi_req_o   = trans_valid_i;
          obi_addr_o  = trans_addr_i;
          obi_we_o    = trans_we_i;
          obi_be_o    = trans_be_i;
          obi_wdata_o = trans_wdata_i;
          obi_atop_o  = trans_atop_i;
        end else begin
          obi_req_o   = 1'b1;
          obi_addr_o  = obi_addr_q;
          obi_we_o    = obi_we_q;
          obi_be_o    = obi_be_q;
          obi_wdata_o = obi_wdata_q;
          obi_atop_o  = obi_atop_q;
        end
      end
      always_ff @(posedge clk, negedge rst_n) begin
        if (rst_n == 1'b0) begin
          state_q   <= TRANSPARENT;
          obi_addr_q  <= 32'b0;
          obi_we_q    <= 1'b0;
          obi_be_q    <= 4'b0;
          obi_wdata_q <= 32'b0;
          obi_atop_q  <= 6'b0;
        end else begin
          state_q <= next_state;
          if ((state_q == TRANSPARENT) && (next_state == REGISTERED)) begin
            obi_addr_q  <= obi_addr_o;
            obi_we_q    <= obi_we_o;
            obi_be_q    <= obi_be_o;
            obi_wdata_q <= obi_wdata_o;
            obi_atop_q  <= obi_atop_o;
          end
        end
      end
      assign trans_ready_o = (state_q == TRANSPARENT);
    end
  endgenerate
endmodule


module single_file_rv32imf_prefetch_buffer (
    input logic clk,
    input logic rst_n,
    input logic        req_i,
    input logic        branch_i,
    input logic [31:0] branch_addr_i,
    input logic [31:0] hwlp_target_i,
    input  logic        fetch_ready_i,
    output logic        fetch_valid_o,
    output logic [31:0] fetch_rdata_o,
    output logic        instr_req_o,
    input  logic        instr_gnt_i,
    output logic [31:0] instr_addr_o,
    input  logic [31:0] instr_rdata_i,
    input  logic        instr_rvalid_i,
    input  logic        instr_err_i,
    input  logic        instr_err_pmp_i,
    output logic busy_o
);
  localparam int FifoDepth = 2;
  localparam int unsigned FifoAddrDepth = $clog2(FifoDepth);
  logic                   trans_valid;
  logic                   trans_ready;
  logic [           31:0] trans_addr;
  logic                   fifo_flush;
  logic                   fifo_flush_but_first;
  logic [FifoAddrDepth:0] fifo_cnt;
  logic [           31:0] fifo_rdata;
  logic                   fifo_push;
  logic                   fifo_pop;
  logic                   fifo_empty;
  logic                   resp_valid;
  logic [           31:0] resp_rdata;
  logic                   resp_err;
  single_file_rv32imf_prefetch_controller #(
      .DEPTH(FifoDepth)
  ) prefetch_controller_i (
      .clk  (clk),
      .rst_n(rst_n),
      .req_i        (req_i),
      .branch_i     (branch_i),
      .branch_addr_i(branch_addr_i),
      .busy_o       (busy_o),
      .hwlp_target_i(hwlp_target_i),
      .trans_valid_o(trans_valid),
      .trans_ready_i(trans_ready),
      .trans_addr_o (trans_addr),
      .resp_valid_i(resp_valid),
      .fetch_ready_i(fetch_ready_i),
      .fetch_valid_o(fetch_valid_o),
      .fifo_push_o (fifo_push),
      .fifo_pop_o  (fifo_pop),
      .fifo_flush_o(fifo_flush),
      .fifo_cnt_i  (fifo_cnt),
      .fifo_empty_i(fifo_empty)
  );
  single_file_rv32imf_fifo #(
      .FALL_THROUGH(1'b0),
      .DATA_WIDTH  (32),
      .DEPTH       (FifoDepth)
  ) fifo_i (
      .clk_i            (clk),
      .rst_ni           (rst_n),
      .flush_i          (fifo_flush),
      .flush_but_first_i('0),
      .testmode_i       (1'b0),
      .full_o           (),
      .empty_o          (fifo_empty),
      .cnt_o            (fifo_cnt),
      .data_i           (resp_rdata),
      .push_i           (fifo_push),
      .data_o           (fifo_rdata),
      .pop_i            (fifo_pop)
  );
  assign fetch_rdata_o = fifo_empty ? resp_rdata : fifo_rdata;
  single_file_rv32imf_obi_interface #(
      .TRANS_STABLE(0)
  ) instruction_obi_i (
      .clk  (clk),
      .rst_n(rst_n),
      .trans_valid_i(trans_valid),
      .trans_ready_o(trans_ready),
      .trans_addr_i ({trans_addr[31:2], 2'b00}),
      .trans_we_i   (1'b0),
      .trans_be_i   (4'b1111),
      .trans_wdata_i(32'b0),
      .trans_atop_i (6'b0),
      .resp_valid_o(resp_valid),
      .resp_rdata_o(resp_rdata),
      .resp_err_o  (resp_err),
      .obi_req_o   (instr_req_o),
      .obi_gnt_i   (instr_gnt_i),
      .obi_addr_o  (instr_addr_o),
      .obi_we_o    (),
      .obi_be_o    (),
      .obi_wdata_o (),
      .obi_atop_o  (),
      .obi_rdata_i (instr_rdata_i),
      .obi_rvalid_i(instr_rvalid_i),
      .obi_err_i   (instr_err_i)
  );
endmodule


module single_file_rv32imf_aligner (
    input logic clk,
    input logic rst_n,
    input  logic fetch_valid_i,
    output logic aligner_ready_o,
    input logic if_valid_i,
    input  logic [31:0] fetch_rdata_i,
    output logic [31:0] instr_aligned_o,
    output logic        instr_valid_o,
    input logic [31:0] branch_addr_i,
    input logic        branch_i,
    input logic [31:0] hwlp_addr_i,
    output logic [31:0] pc_o
);
  typedef enum logic [2:0] {
    ALIGNED32,
    MISALIGNED32,
    MISALIGNED16,
    BRANCH_MISALIGNED,
    WAIT_VALID_BRANCH
  } state_t;
  state_t state, next_state;
  logic [15:0] r_instr_h;
  logic [31:0] hwlp_addr_q;
  logic [31:0] pc_q, pc_n;
  logic update_state;
  logic [31:0] pc_plus4, pc_plus2;
  logic aligner_ready_q, hwlp_update_pc_q;
  assign pc_o = pc_q;
  assign pc_plus2 = pc_q + 2;
  assign pc_plus4 = pc_q + 4;
  always_ff @(posedge clk or negedge rst_n) begin : proc_SEQ_FSM
    if (~rst_n) begin
      state            <= ALIGNED32;
      r_instr_h        <= '0;
      hwlp_addr_q      <= '0;
      pc_q             <= '0;
      aligner_ready_q  <= 1'b0;
      hwlp_update_pc_q <= 1'b0;
    end else begin
      if (update_state) begin
        pc_q             <= pc_n;
        state            <= next_state;
        r_instr_h        <= fetch_rdata_i[31:16];
        aligner_ready_q  <= aligner_ready_o;
        hwlp_update_pc_q <= 1'b0;
      end
    end
  end
  always_comb begin
    pc_n            = pc_q;
    instr_valid_o   = fetch_valid_i;
    instr_aligned_o = fetch_rdata_i;
    aligner_ready_o = 1'b1;
    update_state    = 1'b0;
    next_state      = state;
    case (state)
      ALIGNED32: begin
        if (fetch_rdata_i[1:0] == 2'b11) begin
          next_state      = ALIGNED32;
          pc_n            = pc_plus4;
          instr_aligned_o = fetch_rdata_i;
          update_state    = fetch_valid_i & if_valid_i;
          if (hwlp_update_pc_q) pc_n = hwlp_addr_q;
        end else begin
          next_state      = MISALIGNED32;
          pc_n            = pc_plus2;
          instr_aligned_o = fetch_rdata_i;
          update_state    = fetch_valid_i & if_valid_i;
        end
      end
      MISALIGNED32: begin
        if (r_instr_h[1:0] == 2'b11) begin
          next_state = MISALIGNED32;
          pc_n = pc_plus4;
          instr_aligned_o = {
            fetch_rdata_i[15:0], r_instr_h[15:0]
          };
          update_state = fetch_valid_i & if_valid_i;
        end else begin
          instr_aligned_o = {
            fetch_rdata_i[31:16], r_instr_h[15:0]
          };
          next_state = MISALIGNED16;
          instr_valid_o = 1'b1;
          pc_n = pc_plus2;
          aligner_ready_o = !fetch_valid_i;
          update_state = if_valid_i;
        end
      end
      MISALIGNED16: begin
        instr_valid_o = !aligner_ready_q || fetch_valid_i;
        if (fetch_rdata_i[1:0] == 2'b11) begin
          next_state      = ALIGNED32;
          pc_n            = pc_plus4;
          instr_aligned_o = fetch_rdata_i;
          update_state    = (!aligner_ready_q | fetch_valid_i) & if_valid_i;
        end else begin
          next_state      = MISALIGNED32;
          pc_n            = pc_plus2;
          instr_aligned_o = fetch_rdata_i;
          update_state    = (!aligner_ready_q | fetch_valid_i) & if_valid_i;
        end
      end
      BRANCH_MISALIGNED: begin
        if (fetch_rdata_i[17:16] == 2'b11) begin
          next_state      = MISALIGNED32;
          instr_valid_o   = 1'b0;
          pc_n            = pc_q;
          instr_aligned_o = fetch_rdata_i;
          update_state    = fetch_valid_i & if_valid_i;
        end else begin
          next_state      = ALIGNED32;
          pc_n            = pc_plus2;
          instr_aligned_o = {fetch_rdata_i[31:16], fetch_rdata_i[31:16]};
          update_state    = fetch_valid_i & if_valid_i;
        end
      end
      default: ;
    endcase
    if (branch_i) begin
      update_state = 1'b1;
      pc_n = branch_addr_i;
      next_state = branch_addr_i[1] ? BRANCH_MISALIGNED : ALIGNED32;
    end
  end
endmodule


module single_file_rv32imf_compressed_decoder (
    input  logic [31:0] instr_i,
    output logic [31:0] instr_o,
    output logic        is_compressed_o,
    output logic        illegal_instr_o
);
  import single_file_rv32imf_pkg::*;
  always_comb begin
    illegal_instr_o = 1'b0;
    instr_o         = '0;
    unique case (instr_i[1:0])
      2'b00: begin
        unique case (instr_i[15:13])
          3'b000: begin
            instr_o = {
              2'b0,
              instr_i[10:7],
              instr_i[12:11],
              instr_i[5],
              instr_i[6],
              2'b00,
              5'h02,
              3'b000,
              2'b01,
              instr_i[4:2],
              OPCODE_OPIMM
            };
            if (instr_i[12:5] == 8'b0) illegal_instr_o = 1'b1;
          end
          3'b001: begin
            instr_o = {
              4'b0,
              instr_i[6:5],
              instr_i[12:10],
              3'b000,
              2'b01,
              instr_i[9:7],
              3'b011,
              2'b01,
              instr_i[4:2],
              OPCODE_LOAD_FP
            };
          end
          3'b010: begin
            instr_o = {
              5'b0,
              instr_i[5],
              instr_i[12:10],
              instr_i[6],
              2'b00,
              2'b01,
              instr_i[9:7],
              3'b010,
              2'b01,
              instr_i[4:2],
              OPCODE_LOAD
            };
          end
          3'b011: begin
            instr_o = {
              5'b0,
              instr_i[5],
              instr_i[12:10],
              instr_i[6],
              2'b00,
              2'b01,
              instr_i[9:7],
              3'b010,
              2'b01,
              instr_i[4:2],
              OPCODE_LOAD_FP
            };
          end
          3'b100: begin
            illegal_instr_o = 1'b1;
          end
          3'b101: begin
            instr_o = {
              4'b0,
              instr_i[6:5],
              instr_i[12],
              2'b01,
              instr_i[4:2],
              2'b01,
              instr_i[9:7],
              3'b011,
              instr_i[11:10],
              3'b000,
              OPCODE_STORE_FP
            };
          end
          3'b110: begin
            instr_o = {
              5'b0,
              instr_i[5],
              instr_i[12],
              2'b01,
              instr_i[4:2],
              2'b01,
              instr_i[9:7],
              3'b010,
              instr_i[11:10],
              instr_i[6],
              2'b00,
              OPCODE_STORE
            };
          end
          3'b111: begin
            instr_o = {
              5'b0,
              instr_i[5],
              instr_i[12],
              2'b01,
              instr_i[4:2],
              2'b01,
              instr_i[9:7],
              3'b010,
              instr_i[11:10],
              instr_i[6],
              2'b00,
              OPCODE_STORE_FP
            };
          end
          default: begin
            illegal_instr_o = 1'b1;
          end
        endcase
      end
      2'b01: begin
        unique case (instr_i[15:13])
          3'b000: begin
            instr_o = {
              {6{instr_i[12]}},
              instr_i[12],
              instr_i[6:2],
              instr_i[11:7],
              3'b0,
              instr_i[11:7],
              OPCODE_OPIMM
            };
          end
          3'b001, 3'b101: begin
            instr_o = {
              instr_i[12],
              instr_i[8],
              instr_i[10:9],
              instr_i[6],
              instr_i[7],
              instr_i[2],
              instr_i[11],
              instr_i[5:3],
              {9{instr_i[12]}},
              4'b0,
              ~instr_i[15],
              OPCODE_JAL
            };
          end
          3'b010: begin
            if (instr_i[11:7] == 5'b0) begin
              illegal_instr_o = 1'b1;
            end else begin
              instr_o = {
                {6{instr_i[12]}},
                instr_i[12],
                instr_i[6:2],
                5'b0,
                3'b0,
                instr_i[11:7],
                OPCODE_OPIMM
              };
            end
          end
          3'b011: begin
            if ({instr_i[12], instr_i[6:2]} == 6'b0) begin
              illegal_instr_o = 1'b1;
            end else begin
              if (instr_i[11:7] == 5'h02) begin
                instr_o = {
                  {3{instr_i[12]}},
                  instr_i[4:3],
                  instr_i[5],
                  instr_i[2],
                  instr_i[6],
                  4'b0,
                  5'h02,
                  3'b000,
                  5'h02,
                  OPCODE_OPIMM
                };
              end else if (instr_i[11:7] == 5'b0) begin
                illegal_instr_o = 1'b1;
              end else begin
                instr_o = {{15{instr_i[12]}}, instr_i[6:2], instr_i[11:7], OPCODE_LUI};
              end
            end
          end
          3'b100: begin
            unique case (instr_i[11:10])
              2'b00, 2'b01: begin
                if (instr_i[12] == 1'b1) begin
                  illegal_instr_o = 1'b1;
                end else begin
                  if (instr_i[6:2] == 5'b0) begin
                    illegal_instr_o = 1'b1;
                  end else begin
                    instr_o = {
                      1'b0,
                      instr_i[10],
                      5'b0,
                      instr_i[6:2],
                      2'b01,
                      instr_i[9:7],
                      3'b101,
                      2'b01,
                      instr_i[9:7],
                      OPCODE_OPIMM
                    };
                  end
                end
              end
              2'b10: begin
                instr_o = {
                  {6{instr_i[12]}},
                  instr_i[12],
                  instr_i[6:2],
                  2'b01,
                  instr_i[9:7],
                  3'b111,
                  2'b01,
                  instr_i[9:7],
                  OPCODE_OPIMM
                };
              end
              2'b11: begin
                unique case ({
                  instr_i[12], instr_i[6:5]
                })
                  3'b000: begin
                    instr_o = {
                      2'b01,
                      5'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b000,
                      2'b01,
                      instr_i[9:7],
                      OPCODE_OP
                    };
                  end
                  3'b001: begin
                    instr_o = {
                      7'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b100,
                      2'b01,
                      instr_i[9:7],
                      OPCODE_OP
                    };
                  end
                  3'b010: begin
                    instr_o = {
                      7'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b110,
                      2'b01,
                      instr_i[9:7],
                      OPCODE_OP
                    };
                  end
                  3'b011: begin
                    instr_o = {
                      7'b0,
                      2'b01,
                      instr_i[4:2],
                      2'b01,
                      instr_i[9:7],
                      3'b111,
                      2'b01,
                      instr_i[9:7],
                      OPCODE_OP
                    };
                  end
                  3'b100, 3'b101, 3'b110, 3'b111: begin
                    illegal_instr_o = 1'b1;
                  end
                endcase
              end
            endcase
          end
          3'b110, 3'b111: begin
            instr_o = {
              {4{instr_i[12]}},
              instr_i[6:5],
              instr_i[2],
              5'b0,
              2'b01,
              instr_i[9:7],
              2'b00,
              instr_i[13],
              instr_i[11:10],
              instr_i[4:3],
              instr_i[12],
              OPCODE_BRANCH
            };
          end
        endcase
      end
      2'b10: begin
        unique case (instr_i[15:13])
          3'b000: begin
            if (instr_i[12] == 1'b1) begin
              illegal_instr_o = 1'b1;
            end else begin
              if ((instr_i[6:2] == 5'b0) || (instr_i[11:7] == 5'b0)) begin
                illegal_instr_o = 1'b1;
              end else begin
                instr_o = {7'b0, instr_i[6:2], instr_i[11:7], 3'b001, instr_i[11:7], OPCODE_OPIMM};
              end
            end
          end
          3'b001: begin
            instr_o = {
              3'b0,
              instr_i[4:2],
              instr_i[12],
              instr_i[6:5],
              3'b000,
              5'h02,
              3'b011,
              instr_i[11:7],
              OPCODE_LOAD_FP
            };
          end
          3'b010: begin
            instr_o = {
              4'b0,
              instr_i[3:2],
              instr_i[12],
              instr_i[6:4],
              2'b00,
              5'h02,
              3'b010,
              instr_i[11:7],
              OPCODE_LOAD
            };
            if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
          end
          3'b011: begin
            instr_o = {
              4'b0,
              instr_i[3:2],
              instr_i[12],
              instr_i[6:4],
              2'b00,
              5'h02,
              3'b010,
              instr_i[11:7],
              OPCODE_LOAD_FP
            };
          end
          3'b100: begin
            if (instr_i[12] == 1'b0) begin
              if (instr_i[6:2] == 5'b0) begin
                instr_o = {12'b0, instr_i[11:7], 3'b0, 5'b0, OPCODE_JALR};
                if (instr_i[11:7] == 5'b0) illegal_instr_o = 1'b1;
              end else begin
                if (instr_i[11:7] == 5'b0) begin
                  instr_o = {7'b0, instr_i[6:2], 5'b0, 3'b0, instr_i[11:7], OPCODE_OP};
                end else begin
                  instr_o = {7'b0, instr_i[6:2], 5'b0, 3'b0, instr_i[11:7], OPCODE_OP};
                end
              end
            end else begin
              if (instr_i[6:2] == 5'b0) begin
                if (instr_i[11:7] == 5'b0) begin
                  instr_o = {32'h00_10_00_73};
                end else begin
                  instr_o = {12'b0, instr_i[11:7], 3'b000, 5'b00001, OPCODE_JALR};
                end
              end else begin
                if (instr_i[11:7] == 5'b0) begin
                  instr_o = {7'b0, instr_i[6:2], instr_i[11:7], 3'b0, instr_i[11:7], OPCODE_OP};
                end else begin
                  instr_o = {7'b0, instr_i[6:2], instr_i[11:7], 3'b0, instr_i[11:7], OPCODE_OP};
                end
              end
            end
          end
          3'b101: begin
            instr_o = {
              3'b0,
              instr_i[9:7],
              instr_i[12],
              instr_i[6:2],
              5'h02,
              3'b011,
              instr_i[11:10],
              3'b000,
              OPCODE_STORE_FP
            };
          end
          3'b110: begin
            instr_o = {
              4'b0,
              instr_i[8:7],
              instr_i[12],
              instr_i[6:2],
              5'h02,
              3'b010,
              instr_i[11:9],
              2'b00,
              OPCODE_STORE
            };
          end
          3'b111: begin
            instr_o = {
              4'b0,
              instr_i[8:7],
              instr_i[12],
              instr_i[6:2],
              5'h02,
              3'b010,
              instr_i[11:9],
              2'b00,
              OPCODE_STORE_FP
            };
          end
        endcase
      end
      default: begin
        instr_o = instr_i;
      end
    endcase
  end
  assign is_compressed_o = (instr_i[1:0] != 2'b11);
endmodule


module single_file_rv32imf_if_stage (
    input logic clk,
    input logic rst_n,
    input logic [23:0] m_trap_base_addr_i,
    input logic [23:0] u_trap_base_addr_i,
    input logic [ 1:0] trap_addr_mux_i,
    input logic [31:0] boot_addr_i,
    input logic [31:0] dm_exception_addr_i,
    input logic [31:0] dm_halt_addr_i,
    input logic req_i,
    output logic instr_req_o,
    output logic [31:0] instr_addr_o,
    input logic instr_gnt_i,
    input logic instr_rvalid_i,
    input logic [31:0] instr_rdata_i,
    input logic instr_err_i,
    input logic instr_err_pmp_i,
    output logic instr_valid_id_o,
    output logic [31:0] instr_rdata_id_o,
    output logic is_compressed_id_o,
    output logic illegal_c_insn_id_o,
    output logic [31:0] pc_if_o,
    output logic [31:0] pc_id_o,
    output logic is_fetch_failed_o,
    input logic        clear_instr_valid_i,
    input logic        pc_set_i,
    input logic [31:0] mepc_i,
    input logic [31:0] uepc_i,
    input logic [31:0] depc_i,
    input  logic [3:0] pc_mux_i,
    input  logic [2:0] exc_pc_mux_i,
    input  logic [4:0] m_exc_vec_pc_mux_i,
    input  logic [4:0] u_exc_vec_pc_mux_i,
    output logic       csr_mtvec_init_o,
    input logic [31:0] jump_target_id_i,
    input logic [31:0] jump_target_ex_i,
    input logic [31:0] hwlp_target_i,
    input logic halt_if_i,
    input logic id_ready_i,
    output logic if_busy_o,
    output logic perf_imiss_o
);
  import single_file_rv32imf_pkg::*;
  logic if_valid, if_ready;
  logic        prefetch_busy;
  logic        branch_req;
  logic [31:0] branch_addr_n;
  logic        fetch_valid;
  logic        fetch_ready;
  logic [31:0] fetch_rdata;
  logic [31:0] exc_pc;
  logic [23:0] trap_base_addr;
  logic [ 4:0] exc_vec_pc_mux;
  logic        fetch_failed;
  logic        aligner_ready;
  logic        instr_valid;
  logic        illegal_c_insn;
  logic [31:0] instr_aligned;
  logic [31:0] instr_decompressed;
  logic        instr_compressed_int;
  always_comb begin : EXC_PC_MUX
    unique case (trap_addr_mux_i)
      TRAP_MACHINE: trap_base_addr = m_trap_base_addr_i;
      TRAP_USER:    trap_base_addr = u_trap_base_addr_i;
      default:      trap_base_addr = m_trap_base_addr_i;
    endcase
    unique case (trap_addr_mux_i)
      TRAP_MACHINE: exc_vec_pc_mux = m_exc_vec_pc_mux_i;
      TRAP_USER:    exc_vec_pc_mux = u_exc_vec_pc_mux_i;
      default:      exc_vec_pc_mux = m_exc_vec_pc_mux_i;
    endcase
    unique case (exc_pc_mux_i)
      EXC_PC_EXCEPTION:
      exc_pc = {trap_base_addr, 8'h0};
      EXC_PC_IRQ:
      exc_pc = {trap_base_addr, 1'b0, exc_vec_pc_mux, 2'b0};
      EXC_PC_DBD: exc_pc = {dm_halt_addr_i[31:2], 2'b0};
      EXC_PC_DBE: exc_pc = {dm_exception_addr_i[31:2], 2'b0};
      default: exc_pc = {trap_base_addr, 8'h0};
    endcase
  end
  always_comb begin
    branch_addr_n = {boot_addr_i[31:2], 2'b0};
    unique case (pc_mux_i)
      PC_BOOT:      branch_addr_n = {boot_addr_i[31:2], 2'b0};
      PC_JUMP:      branch_addr_n = jump_target_id_i;
      PC_BRANCH:    branch_addr_n = jump_target_ex_i;
      PC_EXCEPTION: branch_addr_n = exc_pc;
      PC_MRET:      branch_addr_n = mepc_i;
      PC_URET:      branch_addr_n = uepc_i;
      PC_DRET:      branch_addr_n = depc_i;
      PC_FENCEI:    branch_addr_n = pc_id_o + 4;
      PC_HWLOOP:    branch_addr_n = hwlp_target_i;
      default:      ;
    endcase
  end
  assign csr_mtvec_init_o = (pc_mux_i == PC_BOOT) & pc_set_i;
  assign fetch_failed = 1'b0;
  single_file_rv32imf_prefetch_buffer #() prefetch_buffer_i (
      .clk  (clk),
      .rst_n(rst_n),
      .req_i(req_i),
      .branch_i     (branch_req),
      .branch_addr_i({branch_addr_n[31:1], 1'b0}),
      .hwlp_target_i(hwlp_target_i),
      .fetch_ready_i(fetch_ready),
      .fetch_valid_o(fetch_valid),
      .fetch_rdata_o(fetch_rdata),
      .instr_req_o   (instr_req_o),
      .instr_addr_o  (instr_addr_o),
      .instr_gnt_i   (instr_gnt_i),
      .instr_rvalid_i(instr_rvalid_i),
      .instr_err_i   (instr_err_i),
      .instr_err_pmp_i(instr_err_pmp_i),
      .instr_rdata_i (instr_rdata_i),
      .busy_o(prefetch_busy)
  );
  always_comb begin
    fetch_ready = 1'b0;
    branch_req  = 1'b0;
    if (pc_set_i) begin
      branch_req = 1'b1;
    end else if (fetch_valid) begin
      if (req_i && if_valid) begin
        fetch_ready = aligner_ready;
      end
    end
  end
  assign if_busy_o = prefetch_busy;
  assign perf_imiss_o = !fetch_valid && !branch_req;
  always_ff @(posedge clk, negedge rst_n) begin : IF_ID_PIPE_REGISTERS
    if (rst_n == 1'b0) begin
      instr_valid_id_o    <= 1'b0;
      instr_rdata_id_o    <= '0;
      is_fetch_failed_o   <= 1'b0;
      pc_id_o             <= '0;
      is_compressed_id_o  <= 1'b0;
      illegal_c_insn_id_o <= 1'b0;
    end else begin
      if (if_valid && instr_valid) begin
        instr_valid_id_o <= 1'b1;
        instr_rdata_id_o <= instr_decompressed;
        is_compressed_id_o <= instr_compressed_int;
        illegal_c_insn_id_o <= illegal_c_insn;
        is_fetch_failed_o <= 1'b0;
        pc_id_o <= pc_if_o;
      end else if (clear_instr_valid_i) begin
        instr_valid_id_o  <= 1'b0;
        is_fetch_failed_o <= fetch_failed;
      end
    end
  end
  assign if_ready = fetch_valid & id_ready_i;
  assign if_valid = (~halt_if_i) & if_ready;
  single_file_rv32imf_aligner aligner_i (
      .clk            (clk),
      .rst_n          (rst_n),
      .fetch_valid_i  (fetch_valid),
      .aligner_ready_o(aligner_ready),
      .if_valid_i     (if_valid),
      .fetch_rdata_i  (fetch_rdata),
      .instr_aligned_o(instr_aligned),
      .instr_valid_o  (instr_valid),
      .branch_addr_i  ({branch_addr_n[31:1], 1'b0}),
      .branch_i       (branch_req),
      .hwlp_addr_i    (hwlp_target_i),
      .pc_o           (pc_if_o)
  );
  single_file_rv32imf_compressed_decoder #() compressed_decoder_i (
      .instr_i        (instr_aligned),
      .instr_o        (instr_decompressed),
      .is_compressed_o(instr_compressed_int),
      .illegal_instr_o(illegal_c_insn)
  );
endmodule


module single_file_rv32imf_register_file #(
    parameter int ADDR_WIDTH = 5,
    parameter int DATA_WIDTH = 32
) (
    input logic clk,
    input logic rst_n,
    input  logic [ADDR_WIDTH-1:0] raddr_a_i,
    output logic [DATA_WIDTH-1:0] rdata_a_o,
    input  logic [ADDR_WIDTH-1:0] raddr_b_i,
    output logic [DATA_WIDTH-1:0] rdata_b_o,
    input  logic [ADDR_WIDTH-1:0] raddr_c_i,
    output logic [DATA_WIDTH-1:0] rdata_c_o,
    input logic [ADDR_WIDTH-1:0] waddr_a_i,
    input logic [DATA_WIDTH-1:0] wdata_a_i,
    input logic                  we_a_i,
    input logic [ADDR_WIDTH-1:0] waddr_b_i,
    input logic [DATA_WIDTH-1:0] wdata_b_i,
    input logic                  we_b_i
);
  localparam int NumWords = 2 ** (ADDR_WIDTH - 1);
  localparam int NumFPWords = 2 ** (ADDR_WIDTH - 1);
  localparam int NumTotalWords = (NumWords + NumFPWords);
  logic [NumWords-1:0][DATA_WIDTH-1:0] mem;
  logic [NumFPWords-1:0][DATA_WIDTH-1:0] mem_fp;
  logic [ADDR_WIDTH-1:0] waddr_a;
  logic [ADDR_WIDTH-1:0] waddr_b;
  logic [NumTotalWords-1:0] we_a_dec;
  logic [NumTotalWords-1:0] we_b_dec;
  assign rdata_a_o = raddr_a_i[ADDR_WIDTH-1] ? mem_fp[raddr_a_i[ADDR_WIDTH-2:0]]
                                             : mem[raddr_a_i[ADDR_WIDTH-2:0]];
  assign rdata_b_o = raddr_b_i[ADDR_WIDTH-1] ? mem_fp[raddr_b_i[ADDR_WIDTH-2:0]]
                                             : mem[raddr_b_i[ADDR_WIDTH-2:0]];
  assign rdata_c_o = raddr_c_i[ADDR_WIDTH-1] ? mem_fp[raddr_c_i[ADDR_WIDTH-2:0]]
                                             : mem[raddr_c_i[ADDR_WIDTH-2:0]];
  assign waddr_a = waddr_a_i;
  assign waddr_b = waddr_b_i;
  for (genvar gidx = 0; gidx < NumTotalWords; gidx++) begin : gen_we_decoder
    assign we_a_dec[gidx] = (waddr_a == gidx) ? we_a_i : 1'b0;
    assign we_b_dec[gidx] = (waddr_b == gidx) ? we_b_i : 1'b0;
  end
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      mem[0] <= 32'b0;
    end else begin
      mem[0] <= 32'b0;
    end
  end
  for (genvar i = 1; i < NumWords; i++) begin : gen_rf
    always_ff @(posedge clk, negedge rst_n) begin : register_write_behavioral
      if (rst_n == 1'b0) begin
        mem[i] <= 32'b0;
      end else begin
        if (we_b_dec[i] == 1'b1) mem[i] <= wdata_b_i;
        else if (we_a_dec[i] == 1'b1) mem[i] <= wdata_a_i;
      end
    end
  end
  for (genvar l = 0; l < NumFPWords; l++) begin : gen_fpu_regs
    always_ff @(posedge clk, negedge rst_n) begin : fp_regs
      if (rst_n == 1'b0) mem_fp[l] <= '0;
      else if (we_b_dec[l+NumWords] == 1'b1) mem_fp[l] <= wdata_b_i;
      else if (we_a_dec[l+NumWords] == 1'b1) mem_fp[l] <= wdata_a_i;
    end
  end
endmodule


module single_file_rv32imf_decoder
  import single_file_rv32imf_pkg::*;
  import single_file_rv32imf_fpu_pkg::*;
#(
    parameter int DEBUG_TRIGGER_EN = 1
) (
    input logic deassert_we_i,
    output logic illegal_insn_o,
    output logic ebrk_insn_o,
    output logic mret_insn_o,
    output logic uret_insn_o,
    output logic dret_insn_o,
    output logic mret_dec_o,
    output logic uret_dec_o,
    output logic dret_dec_o,
    output logic ecall_insn_o,
    output logic wfi_o,
    output logic fencei_insn_o,
    output logic rega_used_o,
    output logic regb_used_o,
    output logic regc_used_o,
    output logic reg_fp_a_o,
    output logic reg_fp_b_o,
    output logic reg_fp_c_o,
    output logic reg_fp_d_o,
    output logic [0:0] bmask_a_mux_o,
    output logic [1:0] bmask_b_mux_o,
    output logic       alu_bmask_a_mux_sel_o,
    output logic       alu_bmask_b_mux_sel_o,
    input logic [31:0] instr_rdata_i,
    input logic        illegal_c_insn_i,
    output logic              alu_en_o,
    output alu_opcode_e       alu_operator_o,
    output logic        [2:0] alu_op_a_mux_sel_o,
    output logic        [2:0] alu_op_b_mux_sel_o,
    output logic        [1:0] alu_op_c_mux_sel_o,
    output logic              alu_vec_o,
    output logic        [1:0] alu_vec_mode_o,
    output logic              scalar_replication_o,
    output logic              scalar_replication_c_o,
    output logic        [0:0] imm_a_mux_sel_o,
    output logic        [3:0] imm_b_mux_sel_o,
    output logic        [1:0] regc_mux_o,
    output logic              is_clpx_o,
    output logic              is_subrot_o,
    output mul_opcode_e       mult_operator_o,
    output logic              mult_int_en_o,
    output logic              mult_dot_en_o,
    output logic        [0:0] mult_imm_mux_o,
    output logic              mult_sel_subword_o,
    output logic        [1:0] mult_signed_mode_o,
    output logic        [1:0] mult_dot_signed_o,
    input logic            fs_off_i,
    input logic [C_RM-1:0] frm_i,
    output logic [ single_file_rv32imf_fpu_pkg::FP_FORMAT_BITS-1:0] fpu_dst_fmt_o,
    output logic [ single_file_rv32imf_fpu_pkg::FP_FORMAT_BITS-1:0] fpu_src_fmt_o,
    output logic [single_file_rv32imf_fpu_pkg::INT_FORMAT_BITS-1:0] fpu_int_fmt_o,
    output logic       apu_en_o,
    output logic [5:0] apu_op_o,
    output logic [1:0] apu_lat_o,
    output logic [2:0] fp_rnd_mode_o,
    output logic regfile_mem_we_o,
    output logic regfile_alu_we_o,
    output logic regfile_alu_we_dec_o,
    output logic regfile_alu_waddr_sel_o,
    output logic        csr_access_o,
    output logic        csr_status_o,
    output csr_opcode_e csr_op_o,
    input  priv_lvl_t   current_priv_lvl_i,
    output logic       data_req_o,
    output logic       data_we_o,
    output logic       prepost_useincr_o,
    output logic [1:0] data_type_o,
    output logic [1:0] data_sign_extension_o,
    output logic [1:0] data_reg_offset_o,
    output logic       data_load_event_o,
    output logic [5:0] atop_o,
    output logic [2:0] hwlp_we_o,
    output logic [1:0] hwlp_target_mux_sel_o,
    output logic [1:0] hwlp_start_mux_sel_o,
    output logic       hwlp_cnt_mux_sel_o,
    input logic debug_mode_i,
    input logic debug_wfi_no_sleep_i,
    output logic [1:0] ctrl_transfer_insn_in_dec_o,
    output logic [1:0] ctrl_transfer_insn_in_id_o,
    output logic [1:0] ctrl_transfer_target_mux_sel_o,
    input logic [31:0] mcounteren_i
);
  logic regfile_mem_we;
  logic regfile_alu_we;
  logic data_req;
  logic [2:0] hwlp_we;
  logic csr_illegal;
  logic [1:0] ctrl_transfer_insn;
  csr_opcode_e csr_op;
  logic alu_en;
  logic mult_int_en;
  logic mult_dot_en;
  logic apu_en;
  logic check_fprm;
  logic [single_file_rv32imf_fpu_pkg::OP_BITS-1:0] fpu_op;
  logic fpu_op_mod;
  logic fpu_vec_op;
  typedef enum logic [1:0] {
    ADDMUL,
    DIVSQRT,
    NONCOMP,
    CONV
  } fp_op_group_t;
  fp_op_group_t fp_op_group;
  always_comb begin : instruction_decoder
    ctrl_transfer_insn             = BRANCH_NONE;
    ctrl_transfer_target_mux_sel_o = JT_JAL;
    alu_en                         = 1'b1;
    alu_operator_o                 = ALU_SLTU;
    alu_op_a_mux_sel_o             = OP_A_REGA_OR_FWD;
    alu_op_b_mux_sel_o             = OP_B_REGB_OR_FWD;
    alu_op_c_mux_sel_o             = OP_C_REGC_OR_FWD;
    alu_vec_o                      = 1'b0;
    alu_vec_mode_o                 = VEC_MODE32;
    scalar_replication_o           = 1'b0;
    scalar_replication_c_o         = 1'b0;
    regc_mux_o                     = REGC_ZERO;
    imm_a_mux_sel_o                = IMMA_ZERO;
    imm_b_mux_sel_o                = IMMB_I;
    mult_int_en                    = 1'b0;
    mult_dot_en                    = 1'b0;
    mult_operator_o                = MUL_I;
    mult_imm_mux_o                 = MIMM_ZERO;
    mult_signed_mode_o             = 2'b00;
    mult_sel_subword_o             = 1'b0;
    mult_dot_signed_o              = 2'b00;
    apu_en                         = 1'b0;
    apu_op_o                       = '0;
    apu_lat_o                      = '0;
    fp_rnd_mode_o                  = '0;
    fpu_op                         = single_file_rv32imf_fpu_pkg::SGNJ;
    fpu_op_mod                     = 1'b0;
    fpu_vec_op                     = 1'b0;
    fpu_dst_fmt_o                  = single_file_rv32imf_fpu_pkg::FP32;
    fpu_src_fmt_o                  = single_file_rv32imf_fpu_pkg::FP32;
    fpu_int_fmt_o                  = single_file_rv32imf_fpu_pkg::INT32;
    check_fprm                     = 1'b0;
    fp_op_group                    = ADDMUL;
    regfile_mem_we                 = 1'b0;
    regfile_alu_we                 = 1'b0;
    regfile_alu_waddr_sel_o        = 1'b1;
    prepost_useincr_o              = 1'b1;
    hwlp_we                        = 3'b0;
    hwlp_target_mux_sel_o          = 2'b0;
    hwlp_start_mux_sel_o           = 2'b0;
    hwlp_cnt_mux_sel_o             = 1'b0;
    csr_access_o                   = 1'b0;
    csr_status_o                   = 1'b0;
    csr_illegal                    = 1'b0;
    csr_op                         = CSR_OP_READ;
    mret_insn_o                    = 1'b0;
    uret_insn_o                    = 1'b0;
    dret_insn_o                    = 1'b0;
    data_we_o                      = 1'b0;
    data_type_o                    = 2'b00;
    data_sign_extension_o          = 2'b00;
    data_reg_offset_o              = 2'b00;
    data_req                       = 1'b0;
    data_load_event_o              = 1'b0;
    atop_o                         = 6'b000000;
    illegal_insn_o                 = 1'b0;
    ebrk_insn_o                    = 1'b0;
    ecall_insn_o                   = 1'b0;
    wfi_o                          = 1'b0;
    fencei_insn_o                  = 1'b0;
    rega_used_o                    = 1'b0;
    regb_used_o                    = 1'b0;
    regc_used_o                    = 1'b0;
    reg_fp_a_o                     = 1'b0;
    reg_fp_b_o                     = 1'b0;
    reg_fp_c_o                     = 1'b0;
    reg_fp_d_o                     = 1'b0;
    bmask_a_mux_o                  = BMASK_A_ZERO;
    bmask_b_mux_o                  = BMASK_B_ZERO;
    alu_bmask_a_mux_sel_o          = BMASK_A_IMM;
    alu_bmask_b_mux_sel_o          = BMASK_B_IMM;
    is_clpx_o                      = 1'b0;
    is_subrot_o                    = 1'b0;
    mret_dec_o                     = 1'b0;
    uret_dec_o                     = 1'b0;
    dret_dec_o                     = 1'b0;
    unique case (instr_rdata_i[6:0])
      OPCODE_JAL: begin
        ctrl_transfer_target_mux_sel_o = JT_JAL;
        ctrl_transfer_insn             = BRANCH_JAL;
        alu_op_a_mux_sel_o             = OP_A_CURRPC;
        alu_op_b_mux_sel_o             = OP_B_IMM;
        imm_b_mux_sel_o                = IMMB_PCINCR;
        alu_operator_o                 = ALU_ADD;
        regfile_alu_we                 = 1'b1;
      end
      OPCODE_JALR: begin
        ctrl_transfer_target_mux_sel_o = JT_JALR;
        ctrl_transfer_insn             = BRANCH_JALR;
        alu_op_a_mux_sel_o             = OP_A_CURRPC;
        alu_op_b_mux_sel_o             = OP_B_IMM;
        imm_b_mux_sel_o                = IMMB_PCINCR;
        alu_operator_o                 = ALU_ADD;
        regfile_alu_we                 = 1'b1;
        rega_used_o                    = 1'b1;
        if (instr_rdata_i[14:12] != 3'b0) begin
          ctrl_transfer_insn = BRANCH_NONE;
          regfile_alu_we     = 1'b0;
          illegal_insn_o     = 1'b1;
        end
      end
      OPCODE_BRANCH: begin
        ctrl_transfer_target_mux_sel_o = JT_COND;
        ctrl_transfer_insn             = BRANCH_COND;
        alu_op_c_mux_sel_o             = OP_C_JT;
        rega_used_o                    = 1'b1;
        regb_used_o                    = 1'b1;
        unique case (instr_rdata_i[14:12])
          3'b000:  alu_operator_o = ALU_EQ;
          3'b001:  alu_operator_o = ALU_NE;
          3'b100:  alu_operator_o = ALU_LTS;
          3'b101:  alu_operator_o = ALU_GES;
          3'b110:  alu_operator_o = ALU_LTU;
          3'b111:  alu_operator_o = ALU_GEU;
          default: illegal_insn_o = 1'b1;
        endcase
      end
      OPCODE_STORE: begin
        data_req           = 1'b1;
        data_we_o          = 1'b1;
        rega_used_o        = 1'b1;
        regb_used_o        = 1'b1;
        alu_operator_o     = ALU_ADD;
        alu_op_c_mux_sel_o = OP_C_REGB_OR_FWD;
        imm_b_mux_sel_o    = IMMB_S;
        alu_op_b_mux_sel_o = OP_B_IMM;
        unique case (instr_rdata_i[14:12])
          3'b000: data_type_o = 2'b10;
          3'b001: data_type_o = 2'b01;
          3'b010: data_type_o = 2'b00;
          default: begin
            illegal_insn_o = 1'b1;
            data_req       = 1'b0;
            data_we_o      = 1'b0;
          end
        endcase
      end
      OPCODE_LOAD: begin
        data_req              = 1'b1;
        regfile_mem_we        = 1'b1;
        rega_used_o           = 1'b1;
        alu_operator_o        = ALU_ADD;
        alu_op_b_mux_sel_o    = OP_B_IMM;
        imm_b_mux_sel_o       = IMMB_I;
        data_sign_extension_o = {1'b0, ~instr_rdata_i[14]};
        unique case (instr_rdata_i[14:12])
          3'b000, 3'b100: data_type_o = 2'b10;
          3'b001, 3'b101: data_type_o = 2'b01;
          3'b010:         data_type_o = 2'b00;
          default: begin
            illegal_insn_o = 1'b1;
          end
        endcase
      end
      OPCODE_AMO: begin
        illegal_insn_o = 1'b1;
      end
      OPCODE_LUI: begin
        alu_op_a_mux_sel_o = OP_A_IMM;
        alu_op_b_mux_sel_o = OP_B_IMM;
        imm_a_mux_sel_o    = IMMA_ZERO;
        imm_b_mux_sel_o    = IMMB_U;
        alu_operator_o     = ALU_ADD;
        regfile_alu_we     = 1'b1;
      end
      OPCODE_AUIPC: begin
        alu_op_a_mux_sel_o = OP_A_CURRPC;
        alu_op_b_mux_sel_o = OP_B_IMM;
        imm_b_mux_sel_o    = IMMB_U;
        alu_operator_o     = ALU_ADD;
        regfile_alu_we     = 1'b1;
      end
      OPCODE_OPIMM: begin
        alu_op_b_mux_sel_o = OP_B_IMM;
        imm_b_mux_sel_o    = IMMB_I;
        regfile_alu_we     = 1'b1;
        rega_used_o        = 1'b1;
        unique case (instr_rdata_i[14:12])
          3'b000: alu_operator_o = ALU_ADD;
          3'b010: alu_operator_o = ALU_SLTS;
          3'b011: alu_operator_o = ALU_SLTU;
          3'b100: alu_operator_o = ALU_XOR;
          3'b110: alu_operator_o = ALU_OR;
          3'b111: alu_operator_o = ALU_AND;
          3'b001: begin
            alu_operator_o = ALU_SLL;
            if (instr_rdata_i[31:25] != 7'b0) illegal_insn_o = 1'b1;
          end
          3'b101: begin
            if (instr_rdata_i[31:25] == 7'b0) alu_operator_o = ALU_SRL;
            else if (instr_rdata_i[31:25] == 7'b010_0000) alu_operator_o = ALU_SRA;
            else illegal_insn_o = 1'b1;
          end
        endcase
      end
      OPCODE_OP: begin
        if (instr_rdata_i[31:30] == 2'b11) begin
          illegal_insn_o = 1'b1;
        end else if (instr_rdata_i[31:30] == 2'b10) begin
          illegal_insn_o = 1'b1;
        end else begin
          regfile_alu_we = 1'b1;
          rega_used_o    = 1'b1;
          if (~instr_rdata_i[28]) regb_used_o = 1'b1;
          unique case ({
            instr_rdata_i[30:25], instr_rdata_i[14:12]
          })
            {6'b00_0000, 3'b000} : alu_operator_o = ALU_ADD;
            {6'b10_0000, 3'b000} : alu_operator_o = ALU_SUB;
            {6'b00_0000, 3'b010} : alu_operator_o = ALU_SLTS;
            {6'b00_0000, 3'b011} : alu_operator_o = ALU_SLTU;
            {6'b00_0000, 3'b100} : alu_operator_o = ALU_XOR;
            {6'b00_0000, 3'b110} : alu_operator_o = ALU_OR;
            {6'b00_0000, 3'b111} : alu_operator_o = ALU_AND;
            {6'b00_0000, 3'b001} : alu_operator_o = ALU_SLL;
            {6'b00_0000, 3'b101} : alu_operator_o = ALU_SRL;
            {6'b10_0000, 3'b101} : alu_operator_o = ALU_SRA;
            {
              6'b00_0001, 3'b000
            } : begin
              alu_en          = 1'b0;
              mult_int_en     = 1'b1;
              mult_operator_o = MUL_MAC32;
              regc_mux_o      = REGC_ZERO;
            end
            {
              6'b00_0001, 3'b001
            } : begin
              alu_en             = 1'b0;
              mult_int_en        = 1'b1;
              regc_used_o        = 1'b1;
              regc_mux_o         = REGC_ZERO;
              mult_signed_mode_o = 2'b11;
              mult_operator_o    = MUL_H;
            end
            {
              6'b00_0001, 3'b010
            } : begin
              alu_en             = 1'b0;
              mult_int_en        = 1'b1;
              regc_used_o        = 1'b1;
              regc_mux_o         = REGC_ZERO;
              mult_signed_mode_o = 2'b01;
              mult_operator_o    = MUL_H;
            end
            {
              6'b00_0001, 3'b011
            } : begin
              alu_en             = 1'b0;
              mult_int_en        = 1'b1;
              regc_used_o        = 1'b1;
              regc_mux_o         = REGC_ZERO;
              mult_signed_mode_o = 2'b00;
              mult_operator_o    = MUL_H;
            end
            {
              6'b00_0001, 3'b100
            } : begin
              alu_op_a_mux_sel_o = OP_A_REGB_OR_FWD;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              regb_used_o        = 1'b1;
              alu_operator_o     = ALU_DIV;
            end
            {
              6'b00_0001, 3'b101
            } : begin
              alu_op_a_mux_sel_o = OP_A_REGB_OR_FWD;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              regb_used_o        = 1'b1;
              alu_operator_o     = ALU_DIVU;
            end
            {
              6'b00_0001, 3'b110
            } : begin
              alu_op_a_mux_sel_o = OP_A_REGB_OR_FWD;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              regb_used_o        = 1'b1;
              alu_operator_o     = ALU_REM;
            end
            {
              6'b00_0001, 3'b111
            } : begin
              alu_op_a_mux_sel_o = OP_A_REGB_OR_FWD;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              regb_used_o        = 1'b1;
              alu_operator_o     = ALU_REMU;
            end
            default: begin
              illegal_insn_o = 1'b1;
            end
          endcase
        end
      end
      OPCODE_OP_FP: begin
        if (fs_off_i == 1'b0) begin
          alu_en        = 1'b0;
          apu_en        = 1'b1;
          rega_used_o   = 1'b1;
          regb_used_o   = 1'b1;
          reg_fp_a_o    = 1'b1;
          reg_fp_b_o    = 1'b1;
          reg_fp_d_o    = 1'b1;
          check_fprm    = 1'b1;
          fp_rnd_mode_o = instr_rdata_i[14:12];
          unique case (instr_rdata_i[26:25])
            2'b00: fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP32;
            2'b01: fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP64;
            2'b10: begin
              if (instr_rdata_i[14:12] == 3'b101) fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
              else fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16;
            end
            2'b11: fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP8;
          endcase
          fpu_src_fmt_o = fpu_dst_fmt_o;
          unique case (instr_rdata_i[31:27])
            5'b00000: begin
              fpu_op             = single_file_rv32imf_fpu_pkg::ADD;
              fp_op_group        = ADDMUL;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              alu_op_c_mux_sel_o = OP_C_REGB_OR_FWD;
            end
            5'b00001: begin
              fpu_op             = single_file_rv32imf_fpu_pkg::ADD;
              fpu_op_mod         = 1'b1;
              fp_op_group        = ADDMUL;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              alu_op_c_mux_sel_o = OP_C_REGB_OR_FWD;
            end
            5'b00010: begin
              fpu_op      = single_file_rv32imf_fpu_pkg::MUL;
              fp_op_group = ADDMUL;
            end
            5'b00011: begin
              fpu_op      = single_file_rv32imf_fpu_pkg::DIV;
              fp_op_group = DIVSQRT;
            end
            5'b01011: begin
              regb_used_o = 1'b0;
              fpu_op      = single_file_rv32imf_fpu_pkg::SQRT;
              fp_op_group = DIVSQRT;
              if (instr_rdata_i[24:20] != 5'b00000) illegal_insn_o = 1'b1;
            end
            5'b00100: begin
              fpu_op      = single_file_rv32imf_fpu_pkg::SGNJ;
              fp_op_group = NONCOMP;
              check_fprm  = 1'b0;
              if (C_XF16ALT) begin
                if (!(instr_rdata_i[14:12] inside {[3'b000 : 3'b010], [3'b100 : 3'b110]})) begin
                  illegal_insn_o = 1'b1;
                end
                if (instr_rdata_i[14]) begin
                  fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end else begin
                  fp_rnd_mode_o = {1'b0, instr_rdata_i[13:12]};
                end
              end else begin
                if (!(instr_rdata_i[14:12] inside {[3'b000 : 3'b010]})) illegal_insn_o = 1'b1;
              end
            end
            5'b00101: begin
              fpu_op      = single_file_rv32imf_fpu_pkg::MINMAX;
              fp_op_group = NONCOMP;
              check_fprm  = 1'b0;
              if (C_XF16ALT) begin
                if (!(instr_rdata_i[14:12] inside {[3'b000 : 3'b001], [3'b100 : 3'b101]})) begin
                  illegal_insn_o = 1'b1;
                end
                if (instr_rdata_i[14]) begin
                  fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end else begin
                  fp_rnd_mode_o = {1'b0, instr_rdata_i[13:12]};
                end
              end else begin
                if (!(instr_rdata_i[14:12] inside {[3'b000 : 3'b001]})) illegal_insn_o = 1'b1;
              end
            end
            5'b01000: begin
              regb_used_o = 1'b0;
              fpu_op      = single_file_rv32imf_fpu_pkg::F2F;
              fp_op_group = CONV;
              if (instr_rdata_i[24:23]) illegal_insn_o = 1'b1;
              unique case (instr_rdata_i[22:20])
                3'b000: begin
                  if (!(C_RVF && (C_XF16 || C_XF16ALT || C_XF8))) illegal_insn_o = 1'b1;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP32;
                end
                3'b001: begin
                  if (~C_RVD) illegal_insn_o = 1'b1;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP64;
                end
                3'b010: begin
                  if (~C_XF16) illegal_insn_o = 1'b1;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16;
                end
                3'b110: begin
                  if (~C_XF16ALT) illegal_insn_o = 1'b1;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end
                3'b011: begin
                  if (~C_XF8) illegal_insn_o = 1'b1;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP8;
                end
                default: illegal_insn_o = 1'b1;
              endcase
            end
            5'b01001: begin
              if (~C_XF16 && ~C_XF16ALT && ~C_XF8) illegal_insn_o = 1;
              fpu_op        = single_file_rv32imf_fpu_pkg::MUL;
              fp_op_group   = ADDMUL;
              fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP32;
            end
            5'b01010: begin
              if (~C_XF16 && ~C_XF16ALT && ~C_XF8) illegal_insn_o = 1;
              regc_used_o   = 1'b1;
              regc_mux_o    = REGC_RD;
              reg_fp_c_o    = 1'b1;
              fpu_op        = single_file_rv32imf_fpu_pkg::FMADD;
              fp_op_group   = ADDMUL;
              fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP32;
            end
            5'b10100: begin
              fpu_op      = single_file_rv32imf_fpu_pkg::CMP;
              fp_op_group = NONCOMP;
              reg_fp_d_o  = 1'b0;
              check_fprm  = 1'b0;
              if (C_XF16ALT) begin
                if (!(instr_rdata_i[14:12] inside {[3'b000 : 3'b010], [3'b100 : 3'b110]})) begin
                  illegal_insn_o = 1'b1;
                end
                if (instr_rdata_i[14]) begin
                  fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end else begin
                  fp_rnd_mode_o = {1'b0, instr_rdata_i[13:12]};
                end
              end else begin
                if (!(instr_rdata_i[14:12] inside {[3'b000 : 3'b010]})) illegal_insn_o = 1'b1;
              end
            end
            5'b11000: begin
              regb_used_o = 1'b0;
              reg_fp_d_o  = 1'b0;
              fpu_op      = single_file_rv32imf_fpu_pkg::F2I;
              fp_op_group = CONV;
              fpu_op_mod  = instr_rdata_i[20];
              unique case (instr_rdata_i[26:25])
                2'b00: begin
                  if (~C_RVF) illegal_insn_o = 1;
                  else fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP32;
                end
                2'b01: begin
                  if (~C_RVD) illegal_insn_o = 1;
                  else fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP64;
                end
                2'b10: begin
                  if (instr_rdata_i[14:12] == 3'b101) begin
                    if (~C_XF16ALT) illegal_insn_o = 1;
                    else fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  end else if (~C_XF16) begin
                    illegal_insn_o = 1;
                  end else begin
                    fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16;
                  end
                end
                2'b11: begin
                  if (~C_XF8) illegal_insn_o = 1;
                  else fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP8;
                end
              endcase
              if (instr_rdata_i[24:21]) illegal_insn_o = 1'b1;
            end
            5'b11010: begin
              regb_used_o = 1'b0;
              reg_fp_a_o  = 1'b0;
              fpu_op      = single_file_rv32imf_fpu_pkg::I2F;
              fp_op_group = CONV;
              fpu_op_mod  = instr_rdata_i[20];
              if (instr_rdata_i[24:21]) illegal_insn_o = 1'b1;
            end
            5'b11100: begin
              regb_used_o = 1'b0;
              reg_fp_d_o  = 1'b0;
              fp_op_group = NONCOMP;
              check_fprm  = 1'b0;
              if ((instr_rdata_i[14:12] == 3'b000)
                || (C_XF16ALT && instr_rdata_i[14:12] == 3'b100)) begin
                alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
                fpu_op             = single_file_rv32imf_fpu_pkg::SGNJ;
                fpu_op_mod         = 1'b1;
                fp_rnd_mode_o      = 3'b011;
                if (instr_rdata_i[14]) begin
                  fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end
              end else if (instr_rdata_i[14:12] == 3'b001
                || (C_XF16ALT && instr_rdata_i[14:12] == 3'b101)) begin
                fpu_op        = single_file_rv32imf_fpu_pkg::CLASSIFY;
                fp_rnd_mode_o = 3'b000;
                if (instr_rdata_i[14]) begin
                  fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end
              end else begin
                illegal_insn_o = 1'b1;
              end
              if (instr_rdata_i[24:20]) illegal_insn_o = 1'b1;
            end
            5'b11110: begin
              regb_used_o        = 1'b0;
              reg_fp_a_o         = 1'b0;
              alu_op_b_mux_sel_o = OP_B_REGA_OR_FWD;
              fpu_op             = single_file_rv32imf_fpu_pkg::SGNJ;
              fpu_op_mod         = 1'b0;
              fp_op_group        = NONCOMP;
              fp_rnd_mode_o      = 3'b011;
              check_fprm         = 1'b0;
              if ((instr_rdata_i[14:12] == 3'b000)
                || (C_XF16ALT && instr_rdata_i[14:12] == 3'b100)) begin
                if (instr_rdata_i[14]) begin
                  fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                  fpu_src_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
                end
              end else begin
                illegal_insn_o = 1'b1;
              end
              if (instr_rdata_i[24:20] != 5'b00000) illegal_insn_o = 1'b1;
            end
            default: illegal_insn_o = 1'b1;
          endcase
          if (~C_RVF && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP32) illegal_insn_o = 1'b1;
          if ((~C_RVD) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP64) illegal_insn_o = 1'b1;
          if ((~C_XF16) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP16) illegal_insn_o = 1'b1;
          if ((~C_XF16ALT) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP16ALT) begin
            illegal_insn_o = 1'b1;
          end
          if ((~C_XF8) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP8) illegal_insn_o = 1'b1;
          if (check_fprm) begin
            unique case (instr_rdata_i[14:12]) inside
              3'b000, 3'b001, 3'b010, 3'b011, 3'b100: ;
              3'b101: begin
                if (~C_XF16ALT || fpu_dst_fmt_o != single_file_rv32imf_fpu_pkg::FP16ALT) illegal_insn_o = 1'b1;
                unique case (frm_i) inside
                  3'b000, 3'b001, 3'b010, 3'b011, 3'b100: fp_rnd_mode_o = frm_i;
                  default:                                illegal_insn_o = 1'b1;
                endcase
              end
              3'b111: begin
                unique case (frm_i) inside
                  3'b000, 3'b001, 3'b010, 3'b011, 3'b100: fp_rnd_mode_o = frm_i;
                  default:                                illegal_insn_o = 1'b1;
                endcase
              end
              default:                                illegal_insn_o = 1'b1;
            endcase
          end
          case (fp_op_group)
            ADDMUL: begin
              unique case (fpu_dst_fmt_o)
                single_file_rv32imf_fpu_pkg::FP32: apu_lat_o = 1;
                single_file_rv32imf_fpu_pkg::FP64: apu_lat_o = (C_LAT_FP64 < 2) ? C_LAT_FP64 + 1 : 2'h3;
                single_file_rv32imf_fpu_pkg::FP16: apu_lat_o = (C_LAT_FP16 < 2) ? C_LAT_FP16 + 1 : 2'h3;
                single_file_rv32imf_fpu_pkg::FP16ALT:
                apu_lat_o = (C_LAT_FP16ALT < 2) ? C_LAT_FP16ALT + 1 : 2'h3;
                single_file_rv32imf_fpu_pkg::FP8: apu_lat_o = (C_LAT_FP8 < 2) ? C_LAT_FP8 + 1 : 2'h3;
                default: ;
              endcase
            end
            DIVSQRT: apu_lat_o = 2'h3;
            NONCOMP, CONV: apu_lat_o = 1;
            default: begin
            end
          endcase
          apu_op_o = {fpu_vec_op, fpu_op_mod, fpu_op};
        end else begin
          illegal_insn_o = 1'b1;
        end
      end
      OPCODE_OP_FMADD, OPCODE_OP_FMSUB, OPCODE_OP_FNMSUB, OPCODE_OP_FNMADD: begin
        if (fs_off_i == 1'b0) begin
          alu_en        = 1'b0;
          apu_en        = 1'b1;
          rega_used_o   = 1'b1;
          regb_used_o   = 1'b1;
          regc_used_o   = 1'b1;
          regc_mux_o    = REGC_S4;
          reg_fp_a_o    = 1'b1;
          reg_fp_b_o    = 1'b1;
          reg_fp_c_o    = 1'b1;
          reg_fp_d_o    = 1'b1;
          fp_rnd_mode_o = instr_rdata_i[14:12];
          unique case (instr_rdata_i[26:25])
            2'b00: fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP32;
            2'b01: fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP64;
            2'b10: begin
              if (instr_rdata_i[14:12] == 3'b101) fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16ALT;
              else fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP16;
            end
            2'b11: fpu_dst_fmt_o = single_file_rv32imf_fpu_pkg::FP8;
          endcase
          fpu_src_fmt_o = fpu_dst_fmt_o;
          unique case (instr_rdata_i[6:0])
            OPCODE_OP_FMADD: begin
              fpu_op = single_file_rv32imf_fpu_pkg::FMADD;
            end
            OPCODE_OP_FMSUB: begin
              fpu_op     = single_file_rv32imf_fpu_pkg::FMADD;
              fpu_op_mod = 1'b1;
            end
            OPCODE_OP_FNMSUB: begin
              fpu_op = single_file_rv32imf_fpu_pkg::FNMSUB;
            end
            OPCODE_OP_FNMADD: begin
              fpu_op     = single_file_rv32imf_fpu_pkg::FNMSUB;
              fpu_op_mod = 1'b1;
            end
            default: ;
          endcase
          if (~C_RVF && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP32) illegal_insn_o = 1'b1;
          if ((~C_RVD) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP64) illegal_insn_o = 1'b1;
          if ((~C_XF16) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP16) illegal_insn_o = 1'b1;
          if ((~C_XF16ALT) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP16ALT) begin
            illegal_insn_o = 1'b1;
          end
          if ((~C_XF8) && fpu_dst_fmt_o == single_file_rv32imf_fpu_pkg::FP8) illegal_insn_o = 1'b1;
          unique case (instr_rdata_i[14:12]) inside
            3'b000, 3'b001, 3'b010, 3'b011, 3'b100: ;
            3'b101: begin
              if (~C_XF16ALT || fpu_dst_fmt_o != single_file_rv32imf_fpu_pkg::FP16ALT) illegal_insn_o = 1'b1;
              unique case (frm_i) inside
                3'b000, 3'b001, 3'b010, 3'b011, 3'b100: fp_rnd_mode_o = frm_i;
                default:                                illegal_insn_o = 1'b1;
              endcase
            end
            3'b111: begin
              unique case (frm_i) inside
                3'b000, 3'b001, 3'b010, 3'b011, 3'b100: fp_rnd_mode_o = frm_i;
                default:                                illegal_insn_o = 1'b1;
              endcase
            end
            default:                                illegal_insn_o = 1'b1;
          endcase
          unique case (fpu_dst_fmt_o)
            single_file_rv32imf_fpu_pkg::FP32:    apu_lat_o = 1;
            single_file_rv32imf_fpu_pkg::FP64:    apu_lat_o = (C_LAT_FP64 < 2) ? C_LAT_FP64 + 1 : 2'h3;
            single_file_rv32imf_fpu_pkg::FP16:    apu_lat_o = (C_LAT_FP16 < 2) ? C_LAT_FP16 + 1 : 2'h3;
            single_file_rv32imf_fpu_pkg::FP16ALT: apu_lat_o = (C_LAT_FP16ALT < 2) ? C_LAT_FP16ALT + 1 : 2'h3;
            single_file_rv32imf_fpu_pkg::FP8:     apu_lat_o = (C_LAT_FP8 < 2) ? C_LAT_FP8 + 1 : 2'h3;
            default:                  ;
          endcase
          apu_op_o = {fpu_vec_op, fpu_op_mod, fpu_op};
        end else begin
          illegal_insn_o = 1'b1;
        end
      end
      OPCODE_STORE_FP: begin
        if (fs_off_i == 1'b0) begin
          data_req           = 1'b1;
          data_we_o          = 1'b1;
          rega_used_o        = 1'b1;
          regb_used_o        = 1'b1;
          alu_operator_o     = ALU_ADD;
          reg_fp_b_o         = 1'b1;
          imm_b_mux_sel_o    = IMMB_S;
          alu_op_b_mux_sel_o = OP_B_IMM;
          alu_op_c_mux_sel_o = OP_C_REGB_OR_FWD;
          unique case (instr_rdata_i[14:12])
            3'b000:  if (C_XF8) data_type_o = 2'b10;
 else illegal_insn_o = 1'b1;
            3'b001:  if (C_XF16 | C_XF16ALT) data_type_o = 2'b01;
 else illegal_insn_o = 1'b1;
            3'b010:  if (C_RVF) data_type_o = 2'b00;
 else illegal_insn_o = 1'b1;
            3'b011:  if (C_RVD) data_type_o = 2'b00;
 else illegal_insn_o = 1'b1;
            default: illegal_insn_o = 1'b1;
          endcase
          if (illegal_insn_o) begin
            data_req  = 1'b0;
            data_we_o = 1'b0;
          end
        end else begin
          illegal_insn_o = 1'b1;
        end
      end
      OPCODE_LOAD_FP: begin
        if (fs_off_i == 1'b0) begin
          data_req              = 1'b1;
          regfile_mem_we        = 1'b1;
          reg_fp_d_o            = 1'b1;
          rega_used_o           = 1'b1;
          alu_operator_o        = ALU_ADD;
          imm_b_mux_sel_o       = IMMB_I;
          alu_op_b_mux_sel_o    = OP_B_IMM;
          data_sign_extension_o = 2'b10;
          unique case (instr_rdata_i[14:12])
            3'b000:  if (C_XF8) data_type_o = 2'b10;
 else illegal_insn_o = 1'b1;
            3'b001:  if (C_XF16 | C_XF16ALT) data_type_o = 2'b01;
 else illegal_insn_o = 1'b1;
            3'b010:  if (C_RVF) data_type_o = 2'b00;
 else illegal_insn_o = 1'b1;
            3'b011:  if (C_RVD) data_type_o = 2'b00;
 else illegal_insn_o = 1'b1;
            default: illegal_insn_o = 1'b1;
          endcase
        end else begin
          illegal_insn_o = 1'b1;
        end
      end
      OPCODE_CUSTOM_0: begin
        illegal_insn_o = 1'b1;
      end
      OPCODE_CUSTOM_1: begin
        illegal_insn_o = 1'b1;
      end
      OPCODE_CUSTOM_2: begin
        illegal_insn_o = 1'b1;
      end
      OPCODE_CUSTOM_3: begin
        illegal_insn_o = 1'b1;
      end
      OPCODE_FENCE: begin
        unique case (instr_rdata_i[14:12])
          3'b000: begin
            fencei_insn_o = 1'b1;
          end
          3'b001: begin
            fencei_insn_o = 1'b1;
          end
          default: illegal_insn_o = 1'b1;
        endcase
      end
      OPCODE_SYSTEM: begin
        if (instr_rdata_i[14:12] == 3'b000) begin
          if ({instr_rdata_i[19:15], instr_rdata_i[11:7]} == '0) begin
            unique case (instr_rdata_i[31:20])
              12'h000: ecall_insn_o = 1'b1;
              12'h001: ebrk_insn_o = 1'b1;
              12'h302: begin
                illegal_insn_o = 1'b0;
                mret_insn_o    = ~illegal_insn_o;
                mret_dec_o     = 1'b1;
              end
              12'h002: begin
                illegal_insn_o = 1'b1;
                uret_insn_o    = ~illegal_insn_o;
                uret_dec_o     = 1'b1;
              end
              12'h7b2: begin
                illegal_insn_o = !debug_mode_i;
                dret_insn_o    = debug_mode_i;
                dret_dec_o     = 1'b1;
              end
              12'h105: begin
                wfi_o = 1'b1;
                if (debug_wfi_no_sleep_i) begin
                  alu_op_b_mux_sel_o = OP_B_IMM;
                  imm_b_mux_sel_o = IMMB_I;
                  alu_operator_o = ALU_ADD;
                end
              end
              default: illegal_insn_o = 1'b1;
            endcase
          end else illegal_insn_o = 1'b1;
        end else begin
          csr_access_o       = 1'b1;
          regfile_alu_we     = 1'b1;
          alu_op_b_mux_sel_o = OP_B_IMM;
          imm_a_mux_sel_o    = IMMA_Z;
          imm_b_mux_sel_o    = IMMB_I;
          if (instr_rdata_i[14] == 1'b1) begin
            alu_op_a_mux_sel_o = OP_A_IMM;
          end else begin
            rega_used_o        = 1'b1;
            alu_op_a_mux_sel_o = OP_A_REGA_OR_FWD;
          end
          unique case (instr_rdata_i[13:12])
            2'b01:   csr_op = CSR_OP_WRITE;
            2'b10:   csr_op = instr_rdata_i[19:15] == 5'b0 ? CSR_OP_READ : CSR_OP_SET;
            2'b11:   csr_op = instr_rdata_i[19:15] == 5'b0 ? CSR_OP_READ : CSR_OP_CLEAR;
            default: csr_illegal = 1'b1;
          endcase
          if (instr_rdata_i[29:28] > current_priv_lvl_i) begin
            csr_illegal = 1'b1;
          end
          case (instr_rdata_i[31:20])
            CSR_FFLAGS: if (fs_off_i == 1'b1) csr_illegal = 1'b1;
            CSR_FRM, CSR_FCSR:
            if (fs_off_i == 1'b1) begin
              csr_illegal = 1'b1;
            end else begin
              if (csr_op != CSR_OP_READ) csr_status_o = 1'b1;
            end
            CSR_MVENDORID, CSR_MARCHID, CSR_MIMPID, CSR_MHARTID:
            if (csr_op != CSR_OP_READ) csr_illegal = 1'b1;
            CSR_MSTATUS, CSR_MEPC, CSR_MTVEC, CSR_MCAUSE: csr_status_o = 1'b1;
            CSR_MISA, CSR_MIE, CSR_MSCRATCH, CSR_MTVAL, CSR_MIP: ;
            CSR_MCYCLE, CSR_MINSTRET, CSR_MHPMCOUNTER3, CSR_MHPMCOUNTER4, CSR_MHPMCOUNTER5,
            CSR_MHPMCOUNTER6, CSR_MHPMCOUNTER7, CSR_MHPMCOUNTER8, CSR_MHPMCOUNTER9,
            CSR_MHPMCOUNTER10, CSR_MHPMCOUNTER11, CSR_MHPMCOUNTER12, CSR_MHPMCOUNTER13,
            CSR_MHPMCOUNTER14, CSR_MHPMCOUNTER15, CSR_MHPMCOUNTER16, CSR_MHPMCOUNTER17,
            CSR_MHPMCOUNTER18, CSR_MHPMCOUNTER19, CSR_MHPMCOUNTER20, CSR_MHPMCOUNTER21,
            CSR_MHPMCOUNTER22, CSR_MHPMCOUNTER23, CSR_MHPMCOUNTER24, CSR_MHPMCOUNTER25,
            CSR_MHPMCOUNTER26, CSR_MHPMCOUNTER27, CSR_MHPMCOUNTER28, CSR_MHPMCOUNTER29,
            CSR_MHPMCOUNTER30, CSR_MHPMCOUNTER31, CSR_MCYCLEH, CSR_MINSTRETH, CSR_MHPMCOUNTER3H,
            CSR_MHPMCOUNTER4H, CSR_MHPMCOUNTER5H, CSR_MHPMCOUNTER6H, CSR_MHPMCOUNTER7H,
            CSR_MHPMCOUNTER8H, CSR_MHPMCOUNTER9H, CSR_MHPMCOUNTER10H, CSR_MHPMCOUNTER11H,
            CSR_MHPMCOUNTER12H, CSR_MHPMCOUNTER13H, CSR_MHPMCOUNTER14H, CSR_MHPMCOUNTER15H,
            CSR_MHPMCOUNTER16H, CSR_MHPMCOUNTER17H, CSR_MHPMCOUNTER18H, CSR_MHPMCOUNTER19H,
            CSR_MHPMCOUNTER20H, CSR_MHPMCOUNTER21H, CSR_MHPMCOUNTER22H, CSR_MHPMCOUNTER23H,
            CSR_MHPMCOUNTER24H, CSR_MHPMCOUNTER25H, CSR_MHPMCOUNTER26H, CSR_MHPMCOUNTER27H,
            CSR_MHPMCOUNTER28H, CSR_MHPMCOUNTER29H, CSR_MHPMCOUNTER30H, CSR_MHPMCOUNTER31H,
            CSR_MCOUNTINHIBIT, CSR_MHPMEVENT3, CSR_MHPMEVENT4, CSR_MHPMEVENT5, CSR_MHPMEVENT6,
            CSR_MHPMEVENT7, CSR_MHPMEVENT8, CSR_MHPMEVENT9, CSR_MHPMEVENT10, CSR_MHPMEVENT11,
            CSR_MHPMEVENT12, CSR_MHPMEVENT13, CSR_MHPMEVENT14, CSR_MHPMEVENT15, CSR_MHPMEVENT16,
            CSR_MHPMEVENT17, CSR_MHPMEVENT18, CSR_MHPMEVENT19, CSR_MHPMEVENT20, CSR_MHPMEVENT21,
            CSR_MHPMEVENT22, CSR_MHPMEVENT23, CSR_MHPMEVENT24, CSR_MHPMEVENT25, CSR_MHPMEVENT26,
            CSR_MHPMEVENT27, CSR_MHPMEVENT28, CSR_MHPMEVENT29, CSR_MHPMEVENT30, CSR_MHPMEVENT31:
            csr_status_o = 1'b1;
            CSR_CYCLE, CSR_INSTRET, CSR_HPMCOUNTER3, CSR_HPMCOUNTER4, CSR_HPMCOUNTER5,
            CSR_HPMCOUNTER6, CSR_HPMCOUNTER7, CSR_HPMCOUNTER8, CSR_HPMCOUNTER9, CSR_HPMCOUNTER10,
            CSR_HPMCOUNTER11, CSR_HPMCOUNTER12, CSR_HPMCOUNTER13, CSR_HPMCOUNTER14,
            CSR_HPMCOUNTER15, CSR_HPMCOUNTER16, CSR_HPMCOUNTER17, CSR_HPMCOUNTER18,
            CSR_HPMCOUNTER19, CSR_HPMCOUNTER20, CSR_HPMCOUNTER21, CSR_HPMCOUNTER22,
            CSR_HPMCOUNTER23, CSR_HPMCOUNTER24, CSR_HPMCOUNTER25, CSR_HPMCOUNTER26,
            CSR_HPMCOUNTER27, CSR_HPMCOUNTER28, CSR_HPMCOUNTER29, CSR_HPMCOUNTER30,
            CSR_HPMCOUNTER31, CSR_CYCLEH, CSR_INSTRETH, CSR_HPMCOUNTER3H, CSR_HPMCOUNTER4H,
            CSR_HPMCOUNTER5H, CSR_HPMCOUNTER6H, CSR_HPMCOUNTER7H, CSR_HPMCOUNTER8H,
            CSR_HPMCOUNTER9H, CSR_HPMCOUNTER10H, CSR_HPMCOUNTER11H, CSR_HPMCOUNTER12H,
            CSR_HPMCOUNTER13H, CSR_HPMCOUNTER14H, CSR_HPMCOUNTER15H, CSR_HPMCOUNTER16H,
            CSR_HPMCOUNTER17H, CSR_HPMCOUNTER18H, CSR_HPMCOUNTER19H, CSR_HPMCOUNTER20H,
            CSR_HPMCOUNTER21H, CSR_HPMCOUNTER22H, CSR_HPMCOUNTER23H, CSR_HPMCOUNTER24H,
            CSR_HPMCOUNTER25H, CSR_HPMCOUNTER26H, CSR_HPMCOUNTER27H, CSR_HPMCOUNTER28H,
            CSR_HPMCOUNTER29H, CSR_HPMCOUNTER30H, CSR_HPMCOUNTER31H:
            if ((csr_op != CSR_OP_READ)) begin
              csr_illegal = 1'b1;
            end else begin
              csr_status_o = 1'b1;
            end
            CSR_MCOUNTEREN: csr_illegal = 1'b1;
            CSR_DCSR, CSR_DPC, CSR_DSCRATCH0, CSR_DSCRATCH1:
            if (!debug_mode_i) begin
              csr_illegal = 1'b1;
            end else begin
              csr_status_o = 1'b1;
            end
            CSR_TSELECT, CSR_TDATA1, CSR_TDATA2, CSR_TDATA3, CSR_TINFO, CSR_MCONTEXT, CSR_SCONTEXT:
            if (DEBUG_TRIGGER_EN != 1) csr_illegal = 1'b1;
            CSR_LPSTART0, CSR_LPEND0, CSR_LPCOUNT0, CSR_LPSTART1, CSR_LPEND1, CSR_LPCOUNT1:
            csr_illegal = 1'b1;
            CSR_UHARTID: csr_illegal = 1'b1;
            CSR_PRIVLV: csr_illegal = 1'b1;
            CSR_ZFINX: csr_illegal = 1'b1;
            CSR_PMPCFG0, CSR_PMPCFG1, CSR_PMPCFG2, CSR_PMPCFG3, CSR_PMPADDR0, CSR_PMPADDR1,
            CSR_PMPADDR2, CSR_PMPADDR3, CSR_PMPADDR4, CSR_PMPADDR5, CSR_PMPADDR6, CSR_PMPADDR7,
            CSR_PMPADDR8, CSR_PMPADDR9, CSR_PMPADDR10, CSR_PMPADDR11, CSR_PMPADDR12, CSR_PMPADDR13,
            CSR_PMPADDR14, CSR_PMPADDR15:
            csr_illegal = 1'b1;
            CSR_USTATUS, CSR_UEPC, CSR_UTVEC, CSR_UCAUSE: csr_illegal = 1'b1;
            default: csr_illegal = 1'b1;
          endcase
          illegal_insn_o = csr_illegal;
        end
      end
      default: illegal_insn_o = 1'b1;
    endcase
    if (illegal_c_insn_i) begin
      illegal_insn_o = 1'b1;
    end
  end
  assign alu_en_o                    = (deassert_we_i) ? 1'b0 : alu_en;
  assign mult_int_en_o               = (deassert_we_i) ? 1'b0 : mult_int_en;
  assign mult_dot_en_o               = (deassert_we_i) ? 1'b0 : mult_dot_en;
  assign apu_en_o                    = (deassert_we_i) ? 1'b0 : apu_en;
  assign regfile_mem_we_o            = (deassert_we_i) ? 1'b0 : regfile_mem_we;
  assign regfile_alu_we_o            = (deassert_we_i) ? 1'b0 : regfile_alu_we;
  assign data_req_o                  = (deassert_we_i) ? 1'b0 : data_req;
  assign hwlp_we_o                   = (deassert_we_i) ? 3'b0 : hwlp_we;
  assign csr_op_o                    = (deassert_we_i) ? CSR_OP_READ : csr_op;
  assign ctrl_transfer_insn_in_id_o  = (deassert_we_i) ? BRANCH_NONE : ctrl_transfer_insn;
  assign ctrl_transfer_insn_in_dec_o = ctrl_transfer_insn;
  assign regfile_alu_we_dec_o        = regfile_alu_we;
endmodule


module single_file_rv32imf_controller
  import single_file_rv32imf_pkg::*;
(
    input logic clk,
    input logic clk_ungated_i,
    input logic rst_n,
    output logic ctrl_busy_o,
    output logic is_decoding_o,
    input  logic is_fetch_failed_i,
    output logic deassert_we_o,
    input logic illegal_insn_i,
    input logic ecall_insn_i,
    input logic mret_insn_i,
    input logic uret_insn_i,
    input logic dret_insn_i,
    input logic mret_dec_i,
    input logic uret_dec_i,
    input logic dret_dec_i,
    input logic wfi_i,
    input logic ebrk_insn_i,
    input logic fencei_insn_i,
    input logic csr_status_i,
    output logic hwlp_mask_o,
    input logic instr_valid_i,
    output logic instr_req_o,
    output logic       pc_set_o,
    output logic [3:0] pc_mux_o,
    output logic [2:0] exc_pc_mux_o,
    output logic [1:0] trap_addr_mux_o,
    input  logic [31:0] pc_id_i,
    output logic [31:0] hwlp_targ_addr_o,
    input  logic data_req_ex_i,
    input  logic data_we_ex_i,
    input  logic data_misaligned_i,
    input  logic data_load_event_i,
    input  logic data_err_i,
    output logic data_err_ack_o,
    input logic mult_multicycle_i,
    input logic apu_en_i,
    input logic apu_read_dep_i,
    input logic apu_read_dep_for_jalr_i,
    input logic apu_write_dep_i,
    output logic apu_stall_o,
    input logic branch_taken_ex_i,
    input logic [1:0] ctrl_transfer_insn_in_id_i,
    input logic [1:0] ctrl_transfer_insn_in_dec_i,
    input logic            irq_req_ctrl_i,
    input logic            irq_sec_ctrl_i,
    input logic      [4:0] irq_id_ctrl_i,
    input logic            irq_wu_ctrl_i,
    input priv_lvl_t       current_priv_lvl_i,
    output logic       irq_ack_o,
    output logic [4:0] irq_id_o,
    output logic [4:0] exc_cause_o,
    output logic       debug_mode_o,
    output logic [2:0] debug_cause_o,
    output logic       debug_csr_save_o,
    input  logic       debug_single_step_i,
    input  logic       debug_ebreakm_i,
    input  logic       debug_ebreaku_i,
    input  logic       trigger_match_i,
    output logic       debug_p_elw_no_sleep_o,
    output logic       debug_wfi_no_sleep_o,
    output logic wake_from_sleep_o,
    output logic       csr_save_if_o,
    output logic       csr_save_id_o,
    output logic       csr_save_ex_o,
    output logic [5:0] csr_cause_o,
    output logic       csr_irq_sec_o,
    output logic       csr_restore_mret_id_o,
    output logic       csr_restore_uret_id_o,
    output logic       csr_restore_dret_id_o,
    output logic       csr_save_cause_o,
    input logic       regfile_we_id_i,
    input logic [5:0] regfile_alu_waddr_id_i,
    input logic       regfile_we_ex_i,
    input logic [5:0] regfile_waddr_ex_i,
    input logic       regfile_we_wb_i,
    input logic       regfile_alu_we_fw_i,
    output logic [1:0] operand_a_fw_mux_sel_o,
    output logic [1:0] operand_b_fw_mux_sel_o,
    output logic [1:0] operand_c_fw_mux_sel_o,
    input logic reg_d_ex_is_reg_a_i,
    input logic reg_d_ex_is_reg_b_i,
    input logic reg_d_ex_is_reg_c_i,
    input logic reg_d_wb_is_reg_a_i,
    input logic reg_d_wb_is_reg_b_i,
    input logic reg_d_wb_is_reg_c_i,
    input logic reg_d_alu_is_reg_a_i,
    input logic reg_d_alu_is_reg_b_i,
    input logic reg_d_alu_is_reg_c_i,
    output logic halt_if_o,
    output logic halt_id_o,
    output logic misaligned_stall_o,
    output logic jr_stall_o,
    output logic load_stall_o,
    input logic id_ready_i,
    input logic id_valid_i,
    input logic ex_valid_i,
    input logic wb_ready_i,
    output logic perf_pipeline_stall_o
);
  ctrl_state_e ctrl_fsm_cs, ctrl_fsm_ns;
  debug_state_e debug_fsm_cs, debug_fsm_ns;
  logic jump_done, jump_done_q, jump_in_dec, branch_in_id;
  logic data_err_q;
  logic debug_mode_q, debug_mode_n;
  logic ebrk_force_debug_mode;
  logic illegal_insn_q, illegal_insn_n;
  logic debug_req_entry_q, debug_req_entry_n;
  logic debug_force_wakeup_q, debug_force_wakeup_n;
  logic hwlp_end_4_id_d;
  logic debug_req_q;
  logic debug_req_pending;
  logic wfi_active;
  always_comb begin
    instr_req_o = 1'b1;
    data_err_ack_o = 1'b0;
    csr_save_if_o = 1'b0;
    csr_save_id_o = 1'b0;
    csr_save_ex_o = 1'b0;
    csr_restore_mret_id_o = 1'b0;
    csr_restore_uret_id_o = 1'b0;
    csr_restore_dret_id_o = 1'b0;
    csr_save_cause_o = 1'b0;
    exc_cause_o = '0;
    exc_pc_mux_o = EXC_PC_IRQ;
    trap_addr_mux_o = TRAP_MACHINE;
    csr_cause_o = '0;
    csr_irq_sec_o = 1'b0;
    pc_mux_o = PC_BOOT;
    pc_set_o = 1'b0;
    jump_done = jump_done_q;
    ctrl_fsm_ns = ctrl_fsm_cs;
    ctrl_busy_o = 1'b1;
    halt_if_o = 1'b0;
    halt_id_o = 1'b0;
    is_decoding_o = 1'b0;
    irq_ack_o = 1'b0;
    irq_id_o = 5'b0;
    jump_in_dec = ctrl_transfer_insn_in_dec_i == BRANCH_JALR
                || ctrl_transfer_insn_in_dec_i == BRANCH_JAL;
    branch_in_id = ctrl_transfer_insn_in_id_i == BRANCH_COND;
    ebrk_force_debug_mode  = (debug_ebreakm_i && current_priv_lvl_i == PRIV_LVL_M) ||
                             (debug_ebreaku_i && current_priv_lvl_i == PRIV_LVL_U);
    debug_csr_save_o = 1'b0;
    debug_cause_o = DBG_CAUSE_EBREAK;
    debug_mode_n = debug_mode_q;
    illegal_insn_n = illegal_insn_q;
    debug_req_entry_n = debug_req_entry_q;
    debug_force_wakeup_n = debug_force_wakeup_q;
    perf_pipeline_stall_o = 1'b0;
    hwlp_mask_o = 1'b0;
    hwlp_end_4_id_d = 1'b0;
    hwlp_targ_addr_o = '0;
    unique case (ctrl_fsm_cs)
      RESET: begin
        is_decoding_o = 1'b0;
        instr_req_o   = 1'b0;
        ctrl_fsm_ns   = BOOT_SET;
      end
      BOOT_SET: begin
        is_decoding_o = 1'b0;
        instr_req_o   = 1'b1;
        pc_mux_o      = PC_BOOT;
        pc_set_o      = 1'b1;
        if (debug_req_pending) begin
          ctrl_fsm_ns = DBG_TAKEN_IF;
          debug_force_wakeup_n = 1'b1;
        end else begin
          ctrl_fsm_ns = FIRST_FETCH;
        end
      end
      WAIT_SLEEP: begin
        is_decoding_o = 1'b0;
        ctrl_busy_o   = 1'b0;
        instr_req_o   = 1'b0;
        halt_if_o     = 1'b1;
        halt_id_o     = 1'b1;
        ctrl_fsm_ns   = SLEEP;
      end
      SLEEP: begin
        is_decoding_o = 1'b0;
        instr_req_o   = 1'b0;
        halt_if_o     = 1'b1;
        halt_id_o     = 1'b1;
        if (wake_from_sleep_o) begin
          if (debug_req_pending) begin
            ctrl_fsm_ns = DBG_TAKEN_IF;
            debug_force_wakeup_n = 1'b1;
          end else begin
            ctrl_fsm_ns = FIRST_FETCH;
          end
        end else begin
          ctrl_busy_o = 1'b0;
        end
      end
      FIRST_FETCH: begin
        is_decoding_o = 1'b0;
        ctrl_fsm_ns   = DECODE;
        if (irq_req_ctrl_i && ~(debug_req_pending || debug_mode_q)) begin
          halt_if_o     = 1'b1;
          halt_id_o     = 1'b1;
          pc_set_o      = 1'b1;
          pc_mux_o      = PC_EXCEPTION;
          exc_pc_mux_o  = EXC_PC_IRQ;
          exc_cause_o   = irq_id_ctrl_i;
          csr_irq_sec_o = irq_sec_ctrl_i;
          irq_ack_o     = 1'b1;
          irq_id_o      = irq_id_ctrl_i;
          if (irq_sec_ctrl_i) trap_addr_mux_o = TRAP_MACHINE;
          else trap_addr_mux_o = current_priv_lvl_i == PRIV_LVL_U ? TRAP_USER : TRAP_MACHINE;
          csr_save_cause_o = 1'b1;
          csr_cause_o      = {1'b1, irq_id_ctrl_i};
          csr_save_if_o    = 1'b1;
        end
      end
      DECODE: begin
        if (branch_taken_ex_i) begin
          is_decoding_o = 1'b0;
          pc_mux_o      = PC_BRANCH;
          pc_set_o      = 1'b1;
        end else if (data_err_i) begin
          is_decoding_o    = 1'b0;
          halt_if_o        = 1'b1;
          halt_id_o        = 1'b1;
          csr_save_ex_o    = 1'b1;
          csr_save_cause_o = 1'b1;
          data_err_ack_o   = 1'b1;
          csr_cause_o      = {1'b0, data_we_ex_i ? EXC_CAUSE_STORE_FAULT : EXC_CAUSE_LOAD_FAULT};
          ctrl_fsm_ns      = FLUSH_WB;
        end else if (is_fetch_failed_i) begin
          is_decoding_o    = 1'b0;
          halt_id_o        = 1'b1;
          halt_if_o        = 1'b1;
          csr_save_if_o    = 1'b1;
          csr_save_cause_o = !debug_mode_q;
          csr_cause_o      = {1'b0, EXC_CAUSE_INSTR_FAULT};
          ctrl_fsm_ns      = FLUSH_WB;
        end else if (instr_valid_i) begin : blk_decode_level1
          is_decoding_o  = 1'b1;
          illegal_insn_n = 1'b0;
          if ((debug_req_pending || trigger_match_i) & ~debug_mode_q) begin
            is_decoding_o     = 1'b1;
            halt_if_o         = 1'b1;
            halt_id_o         = 1'b1;
            ctrl_fsm_ns       = DBG_FLUSH;
            debug_req_entry_n = 1'b1;
          end else if (irq_req_ctrl_i && ~debug_mode_q) begin
            hwlp_mask_o   = 1'b0;
            is_decoding_o = 1'b0;
            halt_if_o     = 1'b1;
            halt_id_o     = 1'b1;
            pc_set_o      = 1'b1;
            pc_mux_o      = PC_EXCEPTION;
            exc_pc_mux_o  = EXC_PC_IRQ;
            exc_cause_o   = irq_id_ctrl_i;
            csr_irq_sec_o = irq_sec_ctrl_i;
            irq_ack_o     = 1'b1;
            irq_id_o      = irq_id_ctrl_i;
            if (irq_sec_ctrl_i) trap_addr_mux_o = TRAP_MACHINE;
            else trap_addr_mux_o = current_priv_lvl_i == PRIV_LVL_U ? TRAP_USER : TRAP_MACHINE;
            csr_save_cause_o = 1'b1;
            csr_cause_o      = {1'b1, irq_id_ctrl_i};
            csr_save_id_o    = 1'b1;
          end else begin
            if (illegal_insn_i) begin
              halt_if_o      = 1'b1;
              halt_id_o      = 1'b0;
              ctrl_fsm_ns    = id_ready_i ? FLUSH_EX : DECODE;
              illegal_insn_n = 1'b1;
            end else begin
              unique case (1'b1)
                jump_in_dec: begin
                  pc_mux_o = PC_JUMP;
                  if ((~jr_stall_o) && (~jump_done_q)) begin
                    pc_set_o  = 1'b1;
                    jump_done = 1'b1;
                  end
                end
                ebrk_insn_i: begin
                  halt_if_o = 1'b1;
                  halt_id_o = 1'b0;
                  if (debug_mode_q) ctrl_fsm_ns = DBG_FLUSH;
                  else if (ebrk_force_debug_mode) begin
                    ctrl_fsm_ns = DBG_FLUSH;
                  end else begin
                    ctrl_fsm_ns = id_ready_i ? FLUSH_EX : DECODE;
                  end
                end
                wfi_active: begin
                  halt_if_o   = 1'b1;
                  halt_id_o   = 1'b0;
                  ctrl_fsm_ns = id_ready_i ? FLUSH_EX : DECODE;
                end
                ecall_insn_i: begin
                  halt_if_o   = 1'b1;
                  halt_id_o   = 1'b0;
                  ctrl_fsm_ns = id_ready_i ? FLUSH_EX : DECODE;
                end
                fencei_insn_i: begin
                  halt_if_o   = 1'b1;
                  halt_id_o   = 1'b0;
                  ctrl_fsm_ns = id_ready_i ? FLUSH_EX : DECODE;
                end
                mret_insn_i | uret_insn_i | dret_insn_i: begin
                  halt_if_o   = 1'b1;
                  halt_id_o   = 1'b0;
                  ctrl_fsm_ns = id_ready_i ? FLUSH_EX : DECODE;
                end
                csr_status_i: begin
                  halt_if_o = 1'b1;
                  if (~id_ready_i) begin
                    ctrl_fsm_ns = DECODE;
                  end else begin
                    ctrl_fsm_ns = FLUSH_EX;
                  end
                end
                data_load_event_i: begin
                  ctrl_fsm_ns = id_ready_i ? ELW_EXE : DECODE;
                  halt_if_o   = 1'b1;
                end
                default: begin
                end
              endcase
            end
            if (debug_single_step_i & ~debug_mode_q) begin
              halt_if_o = 1'b1;
              if (id_ready_i) begin
                unique case (1'b1)
                  illegal_insn_i | ecall_insn_i: begin
                    ctrl_fsm_ns = FLUSH_EX;
                  end
                  (~ebrk_force_debug_mode & ebrk_insn_i): begin
                    ctrl_fsm_ns = FLUSH_EX;
                  end
                  mret_insn_i | uret_insn_i: begin
                    ctrl_fsm_ns = FLUSH_EX;
                  end
                  branch_in_id: begin
                    ctrl_fsm_ns = DBG_WAIT_BRANCH;
                  end
                  default: ctrl_fsm_ns = DBG_FLUSH;
                endcase
              end
            end
          end
        end else begin
          is_decoding_o         = 1'b0;
          perf_pipeline_stall_o = data_load_event_i;
        end
      end
      FLUSH_EX: begin
        is_decoding_o = 1'b0;
        halt_if_o = 1'b1;
        halt_id_o = 1'b1;
        if (data_err_i) begin
          csr_save_ex_o    = 1'b1;
          csr_save_cause_o = 1'b1;
          data_err_ack_o   = 1'b1;
          csr_cause_o      = {1'b0, data_we_ex_i ? EXC_CAUSE_STORE_FAULT : EXC_CAUSE_LOAD_FAULT};
          ctrl_fsm_ns      = FLUSH_WB;
          illegal_insn_n   = 1'b0;
        end else if (ex_valid_i) begin
          ctrl_fsm_ns = FLUSH_WB;
          if (illegal_insn_q) begin
            csr_save_id_o    = 1'b1;
            csr_save_cause_o = !debug_mode_q;
            csr_cause_o      = {1'b0, EXC_CAUSE_ILLEGAL_INSN};
          end else begin
            unique case (1'b1)
              ebrk_insn_i: begin
                csr_save_id_o    = 1'b1;
                csr_save_cause_o = 1'b1;
                csr_cause_o      = {1'b0, EXC_CAUSE_BREAKPOINT};
              end
              ecall_insn_i: begin
                csr_save_id_o = 1'b1;
                csr_save_cause_o = !debug_mode_q;
                csr_cause_o = {
                  1'b0,
                  current_priv_lvl_i == PRIV_LVL_U ? EXC_CAUSE_ECALL_UMODE : EXC_CAUSE_ECALL_MMODE
                };
              end
              default: ;
            endcase
          end
        end
      end
      FLUSH_WB: begin
        is_decoding_o = 1'b0;
        halt_if_o = 1'b1;
        halt_id_o = 1'b1;
        ctrl_fsm_ns = DECODE;
        if (data_err_q) begin
          pc_mux_o        = PC_EXCEPTION;
          pc_set_o        = 1'b1;
          trap_addr_mux_o = TRAP_MACHINE;
          exc_pc_mux_o    = EXC_PC_EXCEPTION;
          exc_cause_o     = data_we_ex_i ? EXC_CAUSE_LOAD_FAULT : EXC_CAUSE_STORE_FAULT;
        end else if (is_fetch_failed_i) begin
          pc_mux_o        = PC_EXCEPTION;
          pc_set_o        = 1'b1;
          trap_addr_mux_o = TRAP_MACHINE;
          exc_pc_mux_o    = debug_mode_q ? EXC_PC_DBE : EXC_PC_EXCEPTION;
          exc_cause_o     = EXC_CAUSE_INSTR_FAULT;
        end else begin
          if (illegal_insn_q) begin
            pc_mux_o        = PC_EXCEPTION;
            pc_set_o        = 1'b1;
            trap_addr_mux_o = TRAP_MACHINE;
            exc_pc_mux_o    = debug_mode_q ? EXC_PC_DBE : EXC_PC_EXCEPTION;
            illegal_insn_n  = 1'b0;
            if (debug_single_step_i && ~debug_mode_q) ctrl_fsm_ns = DBG_TAKEN_IF;
          end else begin
            unique case (1'b1)
              ebrk_insn_i: begin
                pc_mux_o        = PC_EXCEPTION;
                pc_set_o        = 1'b1;
                trap_addr_mux_o = TRAP_MACHINE;
                exc_pc_mux_o    = EXC_PC_EXCEPTION;
                if (debug_single_step_i && ~debug_mode_q) ctrl_fsm_ns = DBG_TAKEN_IF;
              end
              ecall_insn_i: begin
                pc_mux_o        = PC_EXCEPTION;
                pc_set_o        = 1'b1;
                trap_addr_mux_o = TRAP_MACHINE;
                exc_pc_mux_o    = debug_mode_q ? EXC_PC_DBE : EXC_PC_EXCEPTION;
                if (debug_single_step_i && ~debug_mode_q) ctrl_fsm_ns = DBG_TAKEN_IF;
              end
              mret_insn_i: begin
                csr_restore_mret_id_o = !debug_mode_q;
                ctrl_fsm_ns           = XRET_JUMP;
              end
              uret_insn_i: begin
                csr_restore_uret_id_o = !debug_mode_q;
                ctrl_fsm_ns           = XRET_JUMP;
              end
              dret_insn_i: begin
                csr_restore_dret_id_o = 1'b1;
                ctrl_fsm_ns           = XRET_JUMP;
              end
              csr_status_i: begin
              end
              wfi_i: begin
                if (debug_req_pending) begin
                  ctrl_fsm_ns = DBG_TAKEN_IF;
                  debug_force_wakeup_n = 1'b1;
                end else begin
                  ctrl_fsm_ns = WAIT_SLEEP;
                end
              end
              fencei_insn_i: begin
                pc_mux_o = PC_FENCEI;
                pc_set_o = 1'b1;
              end
              default: ;
            endcase
          end
        end
      end
      XRET_JUMP: begin
        is_decoding_o = 1'b0;
        ctrl_fsm_ns   = DECODE;
        unique case (1'b1)
          mret_dec_i: begin
            pc_mux_o     = debug_mode_q ? PC_EXCEPTION : PC_MRET;
            pc_set_o     = 1'b1;
            exc_pc_mux_o = EXC_PC_DBE;
          end
          uret_dec_i: begin
            pc_mux_o     = debug_mode_q ? PC_EXCEPTION : PC_URET;
            pc_set_o     = 1'b1;
            exc_pc_mux_o = EXC_PC_DBE;
          end
          dret_dec_i: begin
            pc_mux_o     = PC_DRET;
            pc_set_o     = 1'b1;
            debug_mode_n = 1'b0;
          end
          default: ;
        endcase
        if (debug_single_step_i && ~debug_mode_q) begin
          ctrl_fsm_ns = DBG_TAKEN_IF;
        end
      end
      DBG_WAIT_BRANCH: begin
        is_decoding_o = 1'b0;
        halt_if_o     = 1'b1;
        if (branch_taken_ex_i) begin
          pc_mux_o = PC_BRANCH;
          pc_set_o = 1'b1;
        end
        ctrl_fsm_ns = DBG_FLUSH;
      end
      DBG_TAKEN_ID: begin
        is_decoding_o = 1'b0;
        pc_set_o      = 1'b1;
        pc_mux_o      = PC_EXCEPTION;
        exc_pc_mux_o  = EXC_PC_DBD;
        if (~debug_mode_q) begin
          csr_save_cause_o = 1'b1;
          csr_save_id_o    = 1'b1;
          debug_csr_save_o = 1'b1;
          if (trigger_match_i) debug_cause_o = DBG_CAUSE_TRIGGER;
          else if (ebrk_force_debug_mode & ebrk_insn_i) debug_cause_o = DBG_CAUSE_EBREAK;
          else if (debug_req_entry_q) debug_cause_o = DBG_CAUSE_HALTREQ;
        end
        debug_req_entry_n = 1'b0;
        ctrl_fsm_ns       = DECODE;
        debug_mode_n      = 1'b1;
      end
      DBG_TAKEN_IF: begin
        is_decoding_o    = 1'b0;
        pc_set_o         = 1'b1;
        pc_mux_o         = PC_EXCEPTION;
        exc_pc_mux_o     = EXC_PC_DBD;
        csr_save_cause_o = 1'b1;
        debug_csr_save_o = 1'b1;
        if (debug_force_wakeup_q) debug_cause_o = DBG_CAUSE_HALTREQ;
        else if (debug_single_step_i) debug_cause_o = DBG_CAUSE_STEP;
        csr_save_if_o        = 1'b1;
        ctrl_fsm_ns          = DECODE;
        debug_mode_n         = 1'b1;
        debug_force_wakeup_n = 1'b0;
      end
      DBG_FLUSH: begin
        is_decoding_o = 1'b0;
        halt_if_o = 1'b1;
        halt_id_o = 1'b1;
        perf_pipeline_stall_o = data_load_event_i;
        if (data_err_i) begin
          csr_save_ex_o    = 1'b1;
          csr_save_cause_o = 1'b1;
          data_err_ack_o   = 1'b1;
          csr_cause_o      = {1'b0, data_we_ex_i ? EXC_CAUSE_STORE_FAULT : EXC_CAUSE_LOAD_FAULT};
          ctrl_fsm_ns      = FLUSH_WB;
        end else begin
          if(debug_mode_q                                      |
             trigger_match_i                                  |
             (ebrk_force_debug_mode & ebrk_insn_i)             |
             data_load_event_i                                |
             debug_req_entry_q
             )
            begin
            ctrl_fsm_ns = DBG_TAKEN_ID;
          end else begin
            ctrl_fsm_ns = DBG_TAKEN_IF;
          end
        end
      end
      default: begin
        is_decoding_o = 1'b0;
        instr_req_o   = 1'b0;
        ctrl_fsm_ns   = RESET;
      end
    endcase
  end
  always_comb begin
    load_stall_o  = 1'b0;
    deassert_we_o = 1'b0;
    if (~is_decoding_o) deassert_we_o = 1'b1;
    if (illegal_insn_i) deassert_we_o = 1'b1;
    if (
          ( (data_req_ex_i == 1'b1) && (regfile_we_ex_i == 1'b1) ||
            (wb_ready_i == 1'b0) && (regfile_we_wb_i == 1'b1)
          ) &&
          ( (reg_d_ex_is_reg_a_i == 1'b1) || (reg_d_ex_is_reg_b_i == 1'b1)
         || (reg_d_ex_is_reg_c_i == 1'b1) || (is_decoding_o &&
            (regfile_we_id_i && !data_misaligned_i)
            && (regfile_waddr_ex_i == regfile_alu_waddr_id_i)))
       )
    begin
      deassert_we_o = 1'b1;
      load_stall_o  = 1'b1;
    end
    if ((ctrl_transfer_insn_in_dec_i == BRANCH_JALR) &&
        (((regfile_we_wb_i == 1'b1) && (reg_d_wb_is_reg_a_i == 1'b1)) ||
         ((regfile_we_ex_i == 1'b1) && (reg_d_ex_is_reg_a_i == 1'b1)) ||
         ((regfile_alu_we_fw_i == 1'b1) && (reg_d_alu_is_reg_a_i == 1'b1)) ||
         ((apu_read_dep_for_jalr_i == 1'b1))
        )
       )
    begin
      jr_stall_o    = 1'b1;
      deassert_we_o = 1'b1;
    end else begin
      jr_stall_o = 1'b0;
    end
  end
  assign misaligned_stall_o = data_misaligned_i;
  assign apu_stall_o = apu_read_dep_i | (apu_write_dep_i & ~apu_en_i);
  always_comb begin
    operand_a_fw_mux_sel_o = SEL_REGFILE;
    operand_b_fw_mux_sel_o = SEL_REGFILE;
    operand_c_fw_mux_sel_o = SEL_REGFILE;
    if (regfile_we_wb_i == 1'b1) begin
      if (reg_d_wb_is_reg_a_i == 1'b1) operand_a_fw_mux_sel_o = SEL_FW_WB;
      if (reg_d_wb_is_reg_b_i == 1'b1) operand_b_fw_mux_sel_o = SEL_FW_WB;
      if (reg_d_wb_is_reg_c_i == 1'b1) operand_c_fw_mux_sel_o = SEL_FW_WB;
    end
    if (regfile_alu_we_fw_i == 1'b1) begin
      if (reg_d_alu_is_reg_a_i == 1'b1) operand_a_fw_mux_sel_o = SEL_FW_EX;
      if (reg_d_alu_is_reg_b_i == 1'b1) operand_b_fw_mux_sel_o = SEL_FW_EX;
      if (reg_d_alu_is_reg_c_i == 1'b1) operand_c_fw_mux_sel_o = SEL_FW_EX;
    end
    if (data_misaligned_i) begin
      operand_a_fw_mux_sel_o = SEL_FW_EX;
      operand_b_fw_mux_sel_o = SEL_REGFILE;
    end else if (mult_multicycle_i) begin
      operand_c_fw_mux_sel_o = SEL_FW_EX;
    end
  end
  always_ff @(posedge clk, negedge rst_n) begin : UPDATE_REGS
    if (rst_n == 1'b0) begin
      ctrl_fsm_cs          <= RESET;
      jump_done_q          <= 1'b0;
      data_err_q           <= 1'b0;
      debug_mode_q         <= 1'b0;
      illegal_insn_q       <= 1'b0;
      debug_req_entry_q    <= 1'b0;
      debug_force_wakeup_q <= 1'b0;
    end else begin
      ctrl_fsm_cs          <= ctrl_fsm_ns;
      jump_done_q          <= jump_done & (~id_ready_i);
      data_err_q           <= data_err_i;
      debug_mode_q         <= debug_mode_n;
      illegal_insn_q       <= illegal_insn_n;
      debug_req_entry_q    <= debug_req_entry_n;
      debug_force_wakeup_q <= debug_force_wakeup_n;
    end
  end
  assign wake_from_sleep_o = irq_wu_ctrl_i || debug_req_pending || debug_mode_q;
  assign debug_mode_o = debug_mode_q;
  assign debug_req_pending = debug_req_q;
  assign debug_p_elw_no_sleep_o = debug_mode_q || debug_req_q
                                  || debug_single_step_i || trigger_match_i;
  assign debug_wfi_no_sleep_o = debug_mode_q || debug_req_pending
                                  || debug_single_step_i || trigger_match_i;
  assign wfi_active = wfi_i & ~debug_wfi_no_sleep_o;
  always_ff @(posedge clk_ungated_i, negedge rst_n)
    if (!rst_n) debug_req_q <= 1'b0;
    else if (debug_mode_q) debug_req_q <= 1'b0;
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      debug_fsm_cs <= HAVERESET;
    end else begin
      debug_fsm_cs <= debug_fsm_ns;
    end
  end
  always_comb begin
    debug_fsm_ns = debug_fsm_cs;
    case (debug_fsm_cs)
      HAVERESET: begin
        if (debug_mode_n || (ctrl_fsm_ns == FIRST_FETCH)) begin
          if (debug_mode_n) begin
            debug_fsm_ns = HALTED;
          end else begin
            debug_fsm_ns = RUNNING;
          end
        end
      end
      RUNNING: begin
        if (debug_mode_n) begin
          debug_fsm_ns = HALTED;
        end
      end
      HALTED: begin
        if (!debug_mode_n) begin
          debug_fsm_ns = RUNNING;
        end
      end
      default: begin
        debug_fsm_ns = HAVERESET;
      end
    endcase
  end
endmodule


module single_file_rv32imf_int_controller
  import single_file_rv32imf_pkg::*;
(
    input logic clk,
    input logic rst_n,
    input logic [31:0] irq_i,
    input logic        irq_sec_i,
    output logic       irq_req_ctrl_o,
    output logic       irq_sec_ctrl_o,
    output logic [4:0] irq_id_ctrl_o,
    output logic       irq_wu_ctrl_o,
    input  logic      [31:0] mie_bypass_i,
    output logic      [31:0] mip_o,
    input  logic             m_ie_i,
    input  logic             u_ie_i,
    input  priv_lvl_t        current_priv_lvl_i
);
  logic        global_irq_enable;
  logic [31:0] irq_local_qual;
  logic [31:0] irq_q;
  logic        irq_sec_q;
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      irq_q     <= '0;
      irq_sec_q <= 1'b0;
    end else begin
      irq_q <= irq_i & IRQ_MASK;
      irq_sec_q <= irq_sec_i;
    end
  end
  assign mip_o = irq_q;
  assign irq_local_qual = irq_q & mie_bypass_i;
  assign irq_wu_ctrl_o = |(irq_i & mie_bypass_i);
  assign global_irq_enable = m_ie_i;
  assign irq_req_ctrl_o = (|irq_local_qual) && global_irq_enable;
  always_comb begin
    if (irq_local_qual[31]) irq_id_ctrl_o = 5'd31;
    else if (irq_local_qual[30]) irq_id_ctrl_o = 5'd30;
    else if (irq_local_qual[29]) irq_id_ctrl_o = 5'd29;
    else if (irq_local_qual[28]) irq_id_ctrl_o = 5'd28;
    else if (irq_local_qual[27]) irq_id_ctrl_o = 5'd27;
    else if (irq_local_qual[26]) irq_id_ctrl_o = 5'd26;
    else if (irq_local_qual[25]) irq_id_ctrl_o = 5'd25;
    else if (irq_local_qual[24]) irq_id_ctrl_o = 5'd24;
    else if (irq_local_qual[23]) irq_id_ctrl_o = 5'd23;
    else if (irq_local_qual[22]) irq_id_ctrl_o = 5'd22;
    else if (irq_local_qual[21]) irq_id_ctrl_o = 5'd21;
    else if (irq_local_qual[20]) irq_id_ctrl_o = 5'd20;
    else if (irq_local_qual[19]) irq_id_ctrl_o = 5'd19;
    else if (irq_local_qual[18]) irq_id_ctrl_o = 5'd18;
    else if (irq_local_qual[17]) irq_id_ctrl_o = 5'd17;
    else if (irq_local_qual[16]) irq_id_ctrl_o = 5'd16;
    else if (irq_local_qual[15]) irq_id_ctrl_o = 5'd15;
    else if (irq_local_qual[14]) irq_id_ctrl_o = 5'd14;
    else if (irq_local_qual[13]) irq_id_ctrl_o = 5'd13;
    else if (irq_local_qual[12]) irq_id_ctrl_o = 5'd12;
    else if (irq_local_qual[CSR_MEIX_BIT]) irq_id_ctrl_o = CSR_MEIX_BIT;
    else if (irq_local_qual[CSR_MSIX_BIT]) irq_id_ctrl_o = CSR_MSIX_BIT;
    else if (irq_local_qual[CSR_MTIX_BIT]) irq_id_ctrl_o = CSR_MTIX_BIT;
    else if (irq_local_qual[10]) irq_id_ctrl_o = 5'd10;
    else if (irq_local_qual[2]) irq_id_ctrl_o = 5'd2;
    else if (irq_local_qual[6]) irq_id_ctrl_o = 5'd6;
    else if (irq_local_qual[9]) irq_id_ctrl_o = 5'd9;
    else if (irq_local_qual[1]) irq_id_ctrl_o = 5'd1;
    else if (irq_local_qual[5]) irq_id_ctrl_o = 5'd5;
    else if (irq_local_qual[8]) irq_id_ctrl_o = 5'd8;
    else if (irq_local_qual[0]) irq_id_ctrl_o = 5'd0;
    else if (irq_local_qual[4]) irq_id_ctrl_o = 5'd4;
    else irq_id_ctrl_o = CSR_MTIX_BIT;
  end
  assign irq_sec_ctrl_o = irq_sec_q;
endmodule


module single_file_rv32imf_id_stage
  import single_file_rv32imf_pkg::*;
#(
    parameter int N_HWLP = 2,
    parameter int N_HWLP_BITS = $clog2(N_HWLP)
) (
    input logic clk,
    input logic clk_ungated_i,
    input logic rst_n,
    output logic ctrl_busy_o,
    output logic is_decoding_o,
    input  logic        instr_valid_i,
    input  logic [31:0] instr_rdata_i,
    output logic        instr_req_o,
    input  logic        is_compressed_i,
    input  logic        illegal_c_insn_i,
    output logic        branch_in_ex_o,
    input  logic        branch_decision_i,
    output logic [31:0] jump_target_o,
    output logic [ 1:0] ctrl_transfer_insn_in_dec_o,
    output logic       clear_instr_valid_o,
    output logic       pc_set_o,
    output logic [3:0] pc_mux_o,
    output logic [2:0] exc_pc_mux_o,
    output logic [1:0] trap_addr_mux_o,
    input logic is_fetch_failed_i,
    input logic [31:0] pc_id_i,
    output logic halt_if_o,
    output logic id_ready_o,
    input  logic ex_ready_i,
    input  logic wb_ready_i,
    output logic id_valid_o,
    input  logic ex_valid_i,
    output logic [31:0] pc_ex_o,
    output logic [31:0] alu_operand_a_ex_o,
    output logic [31:0] alu_operand_b_ex_o,
    output logic [31:0] alu_operand_c_ex_o,
    output logic [ 4:0] bmask_a_ex_o,
    output logic [ 4:0] bmask_b_ex_o,
    output logic [ 1:0] imm_vec_ext_ex_o,
    output logic [ 1:0] alu_vec_mode_ex_o,
    output logic [5:0] regfile_waddr_ex_o,
    output logic       regfile_we_ex_o,
    output logic [5:0] regfile_alu_waddr_ex_o,
    output logic       regfile_alu_we_ex_o,
    output logic              alu_en_ex_o,
    output alu_opcode_e       alu_operator_ex_o,
    output logic              alu_is_clpx_ex_o,
    output logic              alu_is_subrot_ex_o,
    output logic        [1:0] alu_clpx_shift_ex_o,
    output mul_opcode_e        mult_operator_ex_o,
    output logic        [31:0] mult_operand_a_ex_o,
    output logic        [31:0] mult_operand_b_ex_o,
    output logic        [31:0] mult_operand_c_ex_o,
    output logic               mult_en_ex_o,
    output logic               mult_sel_subword_ex_o,
    output logic        [ 1:0] mult_signed_mode_ex_o,
    output logic        [ 4:0] mult_imm_ex_o,
    output logic [31:0] mult_dot_op_a_ex_o,
    output logic [31:0] mult_dot_op_b_ex_o,
    output logic [31:0] mult_dot_op_c_ex_o,
    output logic [ 1:0] mult_dot_signed_ex_o,
    output logic        mult_is_clpx_ex_o,
    output logic [ 1:0] mult_clpx_shift_ex_o,
    output logic        mult_clpx_img_ex_o,
    output logic              apu_en_ex_o,
    output logic [ 5:0]       apu_op_ex_o,
    output logic [ 1:0]       apu_lat_ex_o,
    output logic [ 2:0][31:0] apu_operands_ex_o,
    output logic [14:0]       apu_flags_ex_o,
    output logic [ 5:0]       apu_waddr_ex_o,
    output logic [2:0][5:0] apu_read_regs_o,
    output logic [2:0]      apu_read_regs_valid_o,
    input  logic            apu_read_dep_i,
    input  logic            apu_read_dep_for_jalr_i,
    output logic [1:0][5:0] apu_write_regs_o,
    output logic [1:0]      apu_write_regs_valid_o,
    input  logic            apu_write_dep_i,
    output logic            apu_perf_dep_o,
    input  logic            apu_busy_i,
    input logic            fs_off_i,
    input logic [C_RM-1:0] frm_i,
    output logic              csr_access_ex_o,
    output csr_opcode_e       csr_op_ex_o,
    input  priv_lvl_t         current_priv_lvl_i,
    output logic              csr_irq_sec_o,
    output logic        [5:0] csr_cause_o,
    output logic              csr_save_if_o,
    output logic              csr_save_id_o,
    output logic              csr_save_ex_o,
    output logic              csr_restore_mret_id_o,
    output logic              csr_restore_uret_id_o,
    output logic              csr_restore_dret_id_o,
    output logic              csr_save_cause_o,
    output logic [31:0] hwlp_target_o,
    output logic       data_req_ex_o,
    output logic       data_we_ex_o,
    output logic [1:0] data_type_ex_o,
    output logic [1:0] data_sign_ext_ex_o,
    output logic [1:0] data_reg_offset_ex_o,
    output logic data_misaligned_ex_o,
    output logic prepost_useincr_ex_o,
    input  logic data_misaligned_i,
    input  logic data_err_i,
    output logic data_err_ack_o,
    output logic [5:0] atop_ex_o,
    input  logic [31:0] irq_i,
    input  logic        irq_sec_i,
    input  logic [31:0] mie_bypass_i,
    output logic [31:0] mip_o,
    input  logic        m_irq_enable_i,
    input  logic        u_irq_enable_i,
    output logic        irq_ack_o,
    output logic [ 4:0] irq_id_o,
    output logic [ 4:0] exc_cause_o,
    output logic       debug_mode_o,
    output logic [2:0] debug_cause_o,
    output logic       debug_csr_save_o,
    input  logic       debug_single_step_i,
    input  logic       debug_ebreakm_i,
    input  logic       debug_ebreaku_i,
    input  logic       trigger_match_i,
    output logic       debug_p_elw_no_sleep_o,
    output logic wake_from_sleep_o,
    input logic [5:0] regfile_waddr_wb_i,
    input logic regfile_we_wb_i,
    input logic regfile_we_wb_power_i,
    input logic [31:0] regfile_wdata_wb_i,
    input logic [ 5:0] regfile_alu_waddr_fw_i,
    input logic        regfile_alu_we_fw_i,
    input logic        regfile_alu_we_fw_power_i,
    input logic [31:0] regfile_alu_wdata_fw_i,
    input logic mult_multicycle_i,
    output logic mhpmevent_minstret_o,
    output logic mhpmevent_load_o,
    output logic mhpmevent_store_o,
    output logic mhpmevent_jump_o,
    output logic mhpmevent_branch_o,
    output logic mhpmevent_branch_taken_o,
    output logic mhpmevent_compressed_o,
    output logic mhpmevent_jr_stall_o,
    output logic mhpmevent_imiss_o,
    output logic mhpmevent_ld_stall_o,
    output logic mhpmevent_pipe_stall_o,
    input logic        perf_imiss_i,
    input logic [31:0] mcounteren_i
);
  localparam int RegS1MSB = 19;
  localparam int RegS1LSB = 15;
  localparam int RegS2MSB = 24;
  localparam int RegS2LSB = 20;
  localparam int RegS4MSB = 31;
  localparam int RegS4LSB = 27;
  localparam int RegDMSB = 11;
  localparam int RegDLSB = 7;
  logic [31:0] instr;
  logic        deassert_we;
  logic        illegal_insn_dec;
  logic        ebrk_insn_dec;
  logic        mret_insn_dec;
  logic        uret_insn_dec;
  logic        dret_insn_dec;
  logic        ecall_insn_dec;
  logic        wfi_insn_dec;
  logic        fencei_insn_dec;
  logic        rega_used_dec;
  logic        regb_used_dec;
  logic        regc_used_dec;
  logic        branch_taken_ex;
  logic [ 1:0] ctrl_transfer_insn_in_id;
  logic [ 1:0] ctrl_transfer_insn_in_dec;
  logic        misaligned_stall;
  logic        jr_stall;
  logic        load_stall;
  logic        csr_apu_stall;
  logic        hwlp_mask;
  logic        halt_id;
  logic        halt_if;
  logic        debug_wfi_no_sleep;
  logic [31:0] imm_i_type;
  logic [31:0] imm_iz_type;
  logic [31:0] imm_s_type;
  logic [31:0] imm_sb_type;
  logic [31:0] imm_u_type;
  logic [31:0] imm_uj_type;
  logic [31:0] imm_z_type;
  logic [31:0] imm_s2_type;
  logic [31:0] imm_bi_type;
  logic [31:0] imm_s3_type;
  logic [31:0] imm_vs_type;
  logic [31:0] imm_vu_type;
  logic [31:0] imm_shuffleb_type;
  logic [31:0] imm_shuffleh_type;
  logic [31:0] imm_shuffle_type;
  logic [31:0] imm_clip_type;
  logic [31:0] imm_a;
  logic [31:0] imm_b;
  logic [31:0] jump_target;
  logic        irq_req_ctrl;
  logic        irq_sec_ctrl;
  logic        irq_wu_ctrl;
  logic [ 4:0] irq_id_ctrl;
  logic [ 5:0] regfile_addr_ra_id;
  logic [ 5:0] regfile_addr_rb_id;
  logic [ 5:0] regfile_addr_rc_id;
  logic        regfile_fp_a;
  logic        regfile_fp_b;
  logic        regfile_fp_c;
  logic        regfile_fp_d;
  logic [ 5:0] regfile_waddr_id;
  logic [ 5:0] regfile_alu_waddr_id;
  logic regfile_alu_we_id, regfile_alu_we_dec_id;
  logic        [                                31:0]       regfile_data_ra_id;
  logic        [                                31:0]       regfile_data_rb_id;
  logic        [                                31:0]       regfile_data_rc_id;
  logic                                                     alu_en;
  alu_opcode_e                                              alu_operator;
  logic        [                                 2:0]       alu_op_a_mux_sel;
  logic        [                                 2:0]       alu_op_b_mux_sel;
  logic        [                                 1:0]       alu_op_c_mux_sel;
  logic        [                                 1:0]       regc_mux;
  logic        [                                 0:0]       imm_a_mux_sel;
  logic        [                                 3:0]       imm_b_mux_sel;
  logic        [                                 1:0]       ctrl_transfer_target_mux_sel;
  mul_opcode_e                                              mult_operator;
  logic                                                     mult_en;
  logic                                                     mult_int_en;
  logic                                                     mult_sel_subword;
  logic        [                                 1:0]       mult_signed_mode;
  logic                                                     mult_dot_en;
  logic        [                                 1:0]       mult_dot_signed;
  logic        [ single_file_rv32imf_fpu_pkg::FP_FORMAT_BITS-1:0]       fpu_src_fmt;
  logic        [ single_file_rv32imf_fpu_pkg::FP_FORMAT_BITS-1:0]       fpu_dst_fmt;
  logic        [single_file_rv32imf_fpu_pkg::INT_FORMAT_BITS-1:0]       fpu_int_fmt;
  logic                                                     apu_en;
  logic        [                                 5:0]       apu_op;
  logic        [                                 1:0]       apu_lat;
  logic        [                                 2:0][31:0] apu_operands;
  logic        [                                14:0]       apu_flags;
  logic        [                                 5:0]       apu_waddr;
  logic        [                                 2:0][ 5:0] apu_read_regs;
  logic        [                                 2:0]       apu_read_regs_valid;
  logic        [                                 1:0][ 5:0] apu_write_regs;
  logic        [                                 1:0]       apu_write_regs_valid;
  logic                                                     apu_stall;
  logic        [                                 2:0]       fp_rnd_mode;
  logic                                                     regfile_we_id;
  logic                                                     regfile_alu_waddr_mux_sel;
  logic                                                     data_we_id;
  logic        [                                 1:0]       data_type_id;
  logic        [                                 1:0]       data_sign_ext_id;
  logic        [                                 1:0]       data_reg_offset_id;
  logic                                                     data_req_id;
  logic                                                     data_load_event_id;
  logic        [                                 5:0]       atop_id;
  logic        [                                 2:0]       hwlp_we;
  logic        [                                 1:0]       hwlp_target_mux_sel;
  logic        [                                 1:0]       hwlp_start_mux_sel;
  logic                                                     hwlp_cnt_mux_sel;
  logic        [                          N_HWLP-1:0]       hwlp_dec_cnt;
  logic                                                     csr_access;
  csr_opcode_e                                              csr_op;
  logic                                                     csr_status;
  logic                                                     prepost_useincr;
  logic        [                                 1:0]       operand_a_fw_mux_sel;
  logic        [                                 1:0]       operand_b_fw_mux_sel;
  logic        [                                 1:0]       operand_c_fw_mux_sel;
  logic        [                                31:0]       operand_a_fw_id;
  logic        [                                31:0]       operand_b_fw_id;
  logic        [                                31:0]       operand_c_fw_id;
  logic [31:0] operand_b, operand_b_vec;
  logic [31:0] operand_c, operand_c_vec;
  logic [31:0] alu_operand_a;
  logic [31:0] alu_operand_b;
  logic [31:0] alu_operand_c;
  logic [ 0:0] bmask_a_mux;
  logic [ 1:0] bmask_b_mux;
  logic        alu_bmask_a_mux_sel;
  logic        alu_bmask_b_mux_sel;
  logic [ 0:0] mult_imm_mux;
  logic [ 4:0] bmask_a_id_imm;
  logic [ 4:0] bmask_b_id_imm;
  logic [ 4:0] bmask_a_id;
  logic [ 4:0] bmask_b_id;
  logic [ 1:0] imm_vec_ext_id;
  logic [ 4:0] mult_imm_id;
  logic        alu_vec;
  logic [ 1:0] alu_vec_mode;
  logic        scalar_replication;
  logic        scalar_replication_c;
  logic        reg_d_ex_is_reg_a_id;
  logic        reg_d_ex_is_reg_b_id;
  logic        reg_d_ex_is_reg_c_id;
  logic        reg_d_wb_is_reg_a_id;
  logic        reg_d_wb_is_reg_b_id;
  logic        reg_d_wb_is_reg_c_id;
  logic        reg_d_alu_is_reg_a_id;
  logic        reg_d_alu_is_reg_b_id;
  logic        reg_d_alu_is_reg_c_id;
  logic is_clpx, is_subrot;
  logic mret_dec;
  logic uret_dec;
  logic dret_dec;
  logic id_valid_q;
  logic minstret;
  logic perf_pipeline_stall;
  assign instr = instr_rdata_i;
  assign imm_i_type = {{20{instr[31]}}, instr[31:20]};
  assign imm_iz_type = {20'b0, instr[31:20]};
  assign imm_s_type = {{20{instr[31]}}, instr[31:25], instr[11:7]};
  assign imm_sb_type = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
  assign imm_u_type = {instr[31:12], 12'b0};
  assign imm_uj_type = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
  assign imm_z_type = {27'b0, instr[RegS1MSB:RegS1LSB]};
  assign imm_s2_type = {27'b0, instr[24:20]};
  assign imm_bi_type = {{27{instr[24]}}, instr[24:20]};
  assign imm_s3_type = {27'b0, instr[29:25]};
  assign imm_vs_type = {{26{instr[24]}}, instr[24:20], instr[25]};
  assign imm_vu_type = {26'b0, instr[24:20], instr[25]};
  assign imm_shuffleb_type = {
    6'b0, instr[28:27], 6'b0, instr[24:23], 6'b0, instr[22:21], 6'b0, instr[20], instr[25]
  };
  assign imm_shuffleh_type = {15'h0, instr[20], 15'h0, instr[25]};
  assign imm_clip_type = (32'h1 << instr[24:20]) - 1;
  assign regfile_addr_ra_id = {regfile_fp_a, instr[RegS1MSB:RegS1LSB]};
  assign regfile_addr_rb_id = {regfile_fp_b, instr[RegS2MSB:RegS2LSB]};
  always_comb begin
    unique case (regc_mux)
      REGC_ZERO: regfile_addr_rc_id = '0;
      REGC_RD:   regfile_addr_rc_id = {regfile_fp_c, instr[RegDMSB:RegDLSB]};
      REGC_S1:   regfile_addr_rc_id = {regfile_fp_c, instr[RegS1MSB:RegS1LSB]};
      REGC_S4:   regfile_addr_rc_id = {regfile_fp_c, instr[RegS4MSB:RegS4LSB]};
    endcase
  end
  assign regfile_waddr_id = {regfile_fp_d, instr[RegDMSB:RegDLSB]};
  assign regfile_alu_waddr_id = regfile_alu_waddr_mux_sel ? regfile_waddr_id : regfile_addr_ra_id;
  assign reg_d_ex_is_reg_a_id  = (regfile_waddr_ex_o     == regfile_addr_ra_id)
                                 && (rega_used_dec == 1'b1) && (regfile_addr_ra_id != '0);
  assign reg_d_ex_is_reg_b_id  = (regfile_waddr_ex_o     == regfile_addr_rb_id)
                                 && (regb_used_dec == 1'b1) && (regfile_addr_rb_id != '0);
  assign reg_d_ex_is_reg_c_id  = (regfile_waddr_ex_o     == regfile_addr_rc_id)
                                 && (regc_used_dec == 1'b1) && (regfile_addr_rc_id != '0);
  assign reg_d_wb_is_reg_a_id  = (regfile_waddr_wb_i     == regfile_addr_ra_id)
                                 && (rega_used_dec == 1'b1) && (regfile_addr_ra_id != '0);
  assign reg_d_wb_is_reg_b_id  = (regfile_waddr_wb_i     == regfile_addr_rb_id)
                                 && (regb_used_dec == 1'b1) && (regfile_addr_rb_id != '0);
  assign reg_d_wb_is_reg_c_id  = (regfile_waddr_wb_i     == regfile_addr_rc_id)
                                 && (regc_used_dec == 1'b1) && (regfile_addr_rc_id != '0);
  assign reg_d_alu_is_reg_a_id = (regfile_alu_waddr_fw_i == regfile_addr_ra_id)
                                 && (rega_used_dec == 1'b1) && (regfile_addr_ra_id != '0);
  assign reg_d_alu_is_reg_b_id = (regfile_alu_waddr_fw_i == regfile_addr_rb_id)
                                 && (regb_used_dec == 1'b1) && (regfile_addr_rb_id != '0);
  assign reg_d_alu_is_reg_c_id = (regfile_alu_waddr_fw_i == regfile_addr_rc_id)
                                 && (regc_used_dec == 1'b1) && (regfile_addr_rc_id != '0);
  assign clear_instr_valid_o = id_ready_o | halt_id | branch_taken_ex;
  assign branch_taken_ex = branch_in_ex_o && branch_decision_i;
  assign mult_en = mult_int_en | mult_dot_en;
  always_comb begin : jump_target_mux
    unique case (ctrl_transfer_target_mux_sel)
      JT_JAL:  jump_target = pc_id_i + imm_uj_type;
      JT_COND: jump_target = pc_id_i + imm_sb_type;
      JT_JALR: jump_target = regfile_data_ra_id + imm_i_type;
      default: jump_target = regfile_data_ra_id + imm_i_type;
    endcase
  end
  assign jump_target_o = jump_target;
  always_comb begin : alu_operand_a_mux
    case (alu_op_a_mux_sel)
      OP_A_REGA_OR_FWD: alu_operand_a = operand_a_fw_id;
      OP_A_REGB_OR_FWD: alu_operand_a = operand_b_fw_id;
      OP_A_REGC_OR_FWD: alu_operand_a = operand_c_fw_id;
      OP_A_CURRPC:      alu_operand_a = pc_id_i;
      OP_A_IMM:         alu_operand_a = imm_a;
      default:          alu_operand_a = operand_a_fw_id;
    endcase
    ;
  end
  always_comb begin : immediate_a_mux
    unique case (imm_a_mux_sel)
      IMMA_Z:    imm_a = imm_z_type;
      IMMA_ZERO: imm_a = '0;
    endcase
  end
  always_comb begin : operand_a_fw_mux
    case (operand_a_fw_mux_sel)
      SEL_FW_EX:   operand_a_fw_id = regfile_alu_wdata_fw_i;
      SEL_FW_WB:   operand_a_fw_id = regfile_wdata_wb_i;
      SEL_REGFILE: operand_a_fw_id = regfile_data_ra_id;
      default:     operand_a_fw_id = regfile_data_ra_id;
    endcase
    ;
  end
  always_comb begin : immediate_b_mux
    unique case (imm_b_mux_sel)
      IMMB_I:      imm_b = imm_i_type;
      IMMB_S:      imm_b = imm_s_type;
      IMMB_U:      imm_b = imm_u_type;
      IMMB_PCINCR: imm_b = is_compressed_i ? 32'h2 : 32'h4;
      IMMB_S2:     imm_b = imm_s2_type;
      IMMB_BI:     imm_b = imm_bi_type;
      IMMB_S3:     imm_b = imm_s3_type;
      IMMB_VS:     imm_b = imm_vs_type;
      IMMB_VU:     imm_b = imm_vu_type;
      IMMB_SHUF:   imm_b = imm_shuffle_type;
      IMMB_CLIP:   imm_b = {1'b0, imm_clip_type[31:1]};
      default:     imm_b = imm_i_type;
    endcase
  end
  always_comb begin : alu_operand_b_mux
    case (alu_op_b_mux_sel)
      OP_B_REGA_OR_FWD: operand_b = operand_a_fw_id;
      OP_B_REGB_OR_FWD: operand_b = operand_b_fw_id;
      OP_B_REGC_OR_FWD: operand_b = operand_c_fw_id;
      OP_B_IMM:         operand_b = imm_b;
      OP_B_BMASK:       operand_b = $unsigned(operand_b_fw_id[4:0]);
      default:          operand_b = operand_b_fw_id;
    endcase
  end
  always_comb begin
    if (alu_vec_mode == VEC_MODE8) begin
      operand_b_vec    = {4{operand_b[7:0]}};
      imm_shuffle_type = imm_shuffleb_type;
    end else begin
      operand_b_vec    = {2{operand_b[15:0]}};
      imm_shuffle_type = imm_shuffleh_type;
    end
  end
  assign alu_operand_b = (scalar_replication == 1'b1) ? operand_b_vec : operand_b;
  always_comb begin : operand_b_fw_mux
    case (operand_b_fw_mux_sel)
      SEL_FW_EX:   operand_b_fw_id = regfile_alu_wdata_fw_i;
      SEL_FW_WB:   operand_b_fw_id = regfile_wdata_wb_i;
      SEL_REGFILE: operand_b_fw_id = regfile_data_rb_id;
      default:     operand_b_fw_id = regfile_data_rb_id;
    endcase
    ;
  end
  always_comb begin : alu_operand_c_mux
    case (alu_op_c_mux_sel)
      OP_C_REGC_OR_FWD: operand_c = operand_c_fw_id;
      OP_C_REGB_OR_FWD: operand_c = operand_b_fw_id;
      OP_C_JT:          operand_c = jump_target;
      default:          operand_c = operand_c_fw_id;
    endcase
  end
  always_comb begin
    if (alu_vec_mode == VEC_MODE8) begin
      operand_c_vec = {4{operand_c[7:0]}};
    end else begin
      operand_c_vec = {2{operand_c[15:0]}};
    end
  end
  assign alu_operand_c = (scalar_replication_c == 1'b1) ? operand_c_vec : operand_c;
  always_comb begin : operand_c_fw_mux
    case (operand_c_fw_mux_sel)
      SEL_FW_EX:   operand_c_fw_id = regfile_alu_wdata_fw_i;
      SEL_FW_WB:   operand_c_fw_id = regfile_wdata_wb_i;
      SEL_REGFILE: operand_c_fw_id = regfile_data_rc_id;
      default:     operand_c_fw_id = regfile_data_rc_id;
    endcase
    ;
  end
  always_comb begin
    unique case (bmask_a_mux)
      BMASK_A_ZERO: bmask_a_id_imm = '0;
      BMASK_A_S3:   bmask_a_id_imm = imm_s3_type[4:0];
    endcase
  end
  always_comb begin
    unique case (bmask_b_mux)
      BMASK_B_ZERO: bmask_b_id_imm = '0;
      BMASK_B_ONE:  bmask_b_id_imm = 5'd1;
      BMASK_B_S2:   bmask_b_id_imm = imm_s2_type[4:0];
      BMASK_B_S3:   bmask_b_id_imm = imm_s3_type[4:0];
    endcase
  end
  always_comb begin
    unique case (alu_bmask_a_mux_sel)
      BMASK_A_IMM: bmask_a_id = bmask_a_id_imm;
      BMASK_A_REG: bmask_a_id = operand_b_fw_id[9:5];
    endcase
  end
  always_comb begin
    unique case (alu_bmask_b_mux_sel)
      BMASK_B_IMM: bmask_b_id = bmask_b_id_imm;
      BMASK_B_REG: bmask_b_id = operand_b_fw_id[4:0];
    endcase
  end
  assign imm_vec_ext_id = imm_vu_type[1:0];
  always_comb begin
    unique case (mult_imm_mux)
      MIMM_ZERO: mult_imm_id = '0;
      MIMM_S3:   mult_imm_id = imm_s3_type[4:0];
    endcase
  end
  assign apu_operands[0] = alu_operand_a;
  assign apu_operands[1] = alu_operand_b;
  assign apu_operands[2] = alu_operand_c;
  assign apu_waddr = regfile_alu_waddr_id;
  assign apu_flags = {fpu_int_fmt, fpu_src_fmt, fpu_dst_fmt, fp_rnd_mode};
  always_comb begin
    unique case (alu_op_a_mux_sel)
      OP_A_CURRPC: begin
        if (ctrl_transfer_target_mux_sel == JT_JALR) begin
          apu_read_regs[0]       = regfile_addr_ra_id;
          apu_read_regs_valid[0] = 1'b1;
        end else begin
          apu_read_regs[0]       = regfile_addr_ra_id;
          apu_read_regs_valid[0] = 1'b0;
        end
      end
      OP_A_REGA_OR_FWD: begin
        apu_read_regs[0]       = regfile_addr_ra_id;
        apu_read_regs_valid[0] = 1'b1;
      end
      OP_A_REGB_OR_FWD, OP_A_REGC_OR_FWD: begin
        apu_read_regs[0]       = regfile_addr_rb_id;
        apu_read_regs_valid[0] = 1'b1;
      end
      default: begin
        apu_read_regs[0]       = regfile_addr_ra_id;
        apu_read_regs_valid[0] = 1'b0;
      end
    endcase
  end
  always_comb begin
    unique case (alu_op_b_mux_sel)
      OP_B_REGA_OR_FWD: begin
        apu_read_regs[1]       = regfile_addr_ra_id;
        apu_read_regs_valid[1] = 1'b1;
      end
      OP_B_REGB_OR_FWD, OP_B_BMASK: begin
        apu_read_regs[1]       = regfile_addr_rb_id;
        apu_read_regs_valid[1] = 1'b1;
      end
      OP_B_REGC_OR_FWD: begin
        apu_read_regs[1]       = regfile_addr_rc_id;
        apu_read_regs_valid[1] = 1'b1;
      end
      OP_B_IMM: begin
        if (alu_bmask_b_mux_sel == BMASK_B_REG) begin
          apu_read_regs[1]       = regfile_addr_rb_id;
          apu_read_regs_valid[1] = 1'b1;
        end else begin
          apu_read_regs[1]       = regfile_addr_rb_id;
          apu_read_regs_valid[1] = 1'b0;
        end
      end
      default: begin
        apu_read_regs[1]       = regfile_addr_rb_id;
        apu_read_regs_valid[1] = 1'b0;
      end
    endcase
  end
  always_comb begin
    unique case (alu_op_c_mux_sel)
      OP_C_REGB_OR_FWD: begin
        apu_read_regs[2]       = regfile_addr_rb_id;
        apu_read_regs_valid[2] = 1'b1;
      end
      OP_C_REGC_OR_FWD: begin
        if ((alu_op_a_mux_sel != OP_A_REGC_OR_FWD) && (ctrl_transfer_target_mux_sel != JT_JALR) &&
                !((alu_op_b_mux_sel == OP_B_IMM) && (alu_bmask_b_mux_sel == BMASK_B_REG)) &&
                !(alu_op_b_mux_sel == OP_B_BMASK)) begin
          apu_read_regs[2]       = regfile_addr_rc_id;
          apu_read_regs_valid[2] = 1'b1;
        end else begin
          apu_read_regs[2]       = regfile_addr_rc_id;
          apu_read_regs_valid[2] = 1'b0;
        end
      end
      default: begin
        apu_read_regs[2]       = regfile_addr_rc_id;
        apu_read_regs_valid[2] = 1'b0;
      end
    endcase
  end
  assign apu_write_regs[0] = regfile_alu_waddr_id;
  assign apu_write_regs_valid[0] = regfile_alu_we_id;
  assign apu_write_regs[1] = regfile_waddr_id;
  assign apu_write_regs_valid[1] = regfile_we_id;
  assign apu_read_regs_o = apu_read_regs;
  assign apu_read_regs_valid_o = apu_read_regs_valid;
  assign apu_write_regs_o = apu_write_regs;
  assign apu_write_regs_valid_o = apu_write_regs_valid;
  assign apu_perf_dep_o = apu_stall;
  assign csr_apu_stall = (csr_access & (apu_en_ex_o & (apu_lat_ex_o[1] == 1'b1) | apu_busy_i));
  single_file_rv32imf_register_file #(
      .ADDR_WIDTH(6),
      .DATA_WIDTH(32)
  ) register_file_i (
      .clk  (clk),
      .rst_n(rst_n),
      .raddr_a_i(regfile_addr_ra_id),
      .rdata_a_o(regfile_data_ra_id),
      .raddr_b_i(regfile_addr_rb_id),
      .rdata_b_o(regfile_data_rb_id),
      .raddr_c_i(regfile_addr_rc_id),
      .rdata_c_o(regfile_data_rc_id),
      .waddr_a_i(regfile_waddr_wb_i),
      .wdata_a_i(regfile_wdata_wb_i),
      .we_a_i   (regfile_we_wb_power_i),
      .waddr_b_i(regfile_alu_waddr_fw_i),
      .wdata_b_i(regfile_alu_wdata_fw_i),
      .we_b_i   (regfile_alu_we_fw_power_i)
  );
  single_file_rv32imf_decoder #() decoder_i (
      .deassert_we_i(deassert_we),
      .illegal_insn_o(illegal_insn_dec),
      .ebrk_insn_o   (ebrk_insn_dec),
      .mret_insn_o(mret_insn_dec),
      .uret_insn_o(uret_insn_dec),
      .dret_insn_o(dret_insn_dec),
      .mret_dec_o(mret_dec),
      .uret_dec_o(uret_dec),
      .dret_dec_o(dret_dec),
      .ecall_insn_o(ecall_insn_dec),
      .wfi_o       (wfi_insn_dec),
      .fencei_insn_o(fencei_insn_dec),
      .rega_used_o(rega_used_dec),
      .regb_used_o(regb_used_dec),
      .regc_used_o(regc_used_dec),
      .reg_fp_a_o(regfile_fp_a),
      .reg_fp_b_o(regfile_fp_b),
      .reg_fp_c_o(regfile_fp_c),
      .reg_fp_d_o(regfile_fp_d),
      .bmask_a_mux_o        (bmask_a_mux),
      .bmask_b_mux_o        (bmask_b_mux),
      .alu_bmask_a_mux_sel_o(alu_bmask_a_mux_sel),
      .alu_bmask_b_mux_sel_o(alu_bmask_b_mux_sel),
      .instr_rdata_i   (instr),
      .illegal_c_insn_i(illegal_c_insn_i),
      .alu_en_o              (alu_en),
      .alu_operator_o        (alu_operator),
      .alu_op_a_mux_sel_o    (alu_op_a_mux_sel),
      .alu_op_b_mux_sel_o    (alu_op_b_mux_sel),
      .alu_op_c_mux_sel_o    (alu_op_c_mux_sel),
      .alu_vec_o             (alu_vec),
      .alu_vec_mode_o        (alu_vec_mode),
      .scalar_replication_o  (scalar_replication),
      .scalar_replication_c_o(scalar_replication_c),
      .imm_a_mux_sel_o       (imm_a_mux_sel),
      .imm_b_mux_sel_o       (imm_b_mux_sel),
      .regc_mux_o            (regc_mux),
      .is_clpx_o             (is_clpx),
      .is_subrot_o           (is_subrot),
      .mult_operator_o   (mult_operator),
      .mult_int_en_o     (mult_int_en),
      .mult_sel_subword_o(mult_sel_subword),
      .mult_signed_mode_o(mult_signed_mode),
      .mult_imm_mux_o    (mult_imm_mux),
      .mult_dot_en_o     (mult_dot_en),
      .mult_dot_signed_o (mult_dot_signed),
      .fs_off_i     (fs_off_i),
      .frm_i        (frm_i),
      .fpu_src_fmt_o(fpu_src_fmt),
      .fpu_dst_fmt_o(fpu_dst_fmt),
      .fpu_int_fmt_o(fpu_int_fmt),
      .apu_en_o     (apu_en),
      .apu_op_o     (apu_op),
      .apu_lat_o    (apu_lat),
      .fp_rnd_mode_o(fp_rnd_mode),
      .regfile_mem_we_o       (regfile_we_id),
      .regfile_alu_we_o       (regfile_alu_we_id),
      .regfile_alu_we_dec_o   (regfile_alu_we_dec_id),
      .regfile_alu_waddr_sel_o(regfile_alu_waddr_mux_sel),
      .csr_access_o      (csr_access),
      .csr_status_o      (csr_status),
      .csr_op_o          (csr_op),
      .current_priv_lvl_i(current_priv_lvl_i),
      .data_req_o           (data_req_id),
      .data_we_o            (data_we_id),
      .prepost_useincr_o    (prepost_useincr),
      .data_type_o          (data_type_id),
      .data_sign_extension_o(data_sign_ext_id),
      .data_reg_offset_o    (data_reg_offset_id),
      .data_load_event_o    (data_load_event_id),
      .atop_o(atop_id),
      .hwlp_we_o            (hwlp_we),
      .hwlp_target_mux_sel_o(hwlp_target_mux_sel),
      .hwlp_start_mux_sel_o (hwlp_start_mux_sel),
      .hwlp_cnt_mux_sel_o   (hwlp_cnt_mux_sel),
      .debug_mode_i        (debug_mode_o),
      .debug_wfi_no_sleep_i(debug_wfi_no_sleep),
      .ctrl_transfer_insn_in_dec_o   (ctrl_transfer_insn_in_dec_o),
      .ctrl_transfer_insn_in_id_o    (ctrl_transfer_insn_in_id),
      .ctrl_transfer_target_mux_sel_o(ctrl_transfer_target_mux_sel),
      .mcounteren_i(mcounteren_i)
  );
  single_file_rv32imf_controller #() controller_i (
      .clk          (clk),
      .clk_ungated_i(clk_ungated_i),
      .rst_n        (rst_n),
      .ctrl_busy_o      (ctrl_busy_o),
      .is_decoding_o    (is_decoding_o),
      .is_fetch_failed_i(is_fetch_failed_i),
      .deassert_we_o(deassert_we),
      .illegal_insn_i(illegal_insn_dec),
      .ecall_insn_i  (ecall_insn_dec),
      .mret_insn_i   (mret_insn_dec),
      .uret_insn_i   (uret_insn_dec),
      .dret_insn_i(dret_insn_dec),
      .mret_dec_i(mret_dec),
      .uret_dec_i(uret_dec),
      .dret_dec_i(dret_dec),
      .wfi_i        (wfi_insn_dec),
      .ebrk_insn_i  (ebrk_insn_dec),
      .fencei_insn_i(fencei_insn_dec),
      .csr_status_i (csr_status),
      .hwlp_mask_o(hwlp_mask),
      .instr_valid_i(instr_valid_i),
      .instr_req_o(instr_req_o),
      .pc_set_o       (pc_set_o),
      .pc_mux_o       (pc_mux_o),
      .exc_pc_mux_o   (exc_pc_mux_o),
      .exc_cause_o    (exc_cause_o),
      .trap_addr_mux_o(trap_addr_mux_o),
      .pc_id_i(pc_id_i),
      .hwlp_targ_addr_o(hwlp_target_o),
      .data_req_ex_i    (data_req_ex_o),
      .data_we_ex_i     (data_we_ex_o),
      .data_misaligned_i(data_misaligned_i),
      .data_load_event_i(data_load_event_id),
      .data_err_i       (data_err_i),
      .data_err_ack_o   (data_err_ack_o),
      .mult_multicycle_i(mult_multicycle_i),
      .apu_en_i               (apu_en),
      .apu_read_dep_i         (apu_read_dep_i),
      .apu_read_dep_for_jalr_i(apu_read_dep_for_jalr_i),
      .apu_write_dep_i        (apu_write_dep_i),
      .apu_stall_o(apu_stall),
      .branch_taken_ex_i          (branch_taken_ex),
      .ctrl_transfer_insn_in_id_i (ctrl_transfer_insn_in_id),
      .ctrl_transfer_insn_in_dec_i(ctrl_transfer_insn_in_dec_o),
      .irq_wu_ctrl_i     (irq_wu_ctrl),
      .irq_req_ctrl_i    (irq_req_ctrl),
      .irq_sec_ctrl_i    (irq_sec_ctrl),
      .irq_id_ctrl_i     (irq_id_ctrl),
      .current_priv_lvl_i(current_priv_lvl_i),
      .irq_ack_o         (irq_ack_o),
      .irq_id_o          (irq_id_o),
      .debug_mode_o          (debug_mode_o),
      .debug_cause_o         (debug_cause_o),
      .debug_csr_save_o      (debug_csr_save_o),
      .debug_single_step_i   (debug_single_step_i),
      .debug_ebreakm_i       (debug_ebreakm_i),
      .debug_ebreaku_i       (debug_ebreaku_i),
      .trigger_match_i       (trigger_match_i),
      .debug_p_elw_no_sleep_o(debug_p_elw_no_sleep_o),
      .debug_wfi_no_sleep_o  (debug_wfi_no_sleep),
      .wake_from_sleep_o(wake_from_sleep_o),
      .csr_save_cause_o     (csr_save_cause_o),
      .csr_cause_o          (csr_cause_o),
      .csr_save_if_o        (csr_save_if_o),
      .csr_save_id_o        (csr_save_id_o),
      .csr_save_ex_o        (csr_save_ex_o),
      .csr_restore_mret_id_o(csr_restore_mret_id_o),
      .csr_restore_uret_id_o(csr_restore_uret_id_o),
      .csr_restore_dret_id_o(csr_restore_dret_id_o),
      .csr_irq_sec_o(csr_irq_sec_o),
      .regfile_we_id_i       (regfile_alu_we_dec_id),
      .regfile_alu_waddr_id_i(regfile_alu_waddr_id),
      .regfile_we_ex_i   (regfile_we_ex_o),
      .regfile_waddr_ex_i(regfile_waddr_ex_o),
      .regfile_we_wb_i   (regfile_we_wb_i),
      .regfile_alu_we_fw_i(regfile_alu_we_fw_i),
      .reg_d_ex_is_reg_a_i (reg_d_ex_is_reg_a_id),
      .reg_d_ex_is_reg_b_i (reg_d_ex_is_reg_b_id),
      .reg_d_ex_is_reg_c_i (reg_d_ex_is_reg_c_id),
      .reg_d_wb_is_reg_a_i (reg_d_wb_is_reg_a_id),
      .reg_d_wb_is_reg_b_i (reg_d_wb_is_reg_b_id),
      .reg_d_wb_is_reg_c_i (reg_d_wb_is_reg_c_id),
      .reg_d_alu_is_reg_a_i(reg_d_alu_is_reg_a_id),
      .reg_d_alu_is_reg_b_i(reg_d_alu_is_reg_b_id),
      .reg_d_alu_is_reg_c_i(reg_d_alu_is_reg_c_id),
      .operand_a_fw_mux_sel_o(operand_a_fw_mux_sel),
      .operand_b_fw_mux_sel_o(operand_b_fw_mux_sel),
      .operand_c_fw_mux_sel_o(operand_c_fw_mux_sel),
      .halt_if_o(halt_if),
      .halt_id_o(halt_id),
      .misaligned_stall_o(misaligned_stall),
      .jr_stall_o        (jr_stall),
      .load_stall_o      (load_stall),
      .id_ready_i(id_ready_o),
      .id_valid_i(id_valid_o),
      .ex_valid_i(ex_valid_i),
      .wb_ready_i(wb_ready_i),
      .perf_pipeline_stall_o(perf_pipeline_stall)
  );
  single_file_rv32imf_int_controller #() int_controller_i (
      .clk  (clk),
      .rst_n(rst_n),
      .irq_i    (irq_i),
      .irq_sec_i(irq_sec_i),
      .irq_req_ctrl_o(irq_req_ctrl),
      .irq_sec_ctrl_o(irq_sec_ctrl),
      .irq_id_ctrl_o (irq_id_ctrl),
      .irq_wu_ctrl_o (irq_wu_ctrl),
      .mie_bypass_i      (mie_bypass_i),
      .mip_o             (mip_o),
      .m_ie_i            (m_irq_enable_i),
      .u_ie_i            (u_irq_enable_i),
      .current_priv_lvl_i(current_priv_lvl_i)
  );
  always_ff @(posedge clk, negedge rst_n) begin : ID_EX_PIPE_REGISTERS
    if (rst_n == 1'b0) begin
      alu_en_ex_o            <= '0;
      alu_operator_ex_o      <= ALU_SLTU;
      alu_operand_a_ex_o     <= '0;
      alu_operand_b_ex_o     <= '0;
      alu_operand_c_ex_o     <= '0;
      bmask_a_ex_o           <= '0;
      bmask_b_ex_o           <= '0;
      imm_vec_ext_ex_o       <= '0;
      alu_vec_mode_ex_o      <= '0;
      alu_clpx_shift_ex_o    <= 2'b0;
      alu_is_clpx_ex_o       <= 1'b0;
      alu_is_subrot_ex_o     <= 1'b0;
      mult_operator_ex_o     <= MUL_MAC32;
      mult_operand_a_ex_o    <= '0;
      mult_operand_b_ex_o    <= '0;
      mult_operand_c_ex_o    <= '0;
      mult_en_ex_o           <= 1'b0;
      mult_sel_subword_ex_o  <= 1'b0;
      mult_signed_mode_ex_o  <= 2'b00;
      mult_imm_ex_o          <= '0;
      mult_dot_op_a_ex_o     <= '0;
      mult_dot_op_b_ex_o     <= '0;
      mult_dot_op_c_ex_o     <= '0;
      mult_dot_signed_ex_o   <= '0;
      mult_is_clpx_ex_o      <= 1'b0;
      mult_clpx_shift_ex_o   <= 2'b0;
      mult_clpx_img_ex_o     <= 1'b0;
      apu_en_ex_o            <= '0;
      apu_op_ex_o            <= '0;
      apu_lat_ex_o           <= '0;
      apu_operands_ex_o[0]   <= '0;
      apu_operands_ex_o[1]   <= '0;
      apu_operands_ex_o[2]   <= '0;
      apu_flags_ex_o         <= '0;
      apu_waddr_ex_o         <= '0;
      regfile_waddr_ex_o     <= 6'b0;
      regfile_we_ex_o        <= 1'b0;
      regfile_alu_waddr_ex_o <= 6'b0;
      regfile_alu_we_ex_o    <= 1'b0;
      prepost_useincr_ex_o   <= 1'b0;
      csr_access_ex_o        <= 1'b0;
      csr_op_ex_o            <= CSR_OP_READ;
      data_we_ex_o           <= 1'b0;
      data_type_ex_o         <= 2'b0;
      data_sign_ext_ex_o     <= 2'b0;
      data_reg_offset_ex_o   <= 2'b0;
      data_req_ex_o          <= 1'b0;
      atop_ex_o              <= 5'b0;
      data_misaligned_ex_o   <= 1'b0;
      pc_ex_o                <= '0;
      branch_in_ex_o         <= 1'b0;
    end else if (data_misaligned_i) begin
      if (ex_ready_i) begin
        if (prepost_useincr_ex_o == 1'b1) begin
          alu_operand_a_ex_o <= operand_a_fw_id;
        end
        alu_operand_b_ex_o   <= 32'h4;
        regfile_alu_we_ex_o  <= 1'b0;
        prepost_useincr_ex_o <= 1'b1;
        data_misaligned_ex_o <= 1'b1;
      end
    end else if (mult_multicycle_i) begin
      mult_operand_c_ex_o <= operand_c_fw_id;
    end else begin
      if (id_valid_o) begin
        alu_en_ex_o <= alu_en;
        if (alu_en) begin
          alu_operator_ex_o  <= alu_operator;
          alu_operand_a_ex_o <= alu_operand_a;
          if (alu_op_b_mux_sel == OP_B_REGB_OR_FWD
            && (alu_operator == ALU_CLIP || alu_operator == ALU_CLIPU)) begin
            alu_operand_b_ex_o <= {1'b0, alu_operand_b[30:0]};
          end else begin
            alu_operand_b_ex_o <= alu_operand_b;
          end
          alu_operand_c_ex_o  <= alu_operand_c;
          bmask_a_ex_o        <= bmask_a_id;
          bmask_b_ex_o        <= bmask_b_id;
          imm_vec_ext_ex_o    <= imm_vec_ext_id;
          alu_vec_mode_ex_o   <= alu_vec_mode;
          alu_is_clpx_ex_o    <= is_clpx;
          alu_clpx_shift_ex_o <= instr[14:13];
          alu_is_subrot_ex_o  <= is_subrot;
        end
        mult_en_ex_o <= mult_en;
        if (mult_int_en) begin
          mult_operator_ex_o    <= mult_operator;
          mult_sel_subword_ex_o <= mult_sel_subword;
          mult_signed_mode_ex_o <= mult_signed_mode;
          mult_operand_a_ex_o   <= alu_operand_a;
          mult_operand_b_ex_o   <= alu_operand_b;
          mult_operand_c_ex_o   <= alu_operand_c;
          mult_imm_ex_o         <= mult_imm_id;
        end
        if (mult_dot_en) begin
          mult_operator_ex_o   <= mult_operator;
          mult_dot_signed_ex_o <= mult_dot_signed;
          mult_dot_op_a_ex_o   <= alu_operand_a;
          mult_dot_op_b_ex_o   <= alu_operand_b;
          mult_dot_op_c_ex_o   <= alu_operand_c;
          mult_is_clpx_ex_o    <= is_clpx;
          mult_clpx_shift_ex_o <= instr[14:13];
          mult_clpx_img_ex_o   <= instr[25];
        end
        apu_en_ex_o <= apu_en;
        if (apu_en) begin
          apu_op_ex_o       <= apu_op;
          apu_lat_ex_o      <= apu_lat;
          apu_operands_ex_o <= apu_operands;
          apu_flags_ex_o    <= apu_flags;
          apu_waddr_ex_o    <= apu_waddr;
        end
        regfile_we_ex_o <= regfile_we_id;
        if (regfile_we_id) begin
          regfile_waddr_ex_o <= regfile_waddr_id;
        end
        regfile_alu_we_ex_o <= regfile_alu_we_id;
        if (regfile_alu_we_id) begin
          regfile_alu_waddr_ex_o <= regfile_alu_waddr_id;
        end
        prepost_useincr_ex_o <= prepost_useincr;
        csr_access_ex_o      <= csr_access;
        csr_op_ex_o          <= csr_op;
        data_req_ex_o        <= data_req_id;
        if (data_req_id) begin
          data_we_ex_o         <= data_we_id;
          data_type_ex_o       <= data_type_id;
          data_sign_ext_ex_o   <= data_sign_ext_id;
          data_reg_offset_ex_o <= data_reg_offset_id;
          atop_ex_o            <= atop_id;
        end else begin
        end
        data_misaligned_ex_o <= 1'b0;
        if ((ctrl_transfer_insn_in_id == BRANCH_COND) || data_req_id) begin
          pc_ex_o <= pc_id_i;
        end
        branch_in_ex_o <= ctrl_transfer_insn_in_id == BRANCH_COND;
      end else if (ex_ready_i) begin
        regfile_we_ex_o      <= 1'b0;
        regfile_alu_we_ex_o  <= 1'b0;
        csr_op_ex_o          <= CSR_OP_READ;
        data_req_ex_o        <= 1'b0;
        data_misaligned_ex_o <= 1'b0;
        branch_in_ex_o       <= 1'b0;
        apu_en_ex_o          <= 1'b0;
        alu_operator_ex_o    <= ALU_SLTU;
        mult_en_ex_o         <= 1'b0;
        alu_en_ex_o          <= 1'b1;
      end else if (csr_access_ex_o) begin
        regfile_alu_we_ex_o <= 1'b0;
      end
    end
  end
  assign minstret = id_valid_o && is_decoding_o &&
                  !(illegal_insn_dec || ebrk_insn_dec || ecall_insn_dec);
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      id_valid_q               <= 1'b0;
      mhpmevent_minstret_o     <= 1'b0;
      mhpmevent_load_o         <= 1'b0;
      mhpmevent_store_o        <= 1'b0;
      mhpmevent_jump_o         <= 1'b0;
      mhpmevent_branch_o       <= 1'b0;
      mhpmevent_compressed_o   <= 1'b0;
      mhpmevent_branch_taken_o <= 1'b0;
      mhpmevent_jr_stall_o     <= 1'b0;
      mhpmevent_imiss_o        <= 1'b0;
      mhpmevent_ld_stall_o     <= 1'b0;
      mhpmevent_pipe_stall_o   <= 1'b0;
    end else begin
      id_valid_q <= id_valid_o;
      mhpmevent_minstret_o <= minstret;
      mhpmevent_load_o <= minstret && data_req_id && !data_we_id;
      mhpmevent_store_o <= minstret && data_req_id && data_we_id;
      mhpmevent_jump_o <= minstret && ((ctrl_transfer_insn_in_id == BRANCH_JAL)
                      || (ctrl_transfer_insn_in_id == BRANCH_JALR));
      mhpmevent_branch_o <= minstret && (ctrl_transfer_insn_in_id == BRANCH_COND);
      mhpmevent_compressed_o <= minstret && is_compressed_i;
      mhpmevent_branch_taken_o <= mhpmevent_branch_o && branch_decision_i;
      mhpmevent_imiss_o <= perf_imiss_i;
      mhpmevent_jr_stall_o <= jr_stall && !halt_id && id_valid_q;
      mhpmevent_ld_stall_o <= load_stall && !halt_id && id_valid_q;
      mhpmevent_pipe_stall_o <= perf_pipeline_stall;
    end
  end
  assign id_ready_o = ((~misaligned_stall) & (~jr_stall) & (~load_stall) & (~apu_stall)
                     & (~csr_apu_stall) & ex_ready_i);
  assign id_valid_o = (~halt_id) & id_ready_o;
  assign halt_if_o = halt_if;
endmodule


module single_file_rv32imf_popcnt (
    input logic [31:0] in_i,
    output logic [5:0] result_o
);
  logic [15:0][1:0] cnt_l1;
  logic [ 7:0][2:0] cnt_l2;
  logic [ 3:0][3:0] cnt_l3;
  logic [ 1:0][4:0] cnt_l4;
  genvar l, m, n, p;
  generate
    for (l = 0; l < 16; l++) begin : gen_cnt_l1
      assign cnt_l1[l] = {1'b0, in_i[2*l]} + {1'b0, in_i[2*l+1]};
    end
  endgenerate
  generate
    for (m = 0; m < 8; m++) begin : gen_cnt_l2
      assign cnt_l2[m] = {1'b0, cnt_l1[2*m]} + {1'b0, cnt_l1[2*m+1]};
    end
  endgenerate
  generate
    for (n = 0; n < 4; n++) begin : gen_cnt_l3
      assign cnt_l3[n] = {1'b0, cnt_l2[2*n]} + {1'b0, cnt_l2[2*n+1]};
    end
  endgenerate
  generate
    for (p = 0; p < 2; p++) begin : gen_cnt_l4
      assign cnt_l4[p] = {1'b0, cnt_l3[2*p]} + {1'b0, cnt_l3[2*p+1]};
    end
  endgenerate
  assign result_o = {1'b0, cnt_l4[0]} + {1'b0, cnt_l4[1]};
endmodule


module single_file_rv32imf_ff_one #(
    parameter int LEN = 32
) (
    input logic [LEN-1:0] in_i,
    output logic [$clog2(LEN)-1:0] first_one_o,
    output logic                   no_ones_o
);
  localparam int NumLevels = $clog2(LEN);
  logic [         LEN-1:0][NumLevels-1:0] index_lut;
  logic [2**NumLevels-1:0]                sel_nodes;
  logic [2**NumLevels-1:0][NumLevels-1:0] index_nodes;
  generate
    genvar j;
    for (j = 0; j < LEN; j++) begin : gen_index_lut
      assign index_lut[j] = $unsigned(j);
    end
  endgenerate
  generate
    genvar k;
    genvar l;
    genvar level;
    assign sel_nodes[2**NumLevels-1] = 1'b0;
    for (level = 0; level < NumLevels; level++) begin : gen_tree
      if (level < NumLevels - 1) begin : gen_non_root_level
        for (l = 0; l < 2 ** level; l++) begin : gen_node
          assign sel_nodes[2**level-1+l]   = sel_nodes[2**(level+1)-1+l*2]
                                           | sel_nodes[2**(level+1)-1+l*2+1];
          assign index_nodes[2**level-1+l] = (sel_nodes[2**(level+1)-1+l*2] == 1'b1) ?
                                             index_nodes[2**(level+1)-1+l*2] :
                                             index_nodes[2**(level+1)-1+l*2+1];
        end
      end
      if (level == NumLevels - 1) begin : gen_root_level
        for (k = 0; k < 2 ** level; k++) begin : gen_node
          if (k * 2 < LEN - 1) begin : gen_two
            assign sel_nodes[2**level-1+k] = in_i[k*2] | in_i[k*2+1];
            assign index_nodes[2**level-1+k] = (in_i[k*2] == 1'b1) ? index_lut[k*2]
                                                                   : index_lut[k*2+1];
          end
          if (k * 2 == LEN - 1) begin : gen_one
            assign sel_nodes[2**level-1+k]   = in_i[k*2];
            assign index_nodes[2**level-1+k] = index_lut[k*2];
          end
          if (k * 2 > LEN - 1) begin : gen_out_of_range
            assign sel_nodes[2**level-1+k]   = 1'b0;
            assign index_nodes[2**level-1+k] = '0;
          end
        end
      end
    end
  endgenerate
  assign first_one_o = index_nodes[0];
  assign no_ones_o   = ~sel_nodes[0];
endmodule


module single_file_rv32imf_alu_div #(
    parameter int C_WIDTH = 32,
    parameter int C_LOG_WIDTH = 6
) (
    input logic Clk_CI,
    input logic Rst_RBI,
    input logic [    C_WIDTH-1:0] OpA_DI,
    input logic [    C_WIDTH-1:0] OpB_DI,
    input logic [C_LOG_WIDTH-1:0] OpBShift_DI,
    input logic                   OpBIsZero_SI,
    input logic       OpBSign_SI,
    input logic [1:0] OpCode_SI,
    input logic InVld_SI,
    input  logic               OutRdy_SI,
    output logic               OutVld_SO,
    output logic [C_WIDTH-1:0] Res_DO
);
  logic [C_WIDTH-1:0] ResReg_DP, ResReg_DN;
  logic [C_WIDTH-1:0] ResReg_DP_rev;
  logic [C_WIDTH-1:0] AReg_DP, AReg_DN;
  logic [C_WIDTH-1:0] BReg_DP, BReg_DN;
  logic RemSel_SN, RemSel_SP;
  logic CompInv_SN, CompInv_SP;
  logic ResInv_SN, ResInv_SP;
  logic [C_WIDTH-1:0] AddMux_D;
  logic [C_WIDTH-1:0] AddOut_D;
  logic [C_WIDTH-1:0] AddTmp_D;
  logic [C_WIDTH-1:0] BMux_D;
  logic [C_WIDTH-1:0] OutMux_D;
  logic [C_LOG_WIDTH-1:0] Cnt_DP, Cnt_DN;
  logic CntZero_S;
  logic ARegEn_S, BRegEn_S, ResRegEn_S, ABComp_S, PmSel_S, LoadEn_S;
  typedef enum logic [1:0] {
    IDLE,
    DIVIDE,
    FINISH
  } state_t;
  state_t State_SN, State_SP;
  assign PmSel_S  = LoadEn_S & ~(OpCode_SI[0] & (OpA_DI[$high(OpA_DI)] ^ OpBSign_SI));
  assign AddMux_D = (LoadEn_S) ? OpA_DI : BReg_DP;
  assign BMux_D   = (LoadEn_S) ? OpB_DI : {CompInv_SP, (BReg_DP[$high(BReg_DP):1])};
  genvar index;
  generate
    for (index = 0; index < C_WIDTH; index++) begin : gen_bit_swapping
      assign ResReg_DP_rev[index] = ResReg_DP[C_WIDTH-1-index];
    end
  endgenerate
  assign OutMux_D = (RemSel_SP) ? AReg_DP : ResReg_DP_rev;
  assign Res_DO = (ResInv_SP) ? -$signed(OutMux_D) : OutMux_D;
  assign ABComp_S   = ((AReg_DP == BReg_DP) | ((AReg_DP > BReg_DP) ^ CompInv_SP))
              & ((|AReg_DP) | OpBIsZero_SI);
  assign AddTmp_D = (LoadEn_S) ? 0 : AReg_DP;
  assign AddOut_D = (PmSel_S) ? AddTmp_D + AddMux_D : AddTmp_D - $signed(AddMux_D);
  assign Cnt_DN = (LoadEn_S) ? OpBShift_DI : (~CntZero_S) ? Cnt_DP - 1 : Cnt_DP;
  assign CntZero_S = ~(|Cnt_DP);
  always_comb begin : p_fsm
    State_SN   = State_SP;
    OutVld_SO  = 1'b0;
    LoadEn_S   = 1'b0;
    ARegEn_S   = 1'b0;
    BRegEn_S   = 1'b0;
    ResRegEn_S = 1'b0;
    case (State_SP)
      IDLE: begin
        OutVld_SO = 1'b1;
        if (InVld_SI) begin
          OutVld_SO = 1'b0;
          ARegEn_S  = 1'b1;
          BRegEn_S  = 1'b1;
          LoadEn_S  = 1'b1;
          State_SN  = DIVIDE;
        end
      end
      DIVIDE: begin
        ARegEn_S   = ABComp_S;
        BRegEn_S   = 1'b1;
        ResRegEn_S = 1'b1;
        if (CntZero_S) begin
          State_SN = FINISH;
        end
      end
      FINISH: begin
        OutVld_SO = 1'b1;
        if (OutRdy_SI) begin
          State_SN = IDLE;
        end
      end
      default: begin
      end
    endcase
  end
  assign RemSel_SN = (LoadEn_S) ? OpCode_SI[1] : RemSel_SP;
  assign CompInv_SN = (LoadEn_S) ? OpBSign_SI : CompInv_SP;
  assign ResInv_SN = (LoadEn_S) ? (~OpBIsZero_SI | OpCode_SI[1]) & OpCode_SI[0] & (OpA_DI[$high(
      OpA_DI
  )] ^ OpBSign_SI) : ResInv_SP;
  assign AReg_DN = (ARegEn_S) ? AddOut_D : AReg_DP;
  assign BReg_DN = (BRegEn_S) ? BMux_D : BReg_DP;
  assign ResReg_DN = (LoadEn_S) ? '0 : (ResRegEn_S) ? {ABComp_S, ResReg_DP[$high(
      ResReg_DP
  ):1]} : ResReg_DP;
  always_ff @(posedge Clk_CI or negedge Rst_RBI) begin : p_regs
    if (~Rst_RBI) begin
      State_SP   <= IDLE;
      AReg_DP    <= '0;
      BReg_DP    <= '0;
      ResReg_DP  <= '0;
      Cnt_DP     <= '0;
      RemSel_SP  <= 1'b0;
      CompInv_SP <= 1'b0;
      ResInv_SP  <= 1'b0;
    end else begin
      State_SP   <= State_SN;
      AReg_DP    <= AReg_DN;
      BReg_DP    <= BReg_DN;
      ResReg_DP  <= ResReg_DN;
      Cnt_DP     <= Cnt_DN;
      RemSel_SP  <= RemSel_SN;
      CompInv_SP <= CompInv_SN;
      ResInv_SP  <= ResInv_SN;
    end
  end
endmodule


module single_file_rv32imf_alu
  import single_file_rv32imf_pkg::*;
(
    input logic               clk,
    input logic               rst_n,
    input logic               enable_i,
    input alu_opcode_e        operator_i,
    input logic        [31:0] operand_a_i,
    input logic        [31:0] operand_b_i,
    input logic        [31:0] operand_c_i,
    input logic [1:0] vector_mode_i,
    input logic [4:0] bmask_a_i,
    input logic [4:0] bmask_b_i,
    input logic [1:0] imm_vec_ext_i,
    input logic       is_clpx_i,
    input logic       is_subrot_i,
    input logic [1:0] clpx_shift_i,
    output logic [31:0] result_o,
    output logic        comparison_result_o,
    output logic ready_o,
    input  logic ex_ready_i
);
  logic [31:0] operand_a_rev;
  logic [31:0] operand_a_neg;
  logic [31:0] operand_a_neg_rev;
  assign operand_a_neg = ~operand_a_i;
  generate
    genvar k;
    for (k = 0; k < 32; k++) begin : gen_operand_a_rev
      assign operand_a_rev[k] = operand_a_i[31-k];
    end
  endgenerate
  generate
    genvar m;
    for (m = 0; m < 32; m++) begin : gen_operand_a_neg_rev
      assign operand_a_neg_rev[m] = operand_a_neg[31-m];
    end
  endgenerate
  logic [31:0] operand_b_neg;
  assign operand_b_neg = ~operand_b_i;
  logic [ 5:0] div_shift;
  logic        div_valid;
  logic [31:0] bmask;
  logic        adder_op_b_negate;
  logic [31:0] adder_op_a, adder_op_b;
  logic [35:0] adder_in_a, adder_in_b;
  logic [31:0] adder_result;
  logic [36:0] adder_result_expanded;
  assign adder_op_b_negate = (operator_i == ALU_SUB) || (operator_i == ALU_SUBR) ||
                              (operator_i == ALU_SUBU) || (operator_i == ALU_SUBUR) || is_subrot_i;
  assign adder_op_a = (operator_i == ALU_ABS) ? operand_a_neg : (is_subrot_i ? {
    operand_b_i[15:0], operand_a_i[31:16]
  } : operand_a_i);
  assign adder_op_b = adder_op_b_negate ? (is_subrot_i ? ~{
    operand_a_i[15:0], operand_b_i[31:16]
  } : operand_b_neg) : operand_b_i;
  always_comb begin
    adder_in_a[0]     = 1'b1;
    adder_in_a[8:1]   = adder_op_a[7:0];
    adder_in_a[9]     = 1'b1;
    adder_in_a[17:10] = adder_op_a[15:8];
    adder_in_a[18]    = 1'b1;
    adder_in_a[26:19] = adder_op_a[23:16];
    adder_in_a[27]    = 1'b1;
    adder_in_a[35:28] = adder_op_a[31:24];
    adder_in_b[0]     = 1'b0;
    adder_in_b[8:1]   = adder_op_b[7:0];
    adder_in_b[9]     = 1'b0;
    adder_in_b[17:10] = adder_op_b[15:8];
    adder_in_b[18]    = 1'b0;
    adder_in_b[26:19] = adder_op_b[23:16];
    adder_in_b[27]    = 1'b0;
    adder_in_b[35:28] = adder_op_b[31:24];
    if (adder_op_b_negate || (operator_i == ALU_ABS || operator_i == ALU_CLIP)) begin
      adder_in_b[0] = 1'b1;
      case (vector_mode_i)
        VEC_MODE16: begin
          adder_in_b[18] = 1'b1;
        end
        VEC_MODE8: begin
          adder_in_b[9]  = 1'b1;
          adder_in_b[18] = 1'b1;
          adder_in_b[27] = 1'b1;
        end
        default: ;
      endcase
    end else begin
      case (vector_mode_i)
        VEC_MODE16: begin
          adder_in_a[18] = 1'b0;
        end
        VEC_MODE8: begin
          adder_in_a[9]  = 1'b0;
          adder_in_a[18] = 1'b0;
          adder_in_a[27] = 1'b0;
        end
        default: ;
      endcase
    end
  end
  assign adder_result_expanded = $signed(adder_in_a) + $signed(adder_in_b);
  assign adder_result = {
    adder_result_expanded[35:28],
    adder_result_expanded[26:19],
    adder_result_expanded[17:10],
    adder_result_expanded[8:1]
  };
  logic [31:0] adder_round_value;
  logic [31:0] adder_round_result;
  assign adder_round_value   = ((operator_i == ALU_ADDR) || (operator_i == ALU_SUBR) ||
                                (operator_i == ALU_ADDUR) || (operator_i == ALU_SUBUR)) ? {
    1'b0, bmask[31:1]
  } : '0;
  assign adder_round_result = adder_result + adder_round_value;
  logic        shift_left;
  logic        shift_use_round;
  logic        shift_arithmetic;
  logic [31:0] shift_amt_left;
  logic [31:0] shift_amt;
  logic [31:0] shift_amt_int;
  logic [31:0] shift_amt_norm;
  logic [31:0] shift_op_a;
  logic [31:0] shift_result;
  logic [31:0] shift_right_result;
  logic [31:0] shift_left_result;
  logic [15:0] clpx_shift_ex;
  assign shift_amt = div_valid ? div_shift : operand_b_i;
  always_comb begin
    case (vector_mode_i)
      VEC_MODE16: begin
        shift_amt_left[15:0]  = shift_amt[31:16];
        shift_amt_left[31:16] = shift_amt[15:0];
      end
      VEC_MODE8: begin
        shift_amt_left[7:0]   = shift_amt[31:24];
        shift_amt_left[15:8]  = shift_amt[23:16];
        shift_amt_left[23:16] = shift_amt[15:8];
        shift_amt_left[31:24] = shift_amt[7:0];
      end
      default: begin
        shift_amt_left[31:0] = shift_amt[31:0];
      end
    endcase
  end
  assign shift_left = (operator_i == ALU_SLL) || (operator_i == ALU_BINS) ||
                      (operator_i == ALU_FL1) || (operator_i == ALU_CLB)   ||
                      (operator_i == ALU_DIV) || (operator_i == ALU_DIVU) ||
                      (operator_i == ALU_REM) || (operator_i == ALU_REMU) ||
                      (operator_i == ALU_BREV);
  assign shift_use_round = (operator_i == ALU_ADD)   || (operator_i == ALU_SUB)   ||
                           (operator_i == ALU_ADDR)  || (operator_i == ALU_SUBR)  ||
                           (operator_i == ALU_ADDU)  || (operator_i == ALU_SUBU)  ||
                           (operator_i == ALU_ADDUR) || (operator_i == ALU_SUBUR);
  assign shift_arithmetic = (operator_i == ALU_SRA)   || (operator_i == ALU_BEXT) ||
                            (operator_i == ALU_ADD)   || (operator_i == ALU_SUB)   ||
                            (operator_i == ALU_ADDR)  || (operator_i == ALU_SUBR);
  assign shift_op_a     = shift_left ? operand_a_rev :
                           (shift_use_round ? adder_round_result : operand_a_i);
  assign shift_amt_int = shift_use_round ? shift_amt_norm :
                           (shift_left ? shift_amt_left : shift_amt);
  assign shift_amt_norm = is_clpx_i ? {clpx_shift_ex, clpx_shift_ex} : {4{3'b000, bmask_b_i}};
  assign clpx_shift_ex = $unsigned(clpx_shift_i);
  logic [63:0] shift_op_a_32;
  assign shift_op_a_32 = (operator_i == ALU_ROR) ? {shift_op_a, shift_op_a} : $signed(
      {{32{shift_arithmetic & shift_op_a[31]}}, shift_op_a}
  );
  always_comb begin
    case (vector_mode_i)
      VEC_MODE16: begin
        shift_right_result[31:16] = $signed({shift_arithmetic & shift_op_a[31],
                                             shift_op_a[31:16]}) >>> shift_amt_int[19:16];
        shift_right_result[15:0] =
            $signed({shift_arithmetic & shift_op_a[15], shift_op_a[15:0]}) >>> shift_amt_int[3:0];
      end
      VEC_MODE8: begin
        shift_right_result[31:24] = $signed({shift_arithmetic & shift_op_a[31],
                                             shift_op_a[31:24]}) >>> shift_amt_int[26:24];
        shift_right_result[23:16] = $signed({shift_arithmetic & shift_op_a[23],
                                             shift_op_a[23:16]}) >>> shift_amt_int[18:16];
        shift_right_result[15:8] =
            $signed({shift_arithmetic & shift_op_a[15], shift_op_a[15:8]}) >>> shift_amt_int[10:8];
        shift_right_result[7:0] = $signed({shift_arithmetic & shift_op_a[7], shift_op_a[7:0]}) >>>
            shift_amt_int[2:0];
      end
      default: begin
        shift_right_result = shift_op_a_32 >> shift_amt_int[4:0];
      end
    endcase
    ;
  end
  genvar j;
  generate
    for (j = 0; j < 32; j++) begin : gen_shift_left_result
      assign shift_left_result[j] = shift_right_result[31-j];
    end
  endgenerate
  assign shift_result = shift_left ? shift_left_result : shift_right_result;
  logic [ 3:0] is_equal;
  logic [ 3:0] is_greater;
  logic [ 3:0] cmp_signed;
  logic [ 3:0] is_equal_vec;
  logic [ 3:0] is_greater_vec;
  logic [31:0] operand_b_eq;
  logic        is_equal_clip;
  always_comb begin
    operand_b_eq = operand_b_neg;
    if (operator_i == ALU_CLIPU) operand_b_eq = '0;
    else operand_b_eq = operand_b_neg;
  end
  assign is_equal_clip = operand_a_i == operand_b_eq;
  always_comb begin
    cmp_signed = 4'b0;
    unique case (operator_i)
      ALU_GTS,
      ALU_GES,
      ALU_LTS,
      ALU_LES,
      ALU_SLTS,
      ALU_SLETS,
      ALU_MIN,
      ALU_MAX,
      ALU_ABS,
      ALU_CLIP,
      ALU_CLIPU: begin
        case (vector_mode_i)
          VEC_MODE8:  cmp_signed[3:0] = 4'b1111;
          VEC_MODE16: cmp_signed[3:0] = 4'b1010;
          default:    cmp_signed[3:0] = 4'b1000;
        endcase
      end
      default: ;
    endcase
  end
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : gen_is_vec
      assign is_equal_vec[i] = (operand_a_i[8*i+7:8*i] == operand_b_i[8*i+7:i*8]);
      assign is_greater_vec[i] = $signed(
              {operand_a_i[8*i+7] & cmp_signed[i], operand_a_i[8*i+7:8*i]}
          ) > $signed(
              {operand_b_i[8*i+7] & cmp_signed[i], operand_b_i[8*i+7:i*8]}
          );
    end
  endgenerate
  always_comb begin
    is_equal[3:0] = {4{is_equal_vec[3] & is_equal_vec[2] & is_equal_vec[1] & is_equal_vec[0]}};
    is_greater[3:0] = {4{is_greater_vec[3] | (is_equal_vec[3] & (is_greater_vec[2]
                    | (is_equal_vec[2] & (is_greater_vec[1]
                    | (is_equal_vec[1] & (is_greater_vec[0]))))))}};
    case (vector_mode_i)
      VEC_MODE16: begin
        is_equal[1:0]   = {2{is_equal_vec[0] & is_equal_vec[1]}};
        is_equal[3:2]   = {2{is_equal_vec[2] & is_equal_vec[3]}};
        is_greater[1:0] = {2{is_greater_vec[1] | (is_equal_vec[1] & is_greater_vec[0])}};
        is_greater[3:2] = {2{is_greater_vec[3] | (is_equal_vec[3] & is_greater_vec[2])}};
      end
      VEC_MODE8: begin
        is_equal[3:0]   = is_equal_vec[3:0];
        is_greater[3:0] = is_greater_vec[3:0];
      end
      default: ;
    endcase
  end
  logic [3:0] cmp_result;
  always_comb begin
    cmp_result = is_equal;
    unique case (operator_i)
      ALU_EQ:                                 cmp_result = is_equal;
      ALU_NE:                                 cmp_result = ~is_equal;
      ALU_GTS, ALU_GTU:                       cmp_result = is_greater;
      ALU_GES, ALU_GEU:                       cmp_result = is_greater | is_equal;
      ALU_LTS, ALU_SLTS, ALU_LTU, ALU_SLTU:   cmp_result = ~(is_greater | is_equal);
      ALU_SLETS, ALU_SLETU, ALU_LES, ALU_LEU: cmp_result = ~is_greater;
      default:                                ;
    endcase
  end
  assign comparison_result_o = cmp_result[3];
  logic [31:0] result_minmax;
  logic [ 3:0] sel_minmax;
  logic        do_min;
  logic [31:0] minmax_b;
  assign minmax_b = (operator_i == ALU_ABS) ? adder_result : operand_b_i;
  assign do_min   = (operator_i == ALU_MIN)   || (operator_i == ALU_MINU) ||
                      (operator_i == ALU_CLIP) || (operator_i == ALU_CLIPU);
  assign sel_minmax[3:0] = is_greater ^ {4{do_min}};
  assign result_minmax[31:24] = (sel_minmax[3] == 1'b1) ? operand_a_i[31:24] : minmax_b[31:24];
  assign result_minmax[23:16] = (sel_minmax[2] == 1'b1) ? operand_a_i[23:16] : minmax_b[23:16];
  assign result_minmax[15:8] = (sel_minmax[1] == 1'b1) ? operand_a_i[15:8] : minmax_b[15:8];
  assign result_minmax[7:0] = (sel_minmax[0] == 1'b1) ? operand_a_i[7:0] : minmax_b[7:0];
  logic [31:0] clip_result;
  always_comb begin
    clip_result = result_minmax;
    if (operator_i == ALU_CLIPU) begin
      if (operand_a_i[31] || is_equal_clip) begin
        clip_result = '0;
      end else begin
        clip_result = result_minmax;
      end
    end else begin
      if (adder_result_expanded[36] || is_equal_clip) begin
        clip_result = operand_b_neg;
      end else begin
        clip_result = result_minmax;
      end
    end
  end
  logic [3:0][1:0] shuffle_byte_sel;
  logic [3:0]      shuffle_reg_sel;
  logic [1:0]      shuffle_reg1_sel;
  logic [1:0]      shuffle_reg0_sel;
  logic [3:0]      shuffle_through;
  logic [31:0] shuffle_r1, shuffle_r0;
  logic [31:0] shuffle_r1_in, shuffle_r0_in;
  logic [31:0] shuffle_result;
  logic [31:0] pack_result;
  always_comb begin
    shuffle_reg_sel  = '0;
    shuffle_reg1_sel = 2'b01;
    shuffle_reg0_sel = 2'b10;
    shuffle_through  = '1;
    unique case (operator_i)
      ALU_EXT, ALU_EXTS: begin
        if (operator_i == ALU_EXTS) shuffle_reg1_sel = 2'b11;
        if (vector_mode_i == VEC_MODE8) begin
          shuffle_reg_sel[3:1] = 3'b111;
          shuffle_reg_sel[0]   = 1'b0;
        end else begin
          shuffle_reg_sel[3:2] = 2'b11;
          shuffle_reg_sel[1:0] = 2'b00;
        end
      end
      ALU_PCKLO: begin
        shuffle_reg1_sel = 2'b00;
        if (vector_mode_i == VEC_MODE8) begin
          shuffle_through = 4'b0011;
          shuffle_reg_sel = 4'b0001;
        end else begin
          shuffle_reg_sel = 4'b0011;
        end
      end
      ALU_PCKHI: begin
        shuffle_reg1_sel = 2'b00;
        if (vector_mode_i == VEC_MODE8) begin
          shuffle_through = 4'b1100;
          shuffle_reg_sel = 4'b0100;
        end else begin
          shuffle_reg_sel = 4'b0011;
        end
      end
      ALU_SHUF2: begin
        unique case (vector_mode_i)
          VEC_MODE8: begin
            shuffle_reg_sel[3] = ~operand_b_i[26];
            shuffle_reg_sel[2] = ~operand_b_i[18];
            shuffle_reg_sel[1] = ~operand_b_i[10];
            shuffle_reg_sel[0] = ~operand_b_i[2];
          end
          VEC_MODE16: begin
            shuffle_reg_sel[3] = ~operand_b_i[17];
            shuffle_reg_sel[2] = ~operand_b_i[17];
            shuffle_reg_sel[1] = ~operand_b_i[1];
            shuffle_reg_sel[0] = ~operand_b_i[1];
          end
          default: ;
        endcase
      end
      ALU_INS: begin
        unique case (vector_mode_i)
          VEC_MODE8: begin
            shuffle_reg0_sel = 2'b00;
            unique case (imm_vec_ext_i)
              2'b00: begin
                shuffle_reg_sel[3:0] = 4'b1110;
              end
              2'b01: begin
                shuffle_reg_sel[3:0] = 4'b1101;
              end
              2'b10: begin
                shuffle_reg_sel[3:0] = 4'b1011;
              end
              2'b11: begin
                shuffle_reg_sel[3:0] = 4'b0111;
              end
            endcase
          end
          VEC_MODE16: begin
            shuffle_reg0_sel   = 2'b01;
            shuffle_reg_sel[3] = ~imm_vec_ext_i[0];
            shuffle_reg_sel[2] = ~imm_vec_ext_i[0];
            shuffle_reg_sel[1] = imm_vec_ext_i[0];
            shuffle_reg_sel[0] = imm_vec_ext_i[0];
          end
          default: ;
        endcase
      end
      default: ;
    endcase
  end
  always_comb begin
    shuffle_byte_sel = '0;
    unique case (operator_i)
      ALU_EXTS, ALU_EXT: begin
        unique case (vector_mode_i)
          VEC_MODE8: begin
            shuffle_byte_sel[3] = imm_vec_ext_i[1:0];
            shuffle_byte_sel[2] = imm_vec_ext_i[1:0];
            shuffle_byte_sel[1] = imm_vec_ext_i[1:0];
            shuffle_byte_sel[0] = imm_vec_ext_i[1:0];
          end
          VEC_MODE16: begin
            shuffle_byte_sel[3] = {imm_vec_ext_i[0], 1'b1};
            shuffle_byte_sel[2] = {imm_vec_ext_i[0], 1'b1};
            shuffle_byte_sel[1] = {imm_vec_ext_i[0], 1'b1};
            shuffle_byte_sel[0] = {imm_vec_ext_i[0], 1'b0};
          end
          default: ;
        endcase
      end
      ALU_PCKLO: begin
        unique case (vector_mode_i)
          VEC_MODE8: begin
            shuffle_byte_sel[3] = 2'b00;
            shuffle_byte_sel[2] = 2'b00;
            shuffle_byte_sel[1] = 2'b00;
            shuffle_byte_sel[0] = 2'b00;
          end
          VEC_MODE16: begin
            shuffle_byte_sel[3] = 2'b01;
            shuffle_byte_sel[2] = 2'b00;
            shuffle_byte_sel[1] = 2'b01;
            shuffle_byte_sel[0] = 2'b00;
          end
          default: ;
        endcase
      end
      ALU_PCKHI: begin
        unique case (vector_mode_i)
          VEC_MODE8: begin
            shuffle_byte_sel[3] = 2'b00;
            shuffle_byte_sel[2] = 2'b00;
            shuffle_byte_sel[1] = 2'b00;
            shuffle_byte_sel[0] = 2'b00;
          end
          VEC_MODE16: begin
            shuffle_byte_sel[3] = 2'b11;
            shuffle_byte_sel[2] = 2'b10;
            shuffle_byte_sel[1] = 2'b11;
            shuffle_byte_sel[0] = 2'b10;
          end
          default: ;
        endcase
      end
      ALU_SHUF2, ALU_SHUF: begin
        unique case (vector_mode_i)
          VEC_MODE8: begin
            shuffle_byte_sel[3] = operand_b_i[25:24];
            shuffle_byte_sel[2] = operand_b_i[17:16];
            shuffle_byte_sel[1] = operand_b_i[9:8];
            shuffle_byte_sel[0] = operand_b_i[1:0];
          end
          VEC_MODE16: begin
            shuffle_byte_sel[3] = {operand_b_i[16], 1'b1};
            shuffle_byte_sel[2] = {operand_b_i[16], 1'b0};
            shuffle_byte_sel[1] = {operand_b_i[0], 1'b1};
            shuffle_byte_sel[0] = {operand_b_i[0], 1'b0};
          end
          default: ;
        endcase
      end
      ALU_INS: begin
        shuffle_byte_sel[3] = 2'b11;
        shuffle_byte_sel[2] = 2'b10;
        shuffle_byte_sel[1] = 2'b01;
        shuffle_byte_sel[0] = 2'b00;
      end
      default: ;
    endcase
  end
  assign shuffle_r0_in = shuffle_reg0_sel[1] ? operand_a_i :
                           (shuffle_reg0_sel[0] ? {2{operand_a_i[15:0]}} : {4{operand_a_i[7:0]}});
  assign shuffle_r1_in = shuffle_reg1_sel[1] ? {
    {8{operand_a_i[31]}}, {8{operand_a_i[23]}}, {8{operand_a_i[15]}}, {8{operand_a_i[7]}}
  } : (shuffle_reg1_sel[0] ? operand_c_i : operand_b_i);
  assign shuffle_r0[31:24] = shuffle_byte_sel[3][1] ? (shuffle_byte_sel[3][0] ?
         shuffle_r0_in[31:24] : shuffle_r0_in[23:16]) : (shuffle_byte_sel[3][0]
         ? shuffle_r0_in[15: 8] : shuffle_r0_in[ 7: 0]);
  assign shuffle_r0[23:16] = shuffle_byte_sel[2][1] ? (shuffle_byte_sel[2][0] ?
         shuffle_r0_in[31:24] : shuffle_r0_in[23:16]) : (shuffle_byte_sel[2][0]
         ? shuffle_r0_in[15: 8] : shuffle_r0_in[ 7: 0]);
  assign shuffle_r0[15: 8] = shuffle_byte_sel[1][1] ? (shuffle_byte_sel[1][0] ?
         shuffle_r0_in[31:24] : shuffle_r0_in[23:16]) : (shuffle_byte_sel[1][0]
         ? shuffle_r0_in[15: 8] : shuffle_r0_in[ 7: 0]);
  assign shuffle_r0[ 7: 0] = shuffle_byte_sel[0][1] ? (shuffle_byte_sel[0][0] ?
         shuffle_r0_in[31:24] : shuffle_r0_in[23:16]) : (shuffle_byte_sel[0][0]
         ? shuffle_r0_in[15: 8] : shuffle_r0_in[ 7: 0]);
  assign shuffle_r1[31:24] = shuffle_byte_sel[3][1] ? (shuffle_byte_sel[3][0] ?
         shuffle_r1_in[31:24] : shuffle_r1_in[23:16]) : (shuffle_byte_sel[3][0]
         ? shuffle_r1_in[15: 8] : shuffle_r1_in[ 7: 0]);
  assign shuffle_r1[23:16] = shuffle_byte_sel[2][1] ? (shuffle_byte_sel[2][0] ?
         shuffle_r1_in[31:24] : shuffle_r1_in[23:16]) : (shuffle_byte_sel[2][0]
         ? shuffle_r1_in[15: 8] : shuffle_r1_in[ 7: 0]);
  assign shuffle_r1[15: 8] = shuffle_byte_sel[1][1] ? (shuffle_byte_sel[1][0] ?
         shuffle_r1_in[31:24] : shuffle_r1_in[23:16]) : (shuffle_byte_sel[1][0]
         ? shuffle_r1_in[15: 8] : shuffle_r1_in[ 7: 0]);
  assign shuffle_r1[ 7: 0] = shuffle_byte_sel[0][1] ? (shuffle_byte_sel[0][0] ?
         shuffle_r1_in[31:24] : shuffle_r1_in[23:16]) : (shuffle_byte_sel[0][0]
         ? shuffle_r1_in[15: 8] : shuffle_r1_in[ 7: 0]);
  assign shuffle_result[31:24] = shuffle_reg_sel[3] ? shuffle_r1[31:24] : shuffle_r0[31:24];
  assign shuffle_result[23:16] = shuffle_reg_sel[2] ? shuffle_r1[23:16] : shuffle_r0[23:16];
  assign shuffle_result[15:8] = shuffle_reg_sel[1] ? shuffle_r1[15:8] : shuffle_r0[15:8];
  assign shuffle_result[7:0] = shuffle_reg_sel[0] ? shuffle_r1[7:0] : shuffle_r0[7:0];
  assign pack_result[31:24] = shuffle_through[3] ? shuffle_result[31:24] : operand_c_i[31:24];
  assign pack_result[23:16] = shuffle_through[2] ? shuffle_result[23:16] : operand_c_i[23:16];
  assign pack_result[15:8] = shuffle_through[1] ? shuffle_result[15:8] : operand_c_i[15:8];
  assign pack_result[7:0] = shuffle_through[0] ? shuffle_result[7:0] : operand_c_i[7:0];
  logic [31:0] ff_input;
  logic [ 5:0] cnt_result;
  logic [ 5:0] clb_result;
  logic [ 4:0] ff1_result;
  logic        ff_no_one;
  logic [ 4:0] fl1_result;
  logic [ 5:0] bitop_result;
  single_file_rv32imf_popcnt popcnt_i (
      .in_i    (operand_a_i),
      .result_o(cnt_result)
  );
  always_comb begin
    ff_input = '0;
    case (operator_i)
      ALU_FF1: ff_input = operand_a_i;
      ALU_DIVU, ALU_REMU, ALU_FL1: ff_input = operand_a_rev;
      ALU_DIV, ALU_REM, ALU_CLB: begin
        if (operand_a_i[31]) ff_input = operand_a_neg_rev;
        else ff_input = operand_a_rev;
      end
      default: ;
    endcase
  end
  single_file_rv32imf_ff_one ff_one_i (
      .in_i       (ff_input),
      .first_one_o(ff1_result),
      .no_ones_o  (ff_no_one)
  );
  assign fl1_result = 5'd31 - ff1_result;
  assign clb_result = ff1_result - 5'd1;
  always_comb begin
    bitop_result = '0;
    case (operator_i)
      ALU_FF1: bitop_result = ff_no_one ? 6'd32 : {1'b0, ff1_result};
      ALU_FL1: bitop_result = ff_no_one ? 6'd32 : {1'b0, fl1_result};
      ALU_CNT: bitop_result = cnt_result;
      ALU_CLB: begin
        if (ff_no_one) begin
          if (operand_a_i[31]) bitop_result = 6'd31;
          else bitop_result = '0;
        end else begin
          bitop_result = clb_result;
        end
      end
      default: ;
    endcase
  end
  logic extract_is_signed;
  logic extract_sign;
  logic [31:0] bmask_first, bmask_inv;
  logic [31:0] bextins_and;
  logic [31:0] bextins_result, bclr_result, bset_result;
  assign bmask_first       = {32'hFFFFFFFE} << bmask_a_i;
  assign bmask             = (~bmask_first) << bmask_b_i;
  assign bmask_inv         = ~bmask;
  assign bextins_and       = (operator_i == ALU_BINS) ? operand_c_i : {32{extract_sign}};
  assign extract_is_signed = (operator_i == ALU_BEXT);
  assign extract_sign      = extract_is_signed & shift_result[bmask_a_i];
  assign bextins_result    = (bmask & shift_result) | (bextins_and & bmask_inv);
  assign bclr_result       = operand_a_i & bmask_inv;
  assign bset_result       = operand_a_i | bmask;
  logic [31:0] radix_2_rev;
  logic [31:0] radix_4_rev;
  logic [31:0] radix_8_rev;
  logic [31:0] reverse_result;
  logic [ 1:0] radix_mux_sel;
  assign radix_mux_sel = bmask_a_i[1:0];
  generate
    for (j = 0; j < 32; j++) begin : gen_radix_2_rev
      assign radix_2_rev[j] = shift_result[31-j];
    end
    for (j = 0; j < 16; j++) begin : gen_radix_4_rev
      assign radix_4_rev[2*j+1:2*j] = shift_result[31-j*2:31-j*2-1];
    end
    for (j = 0; j < 10; j++) begin : gen_radix_8_rev
      assign radix_8_rev[3*j+2:3*j] = shift_result[31-j*3:31-j*3-2];
    end
    assign radix_8_rev[31:30] = 2'b0;
  endgenerate
  always_comb begin
    reverse_result = '0;
    unique case (radix_mux_sel)
      2'b00: reverse_result = radix_2_rev;
      2'b01: reverse_result = radix_4_rev;
      2'b10: reverse_result = radix_8_rev;
      default: reverse_result = radix_2_rev;
    endcase
  end
  logic [31:0] result_div;
  logic        div_ready;
  logic        div_signed;
  logic        div_op_a_signed;
  logic [ 5:0] div_shift_int;
  assign div_signed = operator_i[0];
  assign div_op_a_signed = operand_a_i[31] & div_signed;
  assign div_shift_int = ff_no_one ? 6'd31 : clb_result;
  assign div_shift = div_shift_int + (div_op_a_signed ? 6'd0 : 6'd1);
  assign div_valid = enable_i & ((operator_i == ALU_DIV) || (operator_i == ALU_DIVU) ||
                                (operator_i == ALU_REM) || (operator_i == ALU_REMU));
  single_file_rv32imf_alu_div alu_div_i (
      .Clk_CI (clk),
      .Rst_RBI(rst_n),
      .OpA_DI      (operand_b_i),
      .OpB_DI      (shift_left_result),
      .OpBShift_DI (div_shift),
      .OpBIsZero_SI((cnt_result == 0)),
      .OpBSign_SI(div_op_a_signed),
      .OpCode_SI (operator_i[1:0]),
      .Res_DO(result_div),
      .InVld_SI (div_valid),
      .OutRdy_SI(ex_ready_i),
      .OutVld_SO(div_ready)
  );
  always_comb begin
    result_o = '0;
    unique case (operator_i)
      ALU_AND: result_o = operand_a_i & operand_b_i;
      ALU_OR:  result_o = operand_a_i | operand_b_i;
      ALU_XOR: result_o = operand_a_i ^ operand_b_i;
      ALU_ADD, ALU_ADDR, ALU_ADDU, ALU_ADDUR,
      ALU_SUB, ALU_SUBR, ALU_SUBU, ALU_SUBUR,
      ALU_SLL,
      ALU_SRL, ALU_SRA,
      ALU_ROR:
      result_o = shift_result;
      ALU_BINS, ALU_BEXT, ALU_BEXTU: result_o = bextins_result;
      ALU_BCLR: result_o = bclr_result;
      ALU_BSET: result_o = bset_result;
      ALU_BREV: result_o = reverse_result;
      ALU_SHUF, ALU_SHUF2, ALU_PCKLO, ALU_PCKHI, ALU_EXT, ALU_EXTS, ALU_INS:
      result_o = pack_result;
      ALU_MIN, ALU_MINU, ALU_MAX, ALU_MAXU: result_o = result_minmax;
      ALU_ABS: result_o = is_clpx_i ? {adder_result[31:16], operand_a_i[15:0]} : result_minmax;
      ALU_CLIP, ALU_CLIPU: result_o = clip_result;
      ALU_EQ, ALU_NE, ALU_GTU, ALU_GEU, ALU_LTU, ALU_LEU, ALU_GTS, ALU_GES, ALU_LTS, ALU_LES: begin
        result_o[31:24] = {8{cmp_result[3]}};
        result_o[23:16] = {8{cmp_result[2]}};
        result_o[15:8]  = {8{cmp_result[1]}};
        result_o[7:0]   = {8{cmp_result[0]}};
      end
      ALU_SLTS, ALU_SLTU, ALU_SLETS, ALU_SLETU: result_o = {31'b0, comparison_result_o};
      ALU_FF1, ALU_FL1, ALU_CLB, ALU_CNT: result_o = {26'h0, bitop_result[5:0]};
      ALU_DIV, ALU_DIVU, ALU_REM, ALU_REMU: result_o = result_div;
      default: ;
    endcase
  end
  assign ready_o = div_ready;
endmodule


module single_file_rv32imf_mult
  import single_file_rv32imf_pkg::*;
(
    input logic clk,
    input logic rst_n,
    input logic        enable_i,
    input mul_opcode_e operator_i,
    input logic       short_subword_i,
    input logic [1:0] short_signed_i,
    input logic [31:0] op_a_i,
    input logic [31:0] op_b_i,
    input logic [31:0] op_c_i,
    input logic [4:0] imm_i,
    input logic [ 1:0] dot_signed_i,
    input logic [31:0] dot_op_a_i,
    input logic [31:0] dot_op_b_i,
    input logic [31:0] dot_op_c_i,
    input logic        is_clpx_i,
    input logic [ 1:0] clpx_shift_i,
    input logic        clpx_img_i,
    output logic [31:0] result_o,
    output logic multicycle_o,
    output logic mulh_active_o,
    output logic ready_o,
    input  logic ex_ready_i
);
  logic [16:0] short_op_a;
  logic [16:0] short_op_b;
  logic [32:0] short_op_c;
  logic [33:0] short_mul;
  logic [33:0] short_mac;
  logic [31:0] short_round, short_round_tmp;
  logic [33:0] short_result;
  logic        short_mac_msb1;
  logic        short_mac_msb0;
  logic [ 4:0] short_imm;
  logic [ 1:0] short_subword;
  logic [ 1:0] short_signed;
  logic        short_shift_arith;
  logic [ 4:0] mulh_imm;
  logic [ 1:0] mulh_subword;
  logic [ 1:0] mulh_signed;
  logic        mulh_shift_arith;
  logic        mulh_carry_q;
  logic        mulh_save;
  logic        mulh_clearcarry;
  logic        mulh_ready;
  mult_state_e mulh_CS, mulh_NS;
  assign short_round_tmp = (32'h00000001) << imm_i;
  assign short_round = (operator_i == MUL_IR) ? {1'b0, short_round_tmp[31:1]} : '0;
  assign short_op_a[15:0] = short_subword[0] ? op_a_i[31:16] : op_a_i[15:0];
  assign short_op_b[15:0] = short_subword[1] ? op_b_i[31:16] : op_b_i[15:0];
  assign short_op_a[16] = short_signed[0] & short_op_a[15];
  assign short_op_b[16] = short_signed[1] & short_op_b[15];
  assign short_op_c = mulh_active_o ? $signed({mulh_carry_q, op_c_i}) : $signed(op_c_i);
  assign short_mul = $signed(short_op_a) * $signed(short_op_b);
  assign short_mac = $signed(short_op_c) + $signed(short_mul) + $signed(short_round);
  assign short_result = $signed(
      {short_shift_arith & short_mac_msb1, short_shift_arith & short_mac_msb0, short_mac[31:0]}
  ) >>> short_imm;
  assign short_imm = mulh_active_o ? mulh_imm : imm_i;
  assign short_subword = mulh_active_o ? mulh_subword : {2{short_subword_i}};
  assign short_signed = mulh_active_o ? mulh_signed : short_signed_i;
  assign short_shift_arith = mulh_active_o ? mulh_shift_arith : short_signed_i[0];
  assign short_mac_msb1 = mulh_active_o ? short_mac[33] : short_mac[31];
  assign short_mac_msb0 = mulh_active_o ? short_mac[32] : short_mac[31];
  always_comb begin
    mulh_NS          = mulh_CS;
    mulh_imm         = 5'd0;
    mulh_subword     = 2'b00;
    mulh_signed      = 2'b00;
    mulh_shift_arith = 1'b0;
    mulh_ready       = 1'b0;
    mulh_active_o    = 1'b1;
    mulh_save        = 1'b0;
    mulh_clearcarry  = 1'b0;
    multicycle_o     = 1'b0;
    case (mulh_CS)
      default: begin
        mulh_active_o = 1'b0;
        mulh_ready    = 1'b1;
        mulh_save     = 1'b0;
        if ((operator_i == MUL_H) && enable_i) begin
          mulh_ready = 1'b0;
          mulh_NS    = STEP0;
        end
      end
      STEP0: begin
        multicycle_o  = 1'b1;
        mulh_imm      = 5'd16;
        mulh_active_o = 1'b1;
        mulh_save     = 1'b0;
        mulh_NS       = STEP1;
      end
      STEP1: begin
        multicycle_o     = 1'b1;
        mulh_signed      = {short_signed_i[1], 1'b0};
        mulh_subword     = 2'b10;
        mulh_save        = 1'b1;
        mulh_shift_arith = 1'b1;
        mulh_NS          = STEP2;
      end
      STEP2: begin
        multicycle_o     = 1'b1;
        mulh_signed      = {1'b0, short_signed_i[0]};
        mulh_subword     = 2'b01;
        mulh_imm         = 5'd16;
        mulh_save        = 1'b1;
        mulh_clearcarry  = 1'b1;
        mulh_shift_arith = 1'b1;
        mulh_NS          = FINISH;
      end
      FINISH: begin
        mulh_signed  = short_signed_i;
        mulh_subword = 2'b11;
        mulh_ready   = 1'b1;
        if (ex_ready_i) mulh_NS = IDLE_MULT;
      end
    endcase
  end
  always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      mulh_CS      <= IDLE_MULT;
      mulh_carry_q <= 1'b0;
    end else begin
      mulh_CS <= mulh_NS;
      if (mulh_save) mulh_carry_q <= ~mulh_clearcarry & short_mac[32];
      else if (ex_ready_i) mulh_carry_q <= 1'b0;
    end
  end
  logic [31:0] int_op_a_msu;
  logic [31:0] int_op_b_msu;
  logic [31:0] int_result;
  logic        int_is_msu;
  assign int_is_msu = (operator_i == MUL_MSU32);
  assign int_op_a_msu = op_a_i ^ {32{int_is_msu}};
  assign int_op_b_msu = op_b_i & {32{int_is_msu}};
  assign int_result = $signed(
          op_c_i
      ) + $signed(
          int_op_b_msu
      ) + $signed(
          int_op_a_msu
      ) * $signed(
          op_b_i
      );
  logic [31:0]       dot_char_result;
  logic [32:0]       dot_short_result;
  logic [31:0]       accumulator;
  logic [15:0]       clpx_shift_result;
  logic [ 3:0][ 8:0] dot_char_op_a;
  logic [ 3:0][ 8:0] dot_char_op_b;
  logic [ 3:0][17:0] dot_char_mul;
  logic [ 1:0][16:0] dot_short_op_a;
  logic [ 1:0][16:0] dot_short_op_b;
  logic [ 1:0][33:0] dot_short_mul;
  logic [16:0]       dot_short_op_a_1_neg;
  logic [31:0]       dot_short_op_b_ext;
  assign dot_char_op_a[0] = {dot_signed_i[1] & dot_op_a_i[7], dot_op_a_i[7:0]};
  assign dot_char_op_a[1] = {dot_signed_i[1] & dot_op_a_i[15], dot_op_a_i[15:8]};
  assign dot_char_op_a[2] = {dot_signed_i[1] & dot_op_a_i[23], dot_op_a_i[23:16]};
  assign dot_char_op_a[3] = {dot_signed_i[1] & dot_op_a_i[31], dot_op_a_i[31:24]};
  assign dot_char_op_b[0] = {dot_signed_i[0] & dot_op_b_i[7], dot_op_b_i[7:0]};
  assign dot_char_op_b[1] = {dot_signed_i[0] & dot_op_b_i[15], dot_op_b_i[15:8]};
  assign dot_char_op_b[2] = {dot_signed_i[0] & dot_op_b_i[23], dot_op_b_i[23:16]};
  assign dot_char_op_b[3] = {dot_signed_i[0] & dot_op_b_i[31], dot_op_b_i[31:24]};
  assign dot_char_mul[0] = $signed(dot_char_op_a[0]) * $signed(dot_char_op_b[0]);
  assign dot_char_mul[1] = $signed(dot_char_op_a[1]) * $signed(dot_char_op_b[1]);
  assign dot_char_mul[2] = $signed(dot_char_op_a[2]) * $signed(dot_char_op_b[2]);
  assign dot_char_mul[3] = $signed(dot_char_op_a[3]) * $signed(dot_char_op_b[3]);
  assign dot_char_result = $signed(
          dot_char_mul[0]
      ) + $signed(
          dot_char_mul[1]
      ) + $signed(
          dot_char_mul[2]
      ) + $signed(
          dot_char_mul[3]
      ) + $signed(
          dot_op_c_i
      );
  assign dot_short_op_a[0] = {dot_signed_i[1] & dot_op_a_i[15], dot_op_a_i[15:0]};
  assign dot_short_op_a[1] = {dot_signed_i[1] & dot_op_a_i[31], dot_op_a_i[31:16]};
  assign dot_short_op_a_1_neg = dot_short_op_a[1] ^ {17{(is_clpx_i & ~clpx_img_i)}};
  assign dot_short_op_b[0] = (is_clpx_i & clpx_img_i) ? {
      dot_signed_i[0] & dot_op_b_i[31], dot_op_b_i[31:16]
  } : {
    dot_signed_i[0] & dot_op_b_i[15], dot_op_b_i[15:0]
  };
  assign dot_short_op_b[1] = (is_clpx_i & clpx_img_i) ? {
      dot_signed_i[0] & dot_op_b_i[15], dot_op_b_i[15:0]
  } : {
    dot_signed_i[0] & dot_op_b_i[31], dot_op_b_i[31:16]
  };
  assign dot_short_mul[0] = $signed(dot_short_op_a[0]) * $signed(dot_short_op_b[0]);
  assign dot_short_mul[1] = $signed(dot_short_op_a_1_neg) * $signed(dot_short_op_b[1]);
  assign dot_short_op_b_ext = $signed(dot_short_op_b[1]);
  assign accumulator = is_clpx_i ? dot_short_op_b_ext & {32{~clpx_img_i}} : $signed(dot_op_c_i);
  assign dot_short_result = $signed(
      dot_short_mul[0][31:0]
  ) + $signed(
      dot_short_mul[1][31:0]
  ) + $signed(
      accumulator
  );
  assign clpx_shift_result = $signed(dot_short_result[31:15]) >>> clpx_shift_i;
  always_comb begin
    result_o = '0;
    unique case (operator_i)
      MUL_MAC32, MUL_MSU32: result_o = int_result[31:0];
      MUL_I, MUL_IR, MUL_H: result_o = short_result[31:0];
      MUL_DOT8: result_o = dot_char_result[31:0];
      MUL_DOT16: begin
        if (is_clpx_i) begin
          if (clpx_img_i) begin
            result_o[31:16] = clpx_shift_result;
            result_o[15:0]  = dot_op_c_i[15:0];
          end else begin
            result_o[15:0]  = clpx_shift_result;
            result_o[31:16] = dot_op_c_i[31:16];
          end
        end else begin
          result_o = dot_short_result[31:0];
        end
      end
      default: begin
      end
    endcase
  end
  assign ready_o = mulh_ready;
endmodule


module single_file_rv32imf_apu_disp (
    input logic clk_i,
    input logic rst_ni,
    input logic       enable_i,
    input logic [1:0] apu_lat_i,
    input logic [5:0] apu_waddr_i,
    output logic [5:0] apu_waddr_o,
    output logic       apu_multicycle_o,
    output logic       apu_singlecycle_o,
    output logic active_o,
    output logic stall_o,
    input  logic            is_decoding_i,
    input  logic [2:0][5:0] read_regs_i,
    input  logic [2:0]      read_regs_valid_i,
    output logic            read_dep_o,
    output logic            read_dep_for_jalr_o,
    input  logic [1:0][5:0] write_regs_i,
    input  logic [1:0]      write_regs_valid_i,
    output logic            write_dep_o,
    output logic perf_type_o,
    output logic perf_cont_o,
    output logic apu_req_o,
    input  logic apu_gnt_i,
    input logic apu_rvalid_i
);
  logic [5:0] addr_req, addr_inflight, addr_waiting;
  logic [5:0] addr_inflight_dn, addr_waiting_dn;
  logic valid_req, valid_inflight, valid_waiting;
  logic valid_inflight_dn, valid_waiting_dn;
  logic returned_req, returned_inflight, returned_waiting;
  logic       req_accepted;
  logic       active;
  logic [1:0] apu_lat;
  logic [2:0]
      read_deps_req, read_deps_inflight, read_deps_waiting;
  logic [1:0]
      write_deps_req,
      write_deps_inflight,
      write_deps_waiting;
  logic read_dep_req, read_dep_inflight, read_dep_waiting;
  logic write_dep_req, write_dep_inflight, write_dep_waiting;
  logic stall_full, stall_type, stall_nack;
  assign valid_req = enable_i & !(stall_full | stall_type);
  assign addr_req = apu_waddr_i;
  assign req_accepted = valid_req & apu_gnt_i;
  assign returned_req = valid_req & apu_rvalid_i & !valid_inflight & !valid_waiting;
  assign returned_inflight = valid_inflight & (apu_rvalid_i) & !valid_waiting;
  assign returned_waiting = valid_waiting & (apu_rvalid_i);
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      valid_inflight <= 1'b0;
      valid_waiting  <= 1'b0;
      addr_inflight  <= '0;
      addr_waiting   <= '0;
    end else begin
      valid_inflight <= valid_inflight_dn;
      valid_waiting  <= valid_waiting_dn;
      addr_inflight  <= addr_inflight_dn;
      addr_waiting   <= addr_waiting_dn;
    end
  end
  always_comb begin
    valid_inflight_dn = valid_inflight;
    valid_waiting_dn  = valid_waiting;
    addr_inflight_dn  = addr_inflight;
    addr_waiting_dn   = addr_waiting;
    if (req_accepted & !returned_req) begin
      valid_inflight_dn = 1'b1;
      addr_inflight_dn  = addr_req;
      if (valid_inflight & !(returned_inflight)) begin
        valid_waiting_dn = 1'b1;
        addr_waiting_dn  = addr_inflight;
      end
      if (returned_waiting) begin
        valid_waiting_dn = 1'b1;
        addr_waiting_dn  = addr_inflight;
      end
    end else if (returned_inflight) begin
      valid_inflight_dn = '0;
      valid_waiting_dn  = '0;
      addr_inflight_dn  = '0;
      addr_waiting_dn   = '0;
    end else if (returned_waiting) begin
      valid_waiting_dn = '0;
      addr_waiting_dn  = '0;
    end
  end
  assign active = valid_inflight | valid_waiting;
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
      apu_lat <= '0;
    end else begin
      if (valid_req) begin
        apu_lat <= apu_lat_i;
      end
    end
  end
  generate
    for (genvar i = 0; i < 3; i++) begin : gen_read_deps
      assign read_deps_req[i]      = (read_regs_i[i] == addr_req) & read_regs_valid_i[i];
      assign read_deps_inflight[i] = (read_regs_i[i] == addr_inflight) & read_regs_valid_i[i];
      assign read_deps_waiting[i]  = (read_regs_i[i] == addr_waiting) & read_regs_valid_i[i];
    end
  endgenerate
  generate
    for (genvar i = 0; i < 2; i++) begin : gen_write_deps
      assign write_deps_req[i]      = (write_regs_i[i] == addr_req) & write_regs_valid_i[i];
      assign write_deps_inflight[i] = (write_regs_i[i] == addr_inflight) & write_regs_valid_i[i];
      assign write_deps_waiting[i]  = (write_regs_i[i] == addr_waiting) & write_regs_valid_i[i];
    end
  endgenerate
  assign read_dep_req = |read_deps_req & valid_req & !returned_req;
  assign read_dep_inflight = |read_deps_inflight & valid_inflight & !returned_inflight;
  assign read_dep_waiting = |read_deps_waiting & valid_waiting & !returned_waiting;
  assign write_dep_req = |write_deps_req & valid_req & !returned_req;
  assign write_dep_inflight = |write_deps_inflight & valid_inflight & !returned_inflight;
  assign write_dep_waiting = |write_deps_waiting & valid_waiting & !returned_waiting;
  assign read_dep_o = (read_dep_req | read_dep_inflight | read_dep_waiting) & is_decoding_i;
  assign write_dep_o = (write_dep_req | write_dep_inflight | write_dep_waiting) & is_decoding_i;
  assign read_dep_for_jalr_o = is_decoding_i & ((|read_deps_req & enable_i) |
                                               (|read_deps_inflight & valid_inflight) |
                                               (|read_deps_waiting & valid_waiting));
  assign stall_full = valid_inflight & valid_waiting;
  assign stall_type = enable_i  & active & ((apu_lat_i==2'h1) |
                      ((apu_lat_i==2'h2) & (apu_lat==2'h3)) | (apu_lat_i==2'h3));
  assign stall_nack = valid_req & !apu_gnt_i;
  assign stall_o = stall_full | stall_type | stall_nack;
  assign apu_req_o = valid_req;
  always_comb begin
    apu_waddr_o = '0;
    if (returned_req) apu_waddr_o = addr_req;
    if (returned_inflight) apu_waddr_o = addr_inflight;
    if (returned_waiting) apu_waddr_o = addr_waiting;
  end
  assign active_o = active;
  assign perf_type_o = stall_type;
  assign perf_cont_o = stall_nack;
  assign apu_multicycle_o = (apu_lat == 2'h3);
  assign apu_singlecycle_o = ~(valid_inflight | valid_waiting);
endmodule


module single_file_rv32imf_ex_stage
  import single_file_rv32imf_pkg::*;
(
    input logic clk,
    input logic rst_n,
    input alu_opcode_e        alu_operator_i,
    input logic        [31:0] alu_operand_a_i,
    input logic        [31:0] alu_operand_b_i,
    input logic        [31:0] alu_operand_c_i,
    input logic               alu_en_i,
    input logic        [ 4:0] bmask_a_i,
    input logic        [ 4:0] bmask_b_i,
    input logic        [ 1:0] imm_vec_ext_i,
    input logic        [ 1:0] alu_vec_mode_i,
    input logic               alu_is_clpx_i,
    input logic               alu_is_subrot_i,
    input logic        [ 1:0] alu_clpx_shift_i,
    input mul_opcode_e        mult_operator_i,
    input logic        [31:0] mult_operand_a_i,
    input logic        [31:0] mult_operand_b_i,
    input logic        [31:0] mult_operand_c_i,
    input logic               mult_en_i,
    input logic               mult_sel_subword_i,
    input logic        [ 1:0] mult_signed_mode_i,
    input logic        [ 4:0] mult_imm_i,
    input logic [31:0] mult_dot_op_a_i,
    input logic [31:0] mult_dot_op_b_i,
    input logic [31:0] mult_dot_op_c_i,
    input logic [ 1:0] mult_dot_signed_i,
    input logic        mult_is_clpx_i,
    input logic [ 1:0] mult_clpx_shift_i,
    input logic        mult_clpx_img_i,
    output logic mult_multicycle_o,
    input logic data_req_i,
    input logic data_rvalid_i,
    input logic data_misaligned_ex_i,
    input logic data_misaligned_i,
    input logic [1:0] ctrl_transfer_insn_in_dec_i,
    output logic       fpu_fflags_we_o,
    output logic [4:0] fpu_fflags_o,
    input logic             apu_en_i,
    input logic [5:0]       apu_op_i,
    input logic [1:0]       apu_lat_i,
    input logic [2:0][31:0] apu_operands_i,
    input logic [5:0]       apu_waddr_i,
    input logic [4:0]       apu_flags_i,
    input  logic [2:0][5:0] apu_read_regs_i,
    input  logic [2:0]      apu_read_regs_valid_i,
    output logic            apu_read_dep_o,
    output logic            apu_read_dep_for_jalr_o,
    input  logic [1:0][5:0] apu_write_regs_i,
    input  logic [1:0]      apu_write_regs_valid_i,
    output logic            apu_write_dep_o,
    output logic apu_perf_type_o,
    output logic apu_perf_cont_o,
    output logic apu_perf_wb_o,
    output logic apu_busy_o,
    output logic apu_ready_wb_o,
    output logic apu_req_o,
    input  logic apu_gnt_i,
    output logic [2:0][31:0] apu_operands_o,
    output logic [5:0]       apu_op_o,
    input logic        apu_rvalid_i,
    input logic [31:0] apu_result_i,
    input logic        lsu_en_i,
    input logic [31:0] lsu_rdata_i,
    input logic       branch_in_ex_i,
    input logic [5:0] regfile_alu_waddr_i,
    input logic       regfile_alu_we_i,
    input logic       regfile_we_i,
    input logic [5:0] regfile_waddr_i,
    input logic        csr_access_i,
    input logic [31:0] csr_rdata_i,
    output logic [5:0] regfile_waddr_wb_o,
    output logic regfile_we_wb_o,
    output logic regfile_we_wb_power_o,
    output logic [31:0] regfile_wdata_wb_o,
    output logic [ 5:0] regfile_alu_waddr_fw_o,
    output logic        regfile_alu_we_fw_o,
    output logic        regfile_alu_we_fw_power_o,
    output logic [31:0] regfile_alu_wdata_fw_o,
    output logic [31:0] jump_target_o,
    output logic        branch_decision_o,
    input logic is_decoding_i,
    input logic lsu_ready_ex_i,
    input logic lsu_err_i,
    output logic ex_ready_o,
    output logic ex_valid_o,
    input  logic wb_ready_i
);
  logic [31:0] alu_result;
  logic [31:0] mult_result;
  logic        alu_cmp_result;
  logic        regfile_we_lsu;
  logic [ 5:0] regfile_waddr_lsu;
  logic        wb_contention;
  logic        wb_contention_lsu;
  logic        alu_ready;
  logic        mulh_active;
  logic        mult_ready;
  logic        apu_valid;
  logic [ 5:0] apu_waddr;
  logic [31:0] apu_result;
  logic        apu_stall;
  logic        apu_active;
  logic        apu_singlecycle;
  logic        apu_multicycle;
  logic        apu_req;
  logic        apu_gnt;
  logic        apu_rvalid_q;
  logic [31:0] apu_result_q;
  logic [ 4:0] apu_flags_q;
  always_comb begin
    regfile_alu_wdata_fw_o    = '0;
    regfile_alu_waddr_fw_o    = '0;
    regfile_alu_we_fw_o       = 1'b0;
    regfile_alu_we_fw_power_o = 1'b0;
    wb_contention             = 1'b0;
    if (apu_valid & (apu_singlecycle | apu_multicycle)) begin
      regfile_alu_we_fw_o       = 1'b1;
      regfile_alu_we_fw_power_o = 1'b1;
      regfile_alu_waddr_fw_o    = apu_waddr;
      regfile_alu_wdata_fw_o    = apu_result;
      if (regfile_alu_we_i & ~apu_en_i) begin
        wb_contention = 1'b1;
      end
    end else begin
      regfile_alu_we_fw_o = regfile_alu_we_i & ~apu_en_i;
      regfile_alu_we_fw_power_o = regfile_alu_we_i & ~apu_en_i;
      regfile_alu_waddr_fw_o = regfile_alu_waddr_i;
      if (alu_en_i) regfile_alu_wdata_fw_o = alu_result;
      if (mult_en_i) regfile_alu_wdata_fw_o = mult_result;
      if (csr_access_i) regfile_alu_wdata_fw_o = csr_rdata_i;
    end
  end
  always_comb begin
    regfile_we_wb_o       = 1'b0;
    regfile_we_wb_power_o = 1'b0;
    regfile_waddr_wb_o    = regfile_waddr_lsu;
    regfile_wdata_wb_o    = lsu_rdata_i;
    wb_contention_lsu     = 1'b0;
    if (regfile_we_lsu) begin
      regfile_we_wb_o       = 1'b1;
      regfile_we_wb_power_o = 1'b1;
      if (apu_valid & (!apu_singlecycle & !apu_multicycle)) begin
        wb_contention_lsu = 1'b1;
      end
    end else if (apu_valid & (!apu_singlecycle & !apu_multicycle)) begin
      regfile_we_wb_o       = 1'b1;
      regfile_we_wb_power_o = 1'b1;
      regfile_waddr_wb_o    = apu_waddr;
      regfile_wdata_wb_o    = apu_result;
    end
  end
  assign branch_decision_o = alu_cmp_result;
  assign jump_target_o     = alu_operand_c_i;
  single_file_rv32imf_alu alu_i (
      .clk        (clk),
      .rst_n      (rst_n),
      .enable_i   (alu_en_i),
      .operator_i (alu_operator_i),
      .operand_a_i(alu_operand_a_i),
      .operand_b_i(alu_operand_b_i),
      .operand_c_i(alu_operand_c_i),
      .vector_mode_i(alu_vec_mode_i),
      .bmask_a_i    (bmask_a_i),
      .bmask_b_i    (bmask_b_i),
      .imm_vec_ext_i(imm_vec_ext_i),
      .is_clpx_i   (alu_is_clpx_i),
      .clpx_shift_i(alu_clpx_shift_i),
      .is_subrot_i (alu_is_subrot_i),
      .result_o           (alu_result),
      .comparison_result_o(alu_cmp_result),
      .ready_o   (alu_ready),
      .ex_ready_i(ex_ready_o)
  );
  single_file_rv32imf_mult mult_i (
      .clk  (clk),
      .rst_n(rst_n),
      .enable_i  (mult_en_i),
      .operator_i(mult_operator_i),
      .short_subword_i(mult_sel_subword_i),
      .short_signed_i (mult_signed_mode_i),
      .op_a_i(mult_operand_a_i),
      .op_b_i(mult_operand_b_i),
      .op_c_i(mult_operand_c_i),
      .imm_i (mult_imm_i),
      .dot_op_a_i  (mult_dot_op_a_i),
      .dot_op_b_i  (mult_dot_op_b_i),
      .dot_op_c_i  (mult_dot_op_c_i),
      .dot_signed_i(mult_dot_signed_i),
      .is_clpx_i   (mult_is_clpx_i),
      .clpx_shift_i(mult_clpx_shift_i),
      .clpx_img_i  (mult_clpx_img_i),
      .result_o(mult_result),
      .multicycle_o (mult_multicycle_o),
      .mulh_active_o(mulh_active),
      .ready_o      (mult_ready),
      .ex_ready_i   (ex_ready_o)
  );
  single_file_rv32imf_apu_disp apu_disp_i (
      .clk_i (clk),
      .rst_ni(rst_n),
      .enable_i   (apu_en_i),
      .apu_lat_i  (apu_lat_i),
      .apu_waddr_i(apu_waddr_i),
      .apu_waddr_o      (apu_waddr),
      .apu_multicycle_o (apu_multicycle),
      .apu_singlecycle_o(apu_singlecycle),
      .active_o(apu_active),
      .stall_o (apu_stall),
      .is_decoding_i      (is_decoding_i),
      .read_regs_i        (apu_read_regs_i),
      .read_regs_valid_i  (apu_read_regs_valid_i),
      .read_dep_o         (apu_read_dep_o),
      .read_dep_for_jalr_o(apu_read_dep_for_jalr_o),
      .write_regs_i       (apu_write_regs_i),
      .write_regs_valid_i (apu_write_regs_valid_i),
      .write_dep_o        (apu_write_dep_o),
      .perf_type_o(apu_perf_type_o),
      .perf_cont_o(apu_perf_cont_o),
      .apu_req_o(apu_req),
      .apu_gnt_i(apu_gnt),
      .apu_rvalid_i(apu_valid)
  );
  assign apu_perf_wb_o  = wb_contention | wb_contention_lsu;
  assign apu_ready_wb_o = ~(apu_active | apu_en_i | apu_stall) | apu_valid;
  always_ff @(posedge clk, negedge rst_n) begin : APU_Result_Memorization
    if (~rst_n) begin
      apu_rvalid_q <= 1'b0;
      apu_result_q <= 'b0;
      apu_flags_q  <= 'b0;
    end else begin
      if (apu_rvalid_i && apu_multicycle &&
          (data_misaligned_i || data_misaligned_ex_i ||
           ((data_req_i || data_rvalid_i) && regfile_alu_we_i) ||
           (mulh_active && (mult_operator_i == MUL_H)) ||
           ((ctrl_transfer_insn_in_dec_i == BRANCH_JALR) &&
            regfile_alu_we_i && ~apu_read_dep_for_jalr_o))) begin
        apu_rvalid_q <= 1'b1;
        apu_result_q <= apu_result_i;
        apu_flags_q  <= apu_flags_i;
      end else if (apu_rvalid_q && !(data_misaligned_i || data_misaligned_ex_i ||
                                       ((data_req_i || data_rvalid_i) && regfile_alu_we_i) ||
                                       (mulh_active && (mult_operator_i == MUL_H)) ||
                                       ((ctrl_transfer_insn_in_dec_i == BRANCH_JALR) &&
                                        regfile_alu_we_i && ~apu_read_dep_for_jalr_o))) begin
        apu_rvalid_q <= 1'b0;
      end
    end
  end
  assign apu_req_o = apu_req;
  assign apu_gnt = apu_gnt_i;
  assign apu_valid      = (apu_multicycle && (data_misaligned_i || data_misaligned_ex_i ||
                          ((data_req_i || data_rvalid_i) && regfile_alu_we_i) ||
                          (mulh_active && (mult_operator_i == MUL_H)) ||
                          ((ctrl_transfer_insn_in_dec_i == BRANCH_JALR) &&
                           regfile_alu_we_i && ~apu_read_dep_for_jalr_o)))
                            ? 1'b0 : (apu_rvalid_i || apu_rvalid_q);
  assign apu_operands_o = apu_operands_i;
  assign apu_op_o = apu_op_i;
  assign apu_result = apu_rvalid_q ? apu_result_q : apu_result_i;
  assign fpu_fflags_we_o = apu_valid;
  assign fpu_fflags_o = apu_rvalid_q ? apu_flags_q : apu_flags_i;
  assign apu_busy_o = apu_active;
  always_ff @(posedge clk, negedge rst_n) begin : EX_WB_Pipeline_Register
    if (~rst_n) begin
      regfile_waddr_lsu <= '0;
      regfile_we_lsu    <= 1'b0;
    end else begin
      if (ex_valid_o) begin
        regfile_we_lsu <= regfile_we_i & ~lsu_err_i;
        if (regfile_we_i & ~lsu_err_i) begin
          regfile_waddr_lsu <= regfile_waddr_i;
        end
      end else if (wb_ready_i) begin
        regfile_we_lsu <= 1'b0;
      end
    end
  end
  assign ex_ready_o = (~apu_stall & alu_ready & mult_ready & lsu_ready_ex_i
                        & wb_ready_i & ~wb_contention) | (branch_in_ex_i);
  assign ex_valid_o = (apu_valid | alu_en_i | mult_en_i | csr_access_i | lsu_en_i)
                        & (alu_ready & mult_ready & lsu_ready_ex_i & wb_ready_i);
endmodule


module single_file_rv32imf_load_store_unit (
    input logic clk,
    input logic rst_n,
    output logic data_req_o,
    input  logic data_gnt_i,
    input  logic data_rvalid_i,
    input  logic data_err_i,
    input  logic data_err_pmp_i,
    output logic [31:0] data_addr_o,
    output logic        data_we_o,
    output logic [ 3:0] data_be_o,
    output logic [31:0] data_wdata_o,
    input  logic [31:0] data_rdata_i,
    input logic        data_we_ex_i,
    input logic [ 1:0] data_type_ex_i,
    input logic [31:0] data_wdata_ex_i,
    input logic [ 1:0] data_reg_offset_ex_i,
    input logic [ 1:0] data_sign_ext_ex_i,
    output logic [31:0] data_rdata_ex_o,
    input  logic        data_req_ex_i,
    input  logic [31:0] operand_a_ex_i,
    input  logic [31:0] operand_b_ex_i,
    input  logic        addr_useincr_ex_i,
    input  logic data_misaligned_ex_i,
    output logic data_misaligned_o,
    input  logic [5:0] data_atop_ex_i,
    output logic [5:0] data_atop_o,
    output logic lsu_ready_ex_o,
    output logic lsu_ready_wb_o,
    output logic busy_o
);
  localparam int DEPTH = 2;
  logic        trans_valid;
  logic        trans_ready;
  logic [31:0] trans_addr;
  logic        trans_we;
  logic [ 3:0] trans_be;
  logic [31:0] trans_wdata;
  logic [ 5:0] trans_atop;
  logic        resp_valid;
  logic [31:0] resp_rdata;
  logic        resp_err;
  logic [ 1:0] cnt_q;
  logic [ 1:0] next_cnt;
  logic        count_up;
  logic        count_down;
  logic        ctrl_update;
  logic [31:0] data_addr_int;
  logic [ 1:0] data_type_q;
  logic [ 1:0] rdata_offset_q;
  logic [ 1:0] data_sign_ext_q;
  logic        data_we_q;
  logic [ 1:0] wdata_offset;
  logic [ 3:0] data_be;
  logic [31:0] data_wdata;
  logic        misaligned_st;
  logic load_err_o, store_err_o;
  logic [31:0] rdata_q;
  always_comb begin
    case (data_type_ex_i)
      2'b00: begin
        if (misaligned_st == 1'b0) begin
          case (data_addr_int[1:0])
            2'b00:   data_be = 4'b1111;
            2'b01:   data_be = 4'b1110;
            2'b10:   data_be = 4'b1100;
            default: data_be = 4'b1000;
          endcase
        end else begin
          case (data_addr_int[1:0])
            2'b01:   data_be = 4'b0001;
            2'b10:   data_be = 4'b0011;
            2'b11:   data_be = 4'b0111;
            default: data_be = 4'b0000;
          endcase
        end
      end
      2'b01: begin
        if (misaligned_st == 1'b0) begin
          case (data_addr_int[1:0])
            2'b00:   data_be = 4'b0011;
            2'b01:   data_be = 4'b0110;
            2'b10:   data_be = 4'b1100;
            default: data_be = 4'b1000;
          endcase
        end else begin
          data_be = 4'b0001;
        end
      end
      default: begin
        case (data_addr_int[1:0])
          2'b00:   data_be = 4'b0001;
          2'b01:   data_be = 4'b0010;
          2'b10:   data_be = 4'b0100;
          default: data_be = 4'b1000;
        endcase
      end
    endcase
  end
  assign wdata_offset = data_addr_int[1:0] - data_reg_offset_ex_i[1:0];
  always_comb begin
    case (wdata_offset)
      2'b00:   data_wdata = data_wdata_ex_i[31:0];
      2'b01:   data_wdata = {data_wdata_ex_i[23:0], data_wdata_ex_i[31:24]};
      2'b10:   data_wdata = {data_wdata_ex_i[15:0], data_wdata_ex_i[31:16]};
      default: data_wdata = {data_wdata_ex_i[7:0], data_wdata_ex_i[31:8]};
    endcase
  end
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      data_type_q     <= '0;
      rdata_offset_q  <= '0;
      data_sign_ext_q <= '0;
      data_we_q       <= 1'b0;
    end else if (ctrl_update) begin
      data_type_q     <= data_type_ex_i;
      rdata_offset_q  <= data_addr_int[1:0];
      data_sign_ext_q <= data_sign_ext_ex_i;
      data_we_q       <= data_we_ex_i;
    end
  end
  logic [31:0] data_rdata_ext;
  logic [31:0] rdata_w_ext;
  logic [31:0] rdata_h_ext;
  logic [31:0] rdata_b_ext;
  always_comb begin
    case (rdata_offset_q)
      2'b00:   rdata_w_ext = resp_rdata[31:0];
      2'b01:   rdata_w_ext = {resp_rdata[7:0], rdata_q[31:8]};
      2'b10:   rdata_w_ext = {resp_rdata[15:0], rdata_q[31:16]};
      default: rdata_w_ext = {resp_rdata[23:0], rdata_q[31:24]};
    endcase
  end
  always_comb begin
    case (rdata_offset_q)
      2'b00: begin
        if (data_sign_ext_q == 2'b00) rdata_h_ext = {16'h0000, resp_rdata[15:0]};
        else if (data_sign_ext_q == 2'b10)
          rdata_h_ext = {16'hffff, resp_rdata[15:0]};
        else rdata_h_ext = {{16{resp_rdata[15]}}, resp_rdata[15:0]};
      end
      2'b01: begin
        if (data_sign_ext_q == 2'b00) rdata_h_ext = {16'h0000, resp_rdata[23:8]};
        else if (data_sign_ext_q == 2'b10)
          rdata_h_ext = {16'hffff, resp_rdata[23:8]};
        else rdata_h_ext = {{16{resp_rdata[23]}}, resp_rdata[23:8]};
      end
      2'b10: begin
        if (data_sign_ext_q == 2'b00) rdata_h_ext = {16'h0000, resp_rdata[31:16]};
        else if (data_sign_ext_q == 2'b10)
          rdata_h_ext = {16'hffff, resp_rdata[31:16]};
        else rdata_h_ext = {{16{resp_rdata[31]}}, resp_rdata[31:16]};
      end
      default: begin
        if (data_sign_ext_q == 2'b00)
          rdata_h_ext = {16'h0000, resp_rdata[7:0], rdata_q[31:24]};
        else if (data_sign_ext_q == 2'b10)
          rdata_h_ext = {16'hffff, resp_rdata[7:0], rdata_q[31:24]};
        else rdata_h_ext = {{16{resp_rdata[7]}}, resp_rdata[7:0], rdata_q[31:24]};
      end
    endcase
  end
  always_comb begin
    case (rdata_offset_q)
      2'b00: begin
        if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
        else if (data_sign_ext_q == 2'b10)
          rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
        else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
      end
      2'b01: begin
        if (data_sign_ext_q == 2'b00)
          rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
        else if (data_sign_ext_q == 2'b10)
          rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
        else rdata_b_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
      end
      2'b10: begin
        if (data_sign_ext_q == 2'b00)
          rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
        else if (data_sign_ext_q == 2'b10)
          rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
        else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
      end
      default: begin
        if (data_sign_ext_q == 2'b00)
          rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
        else if (data_sign_ext_q == 2'b10)
          rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
        else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
      end
    endcase
  end
  always_comb begin
    case (data_type_q)
      2'b00:   data_rdata_ext = rdata_w_ext;
      2'b01:   data_rdata_ext = rdata_h_ext;
      default: data_rdata_ext = rdata_b_ext;
    endcase
  end
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      rdata_q <= '0;
    end else begin
      if (resp_valid && (~data_we_q)) begin
        if ((data_misaligned_ex_i == 1'b1) || (data_misaligned_o == 1'b1))
          rdata_q <= resp_rdata;
        else rdata_q <= data_rdata_ext;
      end
    end
  end
  assign data_rdata_ex_o = (resp_valid == 1'b1) ? data_rdata_ext : rdata_q;
  assign misaligned_st   = data_misaligned_ex_i;
  assign load_err_o      = data_gnt_i && data_err_pmp_i && ~data_we_o;
  assign store_err_o     = data_gnt_i && data_err_pmp_i && data_we_o;
  always_comb begin
    data_misaligned_o = 1'b0;
    if ((data_req_ex_i == 1'b1) && (data_misaligned_ex_i == 1'b0)) begin
      case (data_type_ex_i)
        2'b00: begin
          if (data_addr_int[1:0] != 2'b00) data_misaligned_o = 1'b1;
        end
        2'b01: begin
          if (data_addr_int[1:0] == 2'b11) data_misaligned_o = 1'b1;
        end
        default: begin
        end
      endcase
    end
  end
  assign data_addr_int = (addr_useincr_ex_i) ? (operand_a_ex_i + operand_b_ex_i) : operand_a_ex_i;
  assign busy_o = (cnt_q != 2'b00) || trans_valid;
  assign trans_addr = data_misaligned_ex_i ? {data_addr_int[31:2], 2'b00} : data_addr_int;
  assign trans_we = data_we_ex_i;
  assign trans_be = data_be;
  assign trans_wdata = data_wdata;
  assign trans_atop = data_atop_ex_i;
  assign trans_valid = data_req_ex_i && (cnt_q < DEPTH);
  assign lsu_ready_wb_o = (cnt_q == 2'b00) ? 1'b1 : resp_valid;
  assign lsu_ready_ex_o = (data_req_ex_i == 1'b0) ? 1'b1 :
      (cnt_q == 2'b00) ? (trans_valid && trans_ready) :
      (cnt_q == 2'b01) ? (resp_valid && trans_valid && trans_ready) :
      resp_valid;
  assign ctrl_update = lsu_ready_ex_o && data_req_ex_i;
  assign count_up = trans_valid && trans_ready;
  assign count_down = resp_valid;
  always_comb begin
    case ({
      count_up, count_down
    })
      2'b00: begin
        next_cnt = cnt_q;
      end
      2'b01: begin
        next_cnt = cnt_q - 1'b1;
      end
      2'b10: begin
        next_cnt = cnt_q + 1'b1;
      end
      default: begin
        next_cnt = cnt_q;
      end
    endcase
  end
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      cnt_q <= '0;
    end else begin
      cnt_q <= next_cnt;
    end
  end
  single_file_rv32imf_obi_interface #(
      .TRANS_STABLE(1)
  ) data_obi_i (
      .clk  (clk),
      .rst_n(rst_n),
      .trans_valid_i(trans_valid),
      .trans_ready_o(trans_ready),
      .trans_addr_i (trans_addr),
      .trans_we_i   (trans_we),
      .trans_be_i   (trans_be),
      .trans_wdata_i(trans_wdata),
      .trans_atop_i (trans_atop),
      .resp_valid_o(resp_valid),
      .resp_rdata_o(resp_rdata),
      .resp_err_o  (resp_err),
      .obi_req_o   (data_req_o),
      .obi_gnt_i   (data_gnt_i),
      .obi_addr_o  (data_addr_o),
      .obi_we_o    (data_we_o),
      .obi_be_o    (data_be_o),
      .obi_wdata_o (data_wdata_o),
      .obi_atop_o  (data_atop_o),
      .obi_rdata_i (data_rdata_i),
      .obi_rvalid_i(data_rvalid_i),
      .obi_err_i   (data_err_i)
  );
endmodule


module single_file_rv32imf_cs_registers
  import single_file_rv32imf_pkg::*;
#(
    parameter int N_HWLP           = 2,
    parameter int N_PMP_ENTRIES    = 16,
    parameter int DEBUG_TRIGGER_EN = 1
) (
    input logic clk,
    input logic rst_n,
    input  logic [31:0] hart_id_i,
    output logic [23:0] mtvec_o,
    output logic [23:0] utvec_o,
    output logic [ 1:0] mtvec_mode_o,
    output logic [ 1:0] utvec_mode_o,
    input logic [31:0] mtvec_addr_i,
    input logic        csr_mtvec_init_i,
    input  csr_num_e           csr_addr_i,
    input  logic        [31:0] csr_wdata_i,
    input  csr_opcode_e        csr_op_i,
    output logic        [31:0] csr_rdata_o,
    output logic               fs_off_o,
    output logic [        2:0] frm_o,
    input  logic [C_FFLAG-1:0] fflags_i,
    input  logic               fflags_we_i,
    input  logic               fregs_we_i,
    output logic [31:0] mie_bypass_o,
    input  logic [31:0] mip_i,
    output logic        m_irq_enable_o,
    output logic        u_irq_enable_o,
    input  logic        csr_irq_sec_i,
    output logic        sec_lvl_o,
    output logic [31:0] mepc_o,
    output logic [31:0] uepc_o,
    output logic [31:0] mcounteren_o,
    input  logic        debug_mode_i,
    input  logic [ 2:0] debug_cause_i,
    input  logic        debug_csr_save_i,
    output logic [31:0] depc_o,
    output logic        debug_single_step_o,
    output logic        debug_ebreakm_o,
    output logic        debug_ebreaku_o,
    output logic        trigger_match_o,
    output logic [N_PMP_ENTRIES-1:0][31:0] pmp_addr_o,
    output logic [N_PMP_ENTRIES-1:0][ 7:0] pmp_cfg_o,
    output priv_lvl_t priv_lvl_o,
    input logic [31:0] pc_if_i,
    input logic [31:0] pc_id_i,
    input logic [31:0] pc_ex_i,
    input logic csr_save_if_i,
    input logic csr_save_id_i,
    input logic csr_save_ex_i,
    input logic csr_restore_mret_i,
    input logic csr_restore_uret_i,
    input logic csr_restore_dret_i,
    input logic [5:0] csr_cause_i,
    input logic csr_save_cause_i,
    input logic [N_HWLP-1:0][31:0] hwlp_start_i,
    input logic [N_HWLP-1:0][31:0] hwlp_end_i,
    input logic [N_HWLP-1:0][31:0] hwlp_cnt_i,
    input logic mhpmevent_minstret_i,
    input logic mhpmevent_load_i,
    input logic mhpmevent_store_i,
    input logic mhpmevent_jump_i,
    input logic mhpmevent_branch_i,
    input logic mhpmevent_branch_taken_i,
    input logic mhpmevent_compressed_i,
    input logic mhpmevent_jr_stall_i,
    input logic mhpmevent_imiss_i,
    input logic mhpmevent_ld_stall_i,
    input logic mhpmevent_pipe_stall_i,
    input logic apu_typeconflict_i,
    input logic apu_contention_i,
    input logic apu_dep_i,
    input logic apu_wb_i
);
  localparam int HmpEvents = 16;
  localparam int MtvecMode = 2'b01;
  localparam int MaxPmpEntries = 16;
  localparam int MaxPmpConfigs = 4;
  localparam int PmpConfigs = N_PMP_ENTRIES % 4 == 0 ? N_PMP_ENTRIES / 4 : N_PMP_ENTRIES / 4 + 1;
  localparam int MstatusUieBit = 0;
  localparam int MstatusSieBit = 1;
  localparam int MstatusMieBit = 3;
  localparam int MstatusUpieBit = 4;
  localparam int MstatusSpieBit = 5;
  localparam int MstatusMpieBit = 7;
  localparam int MstatusSppBit = 8;
  localparam int MstatusMppBitLow = 11;
  localparam int MstatusMppBitHigh = 12;
  localparam int MstatusFsBitLow = 13;
  localparam int MstatusFsBitHigh = 14;
  localparam int MstatusMprvBit = 17;
  localparam int MstatusSdBit = 31;
  localparam logic [1:0] MXL = 2'd1;
  localparam logic [31:0] MisaValue = (32'(0) << 0)
  | (1 << 2)
  | (1 << 3)
  | (0 << 4)
  | (32'(1) << 5)
  | (1 << 8)
  | (1 << 12)
  | (0 << 13)
  | (0 << 18)
  | (32'(0) << 20)
  | (32'(MXL) << 30);
  typedef struct packed {
    logic [MaxPmpEntries-1:0][31:0] pmpaddr;
    logic [MaxPmpConfigs-1:0][31:0] pmpcfg_packed;
    logic [MaxPmpEntries-1:0][7:0]  pmpcfg;
  } pmp_t;
  logic [31:0] csr_wdata_int;
  logic [31:0] csr_rdata_int;
  logic        csr_we_int;
  logic [C_RM-1:0] frm_q, frm_n;
  logic [C_FFLAG-1:0] fflags_q, fflags_n;
  logic fcsr_update;
  logic [31:0] mepc_q, mepc_n;
  logic [31:0] uepc_q, uepc_n;
  logic [31:0] tmatch_control_rdata;
  logic [31:0] tmatch_value_rdata;
  logic [15:0] tinfo_types;
  dcsr_t dcsr_q, dcsr_n;
  logic [31:0] depc_q, depc_n;
  logic [31:0] dscratch0_q, dscratch0_n;
  logic [31:0] dscratch1_q, dscratch1_n;
  logic [31:0] mscratch_q, mscratch_n;
  logic [31:0] exception_pc;
  status_t mstatus_q, mstatus_n;
  logic mstatus_we_int;
  fs_t mstatus_fs_q, mstatus_fs_n;
  logic [5:0] mcause_q, mcause_n;
  logic [5:0] ucause_q, ucause_n;
  logic [23:0] mtvec_n, mtvec_q;
  logic [23:0] utvec_n, utvec_q;
  logic [1:0] mtvec_mode_n, mtvec_mode_q;
  logic [1:0] utvec_mode_n, utvec_mode_q;
  logic [31:0] mip;
  logic [31:0] mie_q, mie_n;
  logic [31:0] csr_mie_wdata;
  logic        csr_mie_we;
  logic        is_irq;
  priv_lvl_t priv_lvl_n, priv_lvl_q;
  pmp_t pmp_reg_q, pmp_reg_n;
  logic [MaxPmpEntries-1:0] pmpaddr_we;
  logic [MaxPmpEntries-1:0] pmpcfg_we;
  logic [31:0][MHPMCOUNTER_WIDTH-1:0] mhpmcounter_q;
  logic [31:0][31:0] mhpmevent_q, mhpmevent_n;
  logic [31:0] mcounteren_q, mcounteren_n;
  logic [31:0] mcountinhibit_q, mcountinhibit_n;
  logic [HmpEvents-1:0] hpm_events;
  logic [31:0][MHPMCOUNTER_WIDTH-1:0] mhpmcounter_increment;
  logic [31:0] mhpmcounter_write_lower;
  logic [31:0] mhpmcounter_write_upper;
  logic [31:0] mhpmcounter_write_increment;
  assign is_irq = csr_cause_i[5];
  assign mip = mip_i;
  always_comb begin
    csr_mie_wdata = csr_wdata_i;
    csr_mie_we    = 1'b1;
    case (csr_op_i)
      CSR_OP_WRITE: csr_mie_wdata = csr_wdata_i;
      CSR_OP_SET:   csr_mie_wdata = csr_wdata_i | mie_q;
      CSR_OP_CLEAR: csr_mie_wdata = (~csr_wdata_i) & mie_q;
      CSR_OP_READ: begin
        csr_mie_wdata = csr_wdata_i;
        csr_mie_we    = 1'b0;
      end
    endcase
  end
  assign mie_bypass_o = ((csr_addr_i == CSR_MIE) && csr_mie_we) ? csr_mie_wdata & IRQ_MASK : mie_q;
  always_comb begin
    case (csr_addr_i)
      CSR_FFLAGS: csr_rdata_int = {27'b0, fflags_q};
      CSR_FRM: csr_rdata_int = {29'b0, frm_q};
      CSR_FCSR: csr_rdata_int = {24'b0, frm_q, fflags_q};
      CSR_MSTATUS:
      csr_rdata_int = {
        (mstatus_fs_q == FS_DIRTY ? 1'b1 : 1'b0),
        13'b0,
        mstatus_q.mprv,
        2'b0,
        mstatus_fs_q,
        mstatus_q.mpp,
        3'b0,
        mstatus_q.mpie,
        2'h0,
        mstatus_q.upie,
        mstatus_q.mie,
        2'h0,
        mstatus_q.uie
      };
      CSR_MISA: csr_rdata_int = MisaValue;
      CSR_MIE: begin
        csr_rdata_int = mie_q;
      end
      CSR_MTVEC: csr_rdata_int = {mtvec_q, 6'h0, mtvec_mode_q};
      CSR_MSCRATCH: csr_rdata_int = mscratch_q;
      CSR_MEPC: csr_rdata_int = mepc_q;
      CSR_MCAUSE: csr_rdata_int = {mcause_q[5], 26'b0, mcause_q[4:0]};
      CSR_MIP: begin
        csr_rdata_int = mip;
      end
      CSR_MHARTID: csr_rdata_int = hart_id_i;
      CSR_MVENDORID: csr_rdata_int = {MVENDORID_BANK, MVENDORID_OFFSET};
      CSR_MARCHID: csr_rdata_int = MARCHID;
      CSR_MIMPID: begin
        csr_rdata_int = 32'h1;
      end
      CSR_MTVAL: csr_rdata_int = 'b0;
      CSR_TSELECT, CSR_TDATA3, CSR_MCONTEXT, CSR_SCONTEXT:
      csr_rdata_int = 'b0;
      CSR_TDATA1: csr_rdata_int = tmatch_control_rdata;
      CSR_TDATA2: csr_rdata_int = tmatch_value_rdata;
      CSR_TINFO: csr_rdata_int = tinfo_types;
      CSR_DCSR: csr_rdata_int = dcsr_q;
      CSR_DPC: csr_rdata_int = depc_q;
      CSR_DSCRATCH0: csr_rdata_int = dscratch0_q;
      CSR_DSCRATCH1: csr_rdata_int = dscratch1_q;
      CSR_MCYCLE,
      CSR_MINSTRET,
      CSR_MHPMCOUNTER3,
      CSR_MHPMCOUNTER4,  CSR_MHPMCOUNTER5,  CSR_MHPMCOUNTER6,  CSR_MHPMCOUNTER7,
      CSR_MHPMCOUNTER8,  CSR_MHPMCOUNTER9,  CSR_MHPMCOUNTER10, CSR_MHPMCOUNTER11,
      CSR_MHPMCOUNTER12, CSR_MHPMCOUNTER13, CSR_MHPMCOUNTER14, CSR_MHPMCOUNTER15,
      CSR_MHPMCOUNTER16, CSR_MHPMCOUNTER17, CSR_MHPMCOUNTER18, CSR_MHPMCOUNTER19,
      CSR_MHPMCOUNTER20, CSR_MHPMCOUNTER21, CSR_MHPMCOUNTER22, CSR_MHPMCOUNTER23,
      CSR_MHPMCOUNTER24, CSR_MHPMCOUNTER25, CSR_MHPMCOUNTER26, CSR_MHPMCOUNTER27,
      CSR_MHPMCOUNTER28, CSR_MHPMCOUNTER29, CSR_MHPMCOUNTER30, CSR_MHPMCOUNTER31,
      CSR_CYCLE,
      CSR_INSTRET,
      CSR_HPMCOUNTER3,
      CSR_HPMCOUNTER4,  CSR_HPMCOUNTER5,  CSR_HPMCOUNTER6,  CSR_HPMCOUNTER7,
      CSR_HPMCOUNTER8,  CSR_HPMCOUNTER9,  CSR_HPMCOUNTER10, CSR_HPMCOUNTER11,
      CSR_HPMCOUNTER12, CSR_HPMCOUNTER13, CSR_HPMCOUNTER14, CSR_HPMCOUNTER15,
      CSR_HPMCOUNTER16, CSR_HPMCOUNTER17, CSR_HPMCOUNTER18, CSR_HPMCOUNTER19,
      CSR_HPMCOUNTER20, CSR_HPMCOUNTER21, CSR_HPMCOUNTER22, CSR_HPMCOUNTER23,
      CSR_HPMCOUNTER24, CSR_HPMCOUNTER25, CSR_HPMCOUNTER26, CSR_HPMCOUNTER27,
      CSR_HPMCOUNTER28, CSR_HPMCOUNTER29, CSR_HPMCOUNTER30, CSR_HPMCOUNTER31:
      csr_rdata_int = mhpmcounter_q[csr_addr_i[4:0]][31:0];
      CSR_MCYCLEH, CSR_MINSTRETH, CSR_MHPMCOUNTER3H, CSR_MHPMCOUNTER4H,  CSR_MHPMCOUNTER5H,
      CSR_MHPMCOUNTER6H,  CSR_MHPMCOUNTER7H, CSR_MHPMCOUNTER8H,  CSR_MHPMCOUNTER9H,
      CSR_MHPMCOUNTER10H, CSR_MHPMCOUNTER11H, CSR_MHPMCOUNTER12H, CSR_MHPMCOUNTER13H,
      CSR_MHPMCOUNTER14H, CSR_MHPMCOUNTER15H, CSR_MHPMCOUNTER16H, CSR_MHPMCOUNTER17H,
      CSR_MHPMCOUNTER18H, CSR_MHPMCOUNTER19H, CSR_MHPMCOUNTER20H, CSR_MHPMCOUNTER21H,
      CSR_MHPMCOUNTER22H, CSR_MHPMCOUNTER23H, CSR_MHPMCOUNTER24H, CSR_MHPMCOUNTER25H,
      CSR_MHPMCOUNTER26H, CSR_MHPMCOUNTER27H, CSR_MHPMCOUNTER28H, CSR_MHPMCOUNTER29H,
      CSR_MHPMCOUNTER30H, CSR_MHPMCOUNTER31H, CSR_CYCLEH, CSR_INSTRETH, CSR_HPMCOUNTER3H,
      CSR_HPMCOUNTER4H,  CSR_HPMCOUNTER5H,  CSR_HPMCOUNTER6H,  CSR_HPMCOUNTER7H, CSR_HPMCOUNTER8H,
      CSR_HPMCOUNTER9H,  CSR_HPMCOUNTER10H, CSR_HPMCOUNTER11H, CSR_HPMCOUNTER12H,
      CSR_HPMCOUNTER13H, CSR_HPMCOUNTER14H, CSR_HPMCOUNTER15H, CSR_HPMCOUNTER16H,
      CSR_HPMCOUNTER17H, CSR_HPMCOUNTER18H, CSR_HPMCOUNTER19H, CSR_HPMCOUNTER20H,
      CSR_HPMCOUNTER21H, CSR_HPMCOUNTER22H, CSR_MHPMCOUNTER23H, CSR_MHPMCOUNTER24H,
      CSR_MHPMCOUNTER25H, CSR_MHPMCOUNTER26H, CSR_MHPMCOUNTER27H, CSR_MHPMCOUNTER28H,
      CSR_MHPMCOUNTER29H, CSR_MHPMCOUNTER30H, CSR_MHPMCOUNTER31H:
      csr_rdata_int = (MHPMCOUNTER_WIDTH == 64) ? mhpmcounter_q[csr_addr_i[4:0]][63:32] : '0;
      CSR_MCOUNTINHIBIT: csr_rdata_int = mcountinhibit_q;
      CSR_MHPMEVENT3,
      CSR_MHPMEVENT4,  CSR_MHPMEVENT5,  CSR_MHPMEVENT6,  CSR_MHPMEVENT7,
      CSR_MHPMEVENT8,  CSR_MHPMEVENT9,  CSR_MHPMEVENT10, CSR_MHPMEVENT11,
      CSR_MHPMEVENT12, CSR_MHPMEVENT13, CSR_MHPMEVENT14, CSR_MHPMEVENT15,
      CSR_MHPMEVENT16, CSR_MHPMEVENT17, CSR_MHPMEVENT18, CSR_MHPMEVENT19,
      CSR_MHPMEVENT20, CSR_MHPMEVENT21, CSR_MHPMEVENT22, CSR_MHPMEVENT23,
      CSR_MHPMEVENT24, CSR_MHPMEVENT25, CSR_MHPMEVENT26, CSR_MHPMEVENT27,
      CSR_MHPMEVENT28, CSR_MHPMEVENT29, CSR_MHPMEVENT30, CSR_MHPMEVENT31:
      csr_rdata_int = mhpmevent_q[csr_addr_i[4:0]];
      default: csr_rdata_int = '0;
    endcase
  end
  always_comb begin
    fflags_n = fflags_q;
    frm_n = frm_q;
    mstatus_fs_n = mstatus_fs_q;
    fcsr_update = 1'b0;
    mscratch_n = mscratch_q;
    mepc_n = mepc_q;
    uepc_n = 'b0;
    depc_n = depc_q;
    dcsr_n = dcsr_q;
    dscratch0_n = dscratch0_q;
    dscratch1_n = dscratch1_q;
    mstatus_we_int = 1'b0;
    mstatus_n = mstatus_q;
    mcause_n = mcause_q;
    ucause_n = '0;
    exception_pc = pc_id_i;
    priv_lvl_n = priv_lvl_q;
    mtvec_n = csr_mtvec_init_i ? mtvec_addr_i[31:8] : mtvec_q;
    utvec_n = '0;
    pmp_reg_n.pmpaddr = '0;
    pmp_reg_n.pmpcfg_packed = '0;
    pmp_reg_n.pmpcfg = '0;
    pmpaddr_we = '0;
    pmpcfg_we = '0;
    mie_n = mie_q;
    mtvec_mode_n = mtvec_mode_q;
    utvec_mode_n = '0;
    if (csr_we_int) begin
      case (csr_addr_i)
        CSR_FFLAGS:
        begin
          fflags_n = csr_wdata_int[C_FFLAG-1:0];
          fcsr_update = 1'b1;
        end
        CSR_FRM:
        begin
          frm_n = csr_wdata_int[C_RM-1:0];
          fcsr_update = 1'b1;
        end
        CSR_FCSR:
        begin
          fflags_n = csr_wdata_int[C_FFLAG-1:0];
          frm_n    = csr_wdata_int[C_RM+C_FFLAG-1:C_FFLAG];
          fcsr_update = 1'b1;
        end
        CSR_MSTATUS:
        begin
          mstatus_n = '{
              uie: csr_wdata_int[MstatusUieBit],
              mie: csr_wdata_int[MstatusMieBit],
              upie: csr_wdata_int[MstatusUpieBit],
              mpie: csr_wdata_int[MstatusMpieBit],
              mpp: priv_lvl_t'(csr_wdata_int[MstatusMppBitHigh:MstatusMppBitLow]),
              mprv: csr_wdata_int[MstatusMprvBit]
          };
          mstatus_we_int = 1'b1;
          mstatus_fs_n = fs_t'(csr_wdata_int[MstatusFsBitHigh:MstatusFsBitLow]);
        end
        CSR_MIE:
        begin
          mie_n = csr_wdata_int & IRQ_MASK;
        end
        CSR_MTVEC:
        begin
          mtvec_n      = csr_wdata_int[31:8];
          mtvec_mode_n = {1'b0, csr_wdata_int[0]};
        end
        CSR_MSCRATCH:
        begin
          mscratch_n = csr_wdata_int;
        end
        CSR_MEPC:
        begin
          mepc_n = csr_wdata_int & ~32'd1;
        end
        CSR_MCAUSE:
        begin
          mcause_n = {csr_wdata_int[31], csr_wdata_int[4:0]};
        end
        CSR_DCSR:
        begin
          dcsr_n.ebreakm   = csr_wdata_int[15];
          dcsr_n.ebreaks   = 1'b0;
          dcsr_n.ebreaku   = 1'b0;
          dcsr_n.stepie    = csr_wdata_int[11];
          dcsr_n.stopcount = 1'b0;
          dcsr_n.stoptime  = 1'b0;
          dcsr_n.mprven    = 1'b0;
          dcsr_n.step      = csr_wdata_int[2];
          dcsr_n.prv       = PRIV_LVL_M;
        end
        CSR_DPC:
        begin
          depc_n = csr_wdata_int & ~32'd1;
        end
        CSR_DSCRATCH0:
        begin
          dscratch0_n = csr_wdata_int;
        end
        CSR_DSCRATCH1:
        begin
          dscratch1_n = csr_wdata_int;
        end
      endcase
    end
    if (fflags_we_i) begin
      fflags_n = fflags_i | fflags_q;
    end
    if ((fregs_we_i && !(mstatus_we_int && mstatus_fs_n != FS_DIRTY))
        || fflags_we_i || fcsr_update)
    begin
      mstatus_fs_n = FS_DIRTY;
    end
    if (csr_save_cause_i) begin
      if (csr_save_if_i) exception_pc = pc_if_i;
      else if (csr_save_id_i) exception_pc = pc_id_i;
      else if (csr_save_ex_i) exception_pc = pc_ex_i;
      if (debug_csr_save_i) begin
        dcsr_n.prv   = PRIV_LVL_M;
        dcsr_n.cause = debug_cause_i;
        depc_n       = exception_pc;
      end else begin
        priv_lvl_n     = PRIV_LVL_M;
        mstatus_n.mpie = mstatus_q.mie;
        mstatus_n.mie  = 1'b0;
        mstatus_n.mpp  = PRIV_LVL_M;
        mepc_n         = exception_pc;
        mcause_n       = csr_cause_i;
      end
    end else if (csr_restore_mret_i) begin
      mstatus_n.mie  = mstatus_q.mpie;
      priv_lvl_n    = PRIV_LVL_M;
      mstatus_n.mpie = 1'b1;
      mstatus_n.mpp  = PRIV_LVL_M;
    end else if (csr_restore_dret_i) begin
      priv_lvl_n = dcsr_q.prv;
    end
  end
  always_comb begin
    csr_wdata_int = csr_wdata_i;
    csr_we_int    = 1'b1;
    case (csr_op_i)
      CSR_OP_WRITE: csr_wdata_int = csr_wdata_i;
      CSR_OP_SET:   csr_wdata_int = csr_wdata_i | csr_rdata_o;
      CSR_OP_CLEAR: csr_wdata_int = (~csr_wdata_i) & csr_rdata_o;
      CSR_OP_READ: begin
        csr_wdata_int = csr_wdata_i;
        csr_we_int    = 1'b0;
      end
    endcase
  end
  assign csr_rdata_o = csr_rdata_int;
  assign m_irq_enable_o = mstatus_q.mie && !(dcsr_q.step && !dcsr_q.stepie);
  assign u_irq_enable_o = mstatus_q.uie && !(dcsr_q.step && !dcsr_q.stepie);
  assign priv_lvl_o = priv_lvl_q;
  assign sec_lvl_o = priv_lvl_q[0];
  assign fs_off_o = (mstatus_fs_q == FS_OFF ? 1'b1 : 1'b0);
  assign frm_o = frm_q;
  assign mtvec_o = mtvec_q;
  assign utvec_o = utvec_q;
  assign mtvec_mode_o = mtvec_mode_q;
  assign utvec_mode_o = utvec_mode_q;
  assign mepc_o = mepc_q;
  assign uepc_o = uepc_q;
  assign mcounteren_o = '0;
  assign depc_o = depc_q;
  assign pmp_addr_o = pmp_reg_q.pmpaddr;
  assign pmp_cfg_o = pmp_reg_q.pmpcfg;
  assign debug_single_step_o = dcsr_q.step;
  assign debug_ebreakm_o = dcsr_q.ebreakm;
  assign debug_ebreaku_o = dcsr_q.ebreaku;
  assign pmp_reg_q = '0;
  assign uepc_q = '0;
  assign ucause_q = '0;
  assign utvec_q = '0;
  assign utvec_mode_q = '0;
  assign priv_lvl_q = PRIV_LVL_M;
  always_ff @(posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
      frm_q <= '0;
      fflags_q <= '0;
      mstatus_fs_q <= FS_CLEAN;
      mstatus_q <= '{
          uie: 1'b0,
          mie: 1'b0,
          upie: 1'b0,
          mpie: 1'b0,
          mpp: PRIV_LVL_M,
          mprv: 1'b0
      };
      mepc_q <= '0;
      mcause_q <= '0;
      depc_q <= '0;
      dcsr_q <= '{
          xdebugver: XDEBUGVER_STD,
          cause: DBG_CAUSE_NONE,
          prv: PRIV_LVL_M,
          default: '0
      };
      dscratch0_q <= '0;
      dscratch1_q <= '0;
      mscratch_q <= '0;
      mie_q <= '0;
      mtvec_q <= '0;
      mtvec_mode_q <= MtvecMode;
    end else begin
      frm_q <= frm_n;
      fflags_q <= fflags_n;
      mstatus_fs_q <= mstatus_fs_n;
      mstatus_q <= '{
          uie: 1'b0,
          mie: mstatus_n.mie,
          upie: 1'b0,
          mpie: mstatus_n.mpie,
          mpp: PRIV_LVL_M,
          mprv: 1'b0
      };
      mepc_q <= mepc_n;
      mcause_q <= mcause_n;
      depc_q <= depc_n;
      dcsr_q <= dcsr_n;
      dscratch0_q <= dscratch0_n;
      dscratch1_q <= dscratch1_n;
      mscratch_q <= mscratch_n;
      mie_q <= mie_n;
      mtvec_q <= mtvec_n;
      mtvec_mode_q <= mtvec_mode_n;
    end
  end
  if (DEBUG_TRIGGER_EN) begin : gen_trigger_regs
    logic        tmatch_control_exec_q;
    logic [31:0] tmatch_value_q;
    logic        tmatch_control_we;
    logic        tmatch_value_we;
    assign tmatch_control_we = csr_we_int & debug_mode_i & (csr_addr_i == CSR_TDATA1);
    assign tmatch_value_we   = csr_we_int & debug_mode_i & (csr_addr_i == CSR_TDATA2);
    always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        tmatch_control_exec_q <= 'b0;
        tmatch_value_q        <= 'b0;
      end else begin
        if (tmatch_control_we) tmatch_control_exec_q <= csr_wdata_int[2];
        if (tmatch_value_we) tmatch_value_q <= csr_wdata_int[31:0];
      end
    end
    assign tinfo_types = 1 << TTYPE_MCONTROL;
    assign tmatch_control_rdata = {
          TTYPE_MCONTROL,
          1'b1,
          6'h00,
          1'b0,
          1'b0,
          1'b0,
          2'b00,
          4'h1,
          1'b0,
          4'h0,
          1'b1,
          1'b0,
          1'b0,
          1'b0,
          tmatch_control_exec_q,
          1'b0,
          1'b0
        };
    assign tmatch_value_rdata = tmatch_value_q;
    assign trigger_match_o = tmatch_control_exec_q & (pc_id_i[31:0] == tmatch_value_q[31:0]);
  end else begin : gen_no_trigger_regs
    assign tinfo_types          = 'b0;
    assign tmatch_control_rdata = 'b0;
    assign tmatch_value_rdata   = 'b0;
    assign trigger_match_o      = 'b0;
  end
  assign hpm_events[0]  = 1'b1;
  assign hpm_events[1]  = mhpmevent_minstret_i;
  assign hpm_events[2]  = mhpmevent_ld_stall_i;
  assign hpm_events[3]  = mhpmevent_jr_stall_i;
  assign hpm_events[4]  = mhpmevent_imiss_i;
  assign hpm_events[5]  = mhpmevent_load_i;
  assign hpm_events[6]  = mhpmevent_store_i;
  assign hpm_events[7]  = mhpmevent_jump_i;
  assign hpm_events[8]  = mhpmevent_branch_i;
  assign hpm_events[9]  = mhpmevent_branch_taken_i;
  assign hpm_events[10] = mhpmevent_compressed_i;
  assign hpm_events[11] = 1'b0;
  assign hpm_events[12] = apu_typeconflict_i && !apu_dep_i;
  assign hpm_events[13] = apu_contention_i;
  assign hpm_events[14] = apu_dep_i && !apu_contention_i;
  assign hpm_events[15] = apu_wb_i;
  logic mcounteren_we;
  logic mcountinhibit_we;
  logic mhpmevent_we;
  assign mcounteren_we = csr_we_int & (csr_addr_i == CSR_MCOUNTEREN);
  assign mcountinhibit_we = csr_we_int & (csr_addr_i == CSR_MCOUNTINHIBIT);
  assign mhpmevent_we = csr_we_int & ((csr_addr_i == CSR_MHPMEVENT3) ||
      (csr_addr_i == CSR_MHPMEVENT4  ) ||
                                      (csr_addr_i == CSR_MHPMEVENT5  ) ||
                                      (csr_addr_i == CSR_MHPMEVENT6  ) ||
                                      (csr_addr_i == CSR_MHPMEVENT7  ) ||
                                      (csr_addr_i == CSR_MHPMEVENT8  ) ||
                                      (csr_addr_i == CSR_MHPMEVENT9  ) ||
                                      (csr_addr_i == CSR_MHPMEVENT10 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT11 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT12 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT13 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT14 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT15 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT16 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT17 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT18 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT19 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT20 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT21 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT22 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT23 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT24 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT25 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT26 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT27 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT28 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT29 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT30 ) ||
                                      (csr_addr_i == CSR_MHPMEVENT31 ) );
  for (genvar incr_gidx = 0; incr_gidx < 32; incr_gidx++) begin : gen_mhpmcounter_increment
    assign mhpmcounter_increment[incr_gidx] = mhpmcounter_q[incr_gidx] + 1;
  end
  always_comb begin
    mcounteren_n    = mcounteren_q;
    mcountinhibit_n = mcountinhibit_q;
    mhpmevent_n     = mhpmevent_q;
    if (mcountinhibit_we) mcountinhibit_n = csr_wdata_int;
    if (mhpmevent_we) mhpmevent_n[csr_addr_i[4:0]] = csr_wdata_int;
  end
  for (genvar wcnt_gidx = 0; wcnt_gidx < 32; wcnt_gidx++) begin : gen_mhpmcounter_write
    assign mhpmcounter_write_lower[wcnt_gidx] = csr_we_int &&
           (csr_addr_i == (CSR_MCYCLE + wcnt_gidx));
    assign mhpmcounter_write_upper[wcnt_gidx] = !mhpmcounter_write_lower[wcnt_gidx] &&
           csr_we_int && (csr_addr_i == (CSR_MCYCLEH + wcnt_gidx)) && (MHPMCOUNTER_WIDTH == 64);
    if (wcnt_gidx == 0) begin : gen_mhpmcounter_mcycle
      assign mhpmcounter_write_increment[wcnt_gidx] = !mhpmcounter_write_lower[wcnt_gidx] &&
             !mhpmcounter_write_upper[wcnt_gidx] &&
             !mcountinhibit_q[wcnt_gidx];
    end else if (wcnt_gidx == 2) begin : gen_mhpmcounter_minstret
      assign mhpmcounter_write_increment[wcnt_gidx] = !mhpmcounter_write_lower[wcnt_gidx] &&
             !mhpmcounter_write_upper[wcnt_gidx] &&
             !mcountinhibit_q[wcnt_gidx] &&
             hpm_events[1];
    end else if ((wcnt_gidx > 2) && (wcnt_gidx < (4))) begin : gen_mhpmcounter
      assign mhpmcounter_write_increment[wcnt_gidx] = !mhpmcounter_write_lower[wcnt_gidx] &&
             !mhpmcounter_write_upper[wcnt_gidx] && !mcountinhibit_q[wcnt_gidx] &&
             |(hpm_events & mhpmevent_q[wcnt_gidx][HmpEvents-1:0]);
    end else begin : gen_mhpmcounter_not_implemented
      assign mhpmcounter_write_increment[wcnt_gidx] = 1'b0;
    end
  end
  for (genvar cnt_gidx = 0; cnt_gidx < 32; cnt_gidx++) begin : gen_mhpmcounter
    if ((cnt_gidx == 1) || (cnt_gidx >= (4))) begin : gen_non_implemented
      assign mhpmcounter_q[cnt_gidx] = 'b0;
    end else begin : gen_implemented
      always_ff @(posedge clk, negedge rst_n)
        if (!rst_n) begin
          mhpmcounter_q[cnt_gidx] <= 'b0;
        end else begin
          if (mhpmcounter_write_lower[cnt_gidx]) begin
            mhpmcounter_q[cnt_gidx][31:0] <= csr_wdata_int;
          end else if (mhpmcounter_write_upper[cnt_gidx]) begin
            mhpmcounter_q[cnt_gidx][63:32] <= csr_wdata_int;
          end else if (mhpmcounter_write_increment[cnt_gidx]) begin
            mhpmcounter_q[cnt_gidx] <= mhpmcounter_increment[cnt_gidx];
          end
        end
    end
  end
  for (genvar evt_gidx = 0; evt_gidx < 32; evt_gidx++) begin : gen_mhpmevent
    if ((evt_gidx < 3) || (evt_gidx >= (4))) begin : gen_non_implemented
      assign mhpmevent_q[evt_gidx] = 'b0;
    end else begin : gen_implemented
      if (HmpEvents < 32) begin : gen_tie_off
        assign mhpmevent_q[evt_gidx][31:HmpEvents] = 'b0;
      end
      always_ff @(posedge clk, negedge rst_n)
        if (!rst_n) mhpmevent_q[evt_gidx][HmpEvents-1:0] <= 'b0;
        else mhpmevent_q[evt_gidx][HmpEvents-1:0] <= mhpmevent_n[evt_gidx][HmpEvents-1:0];
    end
  end
  for (genvar en_gidx = 0; en_gidx < 32; en_gidx++) begin : gen_mcounteren
    assign mcounteren_q[en_gidx] = 'b0;
  end
  for (genvar inh_gidx = 0; inh_gidx < 32; inh_gidx++) begin : gen_mcountinhibit
    if ((inh_gidx == 1) || (inh_gidx >= (4))) begin : gen_non_implemented
      assign mcountinhibit_q[inh_gidx] = 'b0;
    end else begin : gen_implemented
      always_ff @(posedge clk, negedge rst_n)
        if (!rst_n) mcountinhibit_q[inh_gidx] <= 'b1;
        else mcountinhibit_q[inh_gidx] <= mcountinhibit_n[inh_gidx];
    end
  end
endmodule


module single_file_rv32imf_core (
    input logic clk_i,
    input logic rst_ni,
    input logic [31:0] boot_addr_i,
    input logic [31:0] mtvec_addr_i,
    input logic [31:0] dm_halt_addr_i,
    input logic [31:0] hart_id_i,
    input logic [31:0] dm_exception_addr_i,
    output logic        instr_req_o,
    input  logic        instr_gnt_i,
    input  logic        instr_rvalid_i,
    output logic [31:0] instr_addr_o,
    input  logic [31:0] instr_rdata_i,
    output logic        data_req_o,
    input  logic        data_gnt_i,
    input  logic        data_rvalid_i,
    output logic        data_we_o,
    output logic [ 3:0] data_be_o,
    output logic [31:0] data_addr_o,
    output logic [31:0] data_wdata_o,
    input  logic [31:0] data_rdata_i,
    output logic apu_busy_o,
    output logic apu_req_o,
    input  logic apu_gnt_i,
    output logic [ 2:0][31:0] apu_operands_o,
    output logic [ 5:0]       apu_op_o,
    output logic [14:0]       apu_flags_o,
    input logic        apu_rvalid_i,
    input logic [31:0] apu_result_i,
    input logic [ 4:0] apu_flags_i,
    input  logic [31:0] irq_i,
    output logic        irq_ack_o,
    output logic [ 4:0] irq_id_o
);
  import single_file_rv32imf_pkg::*;
  localparam int NumPmpEntries = 16;
  localparam int DebugTriggerEn = 1;
  logic [5:0] data_atop_o;
  logic       irq_sec_i;
  logic       sec_lvl_o;
  localparam int NumHwlp = 2;
  logic        instr_valid_id;
  logic [31:0] instr_rdata_id;
  logic        is_compressed_id;
  logic        illegal_c_insn_id;
  logic        is_fetch_failed_id;
  logic        clear_instr_valid;
  logic        pc_set;
  logic [ 3:0] pc_mux_id;
  logic [ 2:0] exc_pc_mux_id;
  logic [ 4:0] m_exc_vec_pc_mux_id;
  logic [ 4:0] u_exc_vec_pc_mux_id;
  logic [ 4:0] exc_cause;
  logic [ 1:0] trap_addr_mux;
  logic [31:0] pc_if;
  logic [31:0] pc_id;
  logic        is_decoding;
  logic        useincr_addr_ex;
  logic        data_misaligned;
  logic        mult_multicycle;
  logic [31:0] jump_target_id, jump_target_ex;
  logic               branch_in_ex;
  logic               branch_decision;
  logic        [ 1:0] ctrl_transfer_insn_in_dec;
  logic               ctrl_busy;
  logic               if_busy;
  logic               lsu_busy;
  logic        [31:0] pc_ex;
  logic               alu_en_ex;
  alu_opcode_e        alu_operator_ex;
  logic        [31:0] alu_operand_a_ex;
  logic        [31:0] alu_operand_b_ex;
  logic        [31:0] alu_operand_c_ex;
  logic        [ 4:0] bmask_a_ex;
  logic        [ 4:0] bmask_b_ex;
  logic        [ 1:0] imm_vec_ext_ex;
  logic        [ 1:0] alu_vec_mode_ex;
  logic alu_is_clpx_ex, alu_is_subrot_ex;
  logic        [        1:0]       alu_clpx_shift_ex;
  mul_opcode_e                     mult_operator_ex;
  logic        [       31:0]       mult_operand_a_ex;
  logic        [       31:0]       mult_operand_b_ex;
  logic        [       31:0]       mult_operand_c_ex;
  logic                            mult_en_ex;
  logic                            mult_sel_subword_ex;
  logic        [        1:0]       mult_signed_mode_ex;
  logic        [        4:0]       mult_imm_ex;
  logic        [       31:0]       mult_dot_op_a_ex;
  logic        [       31:0]       mult_dot_op_b_ex;
  logic        [       31:0]       mult_dot_op_c_ex;
  logic        [        1:0]       mult_dot_signed_ex;
  logic                            mult_is_clpx_ex;
  logic        [        1:0]       mult_clpx_shift_ex;
  logic                            mult_clpx_img_ex;
  logic                            fs_off;
  logic        [   C_RM-1:0]       frm_csr;
  logic        [C_FFLAG-1:0]       fflags_csr;
  logic                            fflags_we;
  logic                            fregs_we;
  logic        [        5:0]       apu_waddr_ex;
  logic        [       14:0]       apu_flags_ex;
  logic        [        5:0]       apu_op_ex;
  logic        [        1:0]       apu_lat_ex;
  logic        [        2:0][31:0] apu_operands_ex;
  logic        [        2:0][ 5:0] apu_read_regs;
  logic        [        2:0]       apu_read_regs_valid;
  logic                            apu_read_dep;
  logic                            apu_read_dep_for_jalr;
  logic        [        1:0][ 5:0] apu_write_regs;
  logic        [        1:0]       apu_write_regs_valid;
  logic                            apu_write_dep;
  logic                            perf_apu_type;
  logic                            perf_apu_cont;
  logic                            perf_apu_dep;
  logic                            perf_apu_wb;
  logic        [        5:0]       regfile_waddr_ex;
  logic                            regfile_we_ex;
  logic        [        5:0]       regfile_waddr_fw_wb_o;
  logic                            regfile_we_wb;
  logic                            regfile_we_wb_power;
  logic        [       31:0]       regfile_wdata;
  logic        [        5:0]       regfile_alu_waddr_ex;
  logic                            regfile_alu_we_ex;
  logic        [        5:0]       regfile_alu_waddr_fw;
  logic                            regfile_alu_we_fw;
  logic                            regfile_alu_we_fw_power;
  logic        [       31:0]       regfile_alu_wdata_fw;
  logic                            csr_access_ex;
  csr_opcode_e                     csr_op_ex;
  logic [23:0] mtvec, utvec;
  logic        [ 1:0] mtvec_mode;
  logic        [ 1:0] utvec_mode;
  csr_opcode_e        csr_op;
  csr_num_e           csr_addr;
  csr_num_e           csr_addr_int;
  logic        [31:0] csr_rdata;
  logic        [31:0] csr_wdata;
  priv_lvl_t          current_priv_lvl;
  logic               data_we_ex;
  logic        [ 5:0] data_atop_ex;
  logic        [ 1:0] data_type_ex;
  logic        [ 1:0] data_sign_ext_ex;
  logic        [ 1:0] data_reg_offset_ex;
  logic               data_req_ex;
  logic               data_misaligned_ex;
  logic        [31:0] lsu_rdata;
  logic               halt_if;
  logic               id_ready;
  logic               ex_ready;
  logic               id_valid;
  logic               ex_valid;
  logic               wb_valid;
  logic               lsu_ready_ex;
  logic               lsu_ready_wb;
  logic               apu_ready_wb;
  logic               instr_req_int;
  logic m_irq_enable, u_irq_enable;
  logic csr_irq_sec;
  logic [31:0] mepc, uepc, depc;
  logic [             31:0]       mie_bypass;
  logic [             31:0]       mip;
  logic                           csr_save_cause;
  logic                           csr_save_if;
  logic                           csr_save_id;
  logic                           csr_save_ex;
  logic [              5:0]       csr_cause;
  logic                           csr_restore_mret_id;
  logic                           csr_restore_uret_id;
  logic                           csr_restore_dret_id;
  logic                           csr_mtvec_init;
  logic [             31:0]       mcounteren;
  logic                           debug_mode;
  logic [              2:0]       debug_cause;
  logic                           debug_csr_save;
  logic                           debug_single_step;
  logic                           debug_ebreakm;
  logic                           debug_ebreaku;
  logic                           trigger_match;
  logic                           debug_p_elw_no_sleep;
  logic [      NumHwlp-1:0][31:0] hwlp_start;
  logic [      NumHwlp-1:0][31:0] hwlp_end;
  logic [      NumHwlp-1:0][31:0] hwlp_cnt;
  logic [             31:0]       hwlp_target;
  logic                           mhpmevent_minstret;
  logic                           mhpmevent_load;
  logic                           mhpmevent_store;
  logic                           mhpmevent_jump;
  logic                           mhpmevent_branch;
  logic                           mhpmevent_branch_taken;
  logic                           mhpmevent_compressed;
  logic                           mhpmevent_jr_stall;
  logic                           mhpmevent_imiss;
  logic                           mhpmevent_ld_stall;
  logic                           mhpmevent_pipe_stall;
  logic                           perf_imiss;
  logic                           wake_from_sleep;
  logic [NumPmpEntries-1:0][31:0] pmp_addr;
  logic [NumPmpEntries-1:0][ 7:0] pmp_cfg;
  logic                           data_req_pmp;
  logic [             31:0]       data_addr_pmp;
  logic                           data_gnt_pmp;
  logic                           data_err_pmp;
  logic                           data_err_ack;
  logic                           instr_req_pmp;
  logic                           instr_gnt_pmp;
  logic [             31:0]       instr_addr_pmp;
  logic                           instr_err_pmp;
  assign m_exc_vec_pc_mux_id = (mtvec_mode == 2'b0) ? 5'h0 : exc_cause;
  assign u_exc_vec_pc_mux_id = (utvec_mode == 2'b0) ? 5'h0 : exc_cause;
  assign irq_sec_i = 1'b0;
  assign apu_flags_o = apu_flags_ex;
  logic clk;
  logic fetch_enable;
  single_file_rv32imf_sleep_unit #() sleep_unit_i (
      .clk_i      (clk_i),
      .rst_n      (rst_ni),
      .clk_gated_o(clk),
      .fetch_enable_o(fetch_enable),
      .if_busy_i  (if_busy),
      .ctrl_busy_i(ctrl_busy),
      .lsu_busy_i (lsu_busy),
      .apu_busy_i (apu_busy_o),
      .wake_from_sleep_i(wake_from_sleep)
  );
  single_file_rv32imf_if_stage #() if_stage_i (
      .clk  (clk),
      .rst_n(rst_ni),
      .boot_addr_i        (boot_addr_i[31:0]),
      .dm_exception_addr_i(dm_exception_addr_i[31:0]),
      .dm_halt_addr_i(dm_halt_addr_i[31:0]),
      .m_trap_base_addr_i(mtvec),
      .u_trap_base_addr_i(utvec),
      .trap_addr_mux_i   (trap_addr_mux),
      .req_i(instr_req_int),
      .instr_req_o    (instr_req_pmp),
      .instr_addr_o   (instr_addr_pmp),
      .instr_gnt_i    (instr_gnt_pmp),
      .instr_rvalid_i (instr_rvalid_i),
      .instr_rdata_i  (instr_rdata_i),
      .instr_err_i    (1'b0),
      .instr_err_pmp_i(instr_err_pmp),
      .instr_valid_id_o (instr_valid_id),
      .instr_rdata_id_o (instr_rdata_id),
      .is_fetch_failed_o(is_fetch_failed_id),
      .clear_instr_valid_i(clear_instr_valid),
      .pc_set_i           (pc_set),
      .mepc_i(mepc),
      .uepc_i(uepc),
      .depc_i(depc),
      .pc_mux_i    (pc_mux_id),
      .exc_pc_mux_i(exc_pc_mux_id),
      .pc_id_o(pc_id),
      .pc_if_o(pc_if),
      .is_compressed_id_o (is_compressed_id),
      .illegal_c_insn_id_o(illegal_c_insn_id),
      .m_exc_vec_pc_mux_i(m_exc_vec_pc_mux_id),
      .u_exc_vec_pc_mux_i(u_exc_vec_pc_mux_id),
      .csr_mtvec_init_o(csr_mtvec_init),
      .hwlp_target_i(hwlp_target),
      .jump_target_id_i(jump_target_id),
      .jump_target_ex_i(jump_target_ex),
      .halt_if_i (halt_if),
      .id_ready_i(id_ready),
      .if_busy_o   (if_busy),
      .perf_imiss_o(perf_imiss)
  );
  single_file_rv32imf_id_stage #(
      .N_HWLP(NumHwlp)
  ) id_stage_i (
      .clk          (clk),
      .clk_ungated_i(clk_i),
      .rst_n        (rst_ni),
      .ctrl_busy_o  (ctrl_busy),
      .is_decoding_o(is_decoding),
      .instr_valid_i(instr_valid_id),
      .instr_rdata_i(instr_rdata_id),
      .instr_req_o  (instr_req_int),
      .branch_in_ex_o             (branch_in_ex),
      .branch_decision_i          (branch_decision),
      .jump_target_o              (jump_target_id),
      .ctrl_transfer_insn_in_dec_o(ctrl_transfer_insn_in_dec),
      .clear_instr_valid_o(clear_instr_valid),
      .pc_set_o           (pc_set),
      .pc_mux_o           (pc_mux_id),
      .exc_pc_mux_o       (exc_pc_mux_id),
      .exc_cause_o        (exc_cause),
      .trap_addr_mux_o    (trap_addr_mux),
      .is_fetch_failed_i(is_fetch_failed_id),
      .pc_id_i(pc_id),
      .is_compressed_i (is_compressed_id),
      .illegal_c_insn_i(illegal_c_insn_id),
      .halt_if_o(halt_if),
      .id_ready_o(id_ready),
      .ex_ready_i(ex_ready),
      .wb_ready_i(lsu_ready_wb),
      .id_valid_o(id_valid),
      .ex_valid_i(ex_valid),
      .pc_ex_o(pc_ex),
      .alu_en_ex_o        (alu_en_ex),
      .alu_operator_ex_o  (alu_operator_ex),
      .alu_operand_a_ex_o (alu_operand_a_ex),
      .alu_operand_b_ex_o (alu_operand_b_ex),
      .alu_operand_c_ex_o (alu_operand_c_ex),
      .bmask_a_ex_o       (bmask_a_ex),
      .bmask_b_ex_o       (bmask_b_ex),
      .imm_vec_ext_ex_o   (imm_vec_ext_ex),
      .alu_vec_mode_ex_o  (alu_vec_mode_ex),
      .alu_is_clpx_ex_o   (alu_is_clpx_ex),
      .alu_is_subrot_ex_o (alu_is_subrot_ex),
      .alu_clpx_shift_ex_o(alu_clpx_shift_ex),
      .regfile_waddr_ex_o(regfile_waddr_ex),
      .regfile_we_ex_o   (regfile_we_ex),
      .regfile_alu_we_ex_o(regfile_alu_we_ex),
      .regfile_alu_waddr_ex_o(regfile_alu_waddr_ex),
      .mult_operator_ex_o   (mult_operator_ex),
      .mult_en_ex_o         (mult_en_ex),
      .mult_sel_subword_ex_o(mult_sel_subword_ex),
      .mult_signed_mode_ex_o(mult_signed_mode_ex),
      .mult_operand_a_ex_o  (mult_operand_a_ex),
      .mult_operand_b_ex_o  (mult_operand_b_ex),
      .mult_operand_c_ex_o  (mult_operand_c_ex),
      .mult_imm_ex_o        (mult_imm_ex),
      .mult_dot_op_a_ex_o(mult_dot_op_a_ex),
      .mult_dot_op_b_ex_o(mult_dot_op_b_ex),
      .mult_dot_op_c_ex_o(mult_dot_op_c_ex),
      .mult_dot_signed_ex_o(mult_dot_signed_ex),
      .mult_is_clpx_ex_o(mult_is_clpx_ex),
      .mult_clpx_shift_ex_o(mult_clpx_shift_ex),
      .mult_clpx_img_ex_o(mult_clpx_img_ex),
      .fs_off_i(fs_off),
      .frm_i   (frm_csr),
      .apu_en_ex_o      (apu_en_ex),
      .apu_op_ex_o      (apu_op_ex),
      .apu_lat_ex_o     (apu_lat_ex),
      .apu_operands_ex_o(apu_operands_ex),
      .apu_flags_ex_o   (apu_flags_ex),
      .apu_waddr_ex_o   (apu_waddr_ex),
      .apu_read_regs_o        (apu_read_regs),
      .apu_read_regs_valid_o  (apu_read_regs_valid),
      .apu_read_dep_i         (apu_read_dep),
      .apu_read_dep_for_jalr_i(apu_read_dep_for_jalr),
      .apu_write_regs_o       (apu_write_regs),
      .apu_write_regs_valid_o (apu_write_regs_valid),
      .apu_write_dep_i        (apu_write_dep),
      .apu_perf_dep_o         (perf_apu_dep),
      .apu_busy_i             (apu_busy_o),
      .csr_access_ex_o      (csr_access_ex),
      .csr_op_ex_o          (csr_op_ex),
      .current_priv_lvl_i   (current_priv_lvl),
      .csr_irq_sec_o        (csr_irq_sec),
      .csr_cause_o          (csr_cause),
      .csr_save_if_o        (csr_save_if),
      .csr_save_id_o        (csr_save_id),
      .csr_save_ex_o        (csr_save_ex),
      .csr_restore_mret_id_o(csr_restore_mret_id),
      .csr_restore_uret_id_o(csr_restore_uret_id),
      .csr_restore_dret_id_o(csr_restore_dret_id),
      .csr_save_cause_o(csr_save_cause),
      .hwlp_target_o(hwlp_target),
      .data_req_ex_o       (data_req_ex),
      .data_we_ex_o        (data_we_ex),
      .atop_ex_o           (data_atop_ex),
      .data_type_ex_o      (data_type_ex),
      .data_sign_ext_ex_o  (data_sign_ext_ex),
      .data_reg_offset_ex_o(data_reg_offset_ex),
      .data_misaligned_ex_o(data_misaligned_ex),
      .prepost_useincr_ex_o(useincr_addr_ex),
      .data_misaligned_i   (data_misaligned),
      .data_err_i          (data_err_pmp),
      .data_err_ack_o      (data_err_ack),
      .irq_i         (irq_i),
      .irq_sec_i     (1'b0),
      .mie_bypass_i  (mie_bypass),
      .mip_o         (mip),
      .m_irq_enable_i(m_irq_enable),
      .u_irq_enable_i(u_irq_enable),
      .irq_ack_o     (irq_ack_o),
      .irq_id_o      (irq_id_o),
      .debug_mode_o          (debug_mode),
      .debug_cause_o         (debug_cause),
      .debug_csr_save_o      (debug_csr_save),
      .debug_single_step_i   (debug_single_step),
      .debug_ebreakm_i       (debug_ebreakm),
      .debug_ebreaku_i       (debug_ebreaku),
      .trigger_match_i       (trigger_match),
      .debug_p_elw_no_sleep_o(debug_p_elw_no_sleep),
      .wake_from_sleep_o(wake_from_sleep),
      .regfile_waddr_wb_i   (regfile_waddr_fw_wb_o),
      .regfile_we_wb_i      (regfile_we_wb),
      .regfile_we_wb_power_i(regfile_we_wb_power),
      .regfile_wdata_wb_i   (regfile_wdata),
      .regfile_alu_waddr_fw_i   (regfile_alu_waddr_fw),
      .regfile_alu_we_fw_i      (regfile_alu_we_fw),
      .regfile_alu_we_fw_power_i(regfile_alu_we_fw_power),
      .regfile_alu_wdata_fw_i   (regfile_alu_wdata_fw),
      .mult_multicycle_i(mult_multicycle),
      .mhpmevent_minstret_o    (mhpmevent_minstret),
      .mhpmevent_load_o        (mhpmevent_load),
      .mhpmevent_store_o       (mhpmevent_store),
      .mhpmevent_jump_o        (mhpmevent_jump),
      .mhpmevent_branch_o      (mhpmevent_branch),
      .mhpmevent_branch_taken_o(mhpmevent_branch_taken),
      .mhpmevent_compressed_o  (mhpmevent_compressed),
      .mhpmevent_jr_stall_o    (mhpmevent_jr_stall),
      .mhpmevent_imiss_o       (mhpmevent_imiss),
      .mhpmevent_ld_stall_o    (mhpmevent_ld_stall),
      .mhpmevent_pipe_stall_o  (mhpmevent_pipe_stall),
      .perf_imiss_i(perf_imiss),
      .mcounteren_i(mcounteren)
  );
  single_file_rv32imf_ex_stage #() ex_stage_i (
      .clk  (clk),
      .rst_n(rst_ni),
      .alu_en_i        (alu_en_ex),
      .alu_operator_i  (alu_operator_ex),
      .alu_operand_a_i (alu_operand_a_ex),
      .alu_operand_b_i (alu_operand_b_ex),
      .alu_operand_c_i (alu_operand_c_ex),
      .bmask_a_i       (bmask_a_ex),
      .bmask_b_i       (bmask_b_ex),
      .imm_vec_ext_i   (imm_vec_ext_ex),
      .alu_vec_mode_i  (alu_vec_mode_ex),
      .alu_is_clpx_i   (alu_is_clpx_ex),
      .alu_is_subrot_i (alu_is_subrot_ex),
      .alu_clpx_shift_i(alu_clpx_shift_ex),
      .mult_operator_i   (mult_operator_ex),
      .mult_operand_a_i  (mult_operand_a_ex),
      .mult_operand_b_i  (mult_operand_b_ex),
      .mult_operand_c_i  (mult_operand_c_ex),
      .mult_en_i         (mult_en_ex),
      .mult_sel_subword_i(mult_sel_subword_ex),
      .mult_signed_mode_i(mult_signed_mode_ex),
      .mult_imm_i        (mult_imm_ex),
      .mult_dot_op_a_i   (mult_dot_op_a_ex),
      .mult_dot_op_b_i   (mult_dot_op_b_ex),
      .mult_dot_op_c_i   (mult_dot_op_c_ex),
      .mult_dot_signed_i (mult_dot_signed_ex),
      .mult_is_clpx_i    (mult_is_clpx_ex),
      .mult_clpx_shift_i (mult_clpx_shift_ex),
      .mult_clpx_img_i   (mult_clpx_img_ex),
      .mult_multicycle_o(mult_multicycle),
      .data_req_i          (data_req_o),
      .data_rvalid_i       (data_rvalid_i),
      .data_misaligned_ex_i(data_misaligned_ex),
      .data_misaligned_i   (data_misaligned),
      .ctrl_transfer_insn_in_dec_i(ctrl_transfer_insn_in_dec),
      .fpu_fflags_we_o(fflags_we),
      .fpu_fflags_o   (fflags_csr),
      .apu_en_i      (apu_en_ex),
      .apu_op_i      (apu_op_ex),
      .apu_lat_i     (apu_lat_ex),
      .apu_operands_i(apu_operands_ex),
      .apu_waddr_i   (apu_waddr_ex),
      .apu_read_regs_i        (apu_read_regs),
      .apu_read_regs_valid_i  (apu_read_regs_valid),
      .apu_read_dep_o         (apu_read_dep),
      .apu_read_dep_for_jalr_o(apu_read_dep_for_jalr),
      .apu_write_regs_i       (apu_write_regs),
      .apu_write_regs_valid_i (apu_write_regs_valid),
      .apu_write_dep_o        (apu_write_dep),
      .apu_perf_type_o(perf_apu_type),
      .apu_perf_cont_o(perf_apu_cont),
      .apu_perf_wb_o  (perf_apu_wb),
      .apu_ready_wb_o (apu_ready_wb),
      .apu_busy_o     (apu_busy_o),
      .apu_req_o(apu_req_o),
      .apu_gnt_i(apu_gnt_i),
      .apu_operands_o(apu_operands_o),
      .apu_op_o      (apu_op_o),
      .apu_rvalid_i(apu_rvalid_i),
      .apu_result_i(apu_result_i),
      .apu_flags_i (apu_flags_i),
      .lsu_en_i   (data_req_ex),
      .lsu_rdata_i(lsu_rdata),
      .csr_access_i(csr_access_ex),
      .csr_rdata_i (csr_rdata),
      .branch_in_ex_i  (branch_in_ex),
      .regfile_alu_waddr_i(regfile_alu_waddr_ex),
      .regfile_alu_we_i   (regfile_alu_we_ex),
      .regfile_waddr_i(regfile_waddr_ex),
      .regfile_we_i   (regfile_we_ex),
      .regfile_waddr_wb_o   (regfile_waddr_fw_wb_o),
      .regfile_we_wb_o      (regfile_we_wb),
      .regfile_we_wb_power_o(regfile_we_wb_power),
      .regfile_wdata_wb_o   (regfile_wdata),
      .jump_target_o    (jump_target_ex),
      .branch_decision_o(branch_decision),
      .regfile_alu_waddr_fw_o   (regfile_alu_waddr_fw),
      .regfile_alu_we_fw_o      (regfile_alu_we_fw),
      .regfile_alu_we_fw_power_o(regfile_alu_we_fw_power),
      .regfile_alu_wdata_fw_o   (regfile_alu_wdata_fw),
      .is_decoding_i (is_decoding),
      .lsu_ready_ex_i(lsu_ready_ex),
      .lsu_err_i     (data_err_pmp),
      .ex_ready_o(ex_ready),
      .ex_valid_o(ex_valid),
      .wb_ready_i(lsu_ready_wb)
  );
  single_file_rv32imf_load_store_unit #() load_store_unit_i (
      .clk  (clk),
      .rst_n(rst_ni),
      .data_req_o    (data_req_pmp),
      .data_gnt_i    (data_gnt_pmp),
      .data_rvalid_i (data_rvalid_i),
      .data_err_i    (1'b0),
      .data_err_pmp_i(data_err_pmp),
      .data_addr_o (data_addr_pmp),
      .data_we_o   (data_we_o),
      .data_atop_o (data_atop_o),
      .data_be_o   (data_be_o),
      .data_wdata_o(data_wdata_o),
      .data_rdata_i(data_rdata_i),
      .data_we_ex_i        (data_we_ex),
      .data_atop_ex_i      (data_atop_ex),
      .data_type_ex_i      (data_type_ex),
      .data_wdata_ex_i     (alu_operand_c_ex),
      .data_reg_offset_ex_i(data_reg_offset_ex),
      .data_sign_ext_ex_i  (data_sign_ext_ex),
      .data_rdata_ex_o  (lsu_rdata),
      .data_req_ex_i    (data_req_ex),
      .operand_a_ex_i   (alu_operand_a_ex),
      .operand_b_ex_i   (alu_operand_b_ex),
      .addr_useincr_ex_i(useincr_addr_ex),
      .data_misaligned_ex_i(data_misaligned_ex),
      .data_misaligned_o   (data_misaligned),
      .lsu_ready_ex_o(lsu_ready_ex),
      .lsu_ready_wb_o(lsu_ready_wb),
      .busy_o(lsu_busy)
  );
  assign wb_valid = lsu_ready_wb;
  single_file_rv32imf_cs_registers #(
      .N_HWLP          (NumHwlp),
      .N_PMP_ENTRIES   (NumPmpEntries),
      .DEBUG_TRIGGER_EN(DebugTriggerEn)
  ) cs_registers_i (
      .clk  (clk),
      .rst_n(rst_ni),
      .hart_id_i   (hart_id_i),
      .mtvec_o     (mtvec),
      .utvec_o     (utvec),
      .mtvec_mode_o(mtvec_mode),
      .utvec_mode_o(utvec_mode),
      .mtvec_addr_i(mtvec_addr_i[31:0]),
      .csr_mtvec_init_i(csr_mtvec_init),
      .csr_addr_i (csr_addr),
      .csr_wdata_i(csr_wdata),
      .csr_op_i   (csr_op),
      .csr_rdata_o(csr_rdata),
      .fs_off_o   (fs_off),
      .frm_o      (frm_csr),
      .fflags_i   (fflags_csr),
      .fflags_we_i(fflags_we),
      .fregs_we_i (fregs_we),
      .mie_bypass_o  (mie_bypass),
      .mip_i         (mip),
      .m_irq_enable_o(m_irq_enable),
      .u_irq_enable_o(u_irq_enable),
      .csr_irq_sec_i (csr_irq_sec),
      .sec_lvl_o     (sec_lvl_o),
      .mepc_o        (mepc),
      .uepc_o        (uepc),
      .mcounteren_o(mcounteren),
      .debug_mode_i       (debug_mode),
      .debug_cause_i      (debug_cause),
      .debug_csr_save_i   (debug_csr_save),
      .depc_o             (depc),
      .debug_single_step_o(debug_single_step),
      .debug_ebreakm_o    (debug_ebreakm),
      .debug_ebreaku_o    (debug_ebreaku),
      .trigger_match_o    (trigger_match),
      .priv_lvl_o(current_priv_lvl),
      .pmp_addr_o(pmp_addr),
      .pmp_cfg_o (pmp_cfg),
      .pc_if_i(pc_if),
      .pc_id_i(pc_id),
      .pc_ex_i(pc_ex),
      .csr_save_if_i   (csr_save_if),
      .csr_save_id_i   (csr_save_id),
      .csr_save_ex_i   (csr_save_ex),
      .csr_restore_mret_i(csr_restore_mret_id),
      .csr_restore_uret_i(csr_restore_uret_id),
      .csr_restore_dret_i(csr_restore_dret_id),
      .csr_cause_i     (csr_cause),
      .csr_save_cause_i(csr_save_cause),
      .hwlp_start_i(hwlp_start),
      .hwlp_end_i  (hwlp_end),
      .hwlp_cnt_i  (hwlp_cnt),
      .mhpmevent_minstret_i    (mhpmevent_minstret),
      .mhpmevent_load_i        (mhpmevent_load),
      .mhpmevent_store_i       (mhpmevent_store),
      .mhpmevent_jump_i        (mhpmevent_jump),
      .mhpmevent_branch_i      (mhpmevent_branch),
      .mhpmevent_branch_taken_i(mhpmevent_branch_taken),
      .mhpmevent_compressed_i  (mhpmevent_compressed),
      .mhpmevent_jr_stall_i    (mhpmevent_jr_stall),
      .mhpmevent_imiss_i       (mhpmevent_imiss),
      .mhpmevent_ld_stall_i    (mhpmevent_ld_stall),
      .mhpmevent_pipe_stall_i  (mhpmevent_pipe_stall),
      .apu_typeconflict_i      (perf_apu_type),
      .apu_contention_i        (perf_apu_cont),
      .apu_dep_i               (perf_apu_dep),
      .apu_wb_i                (perf_apu_wb)
  );
  assign csr_addr = csr_addr_int;
  assign csr_wdata = alu_operand_a_ex;
  assign csr_op = csr_op_ex;
  assign csr_addr_int = csr_num_e'(csr_access_ex ? alu_operand_b_ex[11:0] : '0);
  assign fregs_we     = ((regfile_alu_we_fw && regfile_alu_waddr_fw[5])
                           || (regfile_we_wb     && regfile_waddr_fw_wb_o[5]));
  assign instr_req_o = instr_req_pmp;
  assign instr_addr_o = instr_addr_pmp;
  assign instr_gnt_pmp = instr_gnt_i;
  assign instr_err_pmp = 1'b0;
  assign data_req_o = data_req_pmp;
  assign data_addr_o = data_addr_pmp;
  assign data_gnt_pmp = data_gnt_i;
  assign data_err_pmp = 1'b0;
endmodule


module single_file_fpnew_classifier #(
    parameter single_file_fpnew_pkg::fp_format_e FpFormat = single_file_fpnew_pkg::fp_format_e'(0),
    parameter int unsigned NumOperands = 1,
    localparam int unsigned WIDTH = single_file_fpnew_pkg::fp_width(FpFormat)
) (
    input logic [NumOperands-1:0][WIDTH-1:0] operands_i,
    input logic [NumOperands-1:0] is_boxed_i,
    output single_file_fpnew_pkg::fp_info_t [NumOperands-1:0] info_o
);
  localparam int unsigned ExpBits = single_file_fpnew_pkg::exp_bits(FpFormat);
  localparam int unsigned ManBits = single_file_fpnew_pkg::man_bits(FpFormat);
  typedef struct packed {
    logic sign;
    logic [ExpBits-1:0] exponent;
    logic [ManBits-1:0] mantissa;
  } fp_t;
  for (genvar op = 0; op < int'(NumOperands); op++) begin : gen_num_values
    fp_t  value;
    logic is_boxed;
    logic is_normal;
    logic is_inf;
    logic is_nan;
    logic is_signalling;
    logic is_quiet;
    logic is_zero;
    logic is_subnormal;
    always_comb begin : classify_input
      value = operands_i[op];
      is_boxed = is_boxed_i[op];
      is_normal = is_boxed && (value.exponent != '0) && (value.exponent != '1);
      is_zero = is_boxed && (value.exponent == '0) && (value.mantissa == '0);
      is_subnormal = is_boxed && (value.exponent == '0) && !is_zero;
      is_inf = is_boxed && ((value.exponent == '1) && (value.mantissa == '0));
      is_nan = !is_boxed || ((value.exponent == '1) && (value.mantissa != '0));
      is_signalling = is_boxed && is_nan && (value.mantissa[ManBits-1] == 1'b0);
      is_quiet = is_nan && !is_signalling;
      info_o[op].is_normal = is_normal;
      info_o[op].is_subnormal = is_subnormal;
      info_o[op].is_zero = is_zero;
      info_o[op].is_inf = is_inf;
      info_o[op].is_nan = is_nan;
      info_o[op].is_signalling = is_signalling;
      info_o[op].is_quiet = is_quiet;
      info_o[op].is_boxed = is_boxed;
    end
  end
endmodule


module single_file_lzc #(
    parameter int unsigned WIDTH = 2,
    parameter bit MODE = 1'b0,
    parameter int unsigned CNT_WIDTH = (WIDTH > 32'd1) ? unsigned'($clog2(WIDTH)) : 32'd1
) (
    input logic [WIDTH-1:0] in_i,
    output logic [CNT_WIDTH-1:0] cnt_o,
    output logic empty_o
);
  if (WIDTH == 1) begin : gen_degenerate_lzc
    assign cnt_o[0] = !in_i[0];
    assign empty_o  = !in_i[0];
  end else begin : gen_lzc
    localparam int unsigned NumLevels = $clog2(WIDTH);
    initial begin
      assert (WIDTH > 0)
      else $fatal(1, "input must be at least one bit wide");
    end
    logic [WIDTH-1:0][NumLevels-1:0] index_lut;
    logic [2**NumLevels-1:0] sel_nodes;
    logic [2**NumLevels-1:0][NumLevels-1:0] index_nodes;
    logic [WIDTH-1:0] in_tmp;
    always_comb begin : flip_vector
      for (int unsigned i = 0; i < WIDTH; i++) begin
        in_tmp[i] = (MODE) ? in_i[WIDTH-1-i] : in_i[i];
      end
    end
    for (genvar j = 0; unsigned'(j) < WIDTH; j++) begin : g_index_lut
      assign index_lut[j] = (NumLevels)'(unsigned'(j));
    end
    for (genvar level = 0; unsigned'(level) < NumLevels; level++) begin : g_levels
      if (unsigned'(level) == NumLevels - 1) begin : g_last_level
        for (genvar k = 0; k < 2 ** level; k++) begin : g_level
          if (unsigned'(k) * 2 < WIDTH - 1) begin : g_reduce
            assign sel_nodes[2**level-1+k] = in_tmp[k*2] | in_tmp[k*2+1];
            assign index_nodes[2 ** level - 1 + k] = (in_tmp[k * 2] == 1'b1)
              ? index_lut[k * 2] :
                index_lut[k * 2 + 1];
          end
          if (unsigned'(k) * 2 == WIDTH - 1) begin : g_base
            assign sel_nodes[2**level-1+k]   = in_tmp[k*2];
            assign index_nodes[2**level-1+k] = index_lut[k*2];
          end
          if (unsigned'(k) * 2 > WIDTH - 1) begin : g_out_of_range
            assign sel_nodes[2**level-1+k]   = 1'b0;
            assign index_nodes[2**level-1+k] = '0;
          end
        end
      end else begin : g_not_last_level
        for (genvar l = 0; l < 2 ** level; l++) begin : g_level
          assign sel_nodes[2 ** level - 1 + l] =
            sel_nodes[2 ** (level + 1) - 1 + l * 2] | sel_nodes[2 ** (level + 1) - 1 + l * 2 + 1];
          assign index_nodes[2 ** level - 1 + l] =
            (sel_nodes[2 ** (level + 1) - 1 + l * 2] == 1'b1)
            ? index_nodes[2 ** (level + 1) - 1 + l * 2] :
              index_nodes[2 ** (level + 1) - 1 + l * 2 + 1];
        end
      end
    end
    assign cnt_o   = NumLevels > unsigned'(0) ? index_nodes[0] : {($clog2(WIDTH)) {1'b0}};
    assign empty_o = NumLevels > unsigned'(0) ? ~sel_nodes[0] : ~(|in_i);
  end : gen_lzc
endmodule

 : single_file_lzc
module single_file_fpnew_rounding #(
    parameter int unsigned AbsWidth = 2
) (
    input logic [AbsWidth-1:0] abs_value_i,
    input logic sign_i,
    input logic [1:0] round_sticky_bits_i,
    input single_file_fpnew_pkg::roundmode_e rnd_mode_i,
    input logic effective_subtraction_i,
    output logic [AbsWidth-1:0] abs_rounded_o,
    output logic sign_o,
    output logic exact_zero_o
);
  logic round_up;
  always_comb begin : rounding_decision
    unique case (rnd_mode_i)
      single_file_fpnew_pkg::RNE:
      unique case (round_sticky_bits_i)
        2'b00, 2'b01: round_up = 1'b0;
        2'b10: round_up = abs_value_i[0];
        2'b11: round_up = 1'b1;
        default: round_up = single_file_fpnew_pkg::DONT_CARE;
      endcase
      single_file_fpnew_pkg::RTZ: round_up = 1'b0;
      single_file_fpnew_pkg::RDN: round_up = (|round_sticky_bits_i) ? sign_i : 1'b0;
      single_file_fpnew_pkg::RUP: round_up = (|round_sticky_bits_i) ? ~sign_i : 1'b0;
      single_file_fpnew_pkg::RMM: round_up = round_sticky_bits_i[1];
      single_file_fpnew_pkg::ROD: round_up = ~abs_value_i[0] & (|round_sticky_bits_i);
      default: round_up = single_file_fpnew_pkg::DONT_CARE;
    endcase
  end
  assign abs_rounded_o = abs_value_i + round_up;
  assign exact_zero_o = (abs_value_i == '0) && (round_sticky_bits_i == '0);
  assign sign_o = (exact_zero_o && effective_subtraction_i)
                    ? (rnd_mode_i == single_file_fpnew_pkg::RDN)
                    : sign_i;
endmodule


module single_file_fpnew_fma_multi #(
    parameter single_file_fpnew_pkg::fmt_logic_t   FpFmtConfig = '1,
    parameter int unsigned             NumPipeRegs = 0,
    parameter single_file_fpnew_pkg::pipe_config_t PipeConfig  = single_file_fpnew_pkg::BEFORE,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,
    localparam int unsigned WIDTH          = single_file_fpnew_pkg::max_fp_width(FpFmtConfig),
    localparam int unsigned NUM_FORMATS    = single_file_fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned ExtRegEnaWidth = NumPipeRegs == 0 ? 1 : NumPipeRegs
) (
    input logic clk_i,
    input logic rst_ni,
    input logic                  [            2:0][WIDTH-1:0] operands_i,
    input logic                  [NUM_FORMATS-1:0][      2:0] is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e                              rnd_mode_i,
    input single_file_fpnew_pkg::operation_e                              op_i,
    input logic                                               op_mod_i,
    input single_file_fpnew_pkg::fp_format_e                              src_fmt_i,
    input single_file_fpnew_pkg::fp_format_e                              dst_fmt_i,
    input TagType                                             tag_i,
    input logic                                               mask_i,
    input AuxType                                             aux_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [WIDTH-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic                           mask_o,
    output AuxType                         aux_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o,
    input logic [ExtRegEnaWidth-1:0] reg_ena_i
);
  localparam single_file_fpnew_pkg::fp_encoding_t SUPER_FORMAT = single_file_fpnew_pkg::super_format(FpFmtConfig);
  localparam int unsigned SUPER_EXP_BITS = SUPER_FORMAT.exp_bits;
  localparam int unsigned SUPER_MAN_BITS = SUPER_FORMAT.man_bits;
  localparam int unsigned PRECISION_BITS = SUPER_MAN_BITS + 1;
  localparam int unsigned LOWER_SUM_WIDTH = 2 * PRECISION_BITS + 3;
  localparam int unsigned LZC_RESULT_WIDTH = $clog2(LOWER_SUM_WIDTH);
  localparam int unsigned EXP_WIDTH = single_file_fpnew_pkg::maximum(SUPER_EXP_BITS + 2, LZC_RESULT_WIDTH);
  localparam int unsigned SHIFT_AMOUNT_WIDTH = $clog2(3 * PRECISION_BITS + 5);
  localparam NUM_INP_REGS = PipeConfig == single_file_fpnew_pkg::BEFORE
                              ? NumPipeRegs
                              : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                                 ? ((NumPipeRegs + 1) / 3)
                                 : 0);
  localparam NUM_MID_REGS = PipeConfig == single_file_fpnew_pkg::INSIDE
                              ? NumPipeRegs
                              : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                                 ? ((NumPipeRegs + 2) / 3)
                                 : 0);
  localparam NUM_OUT_REGS = PipeConfig == single_file_fpnew_pkg::AFTER
                              ? NumPipeRegs
                              : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                                 ? (NumPipeRegs / 3)
                                 : 0);
  typedef struct packed {
    logic                      sign;
    logic [SUPER_EXP_BITS-1:0] exponent;
    logic [SUPER_MAN_BITS-1:0] mantissa;
  } fp_t;
  logic                  [           2:0][      WIDTH-1:0]            operands_q;
  single_file_fpnew_pkg::fp_format_e                                              src_fmt_q;
  single_file_fpnew_pkg::fp_format_e                                              dst_fmt_q;
  logic                  [0:NUM_INP_REGS][            2:0][WIDTH-1:0] inp_pipe_operands_q;
  logic                  [0:NUM_INP_REGS][NUM_FORMATS-1:0][      2:0] inp_pipe_is_boxed_q;
  single_file_fpnew_pkg::roundmode_e [0:NUM_INP_REGS]                             inp_pipe_rnd_mode_q;
  single_file_fpnew_pkg::operation_e [0:NUM_INP_REGS]                             inp_pipe_op_q;
  logic                  [0:NUM_INP_REGS]                             inp_pipe_op_mod_q;
  single_file_fpnew_pkg::fp_format_e [0:NUM_INP_REGS]                             inp_pipe_src_fmt_q;
  single_file_fpnew_pkg::fp_format_e [0:NUM_INP_REGS]                             inp_pipe_dst_fmt_q;
  TagType                [0:NUM_INP_REGS]                             inp_pipe_tag_q;
  logic                  [0:NUM_INP_REGS]                             inp_pipe_mask_q;
  AuxType                [0:NUM_INP_REGS]                             inp_pipe_aux_q;
  logic                  [0:NUM_INP_REGS]                             inp_pipe_valid_q;
  logic                  [0:NUM_INP_REGS]                             inp_pipe_ready;
  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_is_boxed_q[0] = is_boxed_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_op_mod_q[0]   = op_mod_i;
  assign inp_pipe_src_fmt_q[0]  = src_fmt_i;
  assign inp_pipe_dst_fmt_q[0]  = dst_fmt_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;
  assign in_ready_o             = inp_pipe_ready[0];
  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline
    logic reg_ena;
    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        inp_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        inp_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (inp_pipe_ready[i]) ? (inp_pipe_valid_q[i]) : (inp_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (inp_pipe_ready[i] & inp_pipe_valid_q[i]) | reg_ena_i[i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_operands_q[i+1] <= ('0);
      end else begin
        inp_pipe_operands_q[i+1] <= (reg_ena) ? (inp_pipe_operands_q[i]) : (inp_pipe_operands_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_is_boxed_q[i+1] <= ('0);
      end else begin
        inp_pipe_is_boxed_q[i+1] <= (reg_ena) ? (inp_pipe_is_boxed_q[i]) : (inp_pipe_is_boxed_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_rnd_mode_q[i+1] <= (single_file_fpnew_pkg::RNE);
      end else begin
        inp_pipe_rnd_mode_q[i+1] <= (reg_ena) ? (inp_pipe_rnd_mode_q[i]) : (inp_pipe_rnd_mode_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_q[i+1] <= (single_file_fpnew_pkg::FMADD);
      end else begin
        inp_pipe_op_q[i+1] <= (reg_ena) ? (inp_pipe_op_q[i]) : (inp_pipe_op_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_mod_q[i+1] <= ('0);
      end else begin
        inp_pipe_op_mod_q[i+1] <= (reg_ena) ? (inp_pipe_op_mod_q[i]) : (inp_pipe_op_mod_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_src_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        inp_pipe_src_fmt_q[i+1] <= (reg_ena) ? (inp_pipe_src_fmt_q[i]) : (inp_pipe_src_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_dst_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        inp_pipe_dst_fmt_q[i+1] <= (reg_ena) ? (inp_pipe_dst_fmt_q[i]) : (inp_pipe_dst_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        inp_pipe_tag_q[i+1] <= (reg_ena) ? (inp_pipe_tag_q[i]) : (inp_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_mask_q[i+1] <= ('0);
      end else begin
        inp_pipe_mask_q[i+1] <= (reg_ena) ? (inp_pipe_mask_q[i]) : (inp_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        inp_pipe_aux_q[i+1] <= (reg_ena) ? (inp_pipe_aux_q[i]) : (inp_pipe_aux_q[i+1]);
      end
    end
  end
  assign operands_q = inp_pipe_operands_q[NUM_INP_REGS];
  assign src_fmt_q  = inp_pipe_src_fmt_q[NUM_INP_REGS];
  assign dst_fmt_q  = inp_pipe_dst_fmt_q[NUM_INP_REGS];
  logic                [NUM_FORMATS-1:0][2:0]                     fmt_sign;
  logic signed         [NUM_FORMATS-1:0][2:0][SUPER_EXP_BITS-1:0] fmt_exponent;
  logic                [NUM_FORMATS-1:0][2:0][SUPER_MAN_BITS-1:0] fmt_mantissa;
  single_file_fpnew_pkg::fp_info_t [NUM_FORMATS-1:0][2:0]                     info_q;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : fmt_init_inputs
    localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    if (FpFmtConfig[fmt]) begin : active_format
      logic [2:0][FP_WIDTH-1:0] trimmed_ops;
      single_file_fpnew_classifier #(
          .FpFormat   (single_file_fpnew_pkg::fp_format_e'(fmt)),
          .NumOperands(3)
      ) i_fpnew_classifier (
          .operands_i(trimmed_ops),
          .is_boxed_i(inp_pipe_is_boxed_q[NUM_INP_REGS][fmt]),
          .info_o    (info_q[fmt])
      );
      for (genvar op = 0; op < 3; op++) begin : gen_operands
        assign trimmed_ops[op] = operands_q[op][FP_WIDTH-1:0];
        assign fmt_sign[fmt][op] = operands_q[op][FP_WIDTH-1];
        assign fmt_exponent[fmt][op] = signed'({1'b0, operands_q[op][MAN_BITS+:EXP_BITS]});
        assign fmt_mantissa[fmt][op] = {info_q[fmt][op].is_normal, operands_q[op][MAN_BITS-1:0]} <<
                                         (SUPER_MAN_BITS - MAN_BITS);
      end
    end else begin : inactive_format
      assign info_q[fmt]       = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_sign[fmt]     = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_exponent[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_mantissa[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  fp_t operand_a, operand_b, operand_c;
  single_file_fpnew_pkg::fp_info_t info_a, info_b, info_c;
  always_comb begin : op_select
    operand_a = {fmt_sign[src_fmt_q][0], fmt_exponent[src_fmt_q][0], fmt_mantissa[src_fmt_q][0]};
    operand_b = {fmt_sign[src_fmt_q][1], fmt_exponent[src_fmt_q][1], fmt_mantissa[src_fmt_q][1]};
    operand_c = {fmt_sign[dst_fmt_q][2], fmt_exponent[dst_fmt_q][2], fmt_mantissa[dst_fmt_q][2]};
    info_a = info_q[src_fmt_q][0];
    info_b = info_q[src_fmt_q][1];
    info_c = info_q[dst_fmt_q][2];
    operand_c.sign = operand_c.sign ^ inp_pipe_op_mod_q[NUM_INP_REGS];
    unique case (inp_pipe_op_q[NUM_INP_REGS])
      single_file_fpnew_pkg::FMADD:  ;
      single_file_fpnew_pkg::FNMSUB: operand_a.sign = ~operand_a.sign;
      single_file_fpnew_pkg::ADD: begin
        operand_a = '{sign: 1'b0, exponent: single_file_fpnew_pkg::bias(src_fmt_q), mantissa: '0};
        info_a    = '{is_normal: 1'b1, is_boxed: 1'b1, default: 1'b0};
      end
      single_file_fpnew_pkg::MUL: begin
        if (inp_pipe_rnd_mode_q[NUM_INP_REGS] == single_file_fpnew_pkg::RDN)
          operand_c = '{sign: 1'b0, exponent: '0, mantissa: '0};
        else operand_c = '{sign: 1'b1, exponent: '0, mantissa: '0};
        info_c = '{is_zero: 1'b1, is_boxed: 1'b1, default: 1'b0};
      end
      default: begin
        operand_a = '{default: single_file_fpnew_pkg::DONT_CARE};
        operand_b = '{default: single_file_fpnew_pkg::DONT_CARE};
        operand_c = '{default: single_file_fpnew_pkg::DONT_CARE};
        info_a    = '{default: single_file_fpnew_pkg::DONT_CARE};
        info_b    = '{default: single_file_fpnew_pkg::DONT_CARE};
        info_c    = '{default: single_file_fpnew_pkg::DONT_CARE};
      end
    endcase
  end
  logic any_operand_inf;
  logic any_operand_nan;
  logic signalling_nan;
  logic effective_subtraction;
  logic tentative_sign;
  assign any_operand_inf = (|{info_a.is_inf, info_b.is_inf, info_c.is_inf});
  assign any_operand_nan = (|{info_a.is_nan, info_b.is_nan, info_c.is_nan});
  assign signalling_nan = (|{info_a.is_signalling, info_b.is_signalling, info_c.is_signalling});
  assign effective_subtraction = operand_a.sign ^ operand_b.sign ^ operand_c.sign;
  assign tentative_sign = operand_a.sign ^ operand_b.sign;
  logic               [      WIDTH-1:0]            special_result;
  single_file_fpnew_pkg::status_t                              special_status;
  logic                                            result_is_special;
  logic               [NUM_FORMATS-1:0][WIDTH-1:0] fmt_special_result;
  single_file_fpnew_pkg::status_t [NUM_FORMATS-1:0]            fmt_special_status;
  logic               [NUM_FORMATS-1:0]            fmt_result_is_special;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_special_results
    localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam logic [EXP_BITS-1:0] QNAN_EXPONENT = '1;
    localparam logic [MAN_BITS-1:0] QNAN_MANTISSA = 2 ** (MAN_BITS - 1);
    localparam logic [MAN_BITS-1:0] ZERO_MANTISSA = '0;
    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : special_results
        logic [FP_WIDTH-1:0] special_res;
        special_res                = {1'b0, QNAN_EXPONENT, QNAN_MANTISSA};
        fmt_special_status[fmt]    = '0;
        fmt_result_is_special[fmt] = 1'b0;
        if ((info_a.is_inf && info_b.is_zero) || (info_a.is_zero && info_b.is_inf)) begin
          fmt_result_is_special[fmt] = 1'b1;
          fmt_special_status[fmt].NV = 1'b1;
        end else if (any_operand_nan) begin
          fmt_result_is_special[fmt] = 1'b1;
          fmt_special_status[fmt].NV = signalling_nan;
        end else if (any_operand_inf) begin
          fmt_result_is_special[fmt] = 1'b1;
          if ((info_a.is_inf || info_b.is_inf) && info_c.is_inf && effective_subtraction)
            fmt_special_status[fmt].NV = 1'b1;
          else if (info_a.is_inf || info_b.is_inf) begin
            special_res = {operand_a.sign ^ operand_b.sign, QNAN_EXPONENT, ZERO_MANTISSA};
          end else if (info_c.is_inf) begin
            special_res = {operand_c.sign, QNAN_EXPONENT, ZERO_MANTISSA};
          end
        end
        fmt_special_result[fmt]               = '1;
        fmt_special_result[fmt][FP_WIDTH-1:0] = special_res;
      end
    end else begin : inactive_format
      assign fmt_special_result[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_special_status[fmt] = '0;
      assign fmt_result_is_special[fmt] = 1'b0;
    end
  end
  assign result_is_special = fmt_result_is_special[dst_fmt_q];
  assign special_status = fmt_special_status[dst_fmt_q];
  assign special_result = fmt_special_result[dst_fmt_q];
  logic signed [EXP_WIDTH-1:0] exponent_a, exponent_b, exponent_c;
  logic signed [EXP_WIDTH-1:0] exponent_addend, exponent_product, exponent_difference;
  logic signed [EXP_WIDTH-1:0] tentative_exponent;
  assign exponent_a = signed'({1'b0, operand_a.exponent});
  assign exponent_b = signed'({1'b0, operand_b.exponent});
  assign exponent_c = signed'({1'b0, operand_c.exponent});
  assign exponent_addend = signed'(exponent_c + $signed({1'b0, ~info_c.is_normal}));
  assign exponent_product = (info_a.is_zero || info_b.is_zero) ? 2 - signed'(single_file_fpnew_pkg::bias(
      dst_fmt_q
  )) : signed'(exponent_a + info_a.is_subnormal + exponent_b + info_b.is_subnormal -
               2 * signed'(single_file_fpnew_pkg::bias(
      src_fmt_q
  )) + signed'(single_file_fpnew_pkg::bias(
      dst_fmt_q
  )));
  assign exponent_difference = exponent_addend - exponent_product;
  assign tentative_exponent = (exponent_difference > 0) ? exponent_addend : exponent_product;
  logic [SHIFT_AMOUNT_WIDTH-1:0] addend_shamt;
  always_comb begin : addend_shift_amount
    if (exponent_difference <= signed'(-2 * PRECISION_BITS - 1))
      addend_shamt = 3 * PRECISION_BITS + 4;
    else if (exponent_difference <= signed'(PRECISION_BITS + 2))
      addend_shamt = unsigned'(signed'(PRECISION_BITS) + 3 - exponent_difference);
    else
      addend_shamt = 0;
  end
  logic [PRECISION_BITS-1:0] mantissa_a, mantissa_b, mantissa_c;
  logic [2*PRECISION_BITS-1:0] product;
  logic [3*PRECISION_BITS+3:0] product_shifted;
  assign mantissa_a = {info_a.is_normal, operand_a.mantissa};
  assign mantissa_b = {info_b.is_normal, operand_b.mantissa};
  assign mantissa_c = {info_c.is_normal, operand_c.mantissa};
  assign product = mantissa_a * mantissa_b;
  assign product_shifted = product << 2;
  logic [3*PRECISION_BITS+3:0] addend_after_shift;
  logic [  PRECISION_BITS-1:0] addend_sticky_bits;
  logic                        sticky_before_add;
  logic [3*PRECISION_BITS+3:0] addend_shifted;
  logic                        inject_carry_in;
  assign {addend_after_shift, addend_sticky_bits} =
      (mantissa_c << (3 * PRECISION_BITS + 4)) >> addend_shamt;
  assign sticky_before_add = (|addend_sticky_bits);
  assign addend_shifted = (effective_subtraction) ? ~addend_after_shift : addend_after_shift;
  assign inject_carry_in = effective_subtraction & ~sticky_before_add;
  logic [3*PRECISION_BITS+4:0] sum_raw;
  logic                        sum_carry;
  logic [3*PRECISION_BITS+3:0] sum;
  logic                        final_sign;
  assign sum_raw = product_shifted + addend_shifted + inject_carry_in;
  assign sum_carry = sum_raw[3*PRECISION_BITS+4];
  assign sum = (effective_subtraction && ~sum_carry) ? -sum_raw : sum_raw;
  assign final_sign = (effective_subtraction && (sum_carry == tentative_sign))
                      ? 1'b1
                      : (effective_subtraction ? 1'b0 : tentative_sign);
  logic                  [0:NUM_MID_REGS]                         mid_pipe_eff_sub_q;
  logic signed           [0:NUM_MID_REGS][         EXP_WIDTH-1:0] mid_pipe_exp_prod_q;
  logic signed           [0:NUM_MID_REGS][         EXP_WIDTH-1:0] mid_pipe_exp_diff_q;
  logic signed           [0:NUM_MID_REGS][         EXP_WIDTH-1:0] mid_pipe_tent_exp_q;
  logic                  [0:NUM_MID_REGS][SHIFT_AMOUNT_WIDTH-1:0] mid_pipe_add_shamt_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_sticky_q;
  logic                  [0:NUM_MID_REGS][  3*PRECISION_BITS+3:0] mid_pipe_sum_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_final_sign_q;
  single_file_fpnew_pkg::roundmode_e [0:NUM_MID_REGS]                         mid_pipe_rnd_mode_q;
  single_file_fpnew_pkg::fp_format_e [0:NUM_MID_REGS]                         mid_pipe_dst_fmt_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_res_is_spec_q;
  fp_t                   [0:NUM_MID_REGS]                         mid_pipe_spec_res_q;
  single_file_fpnew_pkg::status_t    [0:NUM_MID_REGS]                         mid_pipe_spec_stat_q;
  TagType                [0:NUM_MID_REGS]                         mid_pipe_tag_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_mask_q;
  AuxType                [0:NUM_MID_REGS]                         mid_pipe_aux_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_valid_q;
  logic                  [0:NUM_MID_REGS]                         mid_pipe_ready;
  assign mid_pipe_eff_sub_q[0]        = effective_subtraction;
  assign mid_pipe_exp_prod_q[0]       = exponent_product;
  assign mid_pipe_exp_diff_q[0]       = exponent_difference;
  assign mid_pipe_tent_exp_q[0]       = tentative_exponent;
  assign mid_pipe_add_shamt_q[0]      = addend_shamt;
  assign mid_pipe_sticky_q[0]         = sticky_before_add;
  assign mid_pipe_sum_q[0]            = sum;
  assign mid_pipe_final_sign_q[0]     = final_sign;
  assign mid_pipe_rnd_mode_q[0]       = inp_pipe_rnd_mode_q[NUM_INP_REGS];
  assign mid_pipe_dst_fmt_q[0]        = dst_fmt_q;
  assign mid_pipe_res_is_spec_q[0]    = result_is_special;
  assign mid_pipe_spec_res_q[0]       = special_result;
  assign mid_pipe_spec_stat_q[0]      = special_status;
  assign mid_pipe_tag_q[0]            = inp_pipe_tag_q[NUM_INP_REGS];
  assign mid_pipe_mask_q[0]           = inp_pipe_mask_q[NUM_INP_REGS];
  assign mid_pipe_aux_q[0]            = inp_pipe_aux_q[NUM_INP_REGS];
  assign mid_pipe_valid_q[0]          = inp_pipe_valid_q[NUM_INP_REGS];
  assign inp_pipe_ready[NUM_INP_REGS] = mid_pipe_ready[0];
  for (genvar i = 0; i < NUM_MID_REGS; i++) begin : gen_inside_pipeline
    logic reg_ena;
    assign mid_pipe_ready[i] = mid_pipe_ready[i+1] | ~mid_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        mid_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        mid_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (mid_pipe_ready[i]) ? (mid_pipe_valid_q[i]) : (mid_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (mid_pipe_ready[i] & mid_pipe_valid_q[i]) | reg_ena_i[NUM_INP_REGS+i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_eff_sub_q[i+1] <= ('0);
      end else begin
        mid_pipe_eff_sub_q[i+1] <= (reg_ena) ? (mid_pipe_eff_sub_q[i]) : (mid_pipe_eff_sub_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_exp_prod_q[i+1] <= ('0);
      end else begin
        mid_pipe_exp_prod_q[i+1] <= (reg_ena) ? (mid_pipe_exp_prod_q[i]) : (mid_pipe_exp_prod_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_exp_diff_q[i+1] <= ('0);
      end else begin
        mid_pipe_exp_diff_q[i+1] <= (reg_ena) ? (mid_pipe_exp_diff_q[i]) : (mid_pipe_exp_diff_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_tent_exp_q[i+1] <= ('0);
      end else begin
        mid_pipe_tent_exp_q[i+1] <= (reg_ena) ? (mid_pipe_tent_exp_q[i]) : (mid_pipe_tent_exp_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_add_shamt_q[i+1] <= ('0);
      end else begin
        mid_pipe_add_shamt_q[i+1] <= (reg_ena) ? (mid_pipe_add_shamt_q[i]) : (mid_pipe_add_shamt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_sticky_q[i+1] <= ('0);
      end else begin
        mid_pipe_sticky_q[i+1] <= (reg_ena) ? (mid_pipe_sticky_q[i]) : (mid_pipe_sticky_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_sum_q[i+1] <= ('0);
      end else begin
        mid_pipe_sum_q[i+1] <= (reg_ena) ? (mid_pipe_sum_q[i]) : (mid_pipe_sum_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_final_sign_q[i+1] <= ('0);
      end else begin
        mid_pipe_final_sign_q[i+1] <= (reg_ena) ? (mid_pipe_final_sign_q[i]) : (mid_pipe_final_sign_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_rnd_mode_q[i+1] <= (single_file_fpnew_pkg::RNE);
      end else begin
        mid_pipe_rnd_mode_q[i+1] <= (reg_ena) ? (mid_pipe_rnd_mode_q[i]) : (mid_pipe_rnd_mode_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_dst_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        mid_pipe_dst_fmt_q[i+1] <= (reg_ena) ? (mid_pipe_dst_fmt_q[i]) : (mid_pipe_dst_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_res_is_spec_q[i+1] <= ('0);
      end else begin
        mid_pipe_res_is_spec_q[i+1] <= (reg_ena) ? (mid_pipe_res_is_spec_q[i]) : (mid_pipe_res_is_spec_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_spec_res_q[i+1] <= ('0);
      end else begin
        mid_pipe_spec_res_q[i+1] <= (reg_ena) ? (mid_pipe_spec_res_q[i]) : (mid_pipe_spec_res_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_spec_stat_q[i+1] <= ('0);
      end else begin
        mid_pipe_spec_stat_q[i+1] <= (reg_ena) ? (mid_pipe_spec_stat_q[i]) : (mid_pipe_spec_stat_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        mid_pipe_tag_q[i+1] <= (reg_ena) ? (mid_pipe_tag_q[i]) : (mid_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_mask_q[i+1] <= ('0);
      end else begin
        mid_pipe_mask_q[i+1] <= (reg_ena) ? (mid_pipe_mask_q[i]) : (mid_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        mid_pipe_aux_q[i+1] <= (reg_ena) ? (mid_pipe_aux_q[i]) : (mid_pipe_aux_q[i+1]);
      end
    end
  end
  logic                                           effective_subtraction_q;
  logic signed           [         EXP_WIDTH-1:0] exponent_product_q;
  logic signed           [         EXP_WIDTH-1:0] exponent_difference_q;
  logic signed           [         EXP_WIDTH-1:0] tentative_exponent_q;
  logic                  [SHIFT_AMOUNT_WIDTH-1:0] addend_shamt_q;
  logic                                           sticky_before_add_q;
  logic                  [  3*PRECISION_BITS+3:0] sum_q;
  logic                                           final_sign_q;
  single_file_fpnew_pkg::fp_format_e                          dst_fmt_q2;
  single_file_fpnew_pkg::roundmode_e                          rnd_mode_q;
  logic                                           result_is_special_q;
  fp_t                                            special_result_q;
  single_file_fpnew_pkg::status_t                             special_status_q;
  assign effective_subtraction_q = mid_pipe_eff_sub_q[NUM_MID_REGS];
  assign exponent_product_q      = mid_pipe_exp_prod_q[NUM_MID_REGS];
  assign exponent_difference_q   = mid_pipe_exp_diff_q[NUM_MID_REGS];
  assign tentative_exponent_q    = mid_pipe_tent_exp_q[NUM_MID_REGS];
  assign addend_shamt_q          = mid_pipe_add_shamt_q[NUM_MID_REGS];
  assign sticky_before_add_q     = mid_pipe_sticky_q[NUM_MID_REGS];
  assign sum_q                   = mid_pipe_sum_q[NUM_MID_REGS];
  assign final_sign_q            = mid_pipe_final_sign_q[NUM_MID_REGS];
  assign rnd_mode_q              = mid_pipe_rnd_mode_q[NUM_MID_REGS];
  assign dst_fmt_q2              = mid_pipe_dst_fmt_q[NUM_MID_REGS];
  assign result_is_special_q     = mid_pipe_res_is_spec_q[NUM_MID_REGS];
  assign special_result_q        = mid_pipe_spec_res_q[NUM_MID_REGS];
  assign special_status_q        = mid_pipe_spec_stat_q[NUM_MID_REGS];
  logic        [   LOWER_SUM_WIDTH-1:0] sum_lower;
  logic        [  LZC_RESULT_WIDTH-1:0] leading_zero_count;
  logic signed [    LZC_RESULT_WIDTH:0] leading_zero_count_sgn;
  logic                                 lzc_zeroes;
  logic        [SHIFT_AMOUNT_WIDTH-1:0] norm_shamt;
  logic signed [         EXP_WIDTH-1:0] normalized_exponent;
  logic        [  3*PRECISION_BITS+4:0] sum_shifted;
  logic        [      PRECISION_BITS:0] final_mantissa;
  logic        [  2*PRECISION_BITS+2:0] sum_sticky_bits;
  logic                                 sticky_after_norm;
  logic signed [         EXP_WIDTH-1:0] final_exponent;
  assign sum_lower = sum_q[LOWER_SUM_WIDTH-1:0];
  single_file_lzc #(
      .WIDTH(LOWER_SUM_WIDTH),
      .MODE (1)
  ) i_lzc (
      .in_i   (sum_lower),
      .cnt_o  (leading_zero_count),
      .empty_o(lzc_zeroes)
  );
  assign leading_zero_count_sgn = signed'({1'b0, leading_zero_count});
  always_comb begin : norm_shift_amount
    if ((exponent_difference_q <= 0) || (effective_subtraction_q && (exponent_difference_q <= 2))) begin
      if ((exponent_product_q - leading_zero_count_sgn + 1 >= 0) && !lzc_zeroes) begin
        norm_shamt          = PRECISION_BITS + 2 + leading_zero_count;
        normalized_exponent = exponent_product_q - leading_zero_count_sgn + 1;
      end else begin
        norm_shamt          = unsigned'(signed'(PRECISION_BITS + 2 + exponent_product_q));
        normalized_exponent = 0;
      end
    end else begin
      norm_shamt          = addend_shamt_q;
      normalized_exponent = tentative_exponent_q;
    end
  end
  assign sum_shifted = sum_q << norm_shamt;
  always_comb begin : small_norm
    {final_mantissa, sum_sticky_bits} = sum_shifted;
    final_exponent                    = normalized_exponent;
    if (sum_shifted[3*PRECISION_BITS+4]) begin
      {final_mantissa, sum_sticky_bits} = sum_shifted >> 1;
      final_exponent                    = normalized_exponent + 1;
    end else if (sum_shifted[3*PRECISION_BITS+3]) begin
    end else if (normalized_exponent > 1) begin
      {final_mantissa, sum_sticky_bits} = sum_shifted << 1;
      final_exponent                    = normalized_exponent - 1;
    end else begin
      final_exponent = '0;
    end
  end
  assign sticky_after_norm = (|{sum_sticky_bits}) | sticky_before_add_q;
  logic                                     pre_round_sign;
  logic [SUPER_EXP_BITS+SUPER_MAN_BITS-1:0] pre_round_abs;
  logic [                              1:0] round_sticky_bits;
  logic of_before_round, of_after_round;
  logic uf_before_round, uf_after_round;
  logic [NUM_FORMATS-1:0][SUPER_EXP_BITS+SUPER_MAN_BITS-1:0] fmt_pre_round_abs;
  logic [NUM_FORMATS-1:0][1:0] fmt_round_sticky_bits;
  logic [NUM_FORMATS-1:0] fmt_of_after_round;
  logic [NUM_FORMATS-1:0] fmt_uf_after_round;
  logic rounded_sign;
  logic [SUPER_EXP_BITS+SUPER_MAN_BITS-1:0] rounded_abs;
  logic result_zero;
  assign of_before_round = final_exponent >= 2 ** (single_file_fpnew_pkg::exp_bits(dst_fmt_q2)) - 1;
  assign uf_before_round = final_exponent == 0;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_res_assemble
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    logic [EXP_BITS-1:0] pre_round_exponent;
    logic [MAN_BITS-1:0] pre_round_mantissa;
    if (FpFmtConfig[fmt]) begin : active_format
      assign pre_round_exponent = (of_before_round) ? 2**EXP_BITS-2 : final_exponent[EXP_BITS-1:0];
      assign pre_round_mantissa = (of_before_round) ? '1 : final_mantissa[SUPER_MAN_BITS-:MAN_BITS];
      assign fmt_pre_round_abs[fmt] = {pre_round_exponent, pre_round_mantissa};
      assign fmt_round_sticky_bits[fmt][1] = final_mantissa[SUPER_MAN_BITS-MAN_BITS] |
                                               of_before_round;
      if (MAN_BITS < SUPER_MAN_BITS) begin : narrow_sticky
        assign fmt_round_sticky_bits[fmt][0] = (| final_mantissa[SUPER_MAN_BITS-MAN_BITS-1:0]) |
                                                 sticky_after_norm | of_before_round;
      end else begin : normal_sticky
        assign fmt_round_sticky_bits[fmt][0] = sticky_after_norm | of_before_round;
      end
    end else begin : inactive_format
      assign fmt_pre_round_abs[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_round_sticky_bits[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign pre_round_sign   = final_sign_q;
  assign pre_round_abs    = fmt_pre_round_abs[dst_fmt_q2];
  assign round_sticky_bits = fmt_round_sticky_bits[dst_fmt_q2];
  single_file_fpnew_rounding #(
      .AbsWidth(SUPER_EXP_BITS + SUPER_MAN_BITS)
  ) i_fpnew_rounding (
      .abs_value_i            (pre_round_abs),
      .sign_i                 (pre_round_sign),
      .round_sticky_bits_i    (round_sticky_bits),
      .rnd_mode_i             (rnd_mode_q),
      .effective_subtraction_i(effective_subtraction_q),
      .abs_rounded_o          (rounded_abs),
      .sign_o                 (rounded_sign),
      .exact_zero_o           (result_zero)
  );
  logic [NUM_FORMATS-1:0][WIDTH-1:0] fmt_result;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_sign_inject
    localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : post_process
        fmt_uf_after_round[fmt] = (rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '0)
        || ((pre_round_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '0) && (rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == 1) &&
            ((round_sticky_bits != 2'b11) || (!sum_sticky_bits[MAN_BITS*2 + 4] && ((rnd_mode_i == single_file_fpnew_pkg::RNE) || (rnd_mode_i == single_file_fpnew_pkg::RMM)))));
        fmt_of_after_round[fmt] = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '1;
        fmt_result[fmt] = '1;
        fmt_result[fmt][FP_WIDTH-1:0] = {rounded_sign, rounded_abs[EXP_BITS+MAN_BITS-1:0]};
      end
    end else begin : inactive_format
      assign fmt_uf_after_round[fmt] = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_of_after_round[fmt] = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_result[fmt]         = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign uf_after_round = fmt_uf_after_round[dst_fmt_q2];
  assign of_after_round = fmt_of_after_round[dst_fmt_q2];
  logic               [WIDTH-1:0] regular_result;
  single_file_fpnew_pkg::status_t             regular_status;
  assign regular_result = fmt_result[dst_fmt_q2];
  assign regular_status.NV = 1'b0;
  assign regular_status.DZ = 1'b0;
  assign regular_status.OF = of_before_round | of_after_round;
  assign regular_status.UF = uf_after_round & regular_status.NX;
  assign regular_status.NX = (|round_sticky_bits) | of_before_round | of_after_round;
  logic               [WIDTH-1:0] result_d;
  single_file_fpnew_pkg::status_t             status_d;
  assign result_d = result_is_special_q ? special_result_q : regular_result;
  assign status_d = result_is_special_q ? special_status_q : regular_status;
  logic               [0:NUM_OUT_REGS][WIDTH-1:0] out_pipe_result_q;
  single_file_fpnew_pkg::status_t [0:NUM_OUT_REGS]            out_pipe_status_q;
  TagType             [0:NUM_OUT_REGS]            out_pipe_tag_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_mask_q;
  AuxType             [0:NUM_OUT_REGS]            out_pipe_aux_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_valid_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_ready;
  assign out_pipe_result_q[0] = result_d;
  assign out_pipe_status_q[0] = status_d;
  assign out_pipe_tag_q[0]    = mid_pipe_tag_q[NUM_MID_REGS];
  assign out_pipe_mask_q[0]   = mid_pipe_mask_q[NUM_MID_REGS];
  assign out_pipe_aux_q[0]    = mid_pipe_aux_q[NUM_MID_REGS];
  assign out_pipe_valid_q[0]  = mid_pipe_valid_q[NUM_MID_REGS];
  assign mid_pipe_ready[NUM_MID_REGS] = out_pipe_ready[0];
  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline
    logic reg_ena;
    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        out_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        out_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (out_pipe_ready[i]) ? (out_pipe_valid_q[i]) : (out_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (out_pipe_ready[i] & out_pipe_valid_q[i]) | reg_ena_i[NUM_INP_REGS + NUM_MID_REGS + i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_result_q[i+1] <= ('0);
      end else begin
        out_pipe_result_q[i+1] <= (reg_ena) ? (out_pipe_result_q[i]) : (out_pipe_result_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_status_q[i+1] <= ('0);
      end else begin
        out_pipe_status_q[i+1] <= (reg_ena) ? (out_pipe_status_q[i]) : (out_pipe_status_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        out_pipe_tag_q[i+1] <= (reg_ena) ? (out_pipe_tag_q[i]) : (out_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_mask_q[i+1] <= ('0);
      end else begin
        out_pipe_mask_q[i+1] <= (reg_ena) ? (out_pipe_mask_q[i]) : (out_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        out_pipe_aux_q[i+1] <= (reg_ena) ? (out_pipe_aux_q[i]) : (out_pipe_aux_q[i+1]);
      end
    end
  end
  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;
  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = 1'b1;
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, mid_pipe_valid_q, out_pipe_valid_q});
endmodule


module single_file_fpnew_opgroup_multifmt_slice #(
    parameter single_file_fpnew_pkg::opgroup_e OpGroup = single_file_fpnew_pkg::CONV,
    parameter int unsigned         Width   = 64,
    parameter single_file_fpnew_pkg::fmt_logic_t   FpFmtConfig   = '1,
    parameter single_file_fpnew_pkg::ifmt_logic_t  IntFmtConfig  = '1,
    parameter logic                    EnableVectors = 1'b1,
    parameter logic                    PulpDivsqrt   = 1'b1,
    parameter int unsigned             NumPipeRegs   = 0,
    parameter single_file_fpnew_pkg::pipe_config_t PipeConfig    = single_file_fpnew_pkg::BEFORE,
    parameter logic                    ExtRegEna     = 1'b0,
    parameter type                     TagType       = logic,
    localparam int unsigned NumOperands = single_file_fpnew_pkg::num_operands(OpGroup),
    localparam int unsigned NumFormats = single_file_fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned NumSimdLanes = single_file_fpnew_pkg::max_num_lanes(
        Width, FpFmtConfig, EnableVectors
    ),
    localparam type MaskType = logic [NumSimdLanes-1:0],
    localparam int unsigned ExtRegEnaWidth = NumPipeRegs == 0 ? 1 : NumPipeRegs
) (
    input logic clk_i,
    input logic rst_ni,
    input logic                   [NumOperands-1:0][      Width-1:0] operands_i,
    input logic                   [ NumFormats-1:0][NumOperands-1:0] is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e                                     rnd_mode_i,
    input single_file_fpnew_pkg::operation_e                                     op_i,
    input logic                                                      op_mod_i,
    input single_file_fpnew_pkg::fp_format_e                                     src_fmt_i,
    input single_file_fpnew_pkg::fp_format_e                                     dst_fmt_i,
    input single_file_fpnew_pkg::int_format_e                                    int_fmt_i,
    input logic                                                      vectorial_op_i,
    input TagType                                                    tag_i,
    input MaskType                                                   simd_mask_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [Width-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o,
    input logic [ExtRegEnaWidth-1:0] reg_ena_i
);
  if ((OpGroup == single_file_fpnew_pkg::DIVSQRT) && !PulpDivsqrt &&
      !((FpFmtConfig[0] == 1) && (FpFmtConfig[1:NumFormats-1] == '0))) begin : g_assert_divsqrt
    $fatal(1, "T-Head-based DivSqrt unit supported only in FP32-only configurations");
  end
  localparam int unsigned MaxFpWidth = single_file_fpnew_pkg::max_fp_width(FpFmtConfig);
  localparam int unsigned MaxIntWidth = single_file_fpnew_pkg::max_int_width(IntFmtConfig);
  localparam int unsigned NumLanes = single_file_fpnew_pkg::max_num_lanes(Width, FpFmtConfig, 1'b1);
  localparam int unsigned NumIntFormats = single_file_fpnew_pkg::NUM_INT_FORMATS;
  localparam int unsigned FmtBits = single_file_fpnew_pkg::maximum($clog2(NumFormats), $clog2(NumIntFormats));
  localparam int unsigned AuxBits = FmtBits + 2;
  logic [NumLanes-1:0] lane_in_ready, lane_out_valid, divsqrt_done, divsqrt_ready;
  logic               vectorial_op;
  logic [FmtBits-1:0] dst_fmt;
  logic [AuxBits-1:0] aux_data;
  logic dst_fmt_is_int, dst_is_cpk;
  logic [1:0] dst_vec_op;
  logic [2:0] target_aux_d;
  logic is_up_cast, is_down_cast;
  logic [NumFormats-1:0][Width-1:0] fmt_slice_result;
  logic [NumIntFormats-1:0][Width-1:0] ifmt_slice_result;
  logic [Width-1:0] conv_target_d, conv_target_q;
  single_file_fpnew_pkg::status_t [NumLanes-1:0]              lane_status;
  logic               [NumLanes-1:0]              lane_ext_bit;
  TagType             [NumLanes-1:0]              lane_tags;
  logic               [NumLanes-1:0]              lane_masks;
  logic               [NumLanes-1:0][AuxBits-1:0] lane_aux;
  logic               [NumLanes-1:0]              lane_busy;
  logic                                           result_is_vector;
  logic               [ FmtBits-1:0]              result_fmt;
  logic result_fmt_is_int, result_is_cpk;
  logic [1:0] result_vec_op;
  logic simd_synch_rdy, simd_synch_done;
  assign in_ready_o = lane_in_ready[0];
  assign vectorial_op = vectorial_op_i & EnableVectors;
  assign dst_fmt_is_int = (OpGroup == single_file_fpnew_pkg::CONV) & (op_i == single_file_fpnew_pkg::F2I);
  assign dst_is_cpk     = (OpGroup == single_file_fpnew_pkg::CONV) & (op_i == single_file_fpnew_pkg::CPKAB ||
                                                              op_i == single_file_fpnew_pkg::CPKCD);
  assign dst_vec_op = (OpGroup == single_file_fpnew_pkg::CONV) & {(op_i == single_file_fpnew_pkg::CPKCD), op_mod_i};
  assign is_up_cast = (single_file_fpnew_pkg::fp_width(dst_fmt_i) > single_file_fpnew_pkg::fp_width(src_fmt_i));
  assign is_down_cast = (single_file_fpnew_pkg::fp_width(dst_fmt_i) < single_file_fpnew_pkg::fp_width(src_fmt_i));
  assign dst_fmt = dst_fmt_is_int ? int_fmt_i : dst_fmt_i;
  assign aux_data = {dst_fmt_is_int, vectorial_op, dst_fmt};
  assign target_aux_d = {dst_vec_op, dst_is_cpk};
  if (OpGroup == single_file_fpnew_pkg::CONV) begin : g_conv_target
    assign conv_target_d = dst_is_cpk ? operands_i[2] : operands_i[1];
  end else begin : g_not_conv_target
    assign conv_target_d = '0;
  end
  logic [NumFormats-1:0]    is_boxed_1op;
  logic [NumFormats-1:0][1:0] is_boxed_2op;
  always_comb begin : boxed_2op
    for (int fmt = 0; fmt < NumFormats; fmt++) begin
      is_boxed_1op[fmt] = is_boxed_i[fmt][0];
      is_boxed_2op[fmt] = is_boxed_i[fmt][1:0];
    end
  end
  for (genvar lane = 0; lane < int'(NumLanes); lane++) begin : gen_num_lanes
    localparam int unsigned LANE = unsigned'(lane);
    localparam single_file_fpnew_pkg::fmt_logic_t ActiveFormats = single_file_fpnew_pkg::get_lane_formats(
        Width, FpFmtConfig, LANE
    );
    localparam single_file_fpnew_pkg::ifmt_logic_t ActiveIntFormats = single_file_fpnew_pkg::get_lane_int_formats(
        Width, FpFmtConfig, IntFmtConfig, LANE
    );
    localparam int unsigned MaxWidth = single_file_fpnew_pkg::max_fp_width(ActiveFormats);
    localparam single_file_fpnew_pkg::fmt_logic_t ConvFormats = single_file_fpnew_pkg::get_conv_lane_formats(
        Width, FpFmtConfig, LANE
    );
    localparam single_file_fpnew_pkg::ifmt_logic_t ConvIntFormats = single_file_fpnew_pkg::get_conv_lane_int_formats(
        Width, FpFmtConfig, IntFmtConfig, LANE
    );
    localparam int unsigned ConvWidth = single_file_fpnew_pkg::max_fp_width(ConvFormats);
    localparam single_file_fpnew_pkg::fmt_logic_t LaneFormats = (OpGroup == single_file_fpnew_pkg::CONV)
                                                               ? ConvFormats : ActiveFormats;
    localparam int unsigned LaneWidth = (OpGroup == single_file_fpnew_pkg::CONV) ? ConvWidth : MaxWidth;
    logic [LaneWidth-1:0] local_result;
    if ((lane == 0) || EnableVectors) begin : g_active_lane
      logic in_valid, out_valid, out_ready;
      logic               [NumOperands-1:0][LaneWidth-1:0] local_operands;
      logic               [  LaneWidth-1:0]                op_result;
      single_file_fpnew_pkg::status_t                                  op_status;
      assign in_valid = in_valid_i & ((lane == 0) | vectorial_op);
      always_comb begin : prepare_input
        for (int unsigned i = 0; i < NumOperands; i++) begin
          if (i == 2) begin
            local_operands[i] = operands_i[i] >> LANE * single_file_fpnew_pkg::fp_width(dst_fmt_i);
          end else begin
            local_operands[i] = operands_i[i] >> LANE * single_file_fpnew_pkg::fp_width(src_fmt_i);
          end
        end
        if (OpGroup == single_file_fpnew_pkg::CONV) begin
          if (op_i == single_file_fpnew_pkg::I2F) begin
            local_operands[0] = operands_i[0] >> LANE * single_file_fpnew_pkg::int_width(int_fmt_i);
          end else if (op_i == single_file_fpnew_pkg::F2F) begin
            if (vectorial_op && op_mod_i && is_up_cast) begin
              local_operands[0] = operands_i[0] >>
                  LANE * single_file_fpnew_pkg::fp_width(src_fmt_i) + MaxFpWidth / 2;
            end
          end else if (dst_is_cpk) begin
            if (lane == 1) begin
              local_operands[0] = operands_i[1][LaneWidth-1:0];
            end
          end
        end
      end
      if (OpGroup == single_file_fpnew_pkg::ADDMUL) begin : g_lane_instance
        single_file_fpnew_fma_multi #(
            .FpFmtConfig(LaneFormats),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic [AuxBits-1:0])
        ) i_fpnew_fma_multi (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands),
            .is_boxed_i,
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .src_fmt_i,
            .dst_fmt_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (aux_data),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_aux[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane]),
            .reg_ena_i
        );
      end else if (OpGroup == single_file_fpnew_pkg::DIVSQRT) begin : g_lane_instance
        if (!PulpDivsqrt && LaneFormats[0]
          && (LaneFormats[1:single_file_fpnew_pkg::NUM_FP_FORMATS-1] == '0)) begin : g_lane_instance
          single_file_fpnew_divsqrt_th_32 #(
              .NumPipeRegs(NumPipeRegs),
              .PipeConfig (PipeConfig),
              .TagType    (TagType),
              .AuxType    (logic [AuxBits-1:0])
          ) i_fpnew_divsqrt_multi_th (
              .clk_i,
              .rst_ni,
              .operands_i     (local_operands[1:0]),
              .is_boxed_i     (is_boxed_2op),
              .rnd_mode_i,
              .op_i,
              .tag_i,
              .mask_i         (simd_mask_i[lane]),
              .aux_i          (aux_data),
              .in_valid_i     (in_valid),
              .in_ready_o     (lane_in_ready[lane]),
              .flush_i,
              .result_o       (op_result),
              .status_o       (op_status),
              .extension_bit_o(lane_ext_bit[lane]),
              .tag_o          (lane_tags[lane]),
              .mask_o         (lane_masks[lane]),
              .aux_o          (lane_aux[lane]),
              .out_valid_o    (out_valid),
              .out_ready_i    (out_ready),
              .busy_o         (lane_busy[lane]),
              .reg_ena_i
          );
        end else begin : g_lane_instance
          fpnew_divsqrt_multi #(
              .FpFmtConfig(LaneFormats),
              .NumPipeRegs(NumPipeRegs),
              .PipeConfig (PipeConfig),
              .TagType    (TagType),
              .AuxType    (logic [AuxBits-1:0])
          ) i_fpnew_divsqrt_multi (
              .clk_i,
              .rst_ni,
              .operands_i       (local_operands[1:0]),
              .is_boxed_i       (is_boxed_2op),
              .rnd_mode_i,
              .op_i,
              .dst_fmt_i,
              .tag_i,
              .mask_i           (simd_mask_i[lane]),
              .aux_i            (aux_data),
              .vectorial_op_i   (vectorial_op),
              .in_valid_i       (in_valid),
              .in_ready_o       (lane_in_ready[lane]),
              .divsqrt_done_o   (divsqrt_done[lane]),
              .simd_synch_done_i(simd_synch_done),
              .divsqrt_ready_o  (divsqrt_ready[lane]),
              .simd_synch_rdy_i (simd_synch_rdy),
              .flush_i,
              .result_o         (op_result),
              .status_o         (op_status),
              .extension_bit_o  (lane_ext_bit[lane]),
              .tag_o            (lane_tags[lane]),
              .mask_o           (lane_masks[lane]),
              .aux_o            (lane_aux[lane]),
              .out_valid_o      (out_valid),
              .out_ready_i      (out_ready),
              .busy_o           (lane_busy[lane]),
              .reg_ena_i
          );
        end
      end else if (OpGroup == single_file_fpnew_pkg::NONCOMP) begin : g_lane_instance
      end else if (OpGroup == single_file_fpnew_pkg::CONV) begin : g_lane_instance
        single_file_fpnew_cast_multi #(
            .FpFmtConfig (LaneFormats),
            .IntFmtConfig(ConvIntFormats),
            .NumPipeRegs (NumPipeRegs),
            .PipeConfig  (PipeConfig),
            .TagType     (TagType),
            .AuxType     (logic [AuxBits-1:0])
        ) i_fpnew_cast_multi (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands[0]),
            .is_boxed_i     (is_boxed_1op),
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .src_fmt_i,
            .dst_fmt_i,
            .int_fmt_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (aux_data),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_aux[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane]),
            .reg_ena_i
        );
      end
      assign out_ready = out_ready_i & ((lane == 0) | result_is_vector);
      assign lane_out_valid[lane] = out_valid & ((lane == 0) | result_is_vector);
      assign local_result = (lane_out_valid[lane] | ExtRegEna) ? op_result : '{
              default: lane_ext_bit[0]
          };
      assign lane_status[lane] = (lane_out_valid[lane] | ExtRegEna) ? op_status : '0;
    end else begin : g_inactive_lane
      assign lane_out_valid[lane] = 1'b0;
      assign lane_in_ready[lane]  = 1'b0;
      assign lane_aux[lane]       = 1'b0;
      assign lane_masks[lane]     = 1'b1;
      assign lane_tags[lane]      = 1'b0;
      assign divsqrt_done[lane]   = 1'b0;
      assign divsqrt_ready[lane]  = 1'b0;
      assign lane_ext_bit[lane]   = 1'b1;
      assign local_result         = {(LaneWidth) {lane_ext_bit[0]}};
      assign lane_status[lane]    = '0;
      assign lane_busy[lane]      = 1'b0;
    end
    for (genvar fmt = 0; fmt < NumFormats; fmt++) begin : g_pack_fp_result
      localparam int unsigned FpWidth = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
      if (ActiveFormats[fmt]) begin : g_pack_fp_result_active
        assign fmt_slice_result[fmt][(LANE+1)*FpWidth-1:LANE*FpWidth] = local_result[FpWidth-1:0];
      end else if ((LANE + 1) * FpWidth <= Width) begin : g_extend_fp_result
        assign fmt_slice_result[fmt][(LANE+1)*FpWidth-1:LANE*FpWidth] = '{
                default: lane_ext_bit[LANE]
            };
      end else if (LANE * FpWidth < Width) begin : g_extend_fp_result
        assign fmt_slice_result[fmt][Width-1:LANE*FpWidth] = '{default: lane_ext_bit[LANE]};
      end
    end
    if (OpGroup == single_file_fpnew_pkg::CONV) begin : g_int_results_enabled
      for (genvar ifmt = 0; ifmt < NumIntFormats; ifmt++) begin : g_pack_int_result
        localparam int unsigned IntWidth = single_file_fpnew_pkg::int_width(single_file_fpnew_pkg::int_format_e'(ifmt));
        if (ActiveIntFormats[ifmt]) begin : g_pack_int_result_active
          assign ifmt_slice_result[ifmt][(LANE+1)*IntWidth-1:LANE*IntWidth] =
              local_result[IntWidth-1:0];
        end else if ((LANE + 1) * IntWidth <= Width) begin : g_pack_int_result_pad
          assign ifmt_slice_result[ifmt][(LANE+1)*IntWidth-1:LANE*IntWidth] = '0;
        end else if (LANE * IntWidth < Width) begin : g_pack_int_result_pad
          assign ifmt_slice_result[ifmt][Width-1:LANE*IntWidth] = '0;
        end
      end
    end
  end
  for (genvar fmt = 0; fmt < NumFormats; fmt++) begin : g_extend_fp_result
    localparam int unsigned FpWidth = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    if (NumLanes * FpWidth < Width)
      assign fmt_slice_result[fmt][Width-1:NumLanes*FpWidth] = '{default: lane_ext_bit[0]};
  end
  for (genvar ifmt = 0; ifmt < NumIntFormats; ifmt++) begin : g_extend_or_mute_int_result
    if (OpGroup != single_file_fpnew_pkg::CONV) begin : g_mute_int_result
      assign ifmt_slice_result[ifmt] = '0;
    end else begin : g_extend_int_result
      localparam int unsigned IntWidth = single_file_fpnew_pkg::int_width(single_file_fpnew_pkg::int_format_e'(ifmt));
      if (NumLanes * IntWidth < Width)
        assign ifmt_slice_result[ifmt][Width-1:NumLanes*IntWidth] = '0;
    end
  end
  if (OpGroup == single_file_fpnew_pkg::CONV) begin : target_regs
    logic [0:NumPipeRegs][Width-1:0] byp_pipe_target_q;
    logic [0:NumPipeRegs][      2:0] byp_pipe_aux_q;
    logic [0:NumPipeRegs]            byp_pipe_valid_q;
    logic [0:NumPipeRegs]            byp_pipe_ready;
    assign byp_pipe_target_q[0] = conv_target_d;
    assign byp_pipe_aux_q[0] = target_aux_d;
    assign byp_pipe_valid_q[0] = in_valid_i & vectorial_op;
    for (genvar i = 0; i < NumPipeRegs; i++) begin : gen_bypass_pipeline
      logic reg_ena;
      assign byp_pipe_ready[i] = byp_pipe_ready[i+1] | ~byp_pipe_valid_q[i+1];
      always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
        if (!rst_ni) begin
          byp_pipe_valid_q[i+1] <= '0;
        end else begin
          byp_pipe_valid_q[i+1] <= (flush_i) ? '0 : (byp_pipe_ready[i]) ? (byp_pipe_valid_q[i]) : (byp_pipe_valid_q[i+1]);
        end
      end
      assign reg_ena = (byp_pipe_ready[i] & byp_pipe_valid_q[i]) | reg_ena_i[i];
      always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
          byp_pipe_target_q[i+1] <= '0;
        end else begin
          byp_pipe_target_q[i+1] <= (reg_ena) ? (byp_pipe_target_q[i]) : (byp_pipe_target_q[i+1]);
        end
      end
      always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
          byp_pipe_aux_q[i+1] <= '0;
        end else begin
          byp_pipe_aux_q[i+1] <= (reg_ena) ? (byp_pipe_aux_q[i]) : (byp_pipe_aux_q[i+1]);
        end
      end
    end
    assign byp_pipe_ready[NumPipeRegs] = out_ready_i & result_is_vector;
    assign conv_target_q = byp_pipe_target_q[NumPipeRegs];
    assign {result_vec_op, result_is_cpk} = byp_pipe_aux_q[NumPipeRegs];
  end else begin : g_no_conv
    assign {result_vec_op, result_is_cpk} = '0;
    assign conv_target_q = '0;
  end
  if (PulpDivsqrt) begin : g_pulp_divsqrt_sync
    assign simd_synch_rdy  = EnableVectors ? &divsqrt_ready : divsqrt_ready[0];
    assign simd_synch_done = EnableVectors ? &divsqrt_done : divsqrt_done[0];
  end else begin : g_no_pulp_divsqrt_sync
    assign simd_synch_rdy  = '0;
    assign simd_synch_done = '0;
  end
  assign {result_fmt_is_int, result_is_vector, result_fmt} = lane_aux[0];
  assign result_o        = result_fmt_is_int
                              ? ifmt_slice_result[result_fmt]
                              : fmt_slice_result[result_fmt];
  assign extension_bit_o = lane_ext_bit[0];
  assign tag_o = lane_tags[0];
  assign busy_o = (|lane_busy);
  assign out_valid_o = lane_out_valid[0];
  always_comb begin : output_processing
    automatic single_file_fpnew_pkg::status_t temp_status;
    temp_status = '0;
    for (int i = 0; i < int'(NumLanes); i++) temp_status |= lane_status[i] & {5{lane_masks[i]}};
    status_o = temp_status;
  end
endmodule


module single_file_rr_arb_tree #(
    parameter int unsigned NumIn = 64,
    parameter int unsigned DataWidth = 32,
    parameter type DataType = logic [DataWidth-1:0],
    parameter bit ExtPrio = 1'b0,
    parameter bit AxiVldRdy = 1'b0,
    parameter bit LockIn = 1'b0,
    parameter bit FairArb = 1'b1,
    parameter int unsigned IdxWidth = (NumIn > 32'd1) ?
    unsigned'($clog2(
        NumIn
    )) : 32'd1,
    parameter type idx_t = logic [IdxWidth-1:0]
) (
    input  logic                clk_i,
    input  logic                rst_ni,
    input  logic                flush_i,
    input  idx_t                rr_i,
    input  logic    [NumIn-1:0] req_i,
    output logic    [NumIn-1:0] gnt_o,
    input  DataType [NumIn-1:0] data_i,
    output logic                req_o,
    input  logic                gnt_i,
    output DataType             data_o,
    output idx_t                idx_o
);
  if (NumIn == unsigned'(1)) begin : gen_pass_through
    assign req_o    = req_i[0];
    assign gnt_o[0] = gnt_i;
    assign data_o   = data_i[0];
    assign idx_o    = '0;
  end else begin : gen_arbiter
    localparam int unsigned NumLevels = unsigned'($clog2(NumIn));
    idx_t    [2**NumLevels-2:0] index_nodes;
    DataType [2**NumLevels-2:0] data_nodes;
    logic    [2**NumLevels-2:0] gnt_nodes;
    logic    [2**NumLevels-2:0] req_nodes;
    idx_t                       rr_q;
    logic    [       NumIn-1:0] req_d;
    assign req_o  = req_nodes[0];
    assign data_o = data_nodes[0];
    assign idx_o  = index_nodes[0];
    if (ExtPrio) begin : gen_ext_rr
      assign rr_q  = rr_i;
      assign req_d = req_i;
    end else begin : gen_int_rr
      idx_t rr_d;
      if (LockIn) begin : gen_lock
        logic lock_d, lock_q;
        logic [NumIn-1:0] req_q;
        assign lock_d = req_o & ~gnt_i;
        assign req_d  = (lock_q) ? req_q : req_i;
        always_ff @(posedge clk_i or negedge rst_ni) begin : p_lock_reg
          if (!rst_ni) begin
            lock_q <= '0;
          end else begin
            if (flush_i) begin
              lock_q <= '0;
            end else begin
              lock_q <= lock_d;
            end
          end
        end
        always_ff @(posedge clk_i or negedge rst_ni) begin : p_req_regs
          if (!rst_ni) begin
            req_q <= '0;
          end else begin
            if (flush_i) begin
              req_q <= '0;
            end else begin
              req_q <= req_d;
            end
          end
        end
      end else begin : gen_no_lock
        assign req_d = req_i;
      end
      if (FairArb) begin : gen_fair_arb
        logic [NumIn-1:0] upper_mask, lower_mask;
        idx_t upper_idx, lower_idx, next_idx;
        logic upper_empty, lower_empty;
        for (genvar i = 0; i < NumIn; i++) begin : gen_mask
          assign upper_mask[i] = (i > rr_q) ? req_d[i] : 1'b0;
          assign lower_mask[i] = (i <= rr_q) ? req_d[i] : 1'b0;
        end
        single_file_lzc #(
            .WIDTH(NumIn),
            .MODE (1'b0)
        ) i_lzc_upper (
            .in_i   (upper_mask),
            .cnt_o  (upper_idx),
            .empty_o(upper_empty)
        );
        single_file_lzc #(
            .WIDTH(NumIn),
            .MODE (1'b0)
        ) i_lzc_lower (
            .in_i   (lower_mask),
            .cnt_o  (lower_idx),
            .empty_o()
        );
        assign next_idx = upper_empty ? lower_idx : upper_idx;
        assign rr_d     = (gnt_i && req_o) ? next_idx : rr_q;
      end else begin : gen_unfair_arb
        assign rr_d = (gnt_i && req_o) ?
            ((rr_q == idx_t'(NumIn - 1)) ? '0 : rr_q + 1'b1) : rr_q;
      end
      always_ff @(posedge clk_i or negedge rst_ni) begin : p_rr_regs
        if (!rst_ni) begin
          rr_q <= '0;
        end else begin
          if (flush_i) begin
            rr_q <= '0;
          end else begin
            rr_q <= rr_d;
          end
        end
      end
    end
    assign gnt_nodes[0] = gnt_i;
    for (genvar level = 0; unsigned'(level) < NumLevels; level++) begin : gen_levels
      for (genvar l = 0; l < 2 ** level; l++) begin : gen_level
        logic sel;
        localparam int unsigned Idx0 = 2 ** level - 1 + l;
        localparam int unsigned Idx1 = 2 ** (level + 1) - 1 + l * 2;
        if (unsigned'(level) == NumLevels - 1) begin : gen_first_level
          if (unsigned'(l) * 2 < NumIn - 1) begin : gen_reduce
            assign req_nodes[Idx0] = req_d[l*2] | req_d[l*2+1];
            assign sel = ~req_d[l*2] | req_d[l*2+1] &
                rr_q[NumLevels-1-level];
            assign index_nodes[Idx0] = idx_t'(sel);
            assign data_nodes[Idx0] = (sel) ? data_i[l*2+1] : data_i[l*2];
            assign gnt_o[l*2] = gnt_nodes[Idx0] &
                (AxiVldRdy | req_d[l*2]) & ~sel;
            assign gnt_o[l*2+1] = gnt_nodes[Idx0] &
                (AxiVldRdy | req_d[l*2+1]) & sel;
          end
          if (unsigned'(l) * 2 == NumIn - 1) begin : gen_first
            assign req_nodes[Idx0] = req_d[l*2];
            assign index_nodes[Idx0] = '0;
            assign data_nodes[Idx0] = data_i[l*2];
            assign gnt_o[l*2] = gnt_nodes[Idx0] &
                (AxiVldRdy | req_d[l*2]);
          end
          if (unsigned'(l) * 2 > NumIn - 1) begin : gen_out_of_range
            assign req_nodes[Idx0]   = 1'b0;
            assign index_nodes[Idx0] = idx_t'('0);
            assign data_nodes[Idx0]  = DataType'('0);
          end
        end else begin : gen_other_levels
          assign req_nodes[Idx0] = req_nodes[Idx1] | req_nodes[Idx1+1];
          assign sel = ~req_nodes[Idx1] | req_nodes[Idx1+1] &
              rr_q[NumLevels-1-level];
          assign index_nodes[Idx0] = (sel) ?
              idx_t'({1'b1, index_nodes[Idx1+1][NumLevels-unsigned'(level)-2:0]}) :
              idx_t'({1'b0, index_nodes[Idx1][NumLevels-unsigned'(level)-2:0]});
          assign data_nodes[Idx0] = (sel) ? data_nodes[Idx1+1] : data_nodes[Idx1];
          assign gnt_nodes[Idx1] = gnt_nodes[Idx0] & ~sel;
          assign gnt_nodes[Idx1+1] = gnt_nodes[Idx0] & sel;
        end
      end
    end
  end
endmodule

 : single_file_rr_arb_tree
module single_file_fpnew_opgroup_block #(
    parameter single_file_fpnew_pkg::opgroup_e OpGroup = single_file_fpnew_pkg::ADDMUL,
    parameter int unsigned                Width         = 32,
    parameter logic                       EnableVectors = 1'b1,
    parameter logic                       PulpDivsqrt   = 1'b1,
    parameter single_file_fpnew_pkg::fmt_logic_t      FpFmtMask     = '1,
    parameter single_file_fpnew_pkg::ifmt_logic_t     IntFmtMask    = '1,
    parameter single_file_fpnew_pkg::fmt_unsigned_t   FmtPipeRegs   = '{default: 0},
    parameter single_file_fpnew_pkg::fmt_unit_types_t FmtUnitTypes  = '{default: single_file_fpnew_pkg::PARALLEL},
    parameter single_file_fpnew_pkg::pipe_config_t    PipeConfig    = single_file_fpnew_pkg::BEFORE,
    parameter type                        TagType       = logic,
    parameter int unsigned                TrueSIMDClass = 0,
    localparam int unsigned NUM_FORMATS = single_file_fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned NUM_OPERANDS = single_file_fpnew_pkg::num_operands(OpGroup),
    localparam int unsigned NUM_LANES = single_file_fpnew_pkg::max_num_lanes(Width, FpFmtMask, EnableVectors),
    localparam type MaskType = logic [NUM_LANES-1:0]
) (
    input logic clk_i,
    input logic rst_ni,
    input logic                   [NUM_OPERANDS-1:0][       Width-1:0] operands_i,
    input logic                   [ NUM_FORMATS-1:0][NUM_OPERANDS-1:0] is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e                                       rnd_mode_i,
    input single_file_fpnew_pkg::operation_e                                       op_i,
    input logic                                                        op_mod_i,
    input single_file_fpnew_pkg::fp_format_e                                       src_fmt_i,
    input single_file_fpnew_pkg::fp_format_e                                       dst_fmt_i,
    input single_file_fpnew_pkg::int_format_e                                      int_fmt_i,
    input logic                                                        vectorial_op_i,
    input TagType                                                      tag_i,
    input MaskType                                                     simd_mask_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [Width-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o
);
  typedef struct packed {
    logic [Width-1:0]   result;
    single_file_fpnew_pkg::status_t status;
    logic               ext_bit;
    TagType             tag;
  } output_t;
  logic [NUM_FORMATS-1:0] fmt_in_ready, fmt_out_valid, fmt_out_ready, fmt_busy;
  output_t [NUM_FORMATS-1:0] fmt_outputs;
  assign in_ready_o = in_valid_i & fmt_in_ready[dst_fmt_i];
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_parallel_slices
    localparam logic ANY_MERGED = single_file_fpnew_pkg::any_enabled_multi(FmtUnitTypes, FpFmtMask);
    localparam logic IS_FIRST_MERGED = single_file_fpnew_pkg::is_first_enabled_multi(
        single_file_fpnew_pkg::fp_format_e'(fmt), FmtUnitTypes, FpFmtMask
    );
    if (FpFmtMask[fmt] && (FmtUnitTypes[fmt] == single_file_fpnew_pkg::PARALLEL)) begin : active_format
      logic in_valid;
      assign in_valid = in_valid_i & (dst_fmt_i == fmt);
      localparam int unsigned INTERNAL_LANES = single_file_fpnew_pkg::num_lanes(
          Width, single_file_fpnew_pkg::fp_format_e'(fmt), EnableVectors
      );
      logic [INTERNAL_LANES-1:0] mask_slice;
      always_comb
        for (int b = 0; b < INTERNAL_LANES; b++)
          mask_slice[b] = simd_mask_i[(NUM_LANES/INTERNAL_LANES)*b];
      single_file_fpnew_opgroup_fmt_slice #(
          .OpGroup      (OpGroup),
          .FpFormat     (single_file_fpnew_pkg::fp_format_e'(fmt)),
          .Width        (Width),
          .EnableVectors(EnableVectors),
          .NumPipeRegs  (FmtPipeRegs[fmt]),
          .PipeConfig   (PipeConfig),
          .TagType      (TagType),
          .TrueSIMDClass(TrueSIMDClass)
      ) i_fmt_slice (
          .clk_i,
          .rst_ni,
          .operands_i     (operands_i),
          .is_boxed_i     (is_boxed_i[fmt]),
          .rnd_mode_i,
          .op_i,
          .op_mod_i,
          .vectorial_op_i,
          .tag_i,
          .simd_mask_i    (mask_slice),
          .in_valid_i     (in_valid),
          .in_ready_o     (fmt_in_ready[fmt]),
          .flush_i,
          .result_o       (fmt_outputs[fmt].result),
          .status_o       (fmt_outputs[fmt].status),
          .extension_bit_o(fmt_outputs[fmt].ext_bit),
          .tag_o          (fmt_outputs[fmt].tag),
          .out_valid_o    (fmt_out_valid[fmt]),
          .out_ready_i    (fmt_out_ready[fmt]),
          .busy_o         (fmt_busy[fmt]),
          .reg_ena_i      ('0)
      );
    end else if (FpFmtMask[fmt] && ANY_MERGED && !IS_FIRST_MERGED) begin : merged_unused
      localparam FMT = single_file_fpnew_pkg::get_first_enabled_multi(FmtUnitTypes, FpFmtMask);
      assign fmt_in_ready[fmt]        = fmt_in_ready[int'(FMT)];
      assign fmt_out_valid[fmt]       = 1'b0;
      assign fmt_busy[fmt]            = 1'b0;
      assign fmt_outputs[fmt].result  = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].status  = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].ext_bit = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_outputs[fmt].tag     = TagType'(single_file_fpnew_pkg::DONT_CARE);
    end else if (!FpFmtMask[fmt] || (FmtUnitTypes[fmt] == single_file_fpnew_pkg::DISABLED)) begin : disable_fmt
      assign fmt_in_ready[fmt]        = 1'b0;
      assign fmt_out_valid[fmt]       = 1'b0;
      assign fmt_busy[fmt]            = 1'b0;
      assign fmt_outputs[fmt].result  = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].status  = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_outputs[fmt].ext_bit = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_outputs[fmt].tag     = TagType'(single_file_fpnew_pkg::DONT_CARE);
    end
  end
  if (single_file_fpnew_pkg::any_enabled_multi(FmtUnitTypes, FpFmtMask)) begin : gen_merged_slice
    localparam FMT = single_file_fpnew_pkg::get_first_enabled_multi(FmtUnitTypes, FpFmtMask);
    localparam REG = single_file_fpnew_pkg::get_num_regs_multi(FmtPipeRegs, FmtUnitTypes, FpFmtMask);
    logic in_valid;
    assign in_valid = in_valid_i & (FmtUnitTypes[dst_fmt_i] == single_file_fpnew_pkg::MERGED);
    single_file_fpnew_opgroup_multifmt_slice #(
        .OpGroup      (OpGroup),
        .Width        (Width),
        .FpFmtConfig  (FpFmtMask),
        .IntFmtConfig (IntFmtMask),
        .EnableVectors(EnableVectors),
        .PulpDivsqrt  (PulpDivsqrt),
        .NumPipeRegs  (REG),
        .PipeConfig   (PipeConfig),
        .TagType      (TagType)
    ) i_multifmt_slice (
        .clk_i,
        .rst_ni,
        .operands_i,
        .is_boxed_i,
        .rnd_mode_i,
        .op_i,
        .op_mod_i,
        .src_fmt_i,
        .dst_fmt_i,
        .int_fmt_i,
        .vectorial_op_i,
        .tag_i,
        .simd_mask_i    (simd_mask_i),
        .in_valid_i     (in_valid),
        .in_ready_o     (fmt_in_ready[FMT]),
        .flush_i,
        .result_o       (fmt_outputs[FMT].result),
        .status_o       (fmt_outputs[FMT].status),
        .extension_bit_o(fmt_outputs[FMT].ext_bit),
        .tag_o          (fmt_outputs[FMT].tag),
        .out_valid_o    (fmt_out_valid[FMT]),
        .out_ready_i    (fmt_out_ready[FMT]),
        .busy_o         (fmt_busy[FMT]),
        .reg_ena_i      ('0)
    );
  end
  output_t arbiter_output;
  single_file_rr_arb_tree #(
      .NumIn    (NUM_FORMATS),
      .DataType (output_t),
      .AxiVldRdy(1'b1)
  ) i_arbiter (
      .clk_i,
      .rst_ni,
      .flush_i,
      .rr_i  ('0),
      .req_i (fmt_out_valid),
      .gnt_o (fmt_out_ready),
      .data_i(fmt_outputs),
      .gnt_i (out_ready_i),
      .req_o (out_valid_o),
      .data_o(arbiter_output),
      .idx_o ()
  );
  assign result_o        = arbiter_output.result;
  assign status_o        = arbiter_output.status;
  assign extension_bit_o = arbiter_output.ext_bit;
  assign tag_o           = arbiter_output.tag;
  assign busy_o          = (|fmt_busy);
endmodule


module single_file_pa_fdsu_special (
    cp0_fpu_xx_dqnan,
    dp_xx_ex1_cnan,
    dp_xx_ex1_id,
    dp_xx_ex1_inf,
    dp_xx_ex1_qnan,
    dp_xx_ex1_snan,
    dp_xx_ex1_zero,
    ex1_div,
    ex1_op0_id,
    ex1_op0_norm,
    ex1_op0_sign,
    ex1_op1_id,
    ex1_op1_norm,
    ex1_result_sign,
    ex1_sqrt,
    ex1_srt_skip,
    fdsu_fpu_ex1_fflags,
    fdsu_fpu_ex1_special_sel,
    fdsu_fpu_ex1_special_sign
);
  input cp0_fpu_xx_dqnan;
  input [2:0] dp_xx_ex1_cnan;
  input [2:0] dp_xx_ex1_id;
  input [2:0] dp_xx_ex1_inf;
  input [2:0] dp_xx_ex1_qnan;
  input [2:0] dp_xx_ex1_snan;
  input [2:0] dp_xx_ex1_zero;
  input ex1_div;
  input ex1_op0_sign;
  input ex1_result_sign;
  input ex1_sqrt;
  output ex1_op0_id;
  output ex1_op0_norm;
  output ex1_op1_id;
  output ex1_op1_norm;
  output ex1_srt_skip;
  output [4:0] fdsu_fpu_ex1_fflags;
  output [7:0] fdsu_fpu_ex1_special_sel;
  output [3:0] fdsu_fpu_ex1_special_sign;
  reg        ex1_result_cnan;
  reg        ex1_result_qnan_op0;
  reg        ex1_result_qnan_op1;
  wire       cp0_fpu_xx_dqnan;
  wire [2:0] dp_xx_ex1_cnan;
  wire [2:0] dp_xx_ex1_id;
  wire [2:0] dp_xx_ex1_inf;
  wire [2:0] dp_xx_ex1_qnan;
  wire [2:0] dp_xx_ex1_snan;
  wire [2:0] dp_xx_ex1_zero;
  wire       ex1_div;
  wire       ex1_div_dz;
  wire       ex1_div_nv;
  wire       ex1_div_rst_inf;
  wire       ex1_div_rst_qnan;
  wire       ex1_div_rst_zero;
  wire       ex1_dz;
  wire [4:0] ex1_fflags;
  wire       ex1_nv;
  wire       ex1_op0_cnan;
  wire       ex1_op0_id;
  wire       ex1_op0_inf;
  wire       ex1_op0_is_qnan;
  wire       ex1_op0_is_snan;
  wire       ex1_op0_norm;
  wire       ex1_op0_qnan;
  wire       ex1_op0_sign;
  wire       ex1_op0_snan;
  wire       ex1_op0_tt_zero;
  wire       ex1_op0_zero;
  wire       ex1_op1_cnan;
  wire       ex1_op1_id;
  wire       ex1_op1_inf;
  wire       ex1_op1_is_qnan;
  wire       ex1_op1_is_snan;
  wire       ex1_op1_norm;
  wire       ex1_op1_qnan;
  wire       ex1_op1_snan;
  wire       ex1_op1_tt_zero;
  wire       ex1_op1_zero;
  wire       ex1_result_inf;
  wire       ex1_result_lfn;
  wire       ex1_result_qnan;
  wire       ex1_result_sign;
  wire       ex1_result_zero;
  wire       ex1_rst_default_qnan;
  wire [7:0] ex1_special_sel;
  wire [3:0] ex1_special_sign;
  wire       ex1_sqrt;
  wire       ex1_sqrt_nv;
  wire       ex1_sqrt_rst_inf;
  wire       ex1_sqrt_rst_qnan;
  wire       ex1_sqrt_rst_zero;
  wire       ex1_srt_skip;
  wire [4:0] fdsu_fpu_ex1_fflags;
  wire [7:0] fdsu_fpu_ex1_special_sel;
  wire [3:0] fdsu_fpu_ex1_special_sign;
  assign ex1_op0_inf = dp_xx_ex1_inf[0];
  assign ex1_op1_inf = dp_xx_ex1_inf[1];
  assign ex1_op0_zero = dp_xx_ex1_zero[0];
  assign ex1_op1_zero = dp_xx_ex1_zero[1];
  assign ex1_op0_id = dp_xx_ex1_id[0];
  assign ex1_op1_id = dp_xx_ex1_id[1];
  assign ex1_op0_cnan = dp_xx_ex1_cnan[0];
  assign ex1_op1_cnan = dp_xx_ex1_cnan[1];
  assign ex1_op0_snan = dp_xx_ex1_snan[0];
  assign ex1_op1_snan = dp_xx_ex1_snan[1];
  assign ex1_op0_qnan = dp_xx_ex1_qnan[0];
  assign ex1_op1_qnan = dp_xx_ex1_qnan[1];
  assign ex1_nv = ex1_div && ex1_div_nv || ex1_sqrt && ex1_sqrt_nv;
  assign ex1_div_nv      = ex1_op0_snan ||
                         ex1_op1_snan ||
                         (ex1_op0_tt_zero && ex1_op1_tt_zero)||
                         (ex1_op0_inf && ex1_op1_inf);
  assign ex1_op0_tt_zero = ex1_op0_zero;
  assign ex1_op1_tt_zero = ex1_op1_zero;
  assign ex1_sqrt_nv = ex1_op0_snan || ex1_op0_sign && (ex1_op0_norm || ex1_op0_inf);
  assign ex1_op0_norm    = !ex1_op0_inf && !ex1_op0_zero && !ex1_op0_snan &&
                         !ex1_op0_qnan && !ex1_op0_cnan;
  assign ex1_op1_norm    = !ex1_op1_inf && !ex1_op1_zero && !ex1_op1_snan &&
                         !ex1_op1_qnan && !ex1_op1_cnan;
  assign ex1_dz = ex1_div && ex1_div_dz;
  assign ex1_div_dz = ex1_op1_tt_zero && ex1_op0_norm;
  assign ex1_result_zero = ex1_div_rst_zero && ex1_div || ex1_sqrt_rst_zero && ex1_sqrt;
  assign ex1_div_rst_zero= (ex1_op0_tt_zero && ex1_op1_norm ) ||
                         (!ex1_op0_inf && !ex1_op0_qnan && !ex1_op0_snan &&
                          !ex1_op0_cnan && ex1_op1_inf);
  assign ex1_sqrt_rst_zero = ex1_op0_tt_zero;
  assign ex1_result_qnan = ex1_div_rst_qnan && ex1_div || ex1_sqrt_rst_qnan && ex1_sqrt || ex1_nv;
  assign ex1_div_rst_qnan = ex1_op0_qnan || ex1_op1_qnan;
  assign ex1_sqrt_rst_qnan = ex1_op0_qnan;
  assign ex1_rst_default_qnan = (ex1_div && ex1_op0_zero && ex1_op1_zero) ||
                               (ex1_div && ex1_op0_inf  && ex1_op1_inf)  ||
                               (ex1_sqrt&& ex1_op0_sign && (ex1_op0_norm || ex1_op0_inf));
  assign ex1_result_inf = ex1_div_rst_inf && ex1_div || ex1_sqrt_rst_inf && ex1_sqrt || ex1_dz;
  assign ex1_div_rst_inf = ex1_op0_inf && !ex1_op1_inf && !ex1_op1_qnan &&
                         !ex1_op1_snan && !ex1_op1_cnan;
  assign ex1_sqrt_rst_inf = ex1_op0_inf && !ex1_op0_sign;
  assign ex1_result_lfn = 1'b0;
  assign ex1_op0_is_snan = ex1_op0_snan;
  assign ex1_op1_is_snan = ex1_op1_snan && ex1_div;
  assign ex1_op0_is_qnan = ex1_op0_qnan;
  assign ex1_op1_is_qnan = ex1_op1_qnan && ex1_div;
  always @( ex1_op0_is_snan or ex1_op0_cnan or ex1_result_qnan or
          ex1_op0_is_qnan or ex1_rst_default_qnan or cp0_fpu_xx_dqnan or
          ex1_op1_cnan or ex1_op1_is_qnan or ex1_op1_is_snan)
begin
    if (ex1_rst_default_qnan) begin
      ex1_result_qnan_op0 = 1'b0;
      ex1_result_qnan_op1 = 1'b0;
      ex1_result_cnan = ex1_result_qnan;
    end else if (ex1_op0_is_snan && cp0_fpu_xx_dqnan) begin
      ex1_result_qnan_op0 = ex1_result_qnan;
      ex1_result_qnan_op1 = 1'b0;
      ex1_result_cnan = 1'b0;
    end else if (ex1_op1_is_snan && cp0_fpu_xx_dqnan) begin
      ex1_result_qnan_op0 = 1'b0;
      ex1_result_qnan_op1 = ex1_result_qnan;
      ex1_result_cnan = 1'b0;
    end else if (ex1_op0_is_qnan && cp0_fpu_xx_dqnan) begin
      ex1_result_qnan_op0 = ex1_result_qnan && !ex1_op0_cnan;
      ex1_result_qnan_op1 = 1'b0;
      ex1_result_cnan = ex1_result_qnan && ex1_op0_cnan;
    end else if (ex1_op1_is_qnan && cp0_fpu_xx_dqnan) begin
      ex1_result_qnan_op0 = 1'b0;
      ex1_result_qnan_op1 = ex1_result_qnan && !ex1_op1_cnan;
      ex1_result_cnan = ex1_result_qnan && ex1_op1_cnan;
    end else begin
      ex1_result_qnan_op0 = 1'b0;
      ex1_result_qnan_op1 = 1'b0;
      ex1_result_cnan = ex1_result_qnan;
    end
  end
  assign ex1_srt_skip = ex1_result_zero || ex1_result_qnan || ex1_result_lfn || ex1_result_inf;
  assign ex1_fflags[4:0] = {ex1_nv, ex1_dz, 3'b0};
  assign ex1_special_sel[7:0] = {
    1'b0,
    ex1_result_qnan_op1,
    ex1_result_qnan_op0,
    ex1_result_cnan,
    ex1_result_lfn,
    ex1_result_inf,
    ex1_result_zero,
    1'b0
  };
  assign ex1_special_sign[3:0] = {ex1_result_sign, ex1_result_sign, ex1_result_sign, 1'b0};
  assign fdsu_fpu_ex1_fflags[4:0] = ex1_fflags[4:0];
  assign fdsu_fpu_ex1_special_sel[7:0] = ex1_special_sel[7:0];
  assign fdsu_fpu_ex1_special_sign[3:0] = ex1_special_sign[3:0];
endmodule


module single_file_pa_fdsu_ff1 (
    fanc_shift_num,
    frac_bin_val,
    frac_num
);
  input [51:0] frac_num;
  output [51:0] fanc_shift_num;
  output [12:0] frac_bin_val;
  reg  [51:0] fanc_shift_num;
  reg  [12:0] frac_bin_val;
  wire [51:0] frac_num;
  always @(frac_num[51:0]) begin
    casez (frac_num[51:0])
      52'b1???????????????????????????????????????????????????: frac_bin_val[12:0] = 13'h0;
      52'b01??????????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1fff;
      52'b001?????????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ffe;
      52'b0001????????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ffd;
      52'b00001???????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ffc;
      52'b000001??????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ffb;
      52'b0000001?????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ffa;
      52'b00000001????????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff9;
      52'b000000001???????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff8;
      52'b0000000001??????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff7;
      52'b00000000001?????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff6;
      52'b000000000001????????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff5;
      52'b0000000000001???????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff4;
      52'b00000000000001??????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff3;
      52'b000000000000001?????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff2;
      52'b0000000000000001????????????????????????????????????: frac_bin_val[12:0] = 13'h1ff1;
      52'b00000000000000001???????????????????????????????????: frac_bin_val[12:0] = 13'h1ff0;
      52'b000000000000000001??????????????????????????????????: frac_bin_val[12:0] = 13'h1fef;
      52'b0000000000000000001?????????????????????????????????: frac_bin_val[12:0] = 13'h1fee;
      52'b00000000000000000001????????????????????????????????: frac_bin_val[12:0] = 13'h1fed;
      52'b000000000000000000001???????????????????????????????: frac_bin_val[12:0] = 13'h1fec;
      52'b0000000000000000000001??????????????????????????????: frac_bin_val[12:0] = 13'h1feb;
      52'b00000000000000000000001?????????????????????????????: frac_bin_val[12:0] = 13'h1fea;
      52'b000000000000000000000001????????????????????????????: frac_bin_val[12:0] = 13'h1fe9;
      52'b0000000000000000000000001???????????????????????????: frac_bin_val[12:0] = 13'h1fe8;
      52'b00000000000000000000000001??????????????????????????: frac_bin_val[12:0] = 13'h1fe7;
      52'b000000000000000000000000001?????????????????????????: frac_bin_val[12:0] = 13'h1fe6;
      52'b0000000000000000000000000001????????????????????????: frac_bin_val[12:0] = 13'h1fe5;
      52'b00000000000000000000000000001???????????????????????: frac_bin_val[12:0] = 13'h1fe4;
      52'b000000000000000000000000000001??????????????????????: frac_bin_val[12:0] = 13'h1fe3;
      52'b0000000000000000000000000000001?????????????????????: frac_bin_val[12:0] = 13'h1fe2;
      52'b00000000000000000000000000000001????????????????????: frac_bin_val[12:0] = 13'h1fe1;
      52'b000000000000000000000000000000001???????????????????: frac_bin_val[12:0] = 13'h1fe0;
      52'b0000000000000000000000000000000001??????????????????: frac_bin_val[12:0] = 13'h1fdf;
      52'b00000000000000000000000000000000001?????????????????: frac_bin_val[12:0] = 13'h1fde;
      52'b000000000000000000000000000000000001????????????????: frac_bin_val[12:0] = 13'h1fdd;
      52'b0000000000000000000000000000000000001???????????????: frac_bin_val[12:0] = 13'h1fdc;
      52'b00000000000000000000000000000000000001??????????????: frac_bin_val[12:0] = 13'h1fdb;
      52'b000000000000000000000000000000000000001?????????????: frac_bin_val[12:0] = 13'h1fda;
      52'b0000000000000000000000000000000000000001????????????: frac_bin_val[12:0] = 13'h1fd9;
      52'b00000000000000000000000000000000000000001???????????: frac_bin_val[12:0] = 13'h1fd8;
      52'b000000000000000000000000000000000000000001??????????: frac_bin_val[12:0] = 13'h1fd7;
      52'b0000000000000000000000000000000000000000001?????????: frac_bin_val[12:0] = 13'h1fd6;
      52'b00000000000000000000000000000000000000000001????????: frac_bin_val[12:0] = 13'h1fd5;
      52'b000000000000000000000000000000000000000000001???????: frac_bin_val[12:0] = 13'h1fd4;
      52'b0000000000000000000000000000000000000000000001??????: frac_bin_val[12:0] = 13'h1fd3;
      52'b00000000000000000000000000000000000000000000001?????: frac_bin_val[12:0] = 13'h1fd2;
      52'b000000000000000000000000000000000000000000000001????: frac_bin_val[12:0] = 13'h1fd1;
      52'b0000000000000000000000000000000000000000000000001???: frac_bin_val[12:0] = 13'h1fd0;
      52'b00000000000000000000000000000000000000000000000001??: frac_bin_val[12:0] = 13'h1fcf;
      52'b000000000000000000000000000000000000000000000000001?: frac_bin_val[12:0] = 13'h1fce;
      52'b0000000000000000000000000000000000000000000000000001: frac_bin_val[12:0] = 13'h1fcd;
      52'b0000000000000000000000000000000000000000000000000000: frac_bin_val[12:0] = 13'h1fcc;
      default: frac_bin_val[12:0] = 13'h000;
    endcase
  end
  always @(frac_num[51:0]) begin
    casez (frac_num[51:0])
      52'b1???????????????????????????????????????????????????:
      fanc_shift_num[51:0] = frac_num[51:0];
      52'b01??????????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[50:0], 1'b0};
      52'b001?????????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[49:0], 2'b0};
      52'b0001????????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[48:0], 3'b0};
      52'b00001???????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[47:0], 4'b0};
      52'b000001??????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[46:0], 5'b0};
      52'b0000001?????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[45:0], 6'b0};
      52'b00000001????????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[44:0], 7'b0};
      52'b000000001???????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[43:0], 8'b0};
      52'b0000000001??????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[42:0], 9'b0};
      52'b00000000001?????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[41:0], 10'b0};
      52'b000000000001????????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[40:0], 11'b0};
      52'b0000000000001???????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[39:0], 12'b0};
      52'b00000000000001??????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[38:0], 13'b0};
      52'b000000000000001?????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[37:0], 14'b0};
      52'b0000000000000001????????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[36:0], 15'b0};
      52'b00000000000000001???????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[35:0], 16'b0};
      52'b000000000000000001??????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[34:0], 17'b0};
      52'b0000000000000000001?????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[33:0], 18'b0};
      52'b00000000000000000001????????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[32:0], 19'b0};
      52'b000000000000000000001???????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[31:0], 20'b0};
      52'b0000000000000000000001??????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[30:0], 21'b0};
      52'b00000000000000000000001?????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[29:0], 22'b0};
      52'b000000000000000000000001????????????????????????????:
      fanc_shift_num[51:0] = {frac_num[28:0], 23'b0};
      52'b0000000000000000000000001???????????????????????????:
      fanc_shift_num[51:0] = {frac_num[27:0], 24'b0};
      52'b00000000000000000000000001??????????????????????????:
      fanc_shift_num[51:0] = {frac_num[26:0], 25'b0};
      52'b000000000000000000000000001?????????????????????????:
      fanc_shift_num[51:0] = {frac_num[25:0], 26'b0};
      52'b0000000000000000000000000001????????????????????????:
      fanc_shift_num[51:0] = {frac_num[24:0], 27'b0};
      52'b00000000000000000000000000001???????????????????????:
      fanc_shift_num[51:0] = {frac_num[23:0], 28'b0};
      52'b000000000000000000000000000001??????????????????????:
      fanc_shift_num[51:0] = {frac_num[22:0], 29'b0};
      52'b0000000000000000000000000000001?????????????????????:
      fanc_shift_num[51:0] = {frac_num[21:0], 30'b0};
      52'b00000000000000000000000000000001????????????????????:
      fanc_shift_num[51:0] = {frac_num[20:0], 31'b0};
      52'b000000000000000000000000000000001???????????????????:
      fanc_shift_num[51:0] = {frac_num[19:0], 32'b0};
      52'b0000000000000000000000000000000001??????????????????:
      fanc_shift_num[51:0] = {frac_num[18:0], 33'b0};
      52'b00000000000000000000000000000000001?????????????????:
      fanc_shift_num[51:0] = {frac_num[17:0], 34'b0};
      52'b000000000000000000000000000000000001????????????????:
      fanc_shift_num[51:0] = {frac_num[16:0], 35'b0};
      52'b0000000000000000000000000000000000001???????????????:
      fanc_shift_num[51:0] = {frac_num[15:0], 36'b0};
      52'b00000000000000000000000000000000000001??????????????:
      fanc_shift_num[51:0] = {frac_num[14:0], 37'b0};
      52'b000000000000000000000000000000000000001?????????????:
      fanc_shift_num[51:0] = {frac_num[13:0], 38'b0};
      52'b0000000000000000000000000000000000000001????????????:
      fanc_shift_num[51:0] = {frac_num[12:0], 39'b0};
      52'b00000000000000000000000000000000000000001???????????:
      fanc_shift_num[51:0] = {frac_num[11:0], 40'b0};
      52'b000000000000000000000000000000000000000001??????????:
      fanc_shift_num[51:0] = {frac_num[10:0], 41'b0};
      52'b0000000000000000000000000000000000000000001?????????:
      fanc_shift_num[51:0] = {frac_num[9:0], 42'b0};
      52'b00000000000000000000000000000000000000000001????????:
      fanc_shift_num[51:0] = {frac_num[8:0], 43'b0};
      52'b000000000000000000000000000000000000000000001???????:
      fanc_shift_num[51:0] = {frac_num[7:0], 44'b0};
      52'b0000000000000000000000000000000000000000000001??????:
      fanc_shift_num[51:0] = {frac_num[6:0], 45'b0};
      52'b00000000000000000000000000000000000000000000001?????:
      fanc_shift_num[51:0] = {frac_num[5:0], 46'b0};
      52'b000000000000000000000000000000000000000000000001????:
      fanc_shift_num[51:0] = {frac_num[4:0], 47'b0};
      52'b0000000000000000000000000000000000000000000000001???:
      fanc_shift_num[51:0] = {frac_num[3:0], 48'b0};
      52'b00000000000000000000000000000000000000000000000001??:
      fanc_shift_num[51:0] = {frac_num[2:0], 49'b0};
      52'b000000000000000000000000000000000000000000000000001?:
      fanc_shift_num[51:0] = {frac_num[1:0], 50'b0};
      52'b0000000000000000000000000000000000000000000000000001:
      fanc_shift_num[51:0] = {frac_num[0:0], 51'b0};
      52'b0000000000000000000000000000000000000000000000000000: fanc_shift_num[51:0] = {52'b0};
      default: fanc_shift_num[51:0] = {52'b0};
    endcase
  end
endmodule


module single_file_pa_fdsu_prepare (
    dp_xx_ex1_rm,
    ex1_div,
    ex1_divisor,
    ex1_expnt_adder_op0,
    ex1_expnt_adder_op1,
    ex1_of_result_lfn,
    ex1_op0_id,
    ex1_op0_sign,
    ex1_op1_id,
    ex1_op1_id_vld,
    ex1_op1_sel,
    ex1_oper_id_expnt,
    ex1_oper_id_expnt_f,
    ex1_oper_id_frac,
    ex1_oper_id_frac_f,
    ex1_remainder,
    ex1_result_sign,
    ex1_rm,
    ex1_sqrt,
    fdsu_ex1_sel,
    idu_fpu_ex1_func,
    idu_fpu_ex1_srcf0,
    idu_fpu_ex1_srcf1
);
  input [2 : 0] dp_xx_ex1_rm;
  input ex1_op0_id;
  input ex1_op1_id;
  input ex1_op1_sel;
  input [12:0] ex1_oper_id_expnt_f;
  input [51:0] ex1_oper_id_frac_f;
  input fdsu_ex1_sel;
  input [9 : 0] idu_fpu_ex1_func;
  input [31:0] idu_fpu_ex1_srcf0;
  input [31:0] idu_fpu_ex1_srcf1;
  output ex1_div;
  output [23:0] ex1_divisor;
  output [12:0] ex1_expnt_adder_op0;
  output [12:0] ex1_expnt_adder_op1;
  output ex1_of_result_lfn;
  output ex1_op0_sign;
  output ex1_op1_id_vld;
  output [12:0] ex1_oper_id_expnt;
  output [51:0] ex1_oper_id_frac;
  output [31:0] ex1_remainder;
  output ex1_result_sign;
  output [2 : 0] ex1_rm;
  output ex1_sqrt;
  reg  [ 12:0] ex1_expnt_adder_op1;
  reg          ex1_of_result_lfn;
  wire         div_sign;
  wire [2 : 0] dp_xx_ex1_rm;
  wire         ex1_div;
  wire [ 52:0] ex1_div_noid_nor_srt_op0;
  wire [ 52:0] ex1_div_noid_nor_srt_op1;
  wire [ 52:0] ex1_div_nor_srt_op0;
  wire [ 52:0] ex1_div_nor_srt_op1;
  wire [ 12:0] ex1_div_op0_expnt;
  wire [ 12:0] ex1_div_op1_expnt;
  wire [ 52:0] ex1_div_srt_op0;
  wire [ 52:0] ex1_div_srt_op1;
  wire [ 23:0] ex1_divisor;
  wire         ex1_double;
  wire [ 12:0] ex1_expnt_adder_op0;
  wire         ex1_op0_id;
  wire         ex1_op0_id_nor;
  wire         ex1_op0_sign;
  wire         ex1_op1_id;
  wire         ex1_op1_id_nor;
  wire         ex1_op1_id_vld;
  wire         ex1_op1_sel;
  wire         ex1_op1_sign;
  wire [ 63:0] ex1_oper0;
  wire [ 51:0] ex1_oper0_frac;
  wire [ 12:0] ex1_oper0_id_expnt;
  wire [ 51:0] ex1_oper0_id_frac;
  wire [ 63:0] ex1_oper1;
  wire [ 51:0] ex1_oper1_frac;
  wire [ 12:0] ex1_oper1_id_expnt;
  wire [ 51:0] ex1_oper1_id_frac;
  wire [ 51:0] ex1_oper_frac;
  wire [ 12:0] ex1_oper_id_expnt;
  wire [ 12:0] ex1_oper_id_expnt_f;
  wire [ 51:0] ex1_oper_id_frac;
  wire [ 51:0] ex1_oper_id_frac_f;
  wire [ 31:0] ex1_remainder;
  wire         ex1_result_sign;
  wire [2 : 0] ex1_rm;
  wire         ex1_single;
  wire         ex1_sqrt;
  wire         ex1_sqrt_expnt_odd;
  wire         ex1_sqrt_op0_expnt_0;
  wire [ 12:0] ex1_sqrt_op1_expnt;
  wire [ 52:0] ex1_sqrt_srt_op0;
  wire         fdsu_ex1_sel;
  wire [9 : 0] idu_fpu_ex1_func;
  wire [ 31:0] idu_fpu_ex1_srcf0;
  wire [ 31:0] idu_fpu_ex1_srcf1;
  wire [ 59:0] sqrt_remainder;
  wire         sqrt_sign;
  assign ex1_sqrt            = idu_fpu_ex1_func[0];
  assign ex1_div             = idu_fpu_ex1_func[1];
  assign ex1_oper0[63:0]     = {32'b0, idu_fpu_ex1_srcf0 & {32{fdsu_ex1_sel}}};
  assign ex1_oper1[63:0]     = {32'b0, idu_fpu_ex1_srcf1 & {32{fdsu_ex1_sel}}};
  assign ex1_double          = 1'b0;
  assign ex1_single          = 1'b1;
  assign ex1_op0_id_nor      = ex1_op0_id;
  assign ex1_op1_id_nor      = ex1_op1_id;
  assign ex1_op0_sign        = ex1_double && ex1_oper0[63] || ex1_single && ex1_oper0[31];
  assign ex1_op1_sign        = ex1_double && ex1_oper1[63] || ex1_single && ex1_oper1[31];
  assign div_sign            = ex1_op0_sign ^ ex1_op1_sign;
  assign sqrt_sign           = ex1_op0_sign;
  assign ex1_result_sign     = (ex1_div) ? div_sign : sqrt_sign;
  assign ex1_oper_frac[51:0] = ex1_op1_sel ? ex1_oper1_frac[51:0] : ex1_oper0_frac[51:0];
  single_file_pa_fdsu_ff1 x_frac_expnt (
      .fanc_shift_num(ex1_oper_id_frac[51:0]),
      .frac_bin_val  (ex1_oper_id_expnt[12:0]),
      .frac_num      (ex1_oper_frac[51:0])
  );
  assign ex1_oper0_id_expnt[12:0] = ex1_op1_sel ? ex1_oper_id_expnt_f[12:0]
                                                : ex1_oper_id_expnt[12:0];
  assign ex1_oper0_id_frac[51:0] = ex1_op1_sel ? ex1_oper_id_frac_f[51:0] : ex1_oper_id_frac[51:0];
  assign ex1_oper1_id_expnt[12:0] = ex1_oper_id_expnt[12:0];
  assign ex1_oper1_id_frac[51:0] = ex1_oper_id_frac[51:0];
  assign ex1_oper0_frac[51:0] = {52{ex1_double}} & ex1_oper0[51:0] |
                              {52{ex1_single}} & {ex1_oper0[22:0],29'b0};
  assign ex1_oper1_frac[51:0] = {52{ex1_double}} & ex1_oper1[51:0] |
                              {52{ex1_single}} & {ex1_oper1[22:0],29'b0};
  assign ex1_div_op0_expnt[12:0]  = {13{ex1_double}} & {2'b0,ex1_oper0[62:52]} |
                                  {13{ex1_single}} & {5'b0,ex1_oper0[30:23]};
  assign ex1_expnt_adder_op0[12:0] = ex1_op0_id_nor ? ex1_oper0_id_expnt[12:0]
                                                    : ex1_div_op0_expnt[12:0];
  assign ex1_div_op1_expnt[12:0] = {13{ex1_double}} & {2'b0,ex1_oper1[62:52]} |
                                 {13{ex1_single}} & {5'b0,ex1_oper1[30:23]};
  assign ex1_sqrt_op1_expnt[12:0] = {13{ex1_double}} & {3'b0,{10{1'b1}}} |
                                  {13{ex1_single}} & {6'b0,{7{1'b1}}};
  always @( ex1_oper1_id_expnt[12:0] or ex1_div or ex1_op1_id_nor or
          ex1_sqrt_op1_expnt[12:0] or ex1_sqrt or ex1_div_op1_expnt[12:0])
begin
    case ({
      ex1_div, ex1_sqrt
    })
      2'b10:
      ex1_expnt_adder_op1[12:0] = ex1_op1_id_nor ? ex1_oper1_id_expnt[12:0] :
                                         ex1_div_op1_expnt[12:0];
      2'b01: ex1_expnt_adder_op1[12:0] = ex1_sqrt_op1_expnt[12:0];
      default: ex1_expnt_adder_op1[12:0] = 13'b0;
    endcase
  end
  assign ex1_sqrt_op0_expnt_0 = ex1_op0_id_nor ? ex1_oper_id_expnt[0] : ex1_div_op0_expnt[0];
  assign ex1_sqrt_expnt_odd   = !ex1_sqrt_op0_expnt_0;
  assign ex1_rm[2:0]          = dp_xx_ex1_rm[2:0];
  always @(ex1_rm[2:0] or ex1_result_sign) begin
    case (ex1_rm[2:0])
      3'b000:  ex1_of_result_lfn = 1'b0;
      3'b001:  ex1_of_result_lfn = 1'b1;
      3'b010:  ex1_of_result_lfn = !ex1_result_sign;
      3'b011:  ex1_of_result_lfn = ex1_result_sign;
      3'b100:  ex1_of_result_lfn = 1'b0;
      default: ex1_of_result_lfn = 1'b0;
    endcase
  end
  assign ex1_remainder[31:0] = {32{ex1_div }} & {5'b0,ex1_div_srt_op0[52:28],2'b0} |
                               {32{ex1_sqrt}} & sqrt_remainder[59:28];
  assign ex1_divisor[23:0] = ex1_div_srt_op1[52:29];
  assign ex1_div_srt_op0[52:0] = ex1_div_nor_srt_op0[52:0];
  assign ex1_div_srt_op1[52:0] = ex1_div_nor_srt_op1[52:0];
  assign ex1_div_noid_nor_srt_op0[52:0] = {53{ex1_double}} & {1'b1,ex1_oper0[51:0]} |
                                         {53{ex1_single}} & {1'b1,ex1_oper0[22:0],29'b0};
  assign ex1_div_nor_srt_op0[52:0]    = ex1_op0_id_nor ? {ex1_oper0_id_frac[51:0],1'b0} :
                                         ex1_div_noid_nor_srt_op0[52:0];
  assign ex1_div_noid_nor_srt_op1[52:0] = {53{ex1_double}} & {1'b1,ex1_oper1[51:0]} |
                                         {53{ex1_single}} & {1'b1,ex1_oper1[22:0],29'b0};
  assign ex1_div_nor_srt_op1[52:0]    = ex1_op1_id_nor ? {ex1_oper1_id_frac[51:0],1'b0} :
                                         ex1_div_noid_nor_srt_op1[52:0];
  assign sqrt_remainder[59:0]       = (ex1_sqrt_expnt_odd) ? {5'b0,ex1_sqrt_srt_op0[52:0],2'b0} :
                                         {6'b0,ex1_sqrt_srt_op0[52:0],1'b0};
  assign ex1_sqrt_srt_op0[52:0] = ex1_div_srt_op0[52:0];
  assign ex1_op1_id_vld = ex1_op1_id_nor && ex1_div;
endmodule


module single_file_gated_clk_cell (
    clk_in,
    global_en,
    module_en,
    local_en,
    external_en,
    pad_yy_icg_scan_en,
    clk_out
);
  input clk_in;
  input global_en;
  input module_en;
  input local_en;
  input external_en;
  input pad_yy_icg_scan_en;
  output clk_out;
  wire clk_en_bf_latch;
  wire SE;
  assign clk_en_bf_latch = (global_en && (module_en || local_en)) || external_en;
  assign SE              = pad_yy_icg_scan_en;
  assign clk_out         = clk_in;
endmodule


module single_file_pa_fdsu_srt_single (
    cp0_fpu_icg_en,
    cp0_yy_clk_en,
    ex1_divisor,
    ex1_expnt_adder_op1,
    ex1_oper_id_frac,
    ex1_oper_id_frac_f,
    ex1_pipedown,
    ex1_pipedown_gate,
    ex1_remainder,
    ex1_save_op0,
    ex1_save_op0_gate,
    ex2_expnt_adder_op0,
    ex2_of,
    ex2_pipe_clk,
    ex2_pipedown,
    ex2_potnt_of,
    ex2_potnt_uf,
    ex2_result_inf,
    ex2_result_lfn,
    ex2_rslt_denorm,
    ex2_srt_expnt_rst,
    ex2_srt_first_round,
    ex2_uf,
    ex2_uf_srt_skip,
    ex3_frac_final_rst,
    ex3_pipedown,
    fdsu_ex3_id_srt_skip,
    fdsu_ex3_rem_sign,
    fdsu_ex3_rem_zero,
    fdsu_ex3_result_denorm_round_add_num,
    fdsu_ex4_frac,
    fdsu_yy_div,
    fdsu_yy_of_rm_lfn,
    fdsu_yy_op0_norm,
    fdsu_yy_op1_norm,
    fdsu_yy_sqrt,
    forever_cpuclk,
    pad_yy_icg_scan_en,
    srt_remainder_zero,
    srt_sm_on,
    total_qt_rt_30
);
  input cp0_fpu_icg_en;
  input cp0_yy_clk_en;
  input [23:0] ex1_divisor;
  input [12:0] ex1_expnt_adder_op1;
  input [51:0] ex1_oper_id_frac;
  input ex1_pipedown;
  input ex1_pipedown_gate;
  input [31:0] ex1_remainder;
  input ex1_save_op0;
  input ex1_save_op0_gate;
  input [9 : 0] ex2_expnt_adder_op0;
  input ex2_pipe_clk;
  input ex2_pipedown;
  input ex2_srt_first_round;
  input [25:0] ex3_frac_final_rst;
  input ex3_pipedown;
  input fdsu_yy_div;
  input fdsu_yy_of_rm_lfn;
  input fdsu_yy_op0_norm;
  input fdsu_yy_op1_norm;
  input fdsu_yy_sqrt;
  input forever_cpuclk;
  input pad_yy_icg_scan_en;
  input srt_sm_on;
  output [51:0] ex1_oper_id_frac_f;
  output ex2_of;
  output ex2_potnt_of;
  output ex2_potnt_uf;
  output ex2_result_inf;
  output ex2_result_lfn;
  output ex2_rslt_denorm;
  output [9 : 0] ex2_srt_expnt_rst;
  output ex2_uf;
  output ex2_uf_srt_skip;
  output fdsu_ex3_id_srt_skip;
  output fdsu_ex3_rem_sign;
  output fdsu_ex3_rem_zero;
  output [23:0] fdsu_ex3_result_denorm_round_add_num;
  output [25:0] fdsu_ex4_frac;
  output srt_remainder_zero;
  output [29:0] total_qt_rt_30;
  reg  [ 31:0] cur_rem;
  reg  [7 : 0] digit_bound_1;
  reg  [7 : 0] digit_bound_2;
  reg  [ 23:0] ex2_result_denorm_round_add_num;
  reg          fdsu_ex3_id_srt_skip;
  reg          fdsu_ex3_rem_sign;
  reg          fdsu_ex3_rem_zero;
  reg  [ 23:0] fdsu_ex3_result_denorm_round_add_num;
  reg  [ 29:0] qt_rt_const_shift_std;
  reg  [7 : 0] qtrt_sel_rem;
  reg  [ 31:0] rem_add1_op1;
  reg  [ 31:0] rem_add2_op1;
  reg  [ 25:0] srt_divisor;
  reg  [ 31:0] srt_remainder;
  reg  [ 29:0] total_qt_rt_30;
  reg  [ 29:0] total_qt_rt_30_next;
  reg  [ 29:0] total_qt_rt_minus_30;
  reg  [ 29:0] total_qt_rt_minus_30_next;
  wire [7 : 0] bound1_cmp_result;
  wire         bound1_cmp_sign;
  wire [7 : 0] bound2_cmp_result;
  wire         bound2_cmp_sign;
  wire [3 : 0] bound_sel;
  wire         cp0_fpu_icg_en;
  wire         cp0_yy_clk_en;
  wire [ 31:0] cur_doub_rem_1;
  wire [ 31:0] cur_doub_rem_2;
  wire [ 31:0] cur_rem_1;
  wire [ 31:0] cur_rem_2;
  wire [ 31:0] div_qt_1_rem_add_op1;
  wire [ 31:0] div_qt_2_rem_add_op1;
  wire [ 31:0] div_qt_r1_rem_add_op1;
  wire [ 31:0] div_qt_r2_rem_add_op1;
  wire [ 23:0] ex1_divisor;
  wire         ex1_ex2_pipe_clk;
  wire         ex1_ex2_pipe_clk_en;
  wire [ 12:0] ex1_expnt_adder_op1;
  wire [ 51:0] ex1_oper_id_frac;
  wire [ 51:0] ex1_oper_id_frac_f;
  wire         ex1_pipedown;
  wire         ex1_pipedown_gate;
  wire [ 31:0] ex1_remainder;
  wire         ex1_save_op0;
  wire         ex1_save_op0_gate;
  wire         ex2_div_of;
  wire         ex2_div_uf;
  wire [9 : 0] ex2_expnt_adder_op0;
  wire [9 : 0] ex2_expnt_adder_op1;
  wire         ex2_expnt_of;
  wire [9 : 0] ex2_expnt_result;
  wire         ex2_expnt_uf;
  wire         ex2_id_nor_srt_skip;
  wire         ex2_of;
  wire         ex2_of_plus;
  wire         ex2_pipe_clk;
  wire         ex2_pipedown;
  wire         ex2_potnt_of;
  wire         ex2_potnt_of_pre;
  wire         ex2_potnt_uf;
  wire         ex2_potnt_uf_pre;
  wire         ex2_result_inf;
  wire         ex2_result_lfn;
  wire         ex2_rslt_denorm;
  wire [9 : 0] ex2_sqrt_expnt_result;
  wire [9 : 0] ex2_srt_expnt_rst;
  wire         ex2_srt_first_round;
  wire         ex2_uf;
  wire         ex2_uf_plus;
  wire         ex2_uf_srt_skip;
  wire [ 25:0] ex3_frac_final_rst;
  wire         ex3_pipedown;
  wire         fdsu_ex2_div;
  wire [9 : 0] fdsu_ex2_expnt_rst;
  wire         fdsu_ex2_of_rm_lfn;
  wire         fdsu_ex2_op0_norm;
  wire         fdsu_ex2_op1_norm;
  wire         fdsu_ex2_result_lfn;
  wire         fdsu_ex2_sqrt;
  wire [ 25:0] fdsu_ex4_frac;
  wire         fdsu_yy_div;
  wire         fdsu_yy_of_rm_lfn;
  wire         fdsu_yy_op0_norm;
  wire         fdsu_yy_op1_norm;
  wire         fdsu_yy_sqrt;
  wire         forever_cpuclk;
  wire         pad_yy_icg_scan_en;
  wire         qt_clk;
  wire         qt_clk_en;
  wire [ 29:0] qt_rt_const_pre_sel_q1;
  wire [ 29:0] qt_rt_const_pre_sel_q2;
  wire [ 29:0] qt_rt_const_q1;
  wire [ 29:0] qt_rt_const_q2;
  wire [ 29:0] qt_rt_const_q3;
  wire [ 29:0] qt_rt_const_shift_std_next;
  wire [ 29:0] qt_rt_mins_const_pre_sel_q1;
  wire [ 29:0] qt_rt_mins_const_pre_sel_q2;
  wire         rem_sign;
  wire [ 31:0] sqrt_qt_1_rem_add_op1;
  wire [ 31:0] sqrt_qt_2_rem_add_op1;
  wire [ 31:0] sqrt_qt_r1_rem_add_op1;
  wire [ 31:0] sqrt_qt_r2_rem_add_op1;
  wire         srt_div_clk;
  wire         srt_div_clk_en;
  wire [ 31:0] srt_remainder_nxt;
  wire [ 31:0] srt_remainder_shift;
  wire         srt_remainder_sign;
  wire         srt_remainder_zero;
  wire         srt_sm_on;
  wire [ 29:0] total_qt_rt_pre_sel;
  assign fdsu_ex2_div = fdsu_yy_div;
  assign fdsu_ex2_sqrt = fdsu_yy_sqrt;
  assign fdsu_ex2_op0_norm = fdsu_yy_op0_norm;
  assign fdsu_ex2_op1_norm = fdsu_yy_op1_norm;
  assign fdsu_ex2_of_rm_lfn = fdsu_yy_of_rm_lfn;
  assign fdsu_ex2_result_lfn = 1'b0;
  assign ex2_expnt_result[9:0] = ex2_expnt_adder_op0[9:0] - ex2_expnt_adder_op1[9:0];
  assign ex2_sqrt_expnt_result[9:0] = {ex2_expnt_result[9], ex2_expnt_result[9:1]};
  assign ex2_srt_expnt_rst[9:0] = (fdsu_ex2_sqrt)
                               ? ex2_sqrt_expnt_result[9:0]
                               : ex2_expnt_result[9:0];
  assign fdsu_ex2_expnt_rst[9:0] = ex2_srt_expnt_rst[9:0];
  assign ex2_expnt_of = ~fdsu_ex2_expnt_rst[9] && (fdsu_ex2_expnt_rst[8] ||
                      (fdsu_ex2_expnt_rst[7] && |fdsu_ex2_expnt_rst[6:0]));
  assign ex2_potnt_of_pre = ~fdsu_ex2_expnt_rst[9] &&
                          ~fdsu_ex2_expnt_rst[8] &&
                           fdsu_ex2_expnt_rst[7] &&
                          ~|fdsu_ex2_expnt_rst[6:0];
  assign ex2_potnt_of = ex2_potnt_of_pre && fdsu_ex2_op0_norm && fdsu_ex2_op1_norm && fdsu_ex2_div;
  assign ex2_expnt_uf = fdsu_ex2_expnt_rst[9] && (fdsu_ex2_expnt_rst[8:0] <= 9'h181);
  assign ex2_potnt_uf_pre = &fdsu_ex2_expnt_rst[9:7] &&
                          ~|fdsu_ex2_expnt_rst[6:2] &&
                           fdsu_ex2_expnt_rst[1]   &&
                          !fdsu_ex2_expnt_rst[0];
  assign ex2_potnt_uf     = (ex2_potnt_uf_pre &&
                          fdsu_ex2_op0_norm &&
                          fdsu_ex2_op1_norm &&
                          fdsu_ex2_div) ||
                         (ex2_potnt_uf_pre &&
                          fdsu_ex2_op0_norm);
  assign ex2_of = ex2_of_plus;
  assign ex2_of_plus = ex2_div_of && fdsu_ex2_div;
  assign ex2_div_of = fdsu_ex2_op0_norm && fdsu_ex2_op1_norm && ex2_expnt_of;
  assign ex2_uf = ex2_uf_plus;
  assign ex2_uf_plus = ex2_div_uf && fdsu_ex2_div;
  assign ex2_div_uf = fdsu_ex2_op0_norm && fdsu_ex2_op1_norm && ex2_expnt_uf;
  assign ex2_id_nor_srt_skip = fdsu_ex2_expnt_rst[9] && (fdsu_ex2_expnt_rst[8:0] < 9'h16a);
  assign ex2_uf_srt_skip = ex2_id_nor_srt_skip;
  assign ex2_rslt_denorm = ex2_uf;
  always @(fdsu_ex2_expnt_rst[9:0]) begin
    case (fdsu_ex2_expnt_rst[9:0])
      10'h382: ex2_result_denorm_round_add_num[23:0] = 24'h1;
      10'h381: ex2_result_denorm_round_add_num[23:0] = 24'h2;
      10'h380: ex2_result_denorm_round_add_num[23:0] = 24'h4;
      10'h37f: ex2_result_denorm_round_add_num[23:0] = 24'h8;
      10'h37e: ex2_result_denorm_round_add_num[23:0] = 24'h10;
      10'h37d: ex2_result_denorm_round_add_num[23:0] = 24'h20;
      10'h37c: ex2_result_denorm_round_add_num[23:0] = 24'h40;
      10'h37b: ex2_result_denorm_round_add_num[23:0] = 24'h80;
      10'h37a: ex2_result_denorm_round_add_num[23:0] = 24'h100;
      10'h379: ex2_result_denorm_round_add_num[23:0] = 24'h200;
      10'h378: ex2_result_denorm_round_add_num[23:0] = 24'h400;
      10'h377: ex2_result_denorm_round_add_num[23:0] = 24'h800;
      10'h376: ex2_result_denorm_round_add_num[23:0] = 24'h1000;
      10'h375: ex2_result_denorm_round_add_num[23:0] = 24'h2000;
      10'h374: ex2_result_denorm_round_add_num[23:0] = 24'h4000;
      10'h373: ex2_result_denorm_round_add_num[23:0] = 24'h8000;
      10'h372: ex2_result_denorm_round_add_num[23:0] = 24'h10000;
      10'h371: ex2_result_denorm_round_add_num[23:0] = 24'h20000;
      10'h370: ex2_result_denorm_round_add_num[23:0] = 24'h40000;
      10'h36f: ex2_result_denorm_round_add_num[23:0] = 24'h80000;
      10'h36e: ex2_result_denorm_round_add_num[23:0] = 24'h100000;
      10'h36d: ex2_result_denorm_round_add_num[23:0] = 24'h200000;
      10'h36c: ex2_result_denorm_round_add_num[23:0] = 24'h400000;
      10'h36b: ex2_result_denorm_round_add_num[23:0] = 24'h800000;
      default: ex2_result_denorm_round_add_num[23:0] = 24'h0;
    endcase
  end
  assign ex2_result_inf = ex2_of_plus && !fdsu_ex2_of_rm_lfn;
  assign ex2_result_lfn = fdsu_ex2_result_lfn || ex2_of_plus && fdsu_ex2_of_rm_lfn;
  always @(posedge ex1_ex2_pipe_clk) begin
    if (ex1_pipedown)
      fdsu_ex3_result_denorm_round_add_num[23:0] <= {14'b0, ex1_expnt_adder_op1[9:0]};
    else if (ex2_pipedown)
      fdsu_ex3_result_denorm_round_add_num[23:0] <= ex2_result_denorm_round_add_num[23:0];
    else fdsu_ex3_result_denorm_round_add_num[23:0] <= fdsu_ex3_result_denorm_round_add_num[23:0];
  end
  assign ex2_expnt_adder_op1 = fdsu_ex3_result_denorm_round_add_num[9:0];
  assign ex1_ex2_pipe_clk_en = ex1_pipedown_gate || ex2_pipedown;
  single_file_gated_clk_cell x_ex1_ex2_pipe_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (ex1_ex2_pipe_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (ex1_ex2_pipe_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  always @(posedge ex2_pipe_clk) begin
    if (ex2_pipedown) begin
      fdsu_ex3_rem_sign <= srt_remainder_sign;
      fdsu_ex3_rem_zero <= srt_remainder_zero;
      fdsu_ex3_id_srt_skip <= ex2_id_nor_srt_skip;
    end else begin
      fdsu_ex3_rem_sign <= fdsu_ex3_rem_sign;
      fdsu_ex3_rem_zero <= fdsu_ex3_rem_zero;
      fdsu_ex3_id_srt_skip <= fdsu_ex3_id_srt_skip;
    end
  end
  always @(posedge qt_clk) begin
    if (ex1_pipedown) srt_remainder[31:0] <= ex1_remainder[31:0];
    else if (srt_sm_on) srt_remainder[31:0] <= srt_remainder_nxt[31:0];
    else srt_remainder[31:0] <= srt_remainder[31:0];
  end
  single_file_gated_clk_cell x_srt_div_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (srt_div_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (srt_div_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign srt_div_clk_en = ex1_pipedown_gate || ex1_save_op0_gate || ex3_pipedown;
  always @(posedge srt_div_clk) begin
    if (ex1_save_op0) srt_divisor[25:0] <= {3'b0, {ex1_oper_id_frac[51:29]}};
    else if (ex1_pipedown) srt_divisor[25:0] <= {2'b0, ex1_divisor[23:0]};
    else if (ex3_pipedown) srt_divisor[25:0] <= ex3_frac_final_rst[25:0];
    else srt_divisor[25:0] <= srt_divisor[25:0];
  end
  assign ex1_oper_id_frac_f[51:0] = {srt_divisor[22:0], 29'b0};
  assign fdsu_ex4_frac[25:0] = srt_divisor[25:0];
  assign bound_sel[3:0] = (fdsu_ex2_div)
                        ? srt_divisor[23:20]
                        : (ex2_srt_first_round)
                          ? 4'b1010
                          : total_qt_rt_30[28:25];
  always @(bound_sel[3:0]) begin
    case (bound_sel[3:0])
      4'b0000: begin
        digit_bound_1[7:0] = 8'b11110100;
        digit_bound_2[7:0] = 8'b11010001;
      end
      4'b1000: begin
        digit_bound_1[7:0] = 8'b11111001;
        digit_bound_2[7:0] = 8'b11100111;
      end
      4'b1001: begin
        digit_bound_1[7:0] = 8'b11111001;
        digit_bound_2[7:0] = 8'b11100100;
      end
      4'b1010: begin
        digit_bound_1[7:0] = 8'b11111000;
        digit_bound_2[7:0] = 8'b11100001;
      end
      4'b1011: begin
        digit_bound_1[7:0] = 8'b11110111;
        digit_bound_2[7:0] = 8'b11011111;
      end
      4'b1100: begin
        digit_bound_1[7:0] = 8'b11110111;
        digit_bound_2[7:0] = 8'b11011100;
      end
      4'b1101: begin
        digit_bound_1[7:0] = 8'b11110110;
        digit_bound_2[7:0] = 8'b11011001;
      end
      4'b1110: begin
        digit_bound_1[7:0] = 8'b11110101;
        digit_bound_2[7:0] = 8'b11010111;
      end
      4'b1111: begin
        digit_bound_1[7:0] = 8'b11110100;
        digit_bound_2[7:0] = 8'b11010001;
      end
      default: begin
        digit_bound_1[7:0] = 8'b11111001;
        digit_bound_2[7:0] = 8'b11100111;
      end
    endcase
  end
  assign bound1_cmp_result[7:0] = qtrt_sel_rem[7:0] + digit_bound_1[7:0];
  assign bound2_cmp_result[7:0] = qtrt_sel_rem[7:0] + digit_bound_2[7:0];
  assign bound1_cmp_sign        = bound1_cmp_result[7];
  assign bound2_cmp_sign        = bound2_cmp_result[7];
  assign rem_sign               = srt_remainder[29];
  always @(ex2_srt_first_round or fdsu_ex2_sqrt or srt_remainder[29:21]) begin
    if (ex2_srt_first_round && fdsu_ex2_sqrt)
      qtrt_sel_rem[7:0] = {srt_remainder[29], srt_remainder[27:21]};
    else qtrt_sel_rem[7:0] = srt_remainder[29] ? ~srt_remainder[29:22] : srt_remainder[29:22];
  end
  single_file_gated_clk_cell x_qt_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (qt_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (qt_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign qt_clk_en = srt_sm_on || ex1_pipedown_gate;
  always @(posedge qt_clk) begin
    if (ex1_pipedown) begin
      qt_rt_const_shift_std[29:0] <= {1'b0, 1'b1, 28'b0};
      total_qt_rt_30[29:0]        <= 30'b0;
      total_qt_rt_minus_30[29:0]  <= 30'b0;
    end else if (srt_sm_on) begin
      qt_rt_const_shift_std[29:0] <= qt_rt_const_shift_std_next[29:0];
      total_qt_rt_30[29:0]        <= total_qt_rt_30_next[29:0];
      total_qt_rt_minus_30[29:0]  <= total_qt_rt_minus_30_next[29:0];
    end else begin
      qt_rt_const_shift_std[29:0] <= qt_rt_const_shift_std[29:0];
      total_qt_rt_30[29:0]        <= total_qt_rt_30[29:0];
      total_qt_rt_minus_30[29:0]  <= total_qt_rt_minus_30[29:0];
    end
  end
  assign qt_rt_const_q1[29:0] = qt_rt_const_shift_std[29:0];
  assign qt_rt_const_q2[29:0] = {qt_rt_const_shift_std[28:0], 1'b0};
  assign qt_rt_const_q3[29:0] = qt_rt_const_q1[29:0] | qt_rt_const_q2[29:0];
  assign qt_rt_const_shift_std_next[29:0] = {2'b0, qt_rt_const_shift_std[29:2]};
  assign total_qt_rt_pre_sel[29:0] = (rem_sign) ? total_qt_rt_minus_30[29:0]
                                                : total_qt_rt_30[29:0];
  assign qt_rt_const_pre_sel_q2[29:0] = qt_rt_const_q2[29:0];
  assign qt_rt_mins_const_pre_sel_q2[29:0] = qt_rt_const_q1[29:0];
  assign qt_rt_const_pre_sel_q1[29:0] = (rem_sign) ? qt_rt_const_q3[29:0] : qt_rt_const_q1[29:0];
  assign qt_rt_mins_const_pre_sel_q1[29:0] = (rem_sign) ? qt_rt_const_q2[29:0] : 30'b0;
  always @( qt_rt_const_q3[29:0] or qt_rt_mins_const_pre_sel_q1[29:0] or
          bound1_cmp_sign or total_qt_rt_30[29:0] or
          qt_rt_mins_const_pre_sel_q2[29:0] or total_qt_rt_minus_30[29:0] or
          bound2_cmp_sign or qt_rt_const_pre_sel_q2[29:0] or
          qt_rt_const_pre_sel_q1[29:0] or total_qt_rt_pre_sel[29:0])
begin
    casez ({
      bound1_cmp_sign, bound2_cmp_sign
    })
      2'b00: begin
        total_qt_rt_30_next[29:0] = total_qt_rt_pre_sel[29:0] | qt_rt_const_pre_sel_q2[29:0];
        total_qt_rt_minus_30_next[29:0] = total_qt_rt_pre_sel[29:0]
        | qt_rt_mins_const_pre_sel_q2[29:0];
      end
      2'b01: begin
        total_qt_rt_30_next[29:0] = total_qt_rt_pre_sel[29:0] | qt_rt_const_pre_sel_q1[29:0];
        total_qt_rt_minus_30_next[29:0] = total_qt_rt_pre_sel[29:0]
        | qt_rt_mins_const_pre_sel_q1[29:0];
      end
      2'b1?: begin
        total_qt_rt_30_next[29:0]    = total_qt_rt_30[29:0];
        total_qt_rt_minus_30_next[29:0] = total_qt_rt_minus_30[29:0] | qt_rt_const_q3[29:0];
      end
      default: begin
        total_qt_rt_30_next[29:0]    = 30'b0;
        total_qt_rt_minus_30_next[29:0] = 30'b0;
      end
    endcase
  end
  assign div_qt_1_rem_add_op1[31:0] = ~{3'b0, srt_divisor[23:0], 5'b0};
  assign div_qt_2_rem_add_op1[31:0] = ~{2'b0, srt_divisor[23:0], 6'b0};
  assign div_qt_r1_rem_add_op1[31:0] = {3'b0, srt_divisor[23:0], 5'b0};
  assign div_qt_r2_rem_add_op1[31:0] = {2'b0, srt_divisor[23:0], 6'b0};
  assign sqrt_qt_1_rem_add_op1[31:0] = ~({2'b0, total_qt_rt_30[29:0]} |
                                       {3'b0, qt_rt_const_q1[29:1]});
  assign sqrt_qt_2_rem_add_op1[31:0] = ~({1'b0, total_qt_rt_30[29:0], 1'b0} |
                                       {1'b0, qt_rt_const_q1[29:0], 1'b0});
  assign sqrt_qt_r1_rem_add_op1[31:0] =  {2'b0, total_qt_rt_minus_30[29:0]} |
                                       {1'b0, qt_rt_const_q1[29:0], 1'b0} |
                                       {2'b0, qt_rt_const_q1[29:0]} |
                                       {3'b0, qt_rt_const_q1[29:1]};
  assign sqrt_qt_r2_rem_add_op1[31:0] =  {1'b0,
                                       total_qt_rt_minus_30[29:0], 1'b0} |
                                       {qt_rt_const_q1[29:0], 2'b0} |
                                       {1'b0, qt_rt_const_q1[29:0], 1'b0};
  always @( div_qt_2_rem_add_op1[31:0] or sqrt_qt_r2_rem_add_op1[31:0] or
          sqrt_qt_r1_rem_add_op1[31:0] or rem_sign or
          div_qt_r2_rem_add_op1[31:0] or div_qt_1_rem_add_op1[31:0] or
          sqrt_qt_2_rem_add_op1[31:0] or fdsu_ex2_sqrt or
          div_qt_r1_rem_add_op1[31:0] or sqrt_qt_1_rem_add_op1[31:0])
begin
    case ({
      rem_sign, fdsu_ex2_sqrt
    })
      2'b01: begin
        rem_add1_op1[31:0] = sqrt_qt_1_rem_add_op1[31:0];
        rem_add2_op1[31:0] = sqrt_qt_2_rem_add_op1[31:0];
      end
      2'b00: begin
        rem_add1_op1[31:0] = div_qt_1_rem_add_op1[31:0];
        rem_add2_op1[31:0] = div_qt_2_rem_add_op1[31:0];
      end
      2'b11: begin
        rem_add1_op1[31:0] = sqrt_qt_r1_rem_add_op1[31:0];
        rem_add2_op1[31:0] = sqrt_qt_r2_rem_add_op1[31:0];
      end
      2'b10: begin
        rem_add1_op1[31:0] = div_qt_r1_rem_add_op1[31:0];
        rem_add2_op1[31:0] = div_qt_r2_rem_add_op1[31:0];
      end
      default: begin
        rem_add1_op1[31:0] = 32'b0;
        rem_add2_op1[31:0] = 32'b0;
      end
    endcase
  end
  assign srt_remainder_shift[31:0] = {srt_remainder[31], srt_remainder[28:0], 2'b0};
  assign cur_doub_rem_1[31:0] = srt_remainder_shift[31:0]
    + rem_add1_op1[31:0] + {31'b0, ~rem_sign};
  assign cur_doub_rem_2[31:0] = srt_remainder_shift[31:0]
    + rem_add2_op1[31:0] + {31'b0, ~rem_sign};
  assign cur_rem_1[31:0] = cur_doub_rem_1[31:0];
  assign cur_rem_2[31:0] = cur_doub_rem_2[31:0];
  always @( cur_rem_2[31:0] or bound1_cmp_sign or srt_remainder_shift[31:0] or
          bound2_cmp_sign or cur_rem_1[31:0])
begin
    case ({
      bound1_cmp_sign, bound2_cmp_sign
    })
      2'b00:   cur_rem[31:0] = cur_rem_2[31:0];
      2'b01:   cur_rem[31:0] = cur_rem_1[31:0];
      default: cur_rem[31:0] = srt_remainder_shift[31:0];
    endcase
  end
  assign srt_remainder_nxt[31:0] = cur_rem[31:0];
  assign srt_remainder_zero      = ~|srt_remainder[31:0];
  assign srt_remainder_sign      = srt_remainder[31];
endmodule


module single_file_pa_fdsu_round_single (
    cp0_fpu_icg_en,
    cp0_yy_clk_en,
    ex3_expnt_adjust_result,
    ex3_frac_final_rst,
    ex3_pipedown,
    ex3_rslt_denorm,
    fdsu_ex3_id_srt_skip,
    fdsu_ex3_rem_sign,
    fdsu_ex3_rem_zero,
    fdsu_ex3_result_denorm_round_add_num,
    fdsu_ex4_denorm_to_tiny_frac,
    fdsu_ex4_nx,
    fdsu_ex4_potnt_norm,
    fdsu_ex4_result_nor,
    fdsu_yy_expnt_rst,
    fdsu_yy_result_inf,
    fdsu_yy_result_lfn,
    fdsu_yy_result_sign,
    fdsu_yy_rm,
    fdsu_yy_rslt_denorm,
    forever_cpuclk,
    pad_yy_icg_scan_en,
    total_qt_rt_30
);
  input cp0_fpu_icg_en;
  input cp0_yy_clk_en;
  input ex3_pipedown;
  input fdsu_ex3_id_srt_skip;
  input fdsu_ex3_rem_sign;
  input fdsu_ex3_rem_zero;
  input [23:0] fdsu_ex3_result_denorm_round_add_num;
  input [9:0] fdsu_yy_expnt_rst;
  input fdsu_yy_result_inf;
  input fdsu_yy_result_lfn;
  input fdsu_yy_result_sign;
  input [2:0] fdsu_yy_rm;
  input fdsu_yy_rslt_denorm;
  input forever_cpuclk;
  input pad_yy_icg_scan_en;
  input [29:0] total_qt_rt_30;
  output [9:0] ex3_expnt_adjust_result;
  output [25:0] ex3_frac_final_rst;
  output ex3_rslt_denorm;
  output fdsu_ex4_denorm_to_tiny_frac;
  output fdsu_ex4_nx;
  output [1:0] fdsu_ex4_potnt_norm;
  output fdsu_ex4_result_nor;
  reg         denorm_to_tiny_frac;
  reg         fdsu_ex4_denorm_to_tiny_frac;
  reg         fdsu_ex4_nx;
  reg  [ 1:0] fdsu_ex4_potnt_norm;
  reg         fdsu_ex4_result_nor;
  reg  [25:0] frac_add1_op1;
  reg         frac_add_1;
  reg         frac_orig;
  reg  [25:0] frac_sub1_op1;
  reg         frac_sub_1;
  reg  [27:0] qt_result_single_denorm_for_round;
  reg         single_denorm_lst_frac;
  wire        cp0_fpu_icg_en;
  wire        cp0_yy_clk_en;
  wire        ex3_denorm_eq;
  wire        ex3_denorm_gr;
  wire        ex3_denorm_lst_frac;
  wire        ex3_denorm_nx;
  wire        ex3_denorm_plus;
  wire        ex3_denorm_potnt_norm;
  wire        ex3_denorm_zero;
  wire [ 9:0] ex3_expnt_adjst;
  wire [ 9:0] ex3_expnt_adjust_result;
  wire [25:0] ex3_frac_final_rst;
  wire        ex3_nx;
  wire        ex3_pipe_clk;
  wire        ex3_pipe_clk_en;
  wire        ex3_pipedown;
  wire [ 1:0] ex3_potnt_norm;
  wire        ex3_qt_eq;
  wire        ex3_qt_gr;
  wire        ex3_qt_sing_lo3_not0;
  wire        ex3_qt_sing_lo4_not0;
  wire        ex3_qt_zero;
  wire        ex3_rslt_denorm;
  wire        ex3_rst_eq_1;
  wire        ex3_rst_nor;
  wire        ex3_single_denorm_eq;
  wire        ex3_single_denorm_gr;
  wire        ex3_single_denorm_zero;
  wire        ex3_single_low_not_zero;
  wire [ 9:0] fdsu_ex3_expnt_rst;
  wire        fdsu_ex3_id_srt_skip;
  wire        fdsu_ex3_rem_sign;
  wire        fdsu_ex3_rem_zero;
  wire [23:0] fdsu_ex3_result_denorm_round_add_num;
  wire        fdsu_ex3_result_inf;
  wire        fdsu_ex3_result_lfn;
  wire        fdsu_ex3_result_sign;
  wire [ 2:0] fdsu_ex3_rm;
  wire        fdsu_ex3_rslt_denorm;
  wire [ 9:0] fdsu_yy_expnt_rst;
  wire        fdsu_yy_result_inf;
  wire        fdsu_yy_result_lfn;
  wire        fdsu_yy_result_sign;
  wire [ 2:0] fdsu_yy_rm;
  wire        fdsu_yy_rslt_denorm;
  wire        forever_cpuclk;
  wire [25:0] frac_add1_op1_with_denorm;
  wire [25:0] frac_add1_rst;
  wire        frac_denorm_rdn_add_1;
  wire        frac_denorm_rdn_sub_1;
  wire        frac_denorm_rmm_add_1;
  wire        frac_denorm_rne_add_1;
  wire        frac_denorm_rtz_sub_1;
  wire        frac_denorm_rup_add_1;
  wire        frac_denorm_rup_sub_1;
  wire [25:0] frac_final_rst;
  wire        frac_rdn_add_1;
  wire        frac_rdn_sub_1;
  wire        frac_rmm_add_1;
  wire        frac_rne_add_1;
  wire        frac_rtz_sub_1;
  wire        frac_rup_add_1;
  wire        frac_rup_sub_1;
  wire [25:0] frac_sub1_op1_with_denorm;
  wire [25:0] frac_sub1_rst;
  wire        pad_yy_icg_scan_en;
  wire [29:0] total_qt_rt_30;
  assign fdsu_ex3_result_sign = fdsu_yy_result_sign;
  assign fdsu_ex3_expnt_rst[9:0] = fdsu_yy_expnt_rst[9:0];
  assign fdsu_ex3_result_inf = fdsu_yy_result_inf;
  assign fdsu_ex3_result_lfn = fdsu_yy_result_lfn;
  assign fdsu_ex3_rm[2:0] = fdsu_yy_rm[2:0];
  assign fdsu_ex3_rslt_denorm = fdsu_yy_rslt_denorm;
  assign ex3_qt_sing_lo4_not0 = |total_qt_rt_30[3:0];
  assign ex3_qt_sing_lo3_not0 = |total_qt_rt_30[2:0];
  assign ex3_qt_gr = (total_qt_rt_30[28])
                   ? total_qt_rt_30[4] && ex3_qt_sing_lo4_not0
                   : total_qt_rt_30[3] && ex3_qt_sing_lo3_not0;
  assign ex3_qt_eq = (total_qt_rt_30[28])
                   ? total_qt_rt_30[4] && !ex3_qt_sing_lo4_not0
                   : total_qt_rt_30[3] && !ex3_qt_sing_lo3_not0;
  assign ex3_qt_zero = (total_qt_rt_30[28]) ? ~|total_qt_rt_30[4:0] : ~|total_qt_rt_30[3:0];
  assign ex3_rst_eq_1 = total_qt_rt_30[28] && ~|total_qt_rt_30[27:5];
  assign ex3_denorm_plus = !total_qt_rt_30[28] && (fdsu_ex3_expnt_rst[9:0] == 10'h382);
  assign ex3_denorm_potnt_norm = total_qt_rt_30[28] && (fdsu_ex3_expnt_rst[9:0] == 10'h381);
  assign ex3_rslt_denorm = ex3_denorm_plus || fdsu_ex3_rslt_denorm;
  always @(total_qt_rt_30[28:0] or fdsu_ex3_expnt_rst[9:0]) begin
    case (fdsu_ex3_expnt_rst[9:0])
      10'h382: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[4:0], 23'b0};
        single_denorm_lst_frac = total_qt_rt_30[5];
      end
      10'h381: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[5:0], 22'b0};
        single_denorm_lst_frac = total_qt_rt_30[6];
      end
      10'h380: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[6:0], 21'b0};
        single_denorm_lst_frac = total_qt_rt_30[7];
      end
      10'h37f: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[7:0], 20'b0};
        single_denorm_lst_frac = total_qt_rt_30[8];
      end
      10'h37e: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[8:0], 19'b0};
        single_denorm_lst_frac = total_qt_rt_30[9];
      end
      10'h37d: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[9:0], 18'b0};
        single_denorm_lst_frac = total_qt_rt_30[10];
      end
      10'h37c: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[10:0], 17'b0};
        single_denorm_lst_frac = total_qt_rt_30[11];
      end
      10'h37b: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[11:0], 16'b0};
        single_denorm_lst_frac = total_qt_rt_30[12];
      end
      10'h37a: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[12:0], 15'b0};
        single_denorm_lst_frac = total_qt_rt_30[13];
      end
      10'h379: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[13:0], 14'b0};
        single_denorm_lst_frac = total_qt_rt_30[14];
      end
      10'h378: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[14:0], 13'b0};
        single_denorm_lst_frac = total_qt_rt_30[15];
      end
      10'h377: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[15:0], 12'b0};
        single_denorm_lst_frac = total_qt_rt_30[16];
      end
      10'h376: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[16:0], 11'b0};
        single_denorm_lst_frac = total_qt_rt_30[17];
      end
      10'h375: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[17:0], 10'b0};
        single_denorm_lst_frac = total_qt_rt_30[18];
      end
      10'h374: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[18:0], 9'b0};
        single_denorm_lst_frac = total_qt_rt_30[19];
      end
      10'h373: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[19:0], 8'b0};
        single_denorm_lst_frac = total_qt_rt_30[20];
      end
      10'h372: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[20:0], 7'b0};
        single_denorm_lst_frac = total_qt_rt_30[21];
      end
      10'h371: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[21:0], 6'b0};
        single_denorm_lst_frac = total_qt_rt_30[22];
      end
      10'h370: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[22:0], 5'b0};
        single_denorm_lst_frac = total_qt_rt_30[23];
      end
      10'h36f: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[23:0], 4'b0};
        single_denorm_lst_frac = total_qt_rt_30[24];
      end
      10'h36e: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[24:0], 3'b0};
        single_denorm_lst_frac = total_qt_rt_30[25];
      end
      10'h36d: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[25:0], 2'b0};
        single_denorm_lst_frac = total_qt_rt_30[26];
      end
      10'h36c: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[26:0], 1'b0};
        single_denorm_lst_frac = total_qt_rt_30[27];
      end
      10'h36b: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[27:0]};
        single_denorm_lst_frac = total_qt_rt_30[28];
      end
      default: begin
        qt_result_single_denorm_for_round[27:0] = {total_qt_rt_30[28:1]};
        single_denorm_lst_frac = 1'b0;
      end
    endcase
  end
  assign ex3_single_denorm_eq = qt_result_single_denorm_for_round[27] && !ex3_single_low_not_zero;
  assign ex3_single_low_not_zero = |qt_result_single_denorm_for_round[26:0];
  assign ex3_single_denorm_gr = qt_result_single_denorm_for_round[27] && ex3_single_low_not_zero;
  assign ex3_single_denorm_zero = !qt_result_single_denorm_for_round[27]
                                    && !ex3_single_low_not_zero;
  assign ex3_denorm_eq = ex3_single_denorm_eq;
  assign ex3_denorm_gr = ex3_single_denorm_gr;
  assign ex3_denorm_zero = ex3_single_denorm_zero;
  assign ex3_denorm_lst_frac = single_denorm_lst_frac;
  assign frac_rne_add_1 = ex3_qt_gr || (ex3_qt_eq && !fdsu_ex3_rem_sign);
  assign frac_rtz_sub_1 = ex3_qt_zero && fdsu_ex3_rem_sign;
  assign frac_rup_add_1 = !fdsu_ex3_result_sign
                      && (!ex3_qt_zero || (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
  assign frac_rup_sub_1 = fdsu_ex3_result_sign && (ex3_qt_zero && fdsu_ex3_rem_sign);
  assign frac_rdn_add_1 = fdsu_ex3_result_sign
  && (!ex3_qt_zero || (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
  assign frac_rdn_sub_1 = !fdsu_ex3_result_sign && (ex3_qt_zero && fdsu_ex3_rem_sign);
  assign frac_rmm_add_1 = ex3_qt_gr || (ex3_qt_eq && !fdsu_ex3_rem_sign);
  assign frac_denorm_rne_add_1 = ex3_denorm_gr ||
                                (ex3_denorm_eq &&
                                 ((fdsu_ex3_rem_zero && ex3_denorm_lst_frac) ||
                                  (!fdsu_ex3_rem_zero && !fdsu_ex3_rem_sign)));
  assign frac_denorm_rtz_sub_1 = ex3_denorm_zero && fdsu_ex3_rem_sign;
  assign frac_denorm_rup_add_1 = !fdsu_ex3_result_sign &&
                                (!ex3_denorm_zero ||
                                 (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
  assign frac_denorm_rup_sub_1 = fdsu_ex3_result_sign && (ex3_denorm_zero && fdsu_ex3_rem_sign);
  assign frac_denorm_rdn_add_1 = fdsu_ex3_result_sign &&
                                (!ex3_denorm_zero ||
                                 (!fdsu_ex3_rem_sign && !fdsu_ex3_rem_zero));
  assign frac_denorm_rdn_sub_1 = !fdsu_ex3_result_sign && (ex3_denorm_zero && fdsu_ex3_rem_sign);
  assign frac_denorm_rmm_add_1 = ex3_denorm_gr || (ex3_denorm_eq && !fdsu_ex3_rem_sign);
  always @(fdsu_ex3_rm[2:0] or frac_denorm_rdn_add_1 or frac_rne_add_1 or
         frac_denorm_rdn_sub_1 or fdsu_ex3_result_sign or frac_rup_add_1 or
         frac_denorm_rup_sub_1 or frac_rdn_sub_1 or frac_rtz_sub_1 or
         frac_rdn_add_1 or fdsu_ex3_id_srt_skip or frac_denorm_rtz_sub_1 or
         ex3_rslt_denorm or frac_rup_sub_1 or frac_denorm_rmm_add_1 or
         frac_denorm_rup_add_1 or frac_denorm_rne_add_1 or frac_rmm_add_1) begin
    case (fdsu_ex3_rm[2:0])
      3'b000: begin
        frac_add_1 = ex3_rslt_denorm ? frac_denorm_rne_add_1 : frac_rne_add_1;
        frac_sub_1 = 1'b0;
        frac_orig = ex3_rslt_denorm ? !frac_denorm_rne_add_1 : !frac_rne_add_1;
        denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? 1'b0 : frac_denorm_rne_add_1;
      end
      3'b001: begin
        frac_add_1 = 1'b0;
        frac_sub_1 = ex3_rslt_denorm ? frac_denorm_rtz_sub_1 : frac_rtz_sub_1;
        frac_orig = ex3_rslt_denorm ? !frac_denorm_rtz_sub_1 : !frac_rtz_sub_1;
        denorm_to_tiny_frac = 1'b0;
      end
      3'b010: begin
        frac_add_1 = ex3_rslt_denorm ? frac_denorm_rdn_add_1 : frac_rdn_add_1;
        frac_sub_1 = ex3_rslt_denorm ? frac_denorm_rdn_sub_1 : frac_rdn_sub_1;
        frac_orig = ex3_rslt_denorm ? !frac_denorm_rdn_add_1 && !frac_denorm_rdn_sub_1 :
                  !frac_rdn_add_1 && !frac_rdn_sub_1;
        denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? fdsu_ex3_result_sign : frac_denorm_rdn_add_1;
      end
      3'b011: begin
        frac_add_1 = ex3_rslt_denorm ? frac_denorm_rup_add_1 : frac_rup_add_1;
        frac_sub_1 = ex3_rslt_denorm ? frac_denorm_rup_sub_1 : frac_rup_sub_1;
        frac_orig = ex3_rslt_denorm ? !frac_denorm_rup_add_1 && !frac_denorm_rup_sub_1 :
                  !frac_rup_add_1 && !frac_rup_sub_1;
        denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? !fdsu_ex3_result_sign : frac_denorm_rup_add_1;
      end
      3'b100: begin
        frac_add_1 = ex3_rslt_denorm ? frac_denorm_rmm_add_1 : frac_rmm_add_1;
        frac_sub_1 = 1'b0;
        frac_orig = ex3_rslt_denorm ? !frac_denorm_rmm_add_1 : !frac_rmm_add_1;
        denorm_to_tiny_frac = fdsu_ex3_id_srt_skip ? 1'b0 : frac_denorm_rmm_add_1;
      end
      default: begin
        frac_add_1 = 1'b0;
        frac_sub_1 = 1'b0;
        frac_orig = 1'b0;
        denorm_to_tiny_frac = 1'b0;
      end
    endcase
  end
  always @(total_qt_rt_30[28]) begin
    case (total_qt_rt_30[28])
      1'b0: begin
        frac_add1_op1[25:0] = {2'b0, 24'd1};
        frac_sub1_op1[25:0] = {2'b11, {24{1'b1}}};
      end
      1'b1: begin
        frac_add1_op1[25:0] = {25'd1, 1'b0};
        frac_sub1_op1[25:0] = {{25{1'b1}}, 1'b0};
      end
      default: begin
        frac_add1_op1[25:0] = 26'b0;
        frac_sub1_op1[25:0] = 26'b0;
      end
    endcase
  end
  assign frac_add1_rst[25:0] = {1'b0, total_qt_rt_30[28:4]} + frac_add1_op1_with_denorm[25:0];
  assign frac_add1_op1_with_denorm[25:0] = ex3_rslt_denorm ?
                                         {1'b0, fdsu_ex3_result_denorm_round_add_num[23:0], 1'b0} :
                                         frac_add1_op1[25:0];
  assign frac_sub1_rst[25:0] = (ex3_rst_eq_1)
                              ? {3'b0, {23{1'b1}}}
                              : {1'b0, total_qt_rt_30[28:4]} +
                                frac_sub1_op1_with_denorm[25:0] + {25'b0, ex3_rslt_denorm};
  assign frac_sub1_op1_with_denorm[25:0] = ex3_rslt_denorm ?
                                         ~{1'b0, fdsu_ex3_result_denorm_round_add_num[23:0], 1'b0}
                                         : frac_sub1_op1[25:0];
  assign frac_final_rst[25:0] = (frac_add1_rst[25:0] & {26{frac_add_1}}) |
                              (frac_sub1_rst[25:0] & {26{frac_sub_1}}) |
                              ({1'b0, total_qt_rt_30[28:4]} & {26{frac_orig}});
  assign ex3_rst_nor = !fdsu_ex3_result_inf && !fdsu_ex3_result_lfn;
  assign ex3_nx = ex3_rst_nor && (!ex3_qt_zero || !fdsu_ex3_rem_zero || ex3_denorm_nx);
  assign ex3_denorm_nx = ex3_rslt_denorm && (!ex3_denorm_zero || !fdsu_ex3_rem_zero);
  assign ex3_expnt_adjst[9:0] = 10'h7f;
  assign ex3_expnt_adjust_result[9:0] = fdsu_ex3_expnt_rst[9:0] + ex3_expnt_adjst[9:0];
  assign ex3_potnt_norm[1:0] = {ex3_denorm_plus, ex3_denorm_potnt_norm};
  single_file_gated_clk_cell x_ex3_pipe_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (ex3_pipe_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (ex3_pipe_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign ex3_pipe_clk_en = ex3_pipedown;
  always @(posedge ex3_pipe_clk) begin
    if (ex3_pipedown) begin
      fdsu_ex4_result_nor          <= ex3_rst_nor;
      fdsu_ex4_nx                  <= ex3_nx;
      fdsu_ex4_denorm_to_tiny_frac <= denorm_to_tiny_frac;
      fdsu_ex4_potnt_norm[1:0]     <= ex3_potnt_norm[1:0];
    end else begin
      fdsu_ex4_result_nor          <= fdsu_ex4_result_nor;
      fdsu_ex4_nx                  <= fdsu_ex4_nx;
      fdsu_ex4_denorm_to_tiny_frac <= fdsu_ex4_denorm_to_tiny_frac;
      fdsu_ex4_potnt_norm[1:0]     <= fdsu_ex4_potnt_norm[1:0];
    end
  end
  assign ex3_frac_final_rst[25:0] = frac_final_rst[25:0];
endmodule


module single_file_pa_fdsu_pack_single (
    fdsu_ex4_denorm_to_tiny_frac,
    fdsu_ex4_frac,
    fdsu_ex4_nx,
    fdsu_ex4_potnt_norm,
    fdsu_ex4_result_nor,
    fdsu_frbus_data,
    fdsu_frbus_fflags,
    fdsu_frbus_freg,
    fdsu_yy_expnt_rst,
    fdsu_yy_of,
    fdsu_yy_of_rm_lfn,
    fdsu_yy_potnt_of,
    fdsu_yy_potnt_uf,
    fdsu_yy_result_inf,
    fdsu_yy_result_lfn,
    fdsu_yy_result_sign,
    fdsu_yy_rslt_denorm,
    fdsu_yy_uf,
    fdsu_yy_wb_freg
);
  input fdsu_ex4_denorm_to_tiny_frac;
  input [25:0] fdsu_ex4_frac;
  input fdsu_ex4_nx;
  input [1 : 0] fdsu_ex4_potnt_norm;
  input fdsu_ex4_result_nor;
  input [9 : 0] fdsu_yy_expnt_rst;
  input fdsu_yy_of;
  input fdsu_yy_of_rm_lfn;
  input fdsu_yy_potnt_of;
  input fdsu_yy_potnt_uf;
  input fdsu_yy_result_inf;
  input fdsu_yy_result_lfn;
  input fdsu_yy_result_sign;
  input fdsu_yy_rslt_denorm;
  input fdsu_yy_uf;
  input [4 : 0] fdsu_yy_wb_freg;
  output [31:0] fdsu_frbus_data;
  output [4 : 0] fdsu_frbus_fflags;
  output [4 : 0] fdsu_frbus_freg;
  reg  [ 22:0] ex4_frac_23;
  reg  [ 31:0] ex4_result;
  reg  [ 22:0] ex4_single_denorm_frac;
  reg  [9 : 0] expnt_add_op1;
  wire         ex4_cor_nx;
  wire         ex4_cor_uf;
  wire         ex4_denorm_potnt_norm;
  wire [ 31:0] ex4_denorm_result;
  wire [9 : 0] ex4_expnt_rst;
  wire [4 : 0] ex4_expt;
  wire         ex4_final_rst_norm;
  wire [ 25:0] ex4_frac;
  wire         ex4_of_plus;
  wire         ex4_result_inf;
  wire         ex4_result_lfn;
  wire         ex4_rslt_denorm;
  wire [ 31:0] ex4_rst_inf;
  wire [ 31:0] ex4_rst_lfn;
  wire         ex4_rst_nor;
  wire [ 31:0] ex4_rst_norm;
  wire         ex4_uf_plus;
  wire         fdsu_ex4_denorm_to_tiny_frac;
  wire         fdsu_ex4_dz;
  wire [9 : 0] fdsu_ex4_expnt_rst;
  wire [ 25:0] fdsu_ex4_frac;
  wire         fdsu_ex4_nv;
  wire         fdsu_ex4_nx;
  wire         fdsu_ex4_of;
  wire         fdsu_ex4_of_rst_lfn;
  wire [1 : 0] fdsu_ex4_potnt_norm;
  wire         fdsu_ex4_potnt_of;
  wire         fdsu_ex4_potnt_uf;
  wire         fdsu_ex4_result_inf;
  wire         fdsu_ex4_result_lfn;
  wire         fdsu_ex4_result_nor;
  wire         fdsu_ex4_result_sign;
  wire         fdsu_ex4_rslt_denorm;
  wire         fdsu_ex4_uf;
  wire [ 31:0] fdsu_frbus_data;
  wire [4 : 0] fdsu_frbus_fflags;
  wire [4 : 0] fdsu_frbus_freg;
  wire [9 : 0] fdsu_yy_expnt_rst;
  wire         fdsu_yy_of;
  wire         fdsu_yy_of_rm_lfn;
  wire         fdsu_yy_potnt_of;
  wire         fdsu_yy_potnt_uf;
  wire         fdsu_yy_result_inf;
  wire         fdsu_yy_result_lfn;
  wire         fdsu_yy_result_sign;
  wire         fdsu_yy_rslt_denorm;
  wire         fdsu_yy_uf;
  wire [4 : 0] fdsu_yy_wb_freg;
  assign fdsu_ex4_result_sign    = fdsu_yy_result_sign;
  assign fdsu_ex4_of_rst_lfn     = fdsu_yy_of_rm_lfn;
  assign fdsu_ex4_result_inf     = fdsu_yy_result_inf;
  assign fdsu_ex4_result_lfn     = fdsu_yy_result_lfn;
  assign fdsu_ex4_of             = fdsu_yy_of;
  assign fdsu_ex4_uf             = fdsu_yy_uf;
  assign fdsu_ex4_potnt_of       = fdsu_yy_potnt_of;
  assign fdsu_ex4_potnt_uf       = fdsu_yy_potnt_uf;
  assign fdsu_ex4_nv             = 1'b0;
  assign fdsu_ex4_dz             = 1'b0;
  assign fdsu_ex4_expnt_rst[9:0] = fdsu_yy_expnt_rst[9:0];
  assign fdsu_ex4_rslt_denorm    = fdsu_yy_rslt_denorm;
  assign ex4_frac[25:0]          = fdsu_ex4_frac[25:0];
  always @(ex4_frac[25:24]) begin
    casez (ex4_frac[25:24])
      2'b00:   expnt_add_op1[9:0] = 10'h1ff;
      2'b01:   expnt_add_op1[9:0] = 10'h0;
      2'b1?:   expnt_add_op1[9:0] = 10'h1;
      default: expnt_add_op1[9:0] = 10'b0;
    endcase
  end
  assign ex4_expnt_rst[9:0] = fdsu_ex4_expnt_rst[9:0] + expnt_add_op1[9:0];
  always @(fdsu_ex4_expnt_rst[9:0] or fdsu_ex4_denorm_to_tiny_frac or ex4_frac[25:1]) begin
    case (fdsu_ex4_expnt_rst[9:0])
      10'h1: ex4_single_denorm_frac[22:0] = {ex4_frac[23:1]};
      10'h0: ex4_single_denorm_frac[22:0] = {ex4_frac[24:2]};
      10'h3ff: ex4_single_denorm_frac[22:0] = {ex4_frac[25:3]};
      10'h3fe: ex4_single_denorm_frac[22:0] = {1'b0, ex4_frac[25:4]};
      10'h3fd: ex4_single_denorm_frac[22:0] = {2'b0, ex4_frac[25:5]};
      10'h3fc: ex4_single_denorm_frac[22:0] = {3'b0, ex4_frac[25:6]};
      10'h3fb: ex4_single_denorm_frac[22:0] = {4'b0, ex4_frac[25:7]};
      10'h3fa: ex4_single_denorm_frac[22:0] = {5'b0, ex4_frac[25:8]};
      10'h3f9: ex4_single_denorm_frac[22:0] = {6'b0, ex4_frac[25:9]};
      10'h3f8: ex4_single_denorm_frac[22:0] = {7'b0, ex4_frac[25:10]};
      10'h3f7: ex4_single_denorm_frac[22:0] = {8'b0, ex4_frac[25:11]};
      10'h3f6: ex4_single_denorm_frac[22:0] = {9'b0, ex4_frac[25:12]};
      10'h3f5: ex4_single_denorm_frac[22:0] = {10'b0, ex4_frac[25:13]};
      10'h3f4: ex4_single_denorm_frac[22:0] = {11'b0, ex4_frac[25:14]};
      10'h3f3: ex4_single_denorm_frac[22:0] = {12'b0, ex4_frac[25:15]};
      10'h3f2: ex4_single_denorm_frac[22:0] = {13'b0, ex4_frac[25:16]};
      10'h3f1: ex4_single_denorm_frac[22:0] = {14'b0, ex4_frac[25:17]};
      10'h3f0: ex4_single_denorm_frac[22:0] = {15'b0, ex4_frac[25:18]};
      10'h3ef: ex4_single_denorm_frac[22:0] = {16'b0, ex4_frac[25:19]};
      10'h3ee: ex4_single_denorm_frac[22:0] = {17'b0, ex4_frac[25:20]};
      10'h3ed: ex4_single_denorm_frac[22:0] = {18'b0, ex4_frac[25:21]};
      10'h3ec: ex4_single_denorm_frac[22:0] = {19'b0, ex4_frac[25:22]};
      10'h3eb: ex4_single_denorm_frac[22:0] = {20'b0, ex4_frac[25:23]};
      10'h3ea: ex4_single_denorm_frac[22:0] = {21'b0, ex4_frac[25:24]};
      default:
      ex4_single_denorm_frac[22:0] = fdsu_ex4_denorm_to_tiny_frac ? 23'd1 : 23'b0;
    endcase
  end
  assign ex4_denorm_potnt_norm = (fdsu_ex4_potnt_norm[1] && ex4_frac[24]) ||
                               (fdsu_ex4_potnt_norm[0] && ex4_frac[25]) ;
  assign ex4_rslt_denorm = fdsu_ex4_rslt_denorm && !ex4_denorm_potnt_norm;
  assign ex4_denorm_result[31:0] = {fdsu_ex4_result_sign, 8'h0, ex4_single_denorm_frac[22:0]};
  assign ex4_rst_nor = fdsu_ex4_result_nor;
  assign ex4_of_plus = fdsu_ex4_potnt_of && (|ex4_frac[25:24]) && ex4_rst_nor;
  assign ex4_uf_plus = fdsu_ex4_potnt_uf && (~|ex4_frac[25:24]) && ex4_rst_nor;
  assign ex4_result_lfn = (ex4_of_plus && fdsu_ex4_of_rst_lfn) || fdsu_ex4_result_lfn;
  assign ex4_result_inf = (ex4_of_plus && !fdsu_ex4_of_rst_lfn) || fdsu_ex4_result_inf;
  assign ex4_rst_lfn[31:0] = {fdsu_ex4_result_sign, 8'hfe, {23{1'b1}}};
  assign ex4_rst_inf[31:0] = {fdsu_ex4_result_sign, 8'hff, 23'b0};
  always @(ex4_frac[25:0]) begin
    casez (ex4_frac[25:24])
      2'b00:   ex4_frac_23[22:0] = ex4_frac[22:0];
      2'b01:   ex4_frac_23[22:0] = ex4_frac[23:1];
      2'b1?:   ex4_frac_23[22:0] = ex4_frac[24:2];
      default: ex4_frac_23[22:0] = 23'b0;
    endcase
  end
  assign ex4_rst_norm[31:0] = {fdsu_ex4_result_sign, ex4_expnt_rst[7:0], ex4_frac_23[22:0]};
  assign ex4_cor_uf = (fdsu_ex4_uf || ex4_denorm_potnt_norm || ex4_uf_plus) && fdsu_ex4_nx;
  assign ex4_cor_nx = fdsu_ex4_nx || fdsu_ex4_of || ex4_of_plus;
  assign ex4_expt[4:0] = {
    fdsu_ex4_nv, fdsu_ex4_dz, fdsu_ex4_of | ex4_of_plus, ex4_cor_uf, ex4_cor_nx
  };
  assign ex4_final_rst_norm = !ex4_result_inf && !ex4_result_lfn && !ex4_rslt_denorm;
  always @( ex4_denorm_result[31:0] or ex4_result_lfn or ex4_result_inf or
          ex4_final_rst_norm or ex4_rst_norm[31:0] or ex4_rst_lfn[31:0] or
          ex4_rst_inf[31:0] or ex4_rslt_denorm)
begin
    case ({
      ex4_rslt_denorm, ex4_result_inf, ex4_result_lfn, ex4_final_rst_norm
    })
      4'b1000: ex4_result[31:0] = ex4_denorm_result[31:0];
      4'b0100: ex4_result[31:0] = ex4_rst_inf[31:0];
      4'b0010: ex4_result[31:0] = ex4_rst_lfn[31:0];
      4'b0001: ex4_result[31:0] = ex4_rst_norm[31:0];
      default: ex4_result[31:0] = 32'b0;
    endcase
  end
  assign fdsu_frbus_freg[4:0]   = fdsu_yy_wb_freg[4:0];
  assign fdsu_frbus_data[31:0]  = ex4_result[31:0];
  assign fdsu_frbus_fflags[4:0] = ex4_expt[4:0];
endmodule


module single_file_pa_fdsu_ctrl (
    cp0_fpu_icg_en,
    cp0_yy_clk_en,
    cpurst_b,
    ctrl_fdsu_ex1_sel,
    ctrl_xx_ex1_cmplt_dp,
    ctrl_xx_ex1_inst_vld,
    ctrl_xx_ex1_stall,
    ctrl_xx_ex1_warm_up,
    ctrl_xx_ex2_warm_up,
    ctrl_xx_ex3_warm_up,
    ex1_div,
    ex1_expnt_adder_op0,
    ex1_of_result_lfn,
    ex1_op0_id,
    ex1_op0_norm,
    ex1_op1_id_vld,
    ex1_op1_norm,
    ex1_oper_id_expnt,
    ex1_oper_id_expnt_f,
    ex1_pipedown,
    ex1_pipedown_gate,
    ex1_result_sign,
    ex1_rm,
    ex1_save_op0,
    ex1_save_op0_gate,
    ex1_sqrt,
    ex1_srt_skip,
    ex2_expnt_adder_op0,
    ex2_of,
    ex2_pipe_clk,
    ex2_pipedown,
    ex2_potnt_of,
    ex2_potnt_uf,
    ex2_result_inf,
    ex2_result_lfn,
    ex2_rslt_denorm,
    ex2_srt_expnt_rst,
    ex2_srt_first_round,
    ex2_uf,
    ex2_uf_srt_skip,
    ex3_expnt_adjust_result,
    ex3_pipedown,
    ex3_rslt_denorm,
    fdsu_ex1_sel,
    fdsu_fpu_debug_info,
    fdsu_fpu_ex1_cmplt,
    fdsu_fpu_ex1_cmplt_dp,
    fdsu_fpu_ex1_stall,
    fdsu_fpu_no_op,
    fdsu_frbus_wb_vld,
    fdsu_yy_div,
    fdsu_yy_expnt_rst,
    fdsu_yy_of,
    fdsu_yy_of_rm_lfn,
    fdsu_yy_op0_norm,
    fdsu_yy_op1_norm,
    fdsu_yy_potnt_of,
    fdsu_yy_potnt_uf,
    fdsu_yy_result_inf,
    fdsu_yy_result_lfn,
    fdsu_yy_result_sign,
    fdsu_yy_rm,
    fdsu_yy_rslt_denorm,
    fdsu_yy_sqrt,
    fdsu_yy_uf,
    fdsu_yy_wb_freg,
    forever_cpuclk,
    frbus_fdsu_wb_grant,
    idu_fpu_ex1_dst_freg,
    idu_fpu_ex1_eu_sel,
    pad_yy_icg_scan_en,
    rtu_xx_ex1_cancel,
    rtu_xx_ex2_cancel,
    rtu_yy_xx_async_flush,
    rtu_yy_xx_flush,
    srt_remainder_zero,
    ex1_op1_sel,
    srt_sm_on
);
  input cp0_fpu_icg_en;
  input cp0_yy_clk_en;
  input cpurst_b;
  input ctrl_fdsu_ex1_sel;
  input ctrl_xx_ex1_cmplt_dp;
  input ctrl_xx_ex1_inst_vld;
  input ctrl_xx_ex1_stall;
  input ctrl_xx_ex1_warm_up;
  input ctrl_xx_ex2_warm_up;
  input ctrl_xx_ex3_warm_up;
  input ex1_div;
  input [12:0] ex1_expnt_adder_op0;
  input ex1_of_result_lfn;
  input ex1_op0_id;
  input ex1_op0_norm;
  input ex1_op1_id_vld;
  input ex1_op1_norm;
  input [12:0] ex1_oper_id_expnt;
  input ex1_result_sign;
  input [2 : 0] ex1_rm;
  input ex1_sqrt;
  input ex1_srt_skip;
  input ex2_of;
  input ex2_potnt_of;
  input ex2_potnt_uf;
  input ex2_result_inf;
  input ex2_result_lfn;
  input ex2_rslt_denorm;
  input [9 : 0] ex2_srt_expnt_rst;
  input ex2_uf;
  input ex2_uf_srt_skip;
  input [9 : 0] ex3_expnt_adjust_result;
  input ex3_rslt_denorm;
  input forever_cpuclk;
  input frbus_fdsu_wb_grant;
  input [4 : 0] idu_fpu_ex1_dst_freg;
  input [2 : 0] idu_fpu_ex1_eu_sel;
  input pad_yy_icg_scan_en;
  input rtu_xx_ex1_cancel;
  input rtu_xx_ex2_cancel;
  input rtu_yy_xx_async_flush;
  input rtu_yy_xx_flush;
  input srt_remainder_zero;
  output ex1_op1_sel;
  output [12:0] ex1_oper_id_expnt_f;
  output ex1_pipedown;
  output ex1_pipedown_gate;
  output ex1_save_op0;
  output ex1_save_op0_gate;
  output [9 : 0] ex2_expnt_adder_op0;
  output ex2_pipe_clk;
  output ex2_pipedown;
  output ex2_srt_first_round;
  output ex3_pipedown;
  output fdsu_ex1_sel;
  output [4 : 0] fdsu_fpu_debug_info;
  output fdsu_fpu_ex1_cmplt;
  output fdsu_fpu_ex1_cmplt_dp;
  output fdsu_fpu_ex1_stall;
  output fdsu_fpu_no_op;
  output fdsu_frbus_wb_vld;
  output fdsu_yy_div;
  output [9 : 0] fdsu_yy_expnt_rst;
  output fdsu_yy_of;
  output fdsu_yy_of_rm_lfn;
  output fdsu_yy_op0_norm;
  output fdsu_yy_op1_norm;
  output fdsu_yy_potnt_of;
  output fdsu_yy_potnt_uf;
  output fdsu_yy_result_inf;
  output fdsu_yy_result_lfn;
  output fdsu_yy_result_sign;
  output [2 : 0] fdsu_yy_rm;
  output fdsu_yy_rslt_denorm;
  output fdsu_yy_sqrt;
  output fdsu_yy_uf;
  output [4 : 0] fdsu_yy_wb_freg;
  output srt_sm_on;
  reg          ex2_srt_first_round;
  reg  [2 : 0] fdsu_cur_state;
  reg          fdsu_div;
  reg  [9 : 0] fdsu_expnt_rst;
  reg  [2 : 0] fdsu_next_state;
  reg          fdsu_of;
  reg          fdsu_of_rm_lfn;
  reg          fdsu_potnt_of;
  reg          fdsu_potnt_uf;
  reg          fdsu_result_inf;
  reg          fdsu_result_lfn;
  reg          fdsu_result_sign;
  reg  [2 : 0] fdsu_rm;
  reg          fdsu_sqrt;
  reg          fdsu_uf;
  reg  [4 : 0] fdsu_wb_freg;
  reg          fdsu_yy_rslt_denorm;
  reg  [4 : 0] srt_cnt;
  reg  [1 : 0] wb_cur_state;
  reg  [1 : 0] wb_nxt_state;
  wire         cp0_fpu_icg_en;
  wire         cp0_yy_clk_en;
  wire         cpurst_b;
  wire         ctrl_fdsu_ex1_sel;
  wire         ctrl_fdsu_ex1_stall;
  wire         ctrl_fdsu_wb_vld;
  wire         ctrl_iter_start;
  wire         ctrl_iter_start_gate;
  wire         ctrl_pack;
  wire         ctrl_result_vld;
  wire         ctrl_round;
  wire         ctrl_sm_cmplt;
  wire         ctrl_sm_ex1;
  wire         ctrl_sm_idle;
  wire         ctrl_sm_start;
  wire         ctrl_sm_start_gate;
  wire         ctrl_srt_idle;
  wire         ctrl_srt_itering;
  wire         ctrl_wb_idle;
  wire         ctrl_wb_sm_cmplt;
  wire         ctrl_wb_sm_ex2;
  wire         ctrl_wb_sm_idle;
  wire         ctrl_wfi2;
  wire         ctrl_wfwb;
  wire         ctrl_xx_ex1_cmplt_dp;
  wire         ctrl_xx_ex1_inst_vld;
  wire         ctrl_xx_ex1_stall;
  wire         ctrl_xx_ex1_warm_up;
  wire         ctrl_xx_ex2_warm_up;
  wire         ctrl_xx_ex3_warm_up;
  wire         ex1_div;
  wire [ 12:0] ex1_expnt_adder_op0;
  wire         ex1_of_result_lfn;
  wire         ex1_op0_id;
  wire         ex1_op1_id_vld;
  wire         ex1_op1_sel;
  wire [ 12:0] ex1_oper_id_expnt;
  wire [ 12:0] ex1_oper_id_expnt_f;
  wire         ex1_pipe_clk;
  wire         ex1_pipe_clk_en;
  wire         ex1_pipedown;
  wire         ex1_pipedown_gate;
  wire         ex1_result_sign;
  wire [2 : 0] ex1_rm;
  wire         ex1_save_op0;
  wire         ex1_save_op0_gate;
  wire         ex1_sqrt;
  wire         ex1_srt_skip;
  wire [4 : 0] ex1_wb_freg;
  wire [9 : 0] ex2_expnt_adder_op0;
  wire         ex2_of;
  wire         ex2_pipe_clk;
  wire         ex2_pipe_clk_en;
  wire         ex2_pipedown;
  wire         ex2_potnt_of;
  wire         ex2_potnt_uf;
  wire         ex2_result_inf;
  wire         ex2_result_lfn;
  wire         ex2_rslt_denorm;
  wire [9 : 0] ex2_srt_expnt_rst;
  wire         ex2_uf;
  wire         ex2_uf_srt_skip;
  wire [9 : 0] ex3_expnt_adjust_result;
  wire         ex3_pipedown;
  wire         ex3_rslt_denorm;
  wire         expnt_rst_clk;
  wire         expnt_rst_clk_en;
  wire         fdsu_busy;
  wire         fdsu_clk;
  wire         fdsu_clk_en;
  wire         fdsu_dn_stall;
  wire         fdsu_ex1_inst_vld;
  wire         fdsu_ex1_res_vld;
  wire         fdsu_ex1_sel;
  wire         fdsu_flush;
  wire [4 : 0] fdsu_fpu_debug_info;
  wire         fdsu_fpu_ex1_cmplt;
  wire         fdsu_fpu_ex1_cmplt_dp;
  wire         fdsu_fpu_ex1_stall;
  wire         fdsu_fpu_no_op;
  wire         fdsu_frbus_wb_vld;
  wire         fdsu_op0_norm;
  wire         fdsu_op1_norm;
  wire         fdsu_wb_grant;
  wire         fdsu_yy_div;
  wire [9 : 0] fdsu_yy_expnt_rst;
  wire         fdsu_yy_of;
  wire         fdsu_yy_of_rm_lfn;
  wire         fdsu_yy_op0_norm;
  wire         fdsu_yy_op1_norm;
  wire         fdsu_yy_potnt_of;
  wire         fdsu_yy_potnt_uf;
  wire         fdsu_yy_result_inf;
  wire         fdsu_yy_result_lfn;
  wire         fdsu_yy_result_sign;
  wire [2 : 0] fdsu_yy_rm;
  wire         fdsu_yy_sqrt;
  wire         fdsu_yy_uf;
  wire [4 : 0] fdsu_yy_wb_freg;
  wire         forever_cpuclk;
  wire         frbus_fdsu_wb_grant;
  wire [4 : 0] idu_fpu_ex1_dst_freg;
  wire [2 : 0] idu_fpu_ex1_eu_sel;
  wire         pad_yy_icg_scan_en;
  wire         rtu_xx_ex1_cancel;
  wire         rtu_xx_ex2_cancel;
  wire         rtu_yy_xx_async_flush;
  wire         rtu_yy_xx_flush;
  wire [4 : 0] srt_cnt_ini;
  wire         srt_cnt_zero;
  wire         srt_last_round;
  wire         srt_remainder_zero;
  wire         srt_skip;
  wire         srt_sm_on;
  assign ex1_wb_freg[4:0] = idu_fpu_ex1_dst_freg[4:0];
  assign fdsu_ex1_inst_vld = ctrl_xx_ex1_inst_vld && ctrl_fdsu_ex1_sel;
  assign fdsu_ex1_sel = idu_fpu_ex1_eu_sel[2];
  assign fdsu_ex1_res_vld = fdsu_ex1_inst_vld && ex1_srt_skip;
  assign fdsu_wb_grant = frbus_fdsu_wb_grant;
  assign ctrl_iter_start = ctrl_sm_start && !fdsu_dn_stall
      || ctrl_wfi2;
  assign ctrl_iter_start_gate = ctrl_sm_start_gate && !fdsu_dn_stall
      || ctrl_wfi2;
  assign ctrl_sm_start = fdsu_ex1_inst_vld && ctrl_srt_idle
      && !ex1_srt_skip;
  assign ctrl_sm_start_gate = fdsu_ex1_inst_vld && ctrl_srt_idle;
  assign srt_last_round = (srt_skip ||
      srt_remainder_zero ||
      srt_cnt_zero)
      && ctrl_srt_itering;
  assign srt_skip = ex2_of ||
      ex2_uf_srt_skip;
  assign srt_cnt_zero = ~|srt_cnt[4:0];
  assign fdsu_dn_stall = ctrl_sm_start && ex1_op1_id_vld;
  parameter int IDLE = 3'b000;
  parameter int WFI2 = 3'b001;
  parameter int ITER = 3'b010;
  parameter int RND = 3'b011;
  parameter int PACK = 3'b100;
  parameter int WFWB = 3'b101;
  always @(posedge fdsu_clk or negedge cpurst_b) begin
    if (!cpurst_b) fdsu_cur_state[2:0] <= IDLE;
    else if (fdsu_flush) fdsu_cur_state[2:0] <= IDLE;
    else fdsu_cur_state[2:0] <= fdsu_next_state[2:0];
  end
  always @( ctrl_sm_start
        or fdsu_dn_stall
        or srt_last_round
        or fdsu_cur_state[2:0]
        or fdsu_wb_grant)
begin
    case (fdsu_cur_state[2:0])
      IDLE: begin
        if (ctrl_sm_start)
          if (fdsu_dn_stall) fdsu_next_state[2:0] = WFI2;
          else fdsu_next_state[2:0] = ITER;
        else fdsu_next_state[2:0] = IDLE;
      end
      WFI2: fdsu_next_state[2:0] = ITER;
      ITER: begin
        if (srt_last_round) fdsu_next_state[2:0] = RND;
        else fdsu_next_state[2:0] = ITER;
      end
      RND: fdsu_next_state[2:0] = PACK;
      PACK: begin
        if (fdsu_wb_grant)
          if (ctrl_sm_start)
            if (fdsu_dn_stall) fdsu_next_state[2:0] = WFI2;
            else fdsu_next_state[2:0] = ITER;
          else fdsu_next_state[2:0] = IDLE;
        else fdsu_next_state[2:0] = WFWB;
      end
      WFWB: begin
        if (fdsu_wb_grant)
          if (ctrl_sm_start)
            if (fdsu_dn_stall) fdsu_next_state[2:0] = WFI2;
            else fdsu_next_state[2:0] = ITER;
          else fdsu_next_state[2:0] = IDLE;
        else fdsu_next_state[2:0] = WFWB;
      end
      default: fdsu_next_state[2:0] = IDLE;
    endcase
  end
  assign ctrl_sm_idle = fdsu_cur_state[2:0] == IDLE;
  assign ctrl_wfi2 = fdsu_cur_state[2:0] == WFI2;
  assign ctrl_srt_itering = fdsu_cur_state[2:0] == ITER;
  assign ctrl_round = fdsu_cur_state[2:0] == RND;
  assign ctrl_pack = fdsu_cur_state[2:0] == PACK;
  assign ctrl_wfwb = fdsu_cur_state[2:0] == WFWB;
  assign ctrl_sm_cmplt = ctrl_pack || ctrl_wfwb;
  assign ctrl_srt_idle = ctrl_sm_idle
      || fdsu_wb_grant;
  assign ctrl_sm_ex1 = ctrl_srt_idle || ctrl_wfi2;
  always @(posedge fdsu_clk) begin
    if (fdsu_flush) srt_cnt[4:0] <= 5'b0;
    else if (ctrl_iter_start) srt_cnt[4:0] <= srt_cnt_ini[4:0];
    else if (ctrl_srt_itering) srt_cnt[4:0] <= srt_cnt[4:0] - 5'd1;
    else srt_cnt[4:0] <= srt_cnt[4:0];
  end
  assign srt_cnt_ini[4:0] = 5'b01110;
  always @(posedge fdsu_clk or negedge cpurst_b) begin
    if (!cpurst_b) ex2_srt_first_round <= 1'b0;
    else if (fdsu_flush) ex2_srt_first_round <= 1'b0;
    else if (ex1_pipedown) ex2_srt_first_round <= 1'b1;
    else ex2_srt_first_round <= 1'b0;
  end
  parameter int WB_IDLE = 2'b00,
  WB_EX2 = 2'b10,
  WB_CMPLT = 2'b01;
  always @(posedge fdsu_clk or negedge cpurst_b) begin
    if (!cpurst_b) wb_cur_state[1:0] <= WB_IDLE;
    else if (fdsu_flush) wb_cur_state[1:0] <= WB_IDLE;
    else wb_cur_state[1:0] <= wb_nxt_state[1:0];
  end
  always @( ctrl_fdsu_wb_vld
        or fdsu_dn_stall
        or ctrl_xx_ex1_stall
        or fdsu_ex1_inst_vld
        or ctrl_iter_start
        or fdsu_ex1_res_vld
        or wb_cur_state[1:0])
begin
    case (wb_cur_state[1:0])
      WB_IDLE:
      if (fdsu_ex1_inst_vld)
        if (ctrl_xx_ex1_stall || fdsu_ex1_res_vld || fdsu_dn_stall)
          wb_nxt_state[1:0] = WB_IDLE;
        else wb_nxt_state[1:0] = WB_EX2;
      else wb_nxt_state[1:0] = WB_IDLE;
      WB_EX2:
      if (ctrl_fdsu_wb_vld)
        if (ctrl_iter_start && !ctrl_xx_ex1_stall) wb_nxt_state[1:0] = WB_EX2;
        else wb_nxt_state[1:0] = WB_IDLE;
      else wb_nxt_state[1:0] = WB_CMPLT;
      WB_CMPLT:
      if (ctrl_fdsu_wb_vld)
        if (ctrl_iter_start && !ctrl_xx_ex1_stall) wb_nxt_state[1:0] = WB_EX2;
        else wb_nxt_state[1:0] = WB_IDLE;
      else wb_nxt_state[1:0] = WB_CMPLT;
      default: wb_nxt_state[1:0] = WB_IDLE;
    endcase
  end
  assign ctrl_wb_idle = wb_cur_state[1:0] == WB_IDLE
      || wb_cur_state[1:0] == WB_CMPLT && ctrl_fdsu_wb_vld;
  assign ctrl_wb_sm_idle = wb_cur_state[1:0] == WB_IDLE;
  assign ctrl_wb_sm_ex2 = wb_cur_state[1:0] == WB_EX2;
  assign ctrl_wb_sm_cmplt = wb_cur_state[1:0] == WB_EX2
      || wb_cur_state[1:0] == WB_CMPLT;
  assign ctrl_result_vld = ctrl_sm_cmplt && ctrl_wb_sm_cmplt;
  assign ctrl_fdsu_wb_vld = ctrl_result_vld && frbus_fdsu_wb_grant;
  assign ctrl_fdsu_ex1_stall = fdsu_ex1_inst_vld && !ctrl_sm_ex1 && !ctrl_wb_idle
      || fdsu_ex1_inst_vld && fdsu_dn_stall;
  always @(posedge ex1_pipe_clk) begin
    if (ex1_pipedown) begin
      fdsu_wb_freg[4:0] <= ex1_wb_freg[4:0];
      fdsu_result_sign  <= ex1_result_sign;
      fdsu_of_rm_lfn    <= ex1_of_result_lfn;
      fdsu_div          <= ex1_div;
      fdsu_sqrt         <= ex1_sqrt;
      fdsu_rm[2:0]      <= ex1_rm[2:0];
    end else begin
      fdsu_wb_freg[4:0] <= fdsu_wb_freg[4:0];
      fdsu_result_sign  <= fdsu_result_sign;
      fdsu_of_rm_lfn    <= fdsu_of_rm_lfn;
      fdsu_div          <= fdsu_div;
      fdsu_sqrt         <= fdsu_sqrt;
      fdsu_rm[2:0]      <= fdsu_rm[2:0];
    end
  end
  assign fdsu_op0_norm = 1'b1;
  assign fdsu_op1_norm = 1'b1;
  always @(posedge expnt_rst_clk) begin
    if (ex1_save_op0) fdsu_expnt_rst[9:0] <= ex1_oper_id_expnt[9:0];
    else if (ex1_pipedown)
      fdsu_expnt_rst[9:0] <= ex1_expnt_adder_op0[9:0];
    else if (ex2_pipedown) fdsu_expnt_rst[9:0] <= ex2_srt_expnt_rst[9:0];
    else if (ex3_pipedown)
      fdsu_expnt_rst[9:0] <= ex3_expnt_adjust_result[9:0];
    else fdsu_expnt_rst[9:0] <= fdsu_expnt_rst[9:0];
  end
  assign ex1_oper_id_expnt_f[12:0] = {3'd1, fdsu_expnt_rst[9:0]};
  always @(posedge expnt_rst_clk) begin
    if (ex2_pipedown) fdsu_yy_rslt_denorm <= ex2_rslt_denorm;
    else if (ex3_pipedown) fdsu_yy_rslt_denorm <= ex3_rslt_denorm;
    else fdsu_yy_rslt_denorm <= fdsu_yy_rslt_denorm;
  end
  always @(posedge ex2_pipe_clk) begin
    if (ex2_pipedown) begin
      fdsu_result_inf <= ex2_result_inf;
      fdsu_result_lfn <= ex2_result_lfn;
      fdsu_of         <= ex2_of;
      fdsu_uf         <= ex2_uf;
      fdsu_potnt_of   <= ex2_potnt_of;
      fdsu_potnt_uf   <= ex2_potnt_uf;
    end else begin
      fdsu_result_inf <= fdsu_result_inf;
      fdsu_result_lfn <= fdsu_result_lfn;
      fdsu_of         <= fdsu_of;
      fdsu_uf         <= fdsu_uf;
      fdsu_potnt_of   <= fdsu_potnt_of;
      fdsu_potnt_uf   <= fdsu_potnt_uf;
    end
  end
  assign fdsu_flush = rtu_xx_ex1_cancel && ctrl_wb_idle
      || rtu_xx_ex2_cancel && ctrl_wb_sm_ex2
      || ctrl_xx_ex1_warm_up
      || rtu_yy_xx_async_flush;
  assign fdsu_busy = fdsu_ex1_inst_vld
      || !ctrl_sm_idle
      || !ctrl_wb_sm_idle;
  assign fdsu_clk_en = fdsu_busy
      || !ctrl_sm_idle
      || rtu_yy_xx_flush;
  single_file_gated_clk_cell x_fdsu_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (fdsu_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (fdsu_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign ex1_pipe_clk_en = ex1_pipedown_gate;
  single_file_gated_clk_cell x_ex1_pipe_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (ex1_pipe_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (ex1_pipe_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign ex2_pipe_clk_en = ex2_pipedown;
  single_file_gated_clk_cell x_ex2_pipe_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (ex2_pipe_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (ex2_pipe_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign expnt_rst_clk_en = ex1_save_op0_gate
      || ex1_pipedown_gate || ex2_pipedown || ex3_pipedown;
  single_file_gated_clk_cell x_expnt_rst_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (expnt_rst_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (expnt_rst_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  assign fdsu_yy_wb_freg[4:0] = fdsu_wb_freg[4:0];
  assign fdsu_yy_result_sign = fdsu_result_sign;
  assign fdsu_yy_op0_norm = fdsu_op0_norm;
  assign fdsu_yy_op1_norm = fdsu_op1_norm;
  assign fdsu_yy_of_rm_lfn = fdsu_of_rm_lfn;
  assign fdsu_yy_div = fdsu_div;
  assign fdsu_yy_sqrt = fdsu_sqrt;
  assign fdsu_yy_rm[2:0] = fdsu_rm[2:0];
  assign fdsu_yy_expnt_rst[9:0] = fdsu_expnt_rst[9:0];
  assign ex2_expnt_adder_op0[9:0] = fdsu_expnt_rst[9:0];
  assign fdsu_yy_result_inf = fdsu_result_inf;
  assign fdsu_yy_result_lfn = fdsu_result_lfn;
  assign fdsu_yy_of = fdsu_of;
  assign fdsu_yy_uf = fdsu_uf;
  assign fdsu_yy_potnt_of = fdsu_potnt_of;
  assign fdsu_yy_potnt_uf = fdsu_potnt_uf;
  assign ex1_pipedown = ctrl_iter_start || ctrl_xx_ex1_warm_up;
  assign ex1_pipedown_gate = ctrl_iter_start_gate || ctrl_xx_ex1_warm_up;
  assign ex2_pipedown = ctrl_srt_itering && srt_last_round || ctrl_xx_ex2_warm_up;
  assign ex3_pipedown = ctrl_round || ctrl_xx_ex3_warm_up;
  assign srt_sm_on = ctrl_srt_itering;
  assign fdsu_fpu_ex1_cmplt = fdsu_ex1_inst_vld;
  assign fdsu_fpu_ex1_cmplt_dp = ctrl_xx_ex1_cmplt_dp && idu_fpu_ex1_eu_sel[2];
  assign fdsu_fpu_ex1_stall = ctrl_fdsu_ex1_stall;
  assign fdsu_frbus_wb_vld = ctrl_result_vld;
  assign fdsu_fpu_no_op = !fdsu_busy;
  assign ex1_op1_sel = ctrl_wfi2;
  assign ex1_save_op0 = ctrl_sm_start && ex1_op0_id && ex1_op1_id_vld;
  assign ex1_save_op0_gate = ctrl_sm_start_gate && ex1_op0_id && ex1_op1_id_vld;
  assign fdsu_fpu_debug_info[4:0] = {wb_cur_state[1:0], fdsu_cur_state[2:0]};
endmodule


module single_file_pa_fdsu_top (
    cp0_fpu_icg_en,
    cp0_fpu_xx_dqnan,
    cp0_yy_clk_en,
    cpurst_b,
    ctrl_fdsu_ex1_sel,
    ctrl_xx_ex1_cmplt_dp,
    ctrl_xx_ex1_inst_vld,
    ctrl_xx_ex1_stall,
    ctrl_xx_ex1_warm_up,
    ctrl_xx_ex2_warm_up,
    ctrl_xx_ex3_warm_up,
    dp_xx_ex1_cnan,
    dp_xx_ex1_id,
    dp_xx_ex1_inf,
    dp_xx_ex1_qnan,
    dp_xx_ex1_rm,
    dp_xx_ex1_snan,
    dp_xx_ex1_zero,
    fdsu_fpu_debug_info,
    fdsu_fpu_ex1_cmplt,
    fdsu_fpu_ex1_cmplt_dp,
    fdsu_fpu_ex1_fflags,
    fdsu_fpu_ex1_special_sel,
    fdsu_fpu_ex1_special_sign,
    fdsu_fpu_ex1_stall,
    fdsu_fpu_no_op,
    fdsu_frbus_data,
    fdsu_frbus_fflags,
    fdsu_frbus_freg,
    fdsu_frbus_wb_vld,
    forever_cpuclk,
    frbus_fdsu_wb_grant,
    idu_fpu_ex1_dst_freg,
    idu_fpu_ex1_eu_sel,
    idu_fpu_ex1_func,
    idu_fpu_ex1_srcf0,
    idu_fpu_ex1_srcf1,
    pad_yy_icg_scan_en,
    rtu_xx_ex1_cancel,
    rtu_xx_ex2_cancel,
    rtu_yy_xx_async_flush,
    rtu_yy_xx_flush
);
  input cp0_fpu_icg_en;
  input cp0_fpu_xx_dqnan;
  input cp0_yy_clk_en;
  input cpurst_b;
  input ctrl_fdsu_ex1_sel;
  input ctrl_xx_ex1_cmplt_dp;
  input ctrl_xx_ex1_inst_vld;
  input ctrl_xx_ex1_stall;
  input ctrl_xx_ex1_warm_up;
  input ctrl_xx_ex2_warm_up;
  input ctrl_xx_ex3_warm_up;
  input [2 : 0] dp_xx_ex1_cnan;
  input [2 : 0] dp_xx_ex1_id;
  input [2 : 0] dp_xx_ex1_inf;
  input [2 : 0] dp_xx_ex1_qnan;
  input [2 : 0] dp_xx_ex1_rm;
  input [2 : 0] dp_xx_ex1_snan;
  input [2 : 0] dp_xx_ex1_zero;
  input forever_cpuclk;
  input frbus_fdsu_wb_grant;
  input [4 : 0] idu_fpu_ex1_dst_freg;
  input [2 : 0] idu_fpu_ex1_eu_sel;
  input [9 : 0] idu_fpu_ex1_func;
  input [31:0] idu_fpu_ex1_srcf0;
  input [31:0] idu_fpu_ex1_srcf1;
  input pad_yy_icg_scan_en;
  input rtu_xx_ex1_cancel;
  input rtu_xx_ex2_cancel;
  input rtu_yy_xx_async_flush;
  input rtu_yy_xx_flush;
  output [4 : 0] fdsu_fpu_debug_info;
  output fdsu_fpu_ex1_cmplt;
  output fdsu_fpu_ex1_cmplt_dp;
  output [4 : 0] fdsu_fpu_ex1_fflags;
  output [7 : 0] fdsu_fpu_ex1_special_sel;
  output [3 : 0] fdsu_fpu_ex1_special_sign;
  output fdsu_fpu_ex1_stall;
  output fdsu_fpu_no_op;
  output [31:0] fdsu_frbus_data;
  output [4 : 0] fdsu_frbus_fflags;
  output [4 : 0] fdsu_frbus_freg;
  output fdsu_frbus_wb_vld;
  wire         cp0_fpu_icg_en;
  wire         cp0_fpu_xx_dqnan;
  wire         cp0_yy_clk_en;
  wire         cpurst_b;
  wire         ctrl_fdsu_ex1_sel;
  wire         ctrl_xx_ex1_cmplt_dp;
  wire         ctrl_xx_ex1_inst_vld;
  wire         ctrl_xx_ex1_stall;
  wire         ctrl_xx_ex1_warm_up;
  wire         ctrl_xx_ex2_warm_up;
  wire         ctrl_xx_ex3_warm_up;
  wire [2 : 0] dp_xx_ex1_cnan;
  wire [2 : 0] dp_xx_ex1_id;
  wire [2 : 0] dp_xx_ex1_inf;
  wire [2 : 0] dp_xx_ex1_qnan;
  wire [2 : 0] dp_xx_ex1_rm;
  wire [2 : 0] dp_xx_ex1_snan;
  wire [2 : 0] dp_xx_ex1_zero;
  wire         ex1_div;
  wire [ 23:0] ex1_divisor;
  wire [ 12:0] ex1_expnt_adder_op0;
  wire [ 12:0] ex1_expnt_adder_op1;
  wire         ex1_of_result_lfn;
  wire         ex1_op0_id;
  wire         ex1_op0_norm;
  wire         ex1_op0_sign;
  wire         ex1_op1_id;
  wire         ex1_op1_id_vld;
  wire         ex1_op1_norm;
  wire         ex1_op1_sel;
  wire [ 12:0] ex1_oper_id_expnt;
  wire [ 12:0] ex1_oper_id_expnt_f;
  wire [ 51:0] ex1_oper_id_frac;
  wire [ 51:0] ex1_oper_id_frac_f;
  wire         ex1_pipedown;
  wire         ex1_pipedown_gate;
  wire [ 31:0] ex1_remainder;
  wire         ex1_result_sign;
  wire [2 : 0] ex1_rm;
  wire         ex1_save_op0;
  wire         ex1_save_op0_gate;
  wire         ex1_sqrt;
  wire         ex1_srt_skip;
  wire [9 : 0] ex2_expnt_adder_op0;
  wire         ex2_of;
  wire         ex2_pipe_clk;
  wire         ex2_pipedown;
  wire         ex2_potnt_of;
  wire         ex2_potnt_uf;
  wire         ex2_result_inf;
  wire         ex2_result_lfn;
  wire         ex2_rslt_denorm;
  wire [9 : 0] ex2_srt_expnt_rst;
  wire         ex2_srt_first_round;
  wire         ex2_uf;
  wire         ex2_uf_srt_skip;
  wire [9 : 0] ex3_expnt_adjust_result;
  wire [ 25:0] ex3_frac_final_rst;
  wire         ex3_pipedown;
  wire         ex3_rslt_denorm;
  wire         fdsu_ex1_sel;
  wire         fdsu_ex3_id_srt_skip;
  wire         fdsu_ex3_rem_sign;
  wire         fdsu_ex3_rem_zero;
  wire [ 23:0] fdsu_ex3_result_denorm_round_add_num;
  wire         fdsu_ex4_denorm_to_tiny_frac;
  wire [ 25:0] fdsu_ex4_frac;
  wire         fdsu_ex4_nx;
  wire [1 : 0] fdsu_ex4_potnt_norm;
  wire         fdsu_ex4_result_nor;
  wire [4 : 0] fdsu_fpu_debug_info;
  wire         fdsu_fpu_ex1_cmplt;
  wire         fdsu_fpu_ex1_cmplt_dp;
  wire [4 : 0] fdsu_fpu_ex1_fflags;
  wire [7 : 0] fdsu_fpu_ex1_special_sel;
  wire [3 : 0] fdsu_fpu_ex1_special_sign;
  wire         fdsu_fpu_ex1_stall;
  wire         fdsu_fpu_no_op;
  wire [ 31:0] fdsu_frbus_data;
  wire [4 : 0] fdsu_frbus_fflags;
  wire [4 : 0] fdsu_frbus_freg;
  wire         fdsu_frbus_wb_vld;
  wire         fdsu_yy_div;
  wire [9 : 0] fdsu_yy_expnt_rst;
  wire         fdsu_yy_of;
  wire         fdsu_yy_of_rm_lfn;
  wire         fdsu_yy_op0_norm;
  wire         fdsu_yy_op1_norm;
  wire         fdsu_yy_potnt_of;
  wire         fdsu_yy_potnt_uf;
  wire         fdsu_yy_result_inf;
  wire         fdsu_yy_result_lfn;
  wire         fdsu_yy_result_sign;
  wire [2 : 0] fdsu_yy_rm;
  wire         fdsu_yy_rslt_denorm;
  wire         fdsu_yy_sqrt;
  wire         fdsu_yy_uf;
  wire [4 : 0] fdsu_yy_wb_freg;
  wire         forever_cpuclk;
  wire         frbus_fdsu_wb_grant;
  wire [4 : 0] idu_fpu_ex1_dst_freg;
  wire [2 : 0] idu_fpu_ex1_eu_sel;
  wire [9 : 0] idu_fpu_ex1_func;
  wire [ 31:0] idu_fpu_ex1_srcf0;
  wire [ 31:0] idu_fpu_ex1_srcf1;
  wire         pad_yy_icg_scan_en;
  wire         rtu_xx_ex1_cancel;
  wire         rtu_xx_ex2_cancel;
  wire         rtu_yy_xx_async_flush;
  wire         rtu_yy_xx_flush;
  wire         srt_remainder_zero;
  wire         srt_sm_on;
  wire [ 29:0] total_qt_rt_30;
  single_file_pa_fdsu_special x_pa_fdsu_special (
      .cp0_fpu_xx_dqnan         (cp0_fpu_xx_dqnan),
      .dp_xx_ex1_cnan           (dp_xx_ex1_cnan),
      .dp_xx_ex1_id             (dp_xx_ex1_id),
      .dp_xx_ex1_inf            (dp_xx_ex1_inf),
      .dp_xx_ex1_qnan           (dp_xx_ex1_qnan),
      .dp_xx_ex1_snan           (dp_xx_ex1_snan),
      .dp_xx_ex1_zero           (dp_xx_ex1_zero),
      .ex1_div                  (ex1_div),
      .ex1_op0_id               (ex1_op0_id),
      .ex1_op0_norm             (ex1_op0_norm),
      .ex1_op0_sign             (ex1_op0_sign),
      .ex1_op1_id               (ex1_op1_id),
      .ex1_op1_norm             (ex1_op1_norm),
      .ex1_result_sign          (ex1_result_sign),
      .ex1_sqrt                 (ex1_sqrt),
      .ex1_srt_skip             (ex1_srt_skip),
      .fdsu_fpu_ex1_fflags      (fdsu_fpu_ex1_fflags),
      .fdsu_fpu_ex1_special_sel (fdsu_fpu_ex1_special_sel),
      .fdsu_fpu_ex1_special_sign(fdsu_fpu_ex1_special_sign)
  );
  single_file_pa_fdsu_prepare x_pa_fdsu_prepare (
      .dp_xx_ex1_rm       (dp_xx_ex1_rm),
      .ex1_div            (ex1_div),
      .ex1_divisor        (ex1_divisor),
      .ex1_expnt_adder_op0(ex1_expnt_adder_op0),
      .ex1_expnt_adder_op1(ex1_expnt_adder_op1),
      .ex1_of_result_lfn  (ex1_of_result_lfn),
      .ex1_op0_id         (ex1_op0_id),
      .ex1_op0_sign       (ex1_op0_sign),
      .ex1_op1_id         (ex1_op1_id),
      .ex1_op1_id_vld     (ex1_op1_id_vld),
      .ex1_op1_sel        (ex1_op1_sel),
      .ex1_oper_id_expnt  (ex1_oper_id_expnt),
      .ex1_oper_id_expnt_f(ex1_oper_id_expnt_f),
      .ex1_oper_id_frac   (ex1_oper_id_frac),
      .ex1_oper_id_frac_f (ex1_oper_id_frac_f),
      .ex1_remainder      (ex1_remainder),
      .ex1_result_sign    (ex1_result_sign),
      .ex1_rm             (ex1_rm),
      .ex1_sqrt           (ex1_sqrt),
      .fdsu_ex1_sel       (fdsu_ex1_sel),
      .idu_fpu_ex1_func   (idu_fpu_ex1_func),
      .idu_fpu_ex1_srcf0  (idu_fpu_ex1_srcf0),
      .idu_fpu_ex1_srcf1  (idu_fpu_ex1_srcf1)
  );
  single_file_pa_fdsu_srt_single x_pa_fdsu_srt (
      .cp0_fpu_icg_en                      (cp0_fpu_icg_en),
      .cp0_yy_clk_en                       (cp0_yy_clk_en),
      .ex1_divisor                         (ex1_divisor),
      .ex1_expnt_adder_op1                 (ex1_expnt_adder_op1),
      .ex1_oper_id_frac                    (ex1_oper_id_frac),
      .ex1_oper_id_frac_f                  (ex1_oper_id_frac_f),
      .ex1_pipedown                        (ex1_pipedown),
      .ex1_pipedown_gate                   (ex1_pipedown_gate),
      .ex1_remainder                       (ex1_remainder),
      .ex1_save_op0                        (ex1_save_op0),
      .ex1_save_op0_gate                   (ex1_save_op0_gate),
      .ex2_expnt_adder_op0                 (ex2_expnt_adder_op0),
      .ex2_of                              (ex2_of),
      .ex2_pipe_clk                        (ex2_pipe_clk),
      .ex2_pipedown                        (ex2_pipedown),
      .ex2_potnt_of                        (ex2_potnt_of),
      .ex2_potnt_uf                        (ex2_potnt_uf),
      .ex2_result_inf                      (ex2_result_inf),
      .ex2_result_lfn                      (ex2_result_lfn),
      .ex2_rslt_denorm                     (ex2_rslt_denorm),
      .ex2_srt_expnt_rst                   (ex2_srt_expnt_rst),
      .ex2_srt_first_round                 (ex2_srt_first_round),
      .ex2_uf                              (ex2_uf),
      .ex2_uf_srt_skip                     (ex2_uf_srt_skip),
      .ex3_frac_final_rst                  (ex3_frac_final_rst),
      .ex3_pipedown                        (ex3_pipedown),
      .fdsu_ex3_id_srt_skip                (fdsu_ex3_id_srt_skip),
      .fdsu_ex3_rem_sign                   (fdsu_ex3_rem_sign),
      .fdsu_ex3_rem_zero                   (fdsu_ex3_rem_zero),
      .fdsu_ex3_result_denorm_round_add_num(fdsu_ex3_result_denorm_round_add_num),
      .fdsu_ex4_frac                       (fdsu_ex4_frac),
      .fdsu_yy_div                         (fdsu_yy_div),
      .fdsu_yy_of_rm_lfn                   (fdsu_yy_of_rm_lfn),
      .fdsu_yy_op0_norm                    (fdsu_yy_op0_norm),
      .fdsu_yy_op1_norm                    (fdsu_yy_op1_norm),
      .fdsu_yy_sqrt                        (fdsu_yy_sqrt),
      .forever_cpuclk                      (forever_cpuclk),
      .pad_yy_icg_scan_en                  (pad_yy_icg_scan_en),
      .srt_remainder_zero                  (srt_remainder_zero),
      .srt_sm_on                           (srt_sm_on),
      .total_qt_rt_30                      (total_qt_rt_30)
  );
  single_file_pa_fdsu_round_single x_pa_fdsu_round (
      .cp0_fpu_icg_en                      (cp0_fpu_icg_en),
      .cp0_yy_clk_en                       (cp0_yy_clk_en),
      .ex3_expnt_adjust_result             (ex3_expnt_adjust_result),
      .ex3_frac_final_rst                  (ex3_frac_final_rst),
      .ex3_pipedown                        (ex3_pipedown),
      .ex3_rslt_denorm                     (ex3_rslt_denorm),
      .fdsu_ex3_id_srt_skip                (fdsu_ex3_id_srt_skip),
      .fdsu_ex3_rem_sign                   (fdsu_ex3_rem_sign),
      .fdsu_ex3_rem_zero                   (fdsu_ex3_rem_zero),
      .fdsu_ex3_result_denorm_round_add_num(fdsu_ex3_result_denorm_round_add_num),
      .fdsu_ex4_denorm_to_tiny_frac        (fdsu_ex4_denorm_to_tiny_frac),
      .fdsu_ex4_nx                         (fdsu_ex4_nx),
      .fdsu_ex4_potnt_norm                 (fdsu_ex4_potnt_norm),
      .fdsu_ex4_result_nor                 (fdsu_ex4_result_nor),
      .fdsu_yy_expnt_rst                   (fdsu_yy_expnt_rst),
      .fdsu_yy_result_inf                  (fdsu_yy_result_inf),
      .fdsu_yy_result_lfn                  (fdsu_yy_result_lfn),
      .fdsu_yy_result_sign                 (fdsu_yy_result_sign),
      .fdsu_yy_rm                          (fdsu_yy_rm),
      .fdsu_yy_rslt_denorm                 (fdsu_yy_rslt_denorm),
      .forever_cpuclk                      (forever_cpuclk),
      .pad_yy_icg_scan_en                  (pad_yy_icg_scan_en),
      .total_qt_rt_30                      (total_qt_rt_30)
  );
  single_file_pa_fdsu_pack_single x_pa_fdsu_pack (
      .fdsu_ex4_denorm_to_tiny_frac(fdsu_ex4_denorm_to_tiny_frac),
      .fdsu_ex4_frac               (fdsu_ex4_frac),
      .fdsu_ex4_nx                 (fdsu_ex4_nx),
      .fdsu_ex4_potnt_norm         (fdsu_ex4_potnt_norm),
      .fdsu_ex4_result_nor         (fdsu_ex4_result_nor),
      .fdsu_frbus_data             (fdsu_frbus_data),
      .fdsu_frbus_fflags           (fdsu_frbus_fflags),
      .fdsu_frbus_freg             (fdsu_frbus_freg),
      .fdsu_yy_expnt_rst           (fdsu_yy_expnt_rst),
      .fdsu_yy_of                  (fdsu_yy_of),
      .fdsu_yy_of_rm_lfn           (fdsu_yy_of_rm_lfn),
      .fdsu_yy_potnt_of            (fdsu_yy_potnt_of),
      .fdsu_yy_potnt_uf            (fdsu_yy_potnt_uf),
      .fdsu_yy_result_inf          (fdsu_yy_result_inf),
      .fdsu_yy_result_lfn          (fdsu_yy_result_lfn),
      .fdsu_yy_result_sign         (fdsu_yy_result_sign),
      .fdsu_yy_rslt_denorm         (fdsu_yy_rslt_denorm),
      .fdsu_yy_uf                  (fdsu_yy_uf),
      .fdsu_yy_wb_freg             (fdsu_yy_wb_freg)
  );
  single_file_pa_fdsu_ctrl x_pa_fdsu_ctrl (
      .cp0_fpu_icg_en         (cp0_fpu_icg_en),
      .cp0_yy_clk_en          (cp0_yy_clk_en),
      .cpurst_b               (cpurst_b),
      .ctrl_fdsu_ex1_sel      (ctrl_fdsu_ex1_sel),
      .ctrl_xx_ex1_cmplt_dp   (ctrl_xx_ex1_cmplt_dp),
      .ctrl_xx_ex1_inst_vld   (ctrl_xx_ex1_inst_vld),
      .ctrl_xx_ex1_stall      (ctrl_xx_ex1_stall),
      .ctrl_xx_ex1_warm_up    (ctrl_xx_ex1_warm_up),
      .ctrl_xx_ex2_warm_up    (ctrl_xx_ex2_warm_up),
      .ctrl_xx_ex3_warm_up    (ctrl_xx_ex3_warm_up),
      .ex1_div                (ex1_div),
      .ex1_expnt_adder_op0    (ex1_expnt_adder_op0),
      .ex1_of_result_lfn      (ex1_of_result_lfn),
      .ex1_op0_id             (ex1_op0_id),
      .ex1_op0_norm           (ex1_op0_norm),
      .ex1_op1_id_vld         (ex1_op1_id_vld),
      .ex1_op1_norm           (ex1_op1_norm),
      .ex1_op1_sel            (ex1_op1_sel),
      .ex1_oper_id_expnt      (ex1_oper_id_expnt),
      .ex1_oper_id_expnt_f    (ex1_oper_id_expnt_f),
      .ex1_pipedown           (ex1_pipedown),
      .ex1_pipedown_gate      (ex1_pipedown_gate),
      .ex1_result_sign        (ex1_result_sign),
      .ex1_rm                 (ex1_rm),
      .ex1_save_op0           (ex1_save_op0),
      .ex1_save_op0_gate      (ex1_save_op0_gate),
      .ex1_sqrt               (ex1_sqrt),
      .ex1_srt_skip           (ex1_srt_skip),
      .ex2_expnt_adder_op0    (ex2_expnt_adder_op0),
      .ex2_of                 (ex2_of),
      .ex2_pipe_clk           (ex2_pipe_clk),
      .ex2_pipedown           (ex2_pipedown),
      .ex2_potnt_of           (ex2_potnt_of),
      .ex2_potnt_uf           (ex2_potnt_uf),
      .ex2_result_inf         (ex2_result_inf),
      .ex2_result_lfn         (ex2_result_lfn),
      .ex2_rslt_denorm        (ex2_rslt_denorm),
      .ex2_srt_expnt_rst      (ex2_srt_expnt_rst),
      .ex2_srt_first_round    (ex2_srt_first_round),
      .ex2_uf                 (ex2_uf),
      .ex2_uf_srt_skip        (ex2_uf_srt_skip),
      .ex3_expnt_adjust_result(ex3_expnt_adjust_result),
      .ex3_pipedown           (ex3_pipedown),
      .ex3_rslt_denorm        (ex3_rslt_denorm),
      .fdsu_ex1_sel           (fdsu_ex1_sel),
      .fdsu_fpu_debug_info    (fdsu_fpu_debug_info),
      .fdsu_fpu_ex1_cmplt     (fdsu_fpu_ex1_cmplt),
      .fdsu_fpu_ex1_cmplt_dp  (fdsu_fpu_ex1_cmplt_dp),
      .fdsu_fpu_ex1_stall     (fdsu_fpu_ex1_stall),
      .fdsu_fpu_no_op         (fdsu_fpu_no_op),
      .fdsu_frbus_wb_vld      (fdsu_frbus_wb_vld),
      .fdsu_yy_div            (fdsu_yy_div),
      .fdsu_yy_expnt_rst      (fdsu_yy_expnt_rst),
      .fdsu_yy_of             (fdsu_yy_of),
      .fdsu_yy_of_rm_lfn      (fdsu_yy_of_rm_lfn),
      .fdsu_yy_op0_norm       (fdsu_yy_op0_norm),
      .fdsu_yy_op1_norm       (fdsu_yy_op1_norm),
      .fdsu_yy_potnt_of       (fdsu_yy_potnt_of),
      .fdsu_yy_potnt_uf       (fdsu_yy_potnt_uf),
      .fdsu_yy_result_inf     (fdsu_yy_result_inf),
      .fdsu_yy_result_lfn     (fdsu_yy_result_lfn),
      .fdsu_yy_result_sign    (fdsu_yy_result_sign),
      .fdsu_yy_rm             (fdsu_yy_rm),
      .fdsu_yy_rslt_denorm    (fdsu_yy_rslt_denorm),
      .fdsu_yy_sqrt           (fdsu_yy_sqrt),
      .fdsu_yy_uf             (fdsu_yy_uf),
      .fdsu_yy_wb_freg        (fdsu_yy_wb_freg),
      .forever_cpuclk         (forever_cpuclk),
      .frbus_fdsu_wb_grant    (frbus_fdsu_wb_grant),
      .idu_fpu_ex1_dst_freg   (idu_fpu_ex1_dst_freg),
      .idu_fpu_ex1_eu_sel     (idu_fpu_ex1_eu_sel),
      .pad_yy_icg_scan_en     (pad_yy_icg_scan_en),
      .rtu_xx_ex1_cancel      (rtu_xx_ex1_cancel),
      .rtu_xx_ex2_cancel      (rtu_xx_ex2_cancel),
      .rtu_yy_xx_async_flush  (rtu_yy_xx_async_flush),
      .rtu_yy_xx_flush        (rtu_yy_xx_flush),
      .srt_remainder_zero     (srt_remainder_zero),
      .srt_sm_on              (srt_sm_on)
  );
endmodule


module single_file_pa_fpu_src_type (
    inst_double,
    inst_single,
    src_cnan,
    src_id,
    src_in,
    src_inf,
    src_norm,
    src_qnan,
    src_snan,
    src_zero
);
  input inst_double;
  input inst_single;
  input [63:0] src_in;
  output src_cnan;
  output src_id;
  output src_inf;
  output src_norm;
  output src_qnan;
  output src_snan;
  output src_zero;
  wire        inst_double;
  wire        inst_single;
  wire [63:0] src;
  wire        src_cnan;
  wire        src_expn_max;
  wire        src_expn_zero;
  wire        src_frac_msb;
  wire        src_frac_zero;
  wire        src_id;
  wire [63:0] src_in;
  wire        src_inf;
  wire        src_norm;
  wire        src_qnan;
  wire        src_snan;
  wire        src_zero;
  assign src[63:0]     = src_in[63:0];
  assign src_cnan      = !(&src[63:32]) && inst_single;
  assign src_expn_zero = !(|src[62:52]) && inst_double || !(|src[30:23]) && inst_single;
  assign src_expn_max  = (&src[62:52]) && inst_double || (&src[30:23]) && inst_single;
  assign src_frac_zero = !(|src[51:0]) && inst_double || !(|src[22:0]) && inst_single;
  assign src_frac_msb  = src[51] && inst_double || src[22] && inst_single;
  assign src_snan      = src_expn_max && !src_frac_msb && !src_frac_zero && !src_cnan;
  assign src_qnan      = src_expn_max && src_frac_msb || src_cnan;
  assign src_zero      = src_expn_zero && src_frac_zero && !src_cnan;
  assign src_id        = src_expn_zero && !src_frac_zero && !src_cnan;
  assign src_inf       = src_expn_max && src_frac_zero && !src_cnan;
  assign src_norm      = !(src_expn_zero && src_frac_zero) && !src_expn_max && !src_cnan;
endmodule


module single_file_pa_fpu_dp (
    cp0_fpu_icg_en,
    cp0_fpu_xx_rm,
    cp0_yy_clk_en,
    ctrl_xx_ex1_inst_vld,
    ctrl_xx_ex1_stall,
    ctrl_xx_ex1_warm_up,
    dp_frbus_ex2_data,
    dp_frbus_ex2_fflags,
    dp_xx_ex1_cnan,
    dp_xx_ex1_id,
    dp_xx_ex1_inf,
    dp_xx_ex1_norm,
    dp_xx_ex1_qnan,
    dp_xx_ex1_snan,
    dp_xx_ex1_zero,
    ex2_inst_wb,
    fdsu_fpu_ex1_fflags,
    fdsu_fpu_ex1_special_sel,
    fdsu_fpu_ex1_special_sign,
    forever_cpuclk,
    idu_fpu_ex1_eu_sel,
    idu_fpu_ex1_func,
    idu_fpu_ex1_gateclk_vld,
    idu_fpu_ex1_rm,
    idu_fpu_ex1_srcf0,
    idu_fpu_ex1_srcf1,
    idu_fpu_ex1_srcf2,
    pad_yy_icg_scan_en
);
  input cp0_fpu_icg_en;
  input [2 : 0] cp0_fpu_xx_rm;
  input cp0_yy_clk_en;
  input ctrl_xx_ex1_inst_vld;
  input ctrl_xx_ex1_stall;
  input ctrl_xx_ex1_warm_up;
  input [4 : 0] fdsu_fpu_ex1_fflags;
  input [7 : 0] fdsu_fpu_ex1_special_sel;
  input [3 : 0] fdsu_fpu_ex1_special_sign;
  input forever_cpuclk;
  input [2 : 0] idu_fpu_ex1_eu_sel;
  input [9 : 0] idu_fpu_ex1_func;
  input idu_fpu_ex1_gateclk_vld;
  input [2 : 0] idu_fpu_ex1_rm;
  input [31:0] idu_fpu_ex1_srcf0;
  input [31:0] idu_fpu_ex1_srcf1;
  input [31:0] idu_fpu_ex1_srcf2;
  input pad_yy_icg_scan_en;
  output [31:0] dp_frbus_ex2_data;
  output [4 : 0] dp_frbus_ex2_fflags;
  output [2 : 0] dp_xx_ex1_cnan;
  output [2 : 0] dp_xx_ex1_id;
  output [2 : 0] dp_xx_ex1_inf;
  output [2 : 0] dp_xx_ex1_norm;
  output [2 : 0] dp_xx_ex1_qnan;
  output [2 : 0] dp_xx_ex1_snan;
  output [2 : 0] dp_xx_ex1_zero;
  output ex2_inst_wb;
  reg  [4 : 0] ex1_fflags;
  reg  [ 31:0] ex1_special_data;
  reg  [8 : 0] ex1_special_sel;
  reg  [3 : 0] ex1_special_sign;
  reg  [4 : 0] ex2_fflags;
  reg  [ 31:0] ex2_result;
  reg  [ 31:0] ex2_special_data;
  reg  [6 : 0] ex2_special_sel;
  reg  [3 : 0] ex2_special_sign;
  wire         cp0_fpu_icg_en;
  wire [2 : 0] cp0_fpu_xx_rm;
  wire         cp0_yy_clk_en;
  wire         ctrl_xx_ex1_inst_vld;
  wire         ctrl_xx_ex1_stall;
  wire         ctrl_xx_ex1_warm_up;
  wire [ 31:0] dp_frbus_ex2_data;
  wire [4 : 0] dp_frbus_ex2_fflags;
  wire [2 : 0] dp_xx_ex1_cnan;
  wire [2 : 0] dp_xx_ex1_id;
  wire [2 : 0] dp_xx_ex1_inf;
  wire [2 : 0] dp_xx_ex1_norm;
  wire [2 : 0] dp_xx_ex1_qnan;
  wire [2 : 0] dp_xx_ex1_snan;
  wire [2 : 0] dp_xx_ex1_zero;
  wire [2 : 0] ex1_decode_rm;
  wire         ex1_double;
  wire [2 : 0] ex1_eu_sel;
  wire [9 : 0] ex1_func;
  wire [2 : 0] ex1_global_rm;
  wire [2 : 0] ex1_rm;
  wire         ex1_single;
  wire [ 31:0] ex1_special_data_final;
  wire [ 63:0] ex1_src0;
  wire [ 63:0] ex1_src1;
  wire [ 63:0] ex1_src2;
  wire         ex1_src2_vld;
  wire [2 : 0] ex1_src_cnan;
  wire [2 : 0] ex1_src_id;
  wire [2 : 0] ex1_src_inf;
  wire [2 : 0] ex1_src_norm;
  wire [2 : 0] ex1_src_qnan;
  wire [2 : 0] ex1_src_snan;
  wire [2 : 0] ex1_src_zero;
  wire         ex2_data_clk;
  wire         ex2_data_clk_en;
  wire         ex2_inst_wb;
  wire [4 : 0] fdsu_fpu_ex1_fflags;
  wire [7 : 0] fdsu_fpu_ex1_special_sel;
  wire [3 : 0] fdsu_fpu_ex1_special_sign;
  wire         forever_cpuclk;
  wire [2 : 0] idu_fpu_ex1_eu_sel;
  wire [9 : 0] idu_fpu_ex1_func;
  wire         idu_fpu_ex1_gateclk_vld;
  wire [2 : 0] idu_fpu_ex1_rm;
  wire [ 31:0] idu_fpu_ex1_srcf0;
  wire [ 31:0] idu_fpu_ex1_srcf1;
  wire [ 31:0] idu_fpu_ex1_srcf2;
  wire         pad_yy_icg_scan_en;
  parameter int DOUBLE_WIDTH = 64;
  parameter int SINGLE_WIDTH = 32;
  parameter int FUNC_WIDTH = 10;
  assign ex1_eu_sel[2:0] = idu_fpu_ex1_eu_sel[2:0];
  assign ex1_func[FUNC_WIDTH-1:0] = idu_fpu_ex1_func[FUNC_WIDTH-1:0];
  assign ex1_global_rm[2:0] = cp0_fpu_xx_rm[2:0];
  assign ex1_decode_rm[2:0] = idu_fpu_ex1_rm[2:0];
  assign ex1_rm[2:0] = (ex1_decode_rm[2:0] == 3'b111) ? ex1_global_rm[2:0] : ex1_decode_rm[2:0];
  assign ex1_src2_vld = idu_fpu_ex1_eu_sel[1] && ex1_func[0];
  assign ex1_src0[DOUBLE_WIDTH-1:0] = {{SINGLE_WIDTH{1'b1}}, idu_fpu_ex1_srcf0[SINGLE_WIDTH-1:0]};
  assign ex1_src1[DOUBLE_WIDTH-1:0] = {{SINGLE_WIDTH{1'b1}}, idu_fpu_ex1_srcf1[SINGLE_WIDTH-1:0]};
  assign ex1_src2[DOUBLE_WIDTH-1:0]  = ex1_src2_vld ?
                                     { {SINGLE_WIDTH{1'b1}}, idu_fpu_ex1_srcf2[SINGLE_WIDTH-1:0]} :
                                     { {SINGLE_WIDTH{1'b1}}, {SINGLE_WIDTH{1'b0}} };
  assign ex1_double = 1'b0;
  assign ex1_single = 1'b1;
  single_file_pa_fpu_src_type x_pa_fpu_ex1_srcf0_type (
      .inst_double(ex1_double),
      .inst_single(ex1_single),
      .src_cnan   (ex1_src_cnan[0]),
      .src_id     (ex1_src_id[0]),
      .src_in     (ex1_src0),
      .src_inf    (ex1_src_inf[0]),
      .src_norm   (ex1_src_norm[0]),
      .src_qnan   (ex1_src_qnan[0]),
      .src_snan   (ex1_src_snan[0]),
      .src_zero   (ex1_src_zero[0])
  );
  single_file_pa_fpu_src_type x_pa_fpu_ex1_srcf1_type (
      .inst_double(ex1_double),
      .inst_single(ex1_single),
      .src_cnan   (ex1_src_cnan[1]),
      .src_id     (ex1_src_id[1]),
      .src_in     (ex1_src1),
      .src_inf    (ex1_src_inf[1]),
      .src_norm   (ex1_src_norm[1]),
      .src_qnan   (ex1_src_qnan[1]),
      .src_snan   (ex1_src_snan[1]),
      .src_zero   (ex1_src_zero[1])
  );
  single_file_pa_fpu_src_type x_pa_fpu_ex1_srcf2_type (
      .inst_double(ex1_double),
      .inst_single(ex1_single),
      .src_cnan   (ex1_src_cnan[2]),
      .src_id     (ex1_src_id[2]),
      .src_in     (ex1_src2),
      .src_inf    (ex1_src_inf[2]),
      .src_norm   (ex1_src_norm[2]),
      .src_qnan   (ex1_src_qnan[2]),
      .src_snan   (ex1_src_snan[2]),
      .src_zero   (ex1_src_zero[2])
  );
  assign dp_xx_ex1_cnan[2:0] = ex1_src_cnan[2:0];
  assign dp_xx_ex1_snan[2:0] = ex1_src_snan[2:0];
  assign dp_xx_ex1_qnan[2:0] = ex1_src_qnan[2:0];
  assign dp_xx_ex1_norm[2:0] = ex1_src_norm[2:0];
  assign dp_xx_ex1_zero[2:0] = ex1_src_zero[2:0];
  assign dp_xx_ex1_inf[2:0]  = ex1_src_inf[2:0];
  assign dp_xx_ex1_id[2:0]   = ex1_src_id[2:0];
  always @( fdsu_fpu_ex1_special_sign[3:0] or fdsu_fpu_ex1_fflags[4:0] or
          ex1_eu_sel[2:0] or fdsu_fpu_ex1_special_sel[7:0])
begin
    case (ex1_eu_sel[2:0])
      3'b100: begin
        ex1_fflags[4:0]       = fdsu_fpu_ex1_fflags[4:0];
        ex1_special_sel[8:0]  = {1'b0, fdsu_fpu_ex1_special_sel[7:0]};
        ex1_special_sign[3:0] = fdsu_fpu_ex1_special_sign[3:0];
      end
      default: begin
        ex1_fflags[4:0]       = {5{1'b0}};
        ex1_special_sel[8:0]  = {9{1'b0}};
        ex1_special_sign[3:0] = {4{1'b0}};
      end
    endcase
  end
  always @(ex1_special_sel[8:5] or ex1_src0[31:0] or ex1_src1[31:0] or ex1_src2[31:0]) begin
    case (ex1_special_sel[8:5])
      4'b0001: ex1_special_data[SINGLE_WIDTH-1:0] = ex1_src0[SINGLE_WIDTH-1:0];
      4'b0010: ex1_special_data[SINGLE_WIDTH-1:0] = ex1_src1[SINGLE_WIDTH-1:0];
      4'b0100: ex1_special_data[SINGLE_WIDTH-1:0] = ex1_src2[SINGLE_WIDTH-1:0];
      default: ex1_special_data[SINGLE_WIDTH-1:0] = ex1_src2[SINGLE_WIDTH-1:0];
    endcase
  end
  assign ex1_special_data_final[SINGLE_WIDTH-1:0] = ex1_special_data[SINGLE_WIDTH-1:0];
  assign ex2_data_clk_en = idu_fpu_ex1_gateclk_vld || ctrl_xx_ex1_warm_up;
  single_file_gated_clk_cell x_fpu_data_ex2_gated_clk (
      .clk_in            (forever_cpuclk),
      .clk_out           (ex2_data_clk),
      .external_en       (1'b0),
      .global_en         (cp0_yy_clk_en),
      .local_en          (ex2_data_clk_en),
      .module_en         (cp0_fpu_icg_en),
      .pad_yy_icg_scan_en(pad_yy_icg_scan_en)
  );
  always @(posedge ex2_data_clk) begin
    if (ctrl_xx_ex1_inst_vld && !ctrl_xx_ex1_stall || ctrl_xx_ex1_warm_up) begin
      ex2_fflags[4:0] <= ex1_fflags[4:0];
      ex2_special_sign[3:0] <= ex1_special_sign[3:0];
      ex2_special_sel[6:0] <= {ex1_special_sel[8], |ex1_special_sel[7:5], ex1_special_sel[4:0]};
      ex2_special_data[SINGLE_WIDTH-1:0] <= ex1_special_data_final[SINGLE_WIDTH-1:0];
    end
  end
  assign ex2_inst_wb = (|ex2_special_sel[6:0]);
  always @(ex2_special_sel[6:0] or ex2_special_data[31:0] or ex2_special_sign[3:0]) begin
    case (ex2_special_sel[6:0])
      7'b0000_001:
      ex2_result[SINGLE_WIDTH-1:0] = {ex2_special_sign[0], ex2_special_data[SINGLE_WIDTH-2:0]};
      7'b0000_010: ex2_result[SINGLE_WIDTH-1:0] = {ex2_special_sign[1], {31{1'b0}}};
      7'b0000_100: ex2_result[SINGLE_WIDTH-1:0] = {ex2_special_sign[2], {8{1'b1}}, {23{1'b0}}};
      7'b0001_000:
      ex2_result[SINGLE_WIDTH-1:0] = {ex2_special_sign[3], {7{1'b1}}, 1'b0, {23{1'b1}}};
      7'b0010_000: ex2_result[SINGLE_WIDTH-1:0] = {1'b0, {8{1'b1}}, 1'b1, {22{1'b0}}};
      7'b0100_000:
      ex2_result[SINGLE_WIDTH-1:0] = {
        ex2_special_data[31], {8{1'b1}}, 1'b1, ex2_special_data[21:0]
      };
      7'b1000_000: ex2_result[SINGLE_WIDTH-1:0] = ex2_special_data[SINGLE_WIDTH-1:0];
      default: ex2_result[SINGLE_WIDTH-1:0] = {SINGLE_WIDTH{1'b0}};
    endcase
  end
  assign dp_frbus_ex2_data[SINGLE_WIDTH-1:0] = ex2_result[SINGLE_WIDTH-1:0];
  assign dp_frbus_ex2_fflags[4:0] = ex2_fflags[4:0];
endmodule


module single_file_pa_fpu_frbus (
    ctrl_frbus_ex2_wb_req,
    dp_frbus_ex2_data,
    dp_frbus_ex2_fflags,
    fdsu_frbus_data,
    fdsu_frbus_fflags,
    fdsu_frbus_wb_vld,
    fpu_idu_fwd_data,
    fpu_idu_fwd_fflags,
    fpu_idu_fwd_vld
);
  input ctrl_frbus_ex2_wb_req;
  input [31:0] dp_frbus_ex2_data;
  input [4 : 0] dp_frbus_ex2_fflags;
  input [31:0] fdsu_frbus_data;
  input [4 : 0] fdsu_frbus_fflags;
  input fdsu_frbus_wb_vld;
  output [31:0] fpu_idu_fwd_data;
  output [4 : 0] fpu_idu_fwd_fflags;
  output fpu_idu_fwd_vld;
  reg  [ 31:0] frbus_wb_data;
  reg  [4 : 0] frbus_wb_fflags;
  wire         ctrl_frbus_ex2_wb_req;
  wire [ 31:0] fdsu_frbus_data;
  wire [4 : 0] fdsu_frbus_fflags;
  wire         fdsu_frbus_wb_vld;
  wire [ 31:0] fpu_idu_fwd_data;
  wire [4 : 0] fpu_idu_fwd_fflags;
  wire         fpu_idu_fwd_vld;
  wire         frbus_ex2_wb_vld;
  wire         frbus_fdsu_wb_vld;
  wire         frbus_wb_vld;
  wire [3 : 0] frbus_source_vld;
  assign frbus_fdsu_wb_vld = fdsu_frbus_wb_vld;
  assign frbus_ex2_wb_vld = ctrl_frbus_ex2_wb_req;
  assign frbus_source_vld[3:0] = {1'b0, 1'b0, frbus_ex2_wb_vld, frbus_fdsu_wb_vld};
  assign frbus_wb_vld = frbus_ex2_wb_vld | frbus_fdsu_wb_vld;
  always @( frbus_source_vld[3:0] or fdsu_frbus_data[31:0] or
          dp_frbus_ex2_data[31:0] or fdsu_frbus_fflags[4:0] or
          dp_frbus_ex2_fflags[4:0])
begin
    case (frbus_source_vld[3:0])
      4'b0001: begin
        frbus_wb_data[31:0]  = fdsu_frbus_data[31:0];
        frbus_wb_fflags[4:0] = fdsu_frbus_fflags[4:0];
      end
      4'b0010: begin
        frbus_wb_data[31:0]  = dp_frbus_ex2_data[31:0];
        frbus_wb_fflags[4:0] = dp_frbus_ex2_fflags[4:0];
      end
      default: begin
        frbus_wb_data[31:0]  = {31{1'b0}};
        frbus_wb_fflags[4:0] = 5'b0;
      end
    endcase
  end
  assign fpu_idu_fwd_vld         = frbus_wb_vld;
  assign fpu_idu_fwd_fflags[4:0] = frbus_wb_fflags[4:0];
  assign fpu_idu_fwd_data[31:0]  = frbus_wb_data[31:0];
endmodule


module single_file_fpnew_divsqrt_th_32 #(
    parameter int unsigned             NumPipeRegs = 0,
    parameter single_file_fpnew_pkg::pipe_config_t PipeConfig  = single_file_fpnew_pkg::BEFORE,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,
    localparam int unsigned WIDTH          = 32,
    localparam int unsigned NUM_FORMATS    = single_file_fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned ExtRegEnaWidth = NumPipeRegs == 0 ? 1 : NumPipeRegs
) (
    input logic clk_i,
    input logic rst_ni,
    input logic                  [            1:0][WIDTH-1:0] operands_i,
    input logic                  [NUM_FORMATS-1:0][      1:0] is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e                              rnd_mode_i,
    input single_file_fpnew_pkg::operation_e                              op_i,
    input TagType                                             tag_i,
    input logic                                               mask_i,
    input AuxType                                             aux_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [WIDTH-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic                           mask_o,
    output AuxType                         aux_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o,
    input logic [ExtRegEnaWidth-1:0] reg_ena_i
);
  localparam NUM_INP_REGS = (PipeConfig == single_file_fpnew_pkg::BEFORE)
                            ? NumPipeRegs
                            : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 2)
                               : 0);
  localparam NUM_OUT_REGS = (PipeConfig == single_file_fpnew_pkg::AFTER || PipeConfig == single_file_fpnew_pkg::INSIDE)
                            ? NumPipeRegs
                            : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 2)
                               : 0);
  logic                  [           1:0][WIDTH-1:0]            operands_q;
  single_file_fpnew_pkg::roundmode_e                                        rnd_mode_q;
  single_file_fpnew_pkg::operation_e                                        op_q;
  logic                                                         in_valid_q;
  logic                  [0:NUM_INP_REGS][      1:0][WIDTH-1:0] inp_pipe_operands_q;
  single_file_fpnew_pkg::roundmode_e [0:NUM_INP_REGS]                       inp_pipe_rnd_mode_q;
  single_file_fpnew_pkg::operation_e [0:NUM_INP_REGS]                       inp_pipe_op_q;
  TagType                [0:NUM_INP_REGS]                       inp_pipe_tag_q;
  logic                  [0:NUM_INP_REGS]                       inp_pipe_mask_q;
  AuxType                [0:NUM_INP_REGS]                       inp_pipe_aux_q;
  logic                  [0:NUM_INP_REGS]                       inp_pipe_valid_q;
  logic                  [0:NUM_INP_REGS]                       inp_pipe_ready;
  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;
  assign in_ready_o             = inp_pipe_ready[0];
  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline
    logic reg_ena;
    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        inp_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        inp_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (inp_pipe_ready[i]) ? (inp_pipe_valid_q[i]) : (inp_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (inp_pipe_ready[i] & inp_pipe_valid_q[i]) | reg_ena_i[i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_operands_q[i+1] <= ('0);
      end else begin
        inp_pipe_operands_q[i+1] <= (reg_ena) ? (inp_pipe_operands_q[i]) : (inp_pipe_operands_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_rnd_mode_q[i+1] <= (single_file_fpnew_pkg::RNE);
      end else begin
        inp_pipe_rnd_mode_q[i+1] <= (reg_ena) ? (inp_pipe_rnd_mode_q[i]) : (inp_pipe_rnd_mode_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_q[i+1] <= (single_file_fpnew_pkg::FMADD);
      end else begin
        inp_pipe_op_q[i+1] <= (reg_ena) ? (inp_pipe_op_q[i]) : (inp_pipe_op_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        inp_pipe_tag_q[i+1] <= (reg_ena) ? (inp_pipe_tag_q[i]) : (inp_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_mask_q[i+1] <= ('0);
      end else begin
        inp_pipe_mask_q[i+1] <= (reg_ena) ? (inp_pipe_mask_q[i]) : (inp_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        inp_pipe_aux_q[i+1] <= (reg_ena) ? (inp_pipe_aux_q[i]) : (inp_pipe_aux_q[i+1]);
      end
    end
  end
  assign operands_q = inp_pipe_operands_q[NUM_INP_REGS];
  assign rnd_mode_q = inp_pipe_rnd_mode_q[NUM_INP_REGS];
  assign op_q       = inp_pipe_op_q[NUM_INP_REGS];
  assign in_valid_q = inp_pipe_valid_q[NUM_INP_REGS];
  typedef enum logic [1:0] {
    IDLE,
    BUSY,
    HOLD
  } fsm_state_e;
  fsm_state_e state_q, state_d;
  logic in_ready;
  logic div_op, sqrt_op;
  logic unit_ready_q, unit_done;
  logic op_starting;
  logic out_valid, out_ready;
  logic hold_result;
  logic data_is_held;
  logic unit_busy;
  assign div_op = in_valid_q & (op_q == single_file_fpnew_pkg::DIV) & in_ready & ~flush_i;
  assign sqrt_op = in_valid_q & (op_q == single_file_fpnew_pkg::SQRT) & in_ready & ~flush_i;
  assign op_starting = div_op | sqrt_op;
  logic fdsu_fpu_ex1_stall, fdsu_fpu_ex1_stall_q;
  logic div_op_d, div_op_q;
  logic sqrt_op_d, sqrt_op_q;
  assign div_op_d  = (fdsu_fpu_ex1_stall) ? div_op : 1'b0;
  assign sqrt_op_d = (fdsu_fpu_ex1_stall) ? sqrt_op : 1'b0;
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      fdsu_fpu_ex1_stall_q <= ('0);
    end else begin
      fdsu_fpu_ex1_stall_q <= (1'b1) ? (fdsu_fpu_ex1_stall) : (fdsu_fpu_ex1_stall_q);
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      div_op_q <= ('0);
    end else begin
      div_op_q <= (1'b1) ? (div_op_d) : (div_op_q);
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      sqrt_op_q <= ('0);
    end else begin
      sqrt_op_q <= (1'b1) ? (sqrt_op_d) : (sqrt_op_q);
    end
  end
  always_comb begin : flag_fsm
    in_ready                     = 1'b0;
    out_valid                    = 1'b0;
    hold_result                  = 1'b0;
    data_is_held                 = 1'b0;
    unit_busy                    = 1'b0;
    state_d                      = state_q;
    inp_pipe_ready[NUM_INP_REGS] = unit_ready_q;
    unique case (state_q)
      IDLE: begin
        in_ready = unit_ready_q;
        if (in_valid_q && unit_ready_q) begin
          inp_pipe_ready[NUM_INP_REGS] = unit_ready_q && !fdsu_fpu_ex1_stall;
          state_d = BUSY;
        end
      end
      BUSY: begin
        inp_pipe_ready[NUM_INP_REGS] = fdsu_fpu_ex1_stall_q;
        unit_busy = 1'b1;
        if (unit_done) begin
          out_valid = 1'b1;
          if (out_ready) begin
            state_d = IDLE;
            if (in_valid_q && unit_ready_q) begin
              in_ready = 1'b1;
              state_d  = BUSY;
            end
          end else begin
            hold_result = 1'b1;
            state_d     = HOLD;
          end
        end
      end
      HOLD: begin
        unit_busy    = 1'b1;
        data_is_held = 1'b1;
        out_valid    = 1'b1;
        if (out_ready) begin
          state_d = IDLE;
          if (in_valid_q && unit_ready_q) begin
            in_ready = 1'b1;
            state_d  = BUSY;
          end
        end
      end
      default: state_d = IDLE;
    endcase
    if (flush_i) begin
      unit_busy = 1'b0;
      out_valid = 1'b0;
      state_d   = IDLE;
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      state_q <= (IDLE);
    end else begin
      state_q <= (state_d);
    end
  end
  TagType result_tag_q;
  AuxType result_aux_q;
  logic   result_mask_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      result_tag_q <= ('0);
    end else begin
      result_tag_q <= (op_starting) ? (inp_pipe_tag_q[NUM_INP_REGS]) : (result_tag_q);
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      result_mask_q <= ('0);
    end else begin
      result_mask_q <= (op_starting) ? (inp_pipe_mask_q[NUM_INP_REGS]) : (result_mask_q);
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      result_aux_q <= ('0);
    end else begin
      result_aux_q <= (op_starting) ? (inp_pipe_aux_q[NUM_INP_REGS]) : (result_aux_q);
    end
  end
  logic [WIDTH-1:0] unit_result, held_result_q;
  single_file_fpnew_pkg::status_t unit_status, held_status_q;
  logic        ctrl_fdsu_ex1_sel;
  logic        fdsu_fpu_ex1_cmplt;
  logic [ 4:0] fdsu_fpu_ex1_fflags;
  logic [ 7:0] fdsu_fpu_ex1_special_sel;
  logic [ 3:0] fdsu_fpu_ex1_special_sign;
  logic        fdsu_fpu_no_op;
  logic [ 2:0] idu_fpu_ex1_eu_sel;
  logic [31:0] fdsu_frbus_data;
  logic [ 4:0] fdsu_frbus_fflags;
  logic        fdsu_frbus_wb_vld;
  logic [31:0] dp_frbus_ex2_data;
  logic [ 4:0] dp_frbus_ex2_fflags;
  logic [ 2:0] dp_xx_ex1_cnan;
  logic [ 2:0] dp_xx_ex1_id;
  logic [ 2:0] dp_xx_ex1_inf;
  logic [ 2:0] dp_xx_ex1_norm;
  logic [ 2:0] dp_xx_ex1_qnan;
  logic [ 2:0] dp_xx_ex1_snan;
  logic [ 2:0] dp_xx_ex1_zero;
  logic        ex2_inst_wb;
  logic ex2_inst_wb_vld_d, ex2_inst_wb_vld_q;
  logic [31:0] fpu_idu_fwd_data;
  logic [ 4:0] fpu_idu_fwd_fflags;
  logic        fpu_idu_fwd_vld;
  logic        unit_ready_d;
  always_comb begin
    if (op_starting && unit_ready_q) begin
      if (ex2_inst_wb && ex2_inst_wb_vld_q) begin
        unit_ready_d = 1'b1;
      end else begin
        unit_ready_d = 1'b0;
      end
    end else if (fpu_idu_fwd_vld | flush_i) begin
      unit_ready_d = 1'b1;
    end else begin
      unit_ready_d = unit_ready_q;
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      unit_ready_q <= (1'b1);
    end else begin
      unit_ready_q <= (1'b1) ? (unit_ready_d) : (unit_ready_q);
    end
  end
  always_comb begin
    ctrl_fdsu_ex1_sel  = 1'b0;
    idu_fpu_ex1_eu_sel = 3'h0;
    if (op_starting) begin
      ctrl_fdsu_ex1_sel  = 1'b1;
      idu_fpu_ex1_eu_sel = 3'h4;
    end else if (fdsu_fpu_ex1_stall_q) begin
      ctrl_fdsu_ex1_sel  = 1'b1;
      idu_fpu_ex1_eu_sel = 3'h4;
    end else begin
      ctrl_fdsu_ex1_sel  = 1'b0;
      idu_fpu_ex1_eu_sel = 3'h0;
    end
  end
  single_file_pa_fdsu_top i_divsqrt_thead (
      .cp0_fpu_icg_en           (1'b0),
      .cp0_fpu_xx_dqnan         (1'b0),
      .cp0_yy_clk_en            (1'b1),
      .cpurst_b                 (rst_ni),
      .ctrl_fdsu_ex1_sel        (ctrl_fdsu_ex1_sel),
      .ctrl_xx_ex1_cmplt_dp     (ctrl_fdsu_ex1_sel),
      .ctrl_xx_ex1_inst_vld     (ctrl_fdsu_ex1_sel),
      .ctrl_xx_ex1_stall        (fdsu_fpu_ex1_stall),
      .ctrl_xx_ex1_warm_up      (1'b0),
      .ctrl_xx_ex2_warm_up      (1'b0),
      .ctrl_xx_ex3_warm_up      (1'b0),
      .dp_xx_ex1_cnan           (dp_xx_ex1_cnan),
      .dp_xx_ex1_id             (dp_xx_ex1_id),
      .dp_xx_ex1_inf            (dp_xx_ex1_inf),
      .dp_xx_ex1_qnan           (dp_xx_ex1_qnan),
      .dp_xx_ex1_rm             (rnd_mode_q),
      .dp_xx_ex1_snan           (dp_xx_ex1_snan),
      .dp_xx_ex1_zero           (dp_xx_ex1_zero),
      .fdsu_fpu_debug_info      (),
      .fdsu_fpu_ex1_cmplt       (fdsu_fpu_ex1_cmplt),
      .fdsu_fpu_ex1_cmplt_dp    (),
      .fdsu_fpu_ex1_fflags      (fdsu_fpu_ex1_fflags),
      .fdsu_fpu_ex1_special_sel (fdsu_fpu_ex1_special_sel),
      .fdsu_fpu_ex1_special_sign(fdsu_fpu_ex1_special_sign),
      .fdsu_fpu_ex1_stall       (fdsu_fpu_ex1_stall),
      .fdsu_fpu_no_op           (fdsu_fpu_no_op),
      .fdsu_frbus_data          (fdsu_frbus_data),
      .fdsu_frbus_fflags        (fdsu_frbus_fflags),
      .fdsu_frbus_freg          (),
      .fdsu_frbus_wb_vld        (fdsu_frbus_wb_vld),
      .forever_cpuclk           (clk_i),
      .frbus_fdsu_wb_grant      (fdsu_frbus_wb_vld),
      .idu_fpu_ex1_dst_freg     (5'h0f),
      .idu_fpu_ex1_eu_sel       (idu_fpu_ex1_eu_sel),
      .idu_fpu_ex1_func         ({8'b0, div_op | div_op_q, sqrt_op | sqrt_op_q}),
      .idu_fpu_ex1_srcf0        (operands_q[0][31:0]),
      .idu_fpu_ex1_srcf1        (operands_q[1][31:0]),
      .pad_yy_icg_scan_en       (1'b0),
      .rtu_xx_ex1_cancel        (1'b0),
      .rtu_xx_ex2_cancel        (1'b0),
      .rtu_yy_xx_async_flush    (flush_i),
      .rtu_yy_xx_flush          (1'b0)
  );
  single_file_pa_fpu_dp x_pa_fpu_dp (
      .cp0_fpu_icg_en           (1'b0),
      .cp0_fpu_xx_rm            (rnd_mode_q),
      .cp0_yy_clk_en            (1'b1),
      .ctrl_xx_ex1_inst_vld     (ctrl_fdsu_ex1_sel),
      .ctrl_xx_ex1_stall        (1'b0),
      .ctrl_xx_ex1_warm_up      (1'b0),
      .dp_frbus_ex2_data        (dp_frbus_ex2_data),
      .dp_frbus_ex2_fflags      (dp_frbus_ex2_fflags),
      .dp_xx_ex1_cnan           (dp_xx_ex1_cnan),
      .dp_xx_ex1_id             (dp_xx_ex1_id),
      .dp_xx_ex1_inf            (dp_xx_ex1_inf),
      .dp_xx_ex1_norm           (dp_xx_ex1_norm),
      .dp_xx_ex1_qnan           (dp_xx_ex1_qnan),
      .dp_xx_ex1_snan           (dp_xx_ex1_snan),
      .dp_xx_ex1_zero           (dp_xx_ex1_zero),
      .ex2_inst_wb              (ex2_inst_wb),
      .fdsu_fpu_ex1_fflags      (fdsu_fpu_ex1_fflags),
      .fdsu_fpu_ex1_special_sel (fdsu_fpu_ex1_special_sel),
      .fdsu_fpu_ex1_special_sign(fdsu_fpu_ex1_special_sign),
      .forever_cpuclk           (clk_i),
      .idu_fpu_ex1_eu_sel       (idu_fpu_ex1_eu_sel),
      .idu_fpu_ex1_func         ({8'b0, div_op, sqrt_op}),
      .idu_fpu_ex1_gateclk_vld  (fdsu_fpu_ex1_cmplt),
      .idu_fpu_ex1_rm           (rnd_mode_q),
      .idu_fpu_ex1_srcf0        (operands_q[0][31:0]),
      .idu_fpu_ex1_srcf1        (operands_q[1][31:0]),
      .idu_fpu_ex1_srcf2        ('0),
      .pad_yy_icg_scan_en       (1'b0)
  );
  assign ex2_inst_wb_vld_d = ctrl_fdsu_ex1_sel;
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      ex2_inst_wb_vld_q <= ('0);
    end else begin
      ex2_inst_wb_vld_q <= (ex2_inst_wb_vld_d);
    end
  end
  single_file_pa_fpu_frbus x_pa_fpu_frbus (
      .ctrl_frbus_ex2_wb_req(ex2_inst_wb & ex2_inst_wb_vld_q),
      .dp_frbus_ex2_data    (dp_frbus_ex2_data),
      .dp_frbus_ex2_fflags  (dp_frbus_ex2_fflags),
      .fdsu_frbus_data      (fdsu_frbus_data),
      .fdsu_frbus_fflags    (fdsu_frbus_fflags),
      .fdsu_frbus_wb_vld    (fdsu_frbus_wb_vld),
      .fpu_idu_fwd_data     (fpu_idu_fwd_data),
      .fpu_idu_fwd_fflags   (fpu_idu_fwd_fflags),
      .fpu_idu_fwd_vld      (fpu_idu_fwd_vld)
  );
  always_comb begin
    unit_result[31:0] = fpu_idu_fwd_data[31:0];
    unit_status[4:0]  = fpu_idu_fwd_fflags[4:0];
    unit_done         = fpu_idu_fwd_vld;
  end
  always_ff @(posedge (clk_i)) begin
    held_result_q <= (hold_result) ? (unit_result) : (held_result_q);
  end
  always_ff @(posedge (clk_i)) begin
    held_status_q <= (hold_result) ? (unit_status) : (held_status_q);
  end
  logic [WIDTH-1:0] result_d;
  single_file_fpnew_pkg::status_t status_d;
  assign result_d = data_is_held ? held_result_q : unit_result;
  assign status_d = data_is_held ? held_status_q : unit_status;
  logic               [0:NUM_OUT_REGS][WIDTH-1:0] out_pipe_result_q;
  single_file_fpnew_pkg::status_t [0:NUM_OUT_REGS]            out_pipe_status_q;
  TagType             [0:NUM_OUT_REGS]            out_pipe_tag_q;
  AuxType             [0:NUM_OUT_REGS]            out_pipe_aux_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_mask_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_valid_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_ready;
  assign out_pipe_result_q[0] = result_d;
  assign out_pipe_status_q[0] = status_d;
  assign out_pipe_tag_q[0]    = result_tag_q;
  assign out_pipe_mask_q[0]   = result_mask_q;
  assign out_pipe_aux_q[0]    = result_aux_q;
  assign out_pipe_valid_q[0]  = out_valid;
  assign out_ready = out_pipe_ready[0];
  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline
    logic reg_ena;
    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        out_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        out_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (out_pipe_ready[i]) ? (out_pipe_valid_q[i]) : (out_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (out_pipe_ready[i] & out_pipe_valid_q[i]) | reg_ena_i[NUM_INP_REGS+i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_result_q[i+1] <= ('0);
      end else begin
        out_pipe_result_q[i+1] <= (reg_ena) ? (out_pipe_result_q[i]) : (out_pipe_result_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_status_q[i+1] <= ('0);
      end else begin
        out_pipe_status_q[i+1] <= (reg_ena) ? (out_pipe_status_q[i]) : (out_pipe_status_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        out_pipe_tag_q[i+1] <= (reg_ena) ? (out_pipe_tag_q[i]) : (out_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_mask_q[i+1] <= ('0);
      end else begin
        out_pipe_mask_q[i+1] <= (reg_ena) ? (out_pipe_mask_q[i]) : (out_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        out_pipe_aux_q[i+1] <= (reg_ena) ? (out_pipe_aux_q[i]) : (out_pipe_aux_q[i+1]);
      end
    end
  end
  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;
  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = 1'b1;
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, unit_busy, out_pipe_valid_q});
endmodule


module single_file_fpnew_noncomp #(
    parameter single_file_fpnew_pkg::fp_format_e   FpFormat    = single_file_fpnew_pkg::fp_format_e'(0),
    parameter int unsigned             NumPipeRegs = 0,
    parameter single_file_fpnew_pkg::pipe_config_t PipeConfig  = single_file_fpnew_pkg::BEFORE,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,
    localparam int unsigned WIDTH = single_file_fpnew_pkg::fp_width(FpFormat),
    localparam int unsigned ExtRegEnaWidth = NumPipeRegs == 0 ? 1 : NumPipeRegs
) (
    input logic clk_i,
    input logic rst_ni,
    input logic                  [1:0][WIDTH-1:0] operands_i,
    input logic                  [1:0]            is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e                  rnd_mode_i,
    input single_file_fpnew_pkg::operation_e                  op_i,
    input logic                                   op_mod_i,
    input TagType                                 tag_i,
    input logic                                   mask_i,
    input AuxType                                 aux_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic                  [WIDTH-1:0] result_o,
    output single_file_fpnew_pkg::status_t                status_o,
    output logic                              extension_bit_o,
    output single_file_fpnew_pkg::classmask_e             class_mask_o,
    output logic                              is_class_o,
    output TagType                            tag_o,
    output logic                              mask_o,
    output AuxType                            aux_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o,
    input logic [ExtRegEnaWidth-1:0] reg_ena_i
);
  localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(FpFormat);
  localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(FpFormat);
  localparam NUM_INP_REGS = (PipeConfig == single_file_fpnew_pkg::BEFORE || PipeConfig == single_file_fpnew_pkg::INSIDE)
                            ? NumPipeRegs
                            : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 2)
                               : 0);
  localparam NUM_OUT_REGS = PipeConfig == single_file_fpnew_pkg::AFTER
                            ? NumPipeRegs
                            : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 2)
                               : 0);
  typedef struct packed {
    logic                sign;
    logic [EXP_BITS-1:0] exponent;
    logic [MAN_BITS-1:0] mantissa;
  } fp_t;
  logic                  [0:NUM_INP_REGS][1:0][WIDTH-1:0] inp_pipe_operands_q;
  logic                  [0:NUM_INP_REGS][1:0]            inp_pipe_is_boxed_q;
  single_file_fpnew_pkg::roundmode_e [0:NUM_INP_REGS]                 inp_pipe_rnd_mode_q;
  single_file_fpnew_pkg::operation_e [0:NUM_INP_REGS]                 inp_pipe_op_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_op_mod_q;
  TagType                [0:NUM_INP_REGS]                 inp_pipe_tag_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_mask_q;
  AuxType                [0:NUM_INP_REGS]                 inp_pipe_aux_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_valid_q;
  logic                  [0:NUM_INP_REGS]                 inp_pipe_ready;
  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_is_boxed_q[0] = is_boxed_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_op_mod_q[0]   = op_mod_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;
  assign in_ready_o             = inp_pipe_ready[0];
  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline
    logic reg_ena;
    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        inp_pipe_valid_q[i+1] <= ('0);
      end else begin
        inp_pipe_valid_q[i+1] <= (flush_i) ? ('0) : (inp_pipe_ready[i]) ? (inp_pipe_valid_q[i]) : (inp_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (inp_pipe_ready[i] & inp_pipe_valid_q[i]) | reg_ena_i[i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_operands_q[i+1] <= ('0);
      end else begin
        inp_pipe_operands_q[i+1] <= (reg_ena) ? (inp_pipe_operands_q[i]) : (inp_pipe_operands_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_is_boxed_q[i+1] <= ('0);
      end else begin
        inp_pipe_is_boxed_q[i+1] <= (reg_ena) ? (inp_pipe_is_boxed_q[i]) : (inp_pipe_is_boxed_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_rnd_mode_q[i+1] <= (single_file_fpnew_pkg::RNE);
      end else begin
        inp_pipe_rnd_mode_q[i+1] <= (reg_ena) ? (inp_pipe_rnd_mode_q[i]) : (inp_pipe_rnd_mode_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_q[i+1] <= (single_file_fpnew_pkg::FMADD);
      end else begin
        inp_pipe_op_q[i+1] <= (reg_ena) ? (inp_pipe_op_q[i]) : (inp_pipe_op_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_mod_q[i+1] <= ('0);
      end else begin
        inp_pipe_op_mod_q[i+1] <= (reg_ena) ? (inp_pipe_op_mod_q[i]) : (inp_pipe_op_mod_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        inp_pipe_tag_q[i+1] <= (reg_ena) ? (inp_pipe_tag_q[i]) : (inp_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_mask_q[i+1] <= ('0);
      end else begin
        inp_pipe_mask_q[i+1] <= (reg_ena) ? (inp_pipe_mask_q[i]) : (inp_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        inp_pipe_aux_q[i+1] <= (reg_ena) ? (inp_pipe_aux_q[i]) : (inp_pipe_aux_q[i+1]);
      end
    end
  end
  single_file_fpnew_pkg::fp_info_t [1:0] info_q;
  single_file_fpnew_classifier #(
      .FpFormat   (FpFormat),
      .NumOperands(2)
  ) i_class_a (
      .operands_i(inp_pipe_operands_q[NUM_INP_REGS]),
      .is_boxed_i(inp_pipe_is_boxed_q[NUM_INP_REGS]),
      .info_o    (info_q)
  );
  fp_t operand_a, operand_b;
  single_file_fpnew_pkg::fp_info_t info_a, info_b;
  assign operand_a = inp_pipe_operands_q[NUM_INP_REGS][0];
  assign operand_b = inp_pipe_operands_q[NUM_INP_REGS][1];
  assign info_a    = info_q[0];
  assign info_b    = info_q[1];
  logic any_operand_inf;
  logic any_operand_nan;
  logic signalling_nan;
  assign any_operand_inf = (|{info_a.is_inf, info_b.is_inf});
  assign any_operand_nan = (|{info_a.is_nan, info_b.is_nan});
  assign signalling_nan  = (|{info_a.is_signalling, info_b.is_signalling});
  logic operands_equal, operand_a_smaller;
  assign operands_equal    = (operand_a == operand_b) || (info_a.is_zero && info_b.is_zero);
  assign operand_a_smaller = (operand_a < operand_b) ^ (operand_a.sign || operand_b.sign);
  fp_t                sgnj_result;
  single_file_fpnew_pkg::status_t sgnj_status;
  logic               sgnj_extension_bit;
  always_comb begin : sign_injections
    logic sign_a, sign_b;
    sgnj_result = operand_a;
    if (!info_a.is_boxed)
      sgnj_result = '{sign: 1'b0, exponent: '1, mantissa: 2 ** (MAN_BITS - 1)};
    sign_a = operand_a.sign & info_a.is_boxed;
    sign_b = operand_b.sign & info_b.is_boxed;
    unique case (inp_pipe_rnd_mode_q[NUM_INP_REGS])
      single_file_fpnew_pkg::RNE: sgnj_result.sign = sign_b;
      single_file_fpnew_pkg::RTZ: sgnj_result.sign = ~sign_b;
      single_file_fpnew_pkg::RDN: sgnj_result.sign = sign_a ^ sign_b;
      single_file_fpnew_pkg::RUP: sgnj_result = operand_a;
      default:        sgnj_result = '{default: single_file_fpnew_pkg::DONT_CARE};
    endcase
  end
  assign sgnj_status = '0;
  assign sgnj_extension_bit = inp_pipe_op_mod_q[NUM_INP_REGS] ? sgnj_result.sign : 1'b1;
  fp_t                minmax_result;
  single_file_fpnew_pkg::status_t minmax_status;
  logic               minmax_extension_bit;
  always_comb begin : min_max
    minmax_status = '0;
    minmax_status.NV = signalling_nan;
    if (info_a.is_nan && info_b.is_nan)
      minmax_result = '{sign: 1'b0, exponent: '1, mantissa: 2 ** (MAN_BITS - 1)};
    else if (info_a.is_nan) minmax_result = operand_b;
    else if (info_b.is_nan) minmax_result = operand_a;
    else begin
      unique case (inp_pipe_rnd_mode_q[NUM_INP_REGS])
        single_file_fpnew_pkg::RNE: minmax_result = operand_a_smaller ? operand_a : operand_b;
        single_file_fpnew_pkg::RTZ: minmax_result = operand_a_smaller ? operand_b : operand_a;
        default: minmax_result = '{default: single_file_fpnew_pkg::DONT_CARE};
      endcase
    end
  end
  assign minmax_extension_bit = 1'b1;
  fp_t                cmp_result;
  single_file_fpnew_pkg::status_t cmp_status;
  logic               cmp_extension_bit;
  always_comb begin : comparisons
    cmp_result = '0;
    cmp_status = '0;
    if (signalling_nan) cmp_status.NV = 1'b1;
    else begin
      unique case (inp_pipe_rnd_mode_q[NUM_INP_REGS])
        single_file_fpnew_pkg::RNE: begin
          if (any_operand_nan) cmp_status.NV = 1'b1;
          else cmp_result = (operand_a_smaller | operands_equal) ^ inp_pipe_op_mod_q[NUM_INP_REGS];
        end
        single_file_fpnew_pkg::RTZ: begin
          if (any_operand_nan) cmp_status.NV = 1'b1;
          else cmp_result = (operand_a_smaller & ~operands_equal) ^ inp_pipe_op_mod_q[NUM_INP_REGS];
        end
        single_file_fpnew_pkg::RDN: begin
          if (any_operand_nan) cmp_result = inp_pipe_op_mod_q[NUM_INP_REGS];
          else cmp_result = operands_equal ^ inp_pipe_op_mod_q[NUM_INP_REGS];
        end
        default: cmp_result = '{default: single_file_fpnew_pkg::DONT_CARE};
      endcase
    end
  end
  assign cmp_extension_bit = 1'b0;
  single_file_fpnew_pkg::status_t    class_status;
  logic                  class_extension_bit;
  single_file_fpnew_pkg::classmask_e class_mask_d;
  always_comb begin : classify
    if (info_a.is_normal) begin
      class_mask_d = operand_a.sign ? single_file_fpnew_pkg::NEGNORM : single_file_fpnew_pkg::POSNORM;
    end else if (info_a.is_subnormal) begin
      class_mask_d = operand_a.sign ? single_file_fpnew_pkg::NEGSUBNORM : single_file_fpnew_pkg::POSSUBNORM;
    end else if (info_a.is_zero) begin
      class_mask_d = operand_a.sign ? single_file_fpnew_pkg::NEGZERO : single_file_fpnew_pkg::POSZERO;
    end else if (info_a.is_inf) begin
      class_mask_d = operand_a.sign ? single_file_fpnew_pkg::NEGINF : single_file_fpnew_pkg::POSINF;
    end else if (info_a.is_nan) begin
      class_mask_d = info_a.is_signalling ? single_file_fpnew_pkg::SNAN : single_file_fpnew_pkg::QNAN;
    end else begin
      class_mask_d = single_file_fpnew_pkg::QNAN;
    end
  end
  assign class_status        = '0;
  assign class_extension_bit = 1'b0;
  fp_t                result_d;
  single_file_fpnew_pkg::status_t status_d;
  logic               extension_bit_d;
  logic               is_class_d;
  always_comb begin : select_result
    unique case (inp_pipe_op_q[NUM_INP_REGS])
      single_file_fpnew_pkg::SGNJ: begin
        result_d        = sgnj_result;
        status_d        = sgnj_status;
        extension_bit_d = sgnj_extension_bit;
      end
      single_file_fpnew_pkg::MINMAX: begin
        result_d        = minmax_result;
        status_d        = minmax_status;
        extension_bit_d = minmax_extension_bit;
      end
      single_file_fpnew_pkg::CMP: begin
        result_d        = cmp_result;
        status_d        = cmp_status;
        extension_bit_d = cmp_extension_bit;
      end
      single_file_fpnew_pkg::CLASSIFY: begin
        result_d        = '{default: single_file_fpnew_pkg::DONT_CARE};
        status_d        = class_status;
        extension_bit_d = class_extension_bit;
      end
      default: begin
        result_d        = '{default: single_file_fpnew_pkg::DONT_CARE};
        status_d        = '{default: single_file_fpnew_pkg::DONT_CARE};
        extension_bit_d = single_file_fpnew_pkg::DONT_CARE;
      end
    endcase
  end
  assign is_class_d = (inp_pipe_op_q[NUM_INP_REGS] == single_file_fpnew_pkg::CLASSIFY);
  fp_t                   [0:NUM_OUT_REGS] out_pipe_result_q;
  single_file_fpnew_pkg::status_t    [0:NUM_OUT_REGS] out_pipe_status_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_extension_bit_q;
  single_file_fpnew_pkg::classmask_e [0:NUM_OUT_REGS] out_pipe_class_mask_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_is_class_q;
  TagType                [0:NUM_OUT_REGS] out_pipe_tag_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_mask_q;
  AuxType                [0:NUM_OUT_REGS] out_pipe_aux_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_valid_q;
  logic                  [0:NUM_OUT_REGS] out_pipe_ready;
  assign out_pipe_result_q[0]         = result_d;
  assign out_pipe_status_q[0]         = status_d;
  assign out_pipe_extension_bit_q[0]  = extension_bit_d;
  assign out_pipe_class_mask_q[0]     = class_mask_d;
  assign out_pipe_is_class_q[0]       = is_class_d;
  assign out_pipe_tag_q[0]            = inp_pipe_tag_q[NUM_INP_REGS];
  assign out_pipe_mask_q[0]           = inp_pipe_mask_q[NUM_INP_REGS];
  assign out_pipe_aux_q[0]            = inp_pipe_aux_q[NUM_INP_REGS];
  assign out_pipe_valid_q[0]          = inp_pipe_valid_q[NUM_INP_REGS];
  assign inp_pipe_ready[NUM_INP_REGS] = out_pipe_ready[0];
  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline
    logic reg_ena;
    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        out_pipe_valid_q[i+1] <= ('0);
      end else begin
        out_pipe_valid_q[i+1] <= (flush_i) ? ('0) : (out_pipe_ready[i]) ? (out_pipe_valid_q[i]) : (out_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (out_pipe_ready[i] & out_pipe_valid_q[i]) | reg_ena_i[NUM_INP_REGS+i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_result_q[i+1] <= ('0);
      end else begin
        out_pipe_result_q[i+1] <= (reg_ena) ? (out_pipe_result_q[i]) : (out_pipe_result_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_status_q[i+1] <= ('0);
      end else begin
        out_pipe_status_q[i+1] <= (reg_ena) ? (out_pipe_status_q[i]) : (out_pipe_status_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_extension_bit_q[i+1] <= ('0);
      end else begin
        out_pipe_extension_bit_q[i+1] <= (reg_ena) ? (out_pipe_extension_bit_q[i]) : (out_pipe_extension_bit_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_class_mask_q[i+1] <= (single_file_fpnew_pkg::QNAN);
      end else begin
        out_pipe_class_mask_q[i+1] <= (reg_ena) ? (out_pipe_class_mask_q[i]) : (out_pipe_class_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_is_class_q[i+1] <= ('0);
      end else begin
        out_pipe_is_class_q[i+1] <= (reg_ena) ? (out_pipe_is_class_q[i]) : (out_pipe_is_class_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        out_pipe_tag_q[i+1] <= (reg_ena) ? (out_pipe_tag_q[i]) : (out_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_mask_q[i+1] <= ('0);
      end else begin
        out_pipe_mask_q[i+1] <= (reg_ena) ? (out_pipe_mask_q[i]) : (out_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        out_pipe_aux_q[i+1] <= (reg_ena) ? (out_pipe_aux_q[i]) : (out_pipe_aux_q[i+1]);
      end
    end
  end
  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;
  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = out_pipe_extension_bit_q[NUM_OUT_REGS];
  assign class_mask_o                 = out_pipe_class_mask_q[NUM_OUT_REGS];
  assign is_class_o                   = out_pipe_is_class_q[NUM_OUT_REGS];
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, out_pipe_valid_q});
endmodule


module single_file_fpnew_opgroup_fmt_slice #(
    parameter single_file_fpnew_pkg::opgroup_e OpGroup = single_file_fpnew_pkg::ADDMUL,
    parameter single_file_fpnew_pkg::fp_format_e  FpFormat         = single_file_fpnew_pkg::fp_format_e'(0),
    parameter int unsigned Width = 32,
    parameter logic EnableVectors = 1'b1,
    parameter int unsigned NumPipeRegs = 0,
    parameter single_file_fpnew_pkg::pipe_config_t PipeConfig = single_file_fpnew_pkg::BEFORE,
    parameter logic ExtRegEna = 1'b0,
    parameter type TagType = logic,
    parameter int unsigned TrueSIMDClass = 0,
    localparam int unsigned NUM_OPERANDS = single_file_fpnew_pkg::num_operands(OpGroup),
    localparam int unsigned NUM_LANES = single_file_fpnew_pkg::num_lanes(
        Width, FpFormat, EnableVectors
    ),
    localparam type MaskType = logic [NUM_LANES-1:0],
    localparam int unsigned ExtRegEnaWidth = NumPipeRegs == 0 ? 1 : NumPipeRegs
) (
    input logic clk_i,
    input logic rst_ni,
    input logic [NUM_OPERANDS-1:0][Width-1:0] operands_i,
    input logic [NUM_OPERANDS-1:0] is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e rnd_mode_i,
    input single_file_fpnew_pkg::operation_e op_i,
    input logic op_mod_i,
    input logic vectorial_op_i,
    input TagType tag_i,
    input MaskType simd_mask_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [Width-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o,
    input logic [ExtRegEnaWidth-1:0] reg_ena_i
);
  localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(
      FpFormat
  );
  localparam int unsigned SIMD_WIDTH = unsigned'(Width / NUM_LANES);
  logic [NUM_LANES-1:0] lane_in_ready, lane_out_valid;
  logic                          vectorial_op;
  logic [NUM_LANES*FP_WIDTH-1:0] slice_result;
  logic [Width-1:0] slice_regular_result, slice_class_result, slice_vec_class_result;
  single_file_fpnew_pkg::status_t    [NUM_LANES-1:0] lane_status;
  logic                  [NUM_LANES-1:0] lane_ext_bit;
  single_file_fpnew_pkg::classmask_e [NUM_LANES-1:0] lane_class_mask;
  TagType                [NUM_LANES-1:0] lane_tags;
  logic                  [NUM_LANES-1:0] lane_masks;
  logic [NUM_LANES-1:0] lane_vectorial, lane_busy, lane_is_class;
  logic result_is_vector, result_is_class;
  assign in_ready_o   = lane_in_ready[0];
  assign vectorial_op = vectorial_op_i & EnableVectors;
  for (
      genvar lane = 0; lane < int'(NUM_LANES); lane++
  ) begin : gen_num_lanes
    logic [FP_WIDTH-1:0] local_result;
    logic                local_sign;
    if ((lane == 0) || EnableVectors) begin : active_lane
      logic in_valid, out_valid, out_ready;
      logic               [NUM_OPERANDS-1:0][FP_WIDTH-1:0] local_operands;
      logic               [    FP_WIDTH-1:0]               op_result;
      single_file_fpnew_pkg::status_t                                  op_status;
      assign in_valid = in_valid_i & ((lane == 0) | vectorial_op);
      always_comb begin : prepare_input
        for (int i = 0; i < int'(NUM_OPERANDS); i++) begin
          local_operands[i] = operands_i[i][(unsigned'(lane)+1)*FP_WIDTH-1:unsigned'(lane)*FP_WIDTH];
        end
      end
      if (OpGroup == single_file_fpnew_pkg::ADDMUL) begin : lane_instance
        fpnew_fma #(
            .FpFormat   (FpFormat),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic)
        ) i_fma (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands),
            .is_boxed_i     (is_boxed_i[NUM_OPERANDS-1:0]),
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (vectorial_op),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_vectorial[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane]),
            .reg_ena_i
        );
        assign lane_is_class[lane]   = 1'b0;
        assign lane_class_mask[lane] = single_file_fpnew_pkg::NEGINF;
      end else if (OpGroup == single_file_fpnew_pkg::DIVSQRT) begin : lane_instance
      end else if (OpGroup == single_file_fpnew_pkg::NONCOMP) begin : lane_instance
        single_file_fpnew_noncomp #(
            .FpFormat   (FpFormat),
            .NumPipeRegs(NumPipeRegs),
            .PipeConfig (PipeConfig),
            .TagType    (TagType),
            .AuxType    (logic)
        ) i_noncomp (
            .clk_i,
            .rst_ni,
            .operands_i     (local_operands),
            .is_boxed_i     (is_boxed_i[NUM_OPERANDS-1:0]),
            .rnd_mode_i,
            .op_i,
            .op_mod_i,
            .tag_i,
            .mask_i         (simd_mask_i[lane]),
            .aux_i          (vectorial_op),
            .in_valid_i     (in_valid),
            .in_ready_o     (lane_in_ready[lane]),
            .flush_i,
            .result_o       (op_result),
            .status_o       (op_status),
            .extension_bit_o(lane_ext_bit[lane]),
            .class_mask_o   (lane_class_mask[lane]),
            .is_class_o     (lane_is_class[lane]),
            .tag_o          (lane_tags[lane]),
            .mask_o         (lane_masks[lane]),
            .aux_o          (lane_vectorial[lane]),
            .out_valid_o    (out_valid),
            .out_ready_i    (out_ready),
            .busy_o         (lane_busy[lane]),
            .reg_ena_i
        );
      end
      assign out_ready = out_ready_i & ((lane == 0) | result_is_vector);
      assign lane_out_valid[lane] = out_valid & ((lane == 0) | result_is_vector);
      assign local_result = (lane_out_valid[lane] | ExtRegEna) ? op_result : '{
              default: lane_ext_bit[0]
          };
      assign lane_status[lane] = (lane_out_valid[lane] | ExtRegEna) ? op_status : '0;
    end else begin
      assign lane_out_valid[lane] = 1'b0;
      assign lane_in_ready[lane]  = 1'b0;
      assign local_result         = '{default: lane_ext_bit[0]};
      assign lane_status[lane]    = '0;
      assign lane_busy[lane]      = 1'b0;
      assign lane_is_class[lane]  = 1'b0;
    end
    assign slice_result[(unsigned'(lane)+1)*FP_WIDTH-1:unsigned'(lane)*FP_WIDTH] = local_result;
    if (TrueSIMDClass && SIMD_WIDTH >= 10) begin : vectorial_true_class
      assign slice_vec_class_result[lane*SIMD_WIDTH+:10] = lane_class_mask[lane];
      assign slice_vec_class_result[(lane+1)*SIMD_WIDTH-1-:SIMD_WIDTH-10] = '0;
    end else if ((lane + 1) * 8 <= Width) begin : vectorial_class
      assign local_sign = (lane_class_mask[lane] == single_file_fpnew_pkg::NEGINF ||
                                 lane_class_mask[lane] == single_file_fpnew_pkg::NEGNORM ||
                                 lane_class_mask[lane] == single_file_fpnew_pkg::NEGSUBNORM ||
                                 lane_class_mask[lane] == single_file_fpnew_pkg::NEGZERO);
      assign slice_vec_class_result[(lane+1)*8-1:lane*8] = {
        local_sign,
        ~local_sign,
        lane_class_mask[lane] == single_file_fpnew_pkg::QNAN,
        lane_class_mask[lane] == single_file_fpnew_pkg::SNAN,
        lane_class_mask[lane] == single_file_fpnew_pkg::POSZERO || lane_class_mask[lane] == single_file_fpnew_pkg::NEGZERO,
        lane_class_mask[lane] == single_file_fpnew_pkg::POSSUBNORM
                    || lane_class_mask[lane] == single_file_fpnew_pkg::NEGSUBNORM,
        lane_class_mask[lane] == single_file_fpnew_pkg::POSNORM || lane_class_mask[lane] == single_file_fpnew_pkg::NEGNORM,
        lane_class_mask[lane] == single_file_fpnew_pkg::POSINF || lane_class_mask[lane] == single_file_fpnew_pkg::NEGINF
      };
    end
  end
  assign result_is_vector = lane_vectorial[0];
  assign result_is_class = lane_is_class[0];
  assign slice_regular_result = $signed({extension_bit_o, slice_result});
  localparam int unsigned CLASS_VEC_BITS = (NUM_LANES*8 > Width) ? 8 * (Width / 8) : NUM_LANES*8;
  if (!(TrueSIMDClass && SIMD_WIDTH >= 10)) begin
    if (CLASS_VEC_BITS < Width) begin : pad_vectorial_class
      assign slice_vec_class_result[Width-1:CLASS_VEC_BITS] = '0;
    end
  end
  assign slice_class_result = result_is_vector ? slice_vec_class_result : lane_class_mask[0];
  assign result_o           = result_is_class ? slice_class_result : slice_regular_result;
  assign extension_bit_o    = lane_ext_bit[0];
  assign tag_o              = lane_tags[0];
  assign busy_o             = (|lane_busy);
  assign out_valid_o        = lane_out_valid[0];
  always_comb begin : output_processing
    automatic single_file_fpnew_pkg::status_t temp_status;
    temp_status = '0;
    for (int i = 0; i < int'(NUM_LANES); i++) temp_status |= lane_status[i] & {5{lane_masks[i]}};
    status_o = temp_status;
  end
endmodule


module single_file_fpnew_cast_multi #(
    parameter single_file_fpnew_pkg::fmt_logic_t  FpFmtConfig  = '1,
    parameter single_file_fpnew_pkg::ifmt_logic_t IntFmtConfig = '1,
    parameter int unsigned             NumPipeRegs = 0,
    parameter single_file_fpnew_pkg::pipe_config_t PipeConfig  = single_file_fpnew_pkg::BEFORE,
    parameter type                     TagType     = logic,
    parameter type                     AuxType     = logic,
    localparam int unsigned WIDTH = single_file_fpnew_pkg::maximum(
        single_file_fpnew_pkg::max_fp_width(FpFmtConfig), single_file_fpnew_pkg::max_int_width(IntFmtConfig)
    ),
    localparam int unsigned NUM_FORMATS = single_file_fpnew_pkg::NUM_FP_FORMATS,
    localparam int unsigned ExtRegEnaWidth = NumPipeRegs == 0 ? 1 : NumPipeRegs
) (
    input logic clk_i,
    input logic rst_ni,
    input logic                   [      WIDTH-1:0] operands_i,
    input logic                   [NUM_FORMATS-1:0] is_boxed_i,
    input single_file_fpnew_pkg::roundmode_e                    rnd_mode_i,
    input single_file_fpnew_pkg::operation_e                    op_i,
    input logic                                     op_mod_i,
    input single_file_fpnew_pkg::fp_format_e                    src_fmt_i,
    input single_file_fpnew_pkg::fp_format_e                    dst_fmt_i,
    input single_file_fpnew_pkg::int_format_e                   int_fmt_i,
    input TagType                                   tag_i,
    input logic                                     mask_i,
    input AuxType                                   aux_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [WIDTH-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output logic                           extension_bit_o,
    output TagType                         tag_o,
    output logic                           mask_o,
    output AuxType                         aux_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o,
    input logic [ExtRegEnaWidth-1:0] reg_ena_i
);
  localparam int unsigned NUM_INT_FORMATS = single_file_fpnew_pkg::NUM_INT_FORMATS;
  localparam int unsigned MAX_INT_WIDTH = single_file_fpnew_pkg::max_int_width(IntFmtConfig);
  localparam single_file_fpnew_pkg::fp_encoding_t SUPER_FORMAT = single_file_fpnew_pkg::super_format(FpFmtConfig);
  localparam int unsigned SUPER_EXP_BITS = SUPER_FORMAT.exp_bits;
  localparam int unsigned SUPER_MAN_BITS = SUPER_FORMAT.man_bits;
  localparam int unsigned SUPER_BIAS = 2 ** (SUPER_EXP_BITS - 1) - 1;
  localparam int unsigned INT_MAN_WIDTH = single_file_fpnew_pkg::maximum(SUPER_MAN_BITS + 1, MAX_INT_WIDTH);
  localparam int unsigned LZC_RESULT_WIDTH = $clog2(INT_MAN_WIDTH);
  localparam int unsigned INT_EXP_WIDTH = single_file_fpnew_pkg::maximum(
      $clog2(MAX_INT_WIDTH), single_file_fpnew_pkg::maximum(SUPER_EXP_BITS, $clog2(SUPER_BIAS + SUPER_MAN_BITS))
  ) + 1;
  localparam NUM_INP_REGS = PipeConfig == single_file_fpnew_pkg::BEFORE
                            ? NumPipeRegs
                            : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                               ? ((NumPipeRegs + 1) / 3)
                               : 0);
  localparam NUM_MID_REGS = PipeConfig == single_file_fpnew_pkg::INSIDE
                          ? NumPipeRegs
                          : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                             ? ((NumPipeRegs + 2) / 3)
                             : 0);
  localparam NUM_OUT_REGS = PipeConfig == single_file_fpnew_pkg::AFTER
                            ? NumPipeRegs
                            : (PipeConfig == single_file_fpnew_pkg::DISTRIBUTED
                               ? (NumPipeRegs / 3)
                               : 0);
  logic                   [      WIDTH-1:0]                  operands_q;
  logic                   [NUM_FORMATS-1:0]                  is_boxed_q;
  logic                                                      op_mod_q;
  single_file_fpnew_pkg::fp_format_e                                     src_fmt_q;
  single_file_fpnew_pkg::fp_format_e                                     dst_fmt_q;
  single_file_fpnew_pkg::int_format_e                                    int_fmt_q;
  logic                   [ 0:NUM_INP_REGS][      WIDTH-1:0] inp_pipe_operands_q;
  logic                   [ 0:NUM_INP_REGS][NUM_FORMATS-1:0] inp_pipe_is_boxed_q;
  single_file_fpnew_pkg::roundmode_e  [ 0:NUM_INP_REGS]                  inp_pipe_rnd_mode_q;
  single_file_fpnew_pkg::operation_e  [ 0:NUM_INP_REGS]                  inp_pipe_op_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_op_mod_q;
  single_file_fpnew_pkg::fp_format_e  [ 0:NUM_INP_REGS]                  inp_pipe_src_fmt_q;
  single_file_fpnew_pkg::fp_format_e  [ 0:NUM_INP_REGS]                  inp_pipe_dst_fmt_q;
  single_file_fpnew_pkg::int_format_e [ 0:NUM_INP_REGS]                  inp_pipe_int_fmt_q;
  TagType                 [ 0:NUM_INP_REGS]                  inp_pipe_tag_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_mask_q;
  AuxType                 [ 0:NUM_INP_REGS]                  inp_pipe_aux_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_valid_q;
  logic                   [ 0:NUM_INP_REGS]                  inp_pipe_ready;
  assign inp_pipe_operands_q[0] = operands_i;
  assign inp_pipe_is_boxed_q[0] = is_boxed_i;
  assign inp_pipe_rnd_mode_q[0] = rnd_mode_i;
  assign inp_pipe_op_q[0]       = op_i;
  assign inp_pipe_op_mod_q[0]   = op_mod_i;
  assign inp_pipe_src_fmt_q[0]  = src_fmt_i;
  assign inp_pipe_dst_fmt_q[0]  = dst_fmt_i;
  assign inp_pipe_int_fmt_q[0]  = int_fmt_i;
  assign inp_pipe_tag_q[0]      = tag_i;
  assign inp_pipe_mask_q[0]     = mask_i;
  assign inp_pipe_aux_q[0]      = aux_i;
  assign inp_pipe_valid_q[0]    = in_valid_i;
  assign in_ready_o             = inp_pipe_ready[0];
  for (genvar i = 0; i < NUM_INP_REGS; i++) begin : gen_input_pipeline
    logic reg_ena;
    assign inp_pipe_ready[i] = inp_pipe_ready[i+1] | ~inp_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        inp_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        inp_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (inp_pipe_ready[i]) ? (inp_pipe_valid_q[i]) : (inp_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (inp_pipe_ready[i] & inp_pipe_valid_q[i]) | reg_ena_i[i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_operands_q[i+1] <= ('0);
      end else begin
        inp_pipe_operands_q[i+1] <= (reg_ena) ? (inp_pipe_operands_q[i]) : (inp_pipe_operands_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_is_boxed_q[i+1] <= ('0);
      end else begin
        inp_pipe_is_boxed_q[i+1] <= (reg_ena) ? (inp_pipe_is_boxed_q[i]) : (inp_pipe_is_boxed_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_rnd_mode_q[i+1] <= (single_file_fpnew_pkg::RNE);
      end else begin
        inp_pipe_rnd_mode_q[i+1] <= (reg_ena) ? (inp_pipe_rnd_mode_q[i]) : (inp_pipe_rnd_mode_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_q[i+1] <= (single_file_fpnew_pkg::FMADD);
      end else begin
        inp_pipe_op_q[i+1] <= (reg_ena) ? (inp_pipe_op_q[i]) : (inp_pipe_op_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_op_mod_q[i+1] <= ('0);
      end else begin
        inp_pipe_op_mod_q[i+1] <= (reg_ena) ? (inp_pipe_op_mod_q[i]) : (inp_pipe_op_mod_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_src_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        inp_pipe_src_fmt_q[i+1] <= (reg_ena) ? (inp_pipe_src_fmt_q[i]) : (inp_pipe_src_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_dst_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        inp_pipe_dst_fmt_q[i+1] <= (reg_ena) ? (inp_pipe_dst_fmt_q[i]) : (inp_pipe_dst_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_int_fmt_q[i+1] <= (single_file_fpnew_pkg::int_format_e'(0));
      end else begin
        inp_pipe_int_fmt_q[i+1] <= (reg_ena) ? (inp_pipe_int_fmt_q[i]) : (inp_pipe_int_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        inp_pipe_tag_q[i+1] <= (reg_ena) ? (inp_pipe_tag_q[i]) : (inp_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_mask_q[i+1] <= ('0);
      end else begin
        inp_pipe_mask_q[i+1] <= (reg_ena) ? (inp_pipe_mask_q[i]) : (inp_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        inp_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        inp_pipe_aux_q[i+1] <= (reg_ena) ? (inp_pipe_aux_q[i]) : (inp_pipe_aux_q[i+1]);
      end
    end
  end
  assign operands_q = inp_pipe_operands_q[NUM_INP_REGS];
  assign is_boxed_q = inp_pipe_is_boxed_q[NUM_INP_REGS];
  assign op_mod_q   = inp_pipe_op_mod_q[NUM_INP_REGS];
  assign src_fmt_q  = inp_pipe_src_fmt_q[NUM_INP_REGS];
  assign dst_fmt_q  = inp_pipe_dst_fmt_q[NUM_INP_REGS];
  assign int_fmt_q  = inp_pipe_int_fmt_q[NUM_INP_REGS];
  logic src_is_int, dst_is_int;
  assign src_is_int = (inp_pipe_op_q[NUM_INP_REGS] == single_file_fpnew_pkg::I2F);
  assign dst_is_int = (inp_pipe_op_q[NUM_INP_REGS] == single_file_fpnew_pkg::F2I);
  logic                [  INT_MAN_WIDTH-1:0]                    encoded_mant;
  logic                [    NUM_FORMATS-1:0]                    fmt_sign;
  logic signed         [    NUM_FORMATS-1:0][INT_EXP_WIDTH-1:0] fmt_exponent;
  logic                [    NUM_FORMATS-1:0][INT_MAN_WIDTH-1:0] fmt_mantissa;
  logic signed         [    NUM_FORMATS-1:0][INT_EXP_WIDTH-1:0] fmt_shift_compensation;
  single_file_fpnew_pkg::fp_info_t [    NUM_FORMATS-1:0]                    info;
  logic                [NUM_INT_FORMATS-1:0][INT_MAN_WIDTH-1:0] ifmt_input_val;
  logic                                                         int_sign;
  logic [INT_MAN_WIDTH-1:0] int_value, int_mantissa;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : fmt_init_inputs
    localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    if (FpFmtConfig[fmt]) begin : active_format
      single_file_fpnew_classifier #(
          .FpFormat   (single_file_fpnew_pkg::fp_format_e'(fmt)),
          .NumOperands(1)
      ) i_fpnew_classifier (
          .operands_i(operands_q[FP_WIDTH-1:0]),
          .is_boxed_i(is_boxed_q[fmt]),
          .info_o    (info[fmt])
      );
      assign fmt_sign[fmt]               = operands_q[FP_WIDTH-1];
      assign fmt_exponent[fmt]           = signed'({1'b0, operands_q[MAN_BITS+:EXP_BITS]});
      assign fmt_mantissa[fmt]           = {info[fmt].is_normal, operands_q[MAN_BITS-1:0]};
      assign fmt_shift_compensation[fmt] = signed'(INT_MAN_WIDTH - 1 - MAN_BITS);
    end else begin : inactive_format
      assign info[fmt]                   = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_sign[fmt]               = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_exponent[fmt]           = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_mantissa[fmt]           = '{default: single_file_fpnew_pkg::DONT_CARE};
      assign fmt_shift_compensation[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_sign_extend_int
    localparam int unsigned INT_WIDTH = single_file_fpnew_pkg::int_width(single_file_fpnew_pkg::int_format_e'(ifmt));
    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : sign_ext_input
        ifmt_input_val[ifmt]                = '{default: operands_q[INT_WIDTH-1] & ~op_mod_q};
        ifmt_input_val[ifmt][INT_WIDTH-1:0] = operands_q[INT_WIDTH-1:0];
      end
    end else begin : inactive_format
      assign ifmt_input_val[ifmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign int_value    = ifmt_input_val[int_fmt_q];
  assign int_sign     = int_value[INT_MAN_WIDTH-1] & ~op_mod_q;
  assign int_mantissa = int_sign ? unsigned'(-int_value) : int_value;
  assign encoded_mant = src_is_int ? int_mantissa : fmt_mantissa[src_fmt_q];
  logic signed [INT_EXP_WIDTH-1:0] src_bias;
  logic signed [INT_EXP_WIDTH-1:0] src_exp;
  logic signed [INT_EXP_WIDTH-1:0] src_subnormal;
  logic signed [INT_EXP_WIDTH-1:0] src_offset;
  assign src_bias      = signed'(single_file_fpnew_pkg::bias(src_fmt_q));
  assign src_exp       = fmt_exponent[src_fmt_q];
  assign src_subnormal = signed'({1'b0, info[src_fmt_q].is_subnormal});
  assign src_offset    = fmt_shift_compensation[src_fmt_q];
  logic                               input_sign;
  logic signed [   INT_EXP_WIDTH-1:0] input_exp;
  logic        [   INT_MAN_WIDTH-1:0] input_mant;
  logic                               mant_is_zero;
  logic signed [   INT_EXP_WIDTH-1:0] fp_input_exp;
  logic signed [   INT_EXP_WIDTH-1:0] int_input_exp;
  logic        [LZC_RESULT_WIDTH-1:0] renorm_shamt;
  logic        [  LZC_RESULT_WIDTH:0] renorm_shamt_sgn;
  single_file_lzc #(
      .WIDTH(INT_MAN_WIDTH),
      .MODE (1)
  ) i_lzc (
      .in_i   (encoded_mant),
      .cnt_o  (renorm_shamt),
      .empty_o(mant_is_zero)
  );
  assign renorm_shamt_sgn = signed'({1'b0, renorm_shamt});
  assign input_sign = src_is_int ? int_sign : fmt_sign[src_fmt_q];
  assign input_mant = encoded_mant << renorm_shamt;
  assign fp_input_exp = signed'(src_exp + src_subnormal - src_bias - renorm_shamt_sgn + src_offset);
  assign int_input_exp = signed'(INT_MAN_WIDTH - 1 - renorm_shamt_sgn);
  assign input_exp = src_is_int ? int_input_exp : fp_input_exp;
  logic signed [INT_EXP_WIDTH-1:0] destination_exp;
  assign destination_exp = input_exp + signed'(single_file_fpnew_pkg::bias(dst_fmt_q));
  logic                                                          input_sign_q;
  logic signed            [INT_EXP_WIDTH-1:0]                    input_exp_q;
  logic                   [INT_MAN_WIDTH-1:0]                    input_mant_q;
  logic signed            [INT_EXP_WIDTH-1:0]                    destination_exp_q;
  logic                                                          src_is_int_q;
  logic                                                          dst_is_int_q;
  single_file_fpnew_pkg::fp_info_t                                           info_q;
  logic                                                          mant_is_zero_q;
  logic                                                          op_mod_q2;
  single_file_fpnew_pkg::roundmode_e                                         rnd_mode_q;
  single_file_fpnew_pkg::fp_format_e                                         src_fmt_q2;
  single_file_fpnew_pkg::fp_format_e                                         dst_fmt_q2;
  single_file_fpnew_pkg::int_format_e                                        int_fmt_q2;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_input_sign_q;
  logic signed            [   0:NUM_MID_REGS][INT_EXP_WIDTH-1:0] mid_pipe_input_exp_q;
  logic                   [   0:NUM_MID_REGS][INT_MAN_WIDTH-1:0] mid_pipe_input_mant_q;
  logic signed            [   0:NUM_MID_REGS][INT_EXP_WIDTH-1:0] mid_pipe_dest_exp_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_src_is_int_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_dst_is_int_q;
  single_file_fpnew_pkg::fp_info_t    [   0:NUM_MID_REGS]                    mid_pipe_info_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_mant_zero_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_op_mod_q;
  single_file_fpnew_pkg::roundmode_e  [   0:NUM_MID_REGS]                    mid_pipe_rnd_mode_q;
  single_file_fpnew_pkg::fp_format_e  [   0:NUM_MID_REGS]                    mid_pipe_src_fmt_q;
  single_file_fpnew_pkg::fp_format_e  [   0:NUM_MID_REGS]                    mid_pipe_dst_fmt_q;
  single_file_fpnew_pkg::int_format_e [   0:NUM_MID_REGS]                    mid_pipe_int_fmt_q;
  TagType                 [   0:NUM_MID_REGS]                    mid_pipe_tag_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_mask_q;
  AuxType                 [   0:NUM_MID_REGS]                    mid_pipe_aux_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_valid_q;
  logic                   [   0:NUM_MID_REGS]                    mid_pipe_ready;
  assign mid_pipe_input_sign_q[0]     = input_sign;
  assign mid_pipe_input_exp_q[0]      = input_exp;
  assign mid_pipe_input_mant_q[0]     = input_mant;
  assign mid_pipe_dest_exp_q[0]       = destination_exp;
  assign mid_pipe_src_is_int_q[0]     = src_is_int;
  assign mid_pipe_dst_is_int_q[0]     = dst_is_int;
  assign mid_pipe_info_q[0]           = info[src_fmt_q];
  assign mid_pipe_mant_zero_q[0]      = mant_is_zero;
  assign mid_pipe_op_mod_q[0]         = op_mod_q;
  assign mid_pipe_rnd_mode_q[0]       = inp_pipe_rnd_mode_q[NUM_INP_REGS];
  assign mid_pipe_src_fmt_q[0]        = src_fmt_q;
  assign mid_pipe_dst_fmt_q[0]        = dst_fmt_q;
  assign mid_pipe_int_fmt_q[0]        = int_fmt_q;
  assign mid_pipe_tag_q[0]            = inp_pipe_tag_q[NUM_INP_REGS];
  assign mid_pipe_mask_q[0]           = inp_pipe_mask_q[NUM_INP_REGS];
  assign mid_pipe_aux_q[0]            = inp_pipe_aux_q[NUM_INP_REGS];
  assign mid_pipe_valid_q[0]          = inp_pipe_valid_q[NUM_INP_REGS];
  assign inp_pipe_ready[NUM_INP_REGS] = mid_pipe_ready[0];
  for (genvar i = 0; i < NUM_MID_REGS; i++) begin : gen_inside_pipeline
    logic reg_ena;
    assign mid_pipe_ready[i] = mid_pipe_ready[i+1] | ~mid_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        mid_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        mid_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (mid_pipe_ready[i]) ? (mid_pipe_valid_q[i]) : (mid_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (mid_pipe_ready[i] & mid_pipe_valid_q[i]) | reg_ena_i[NUM_INP_REGS+i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_input_sign_q[i+1] <= ('0);
      end else begin
        mid_pipe_input_sign_q[i+1] <= (reg_ena) ? (mid_pipe_input_sign_q[i]) : (mid_pipe_input_sign_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_input_exp_q[i+1] <= ('0);
      end else begin
        mid_pipe_input_exp_q[i+1] <= (reg_ena) ? (mid_pipe_input_exp_q[i]) : (mid_pipe_input_exp_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_input_mant_q[i+1] <= ('0);
      end else begin
        mid_pipe_input_mant_q[i+1] <= (reg_ena) ? (mid_pipe_input_mant_q[i]) : (mid_pipe_input_mant_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_dest_exp_q[i+1] <= ('0);
      end else begin
        mid_pipe_dest_exp_q[i+1] <= (reg_ena) ? (mid_pipe_dest_exp_q[i]) : (mid_pipe_dest_exp_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_src_is_int_q[i+1] <= ('0);
      end else begin
        mid_pipe_src_is_int_q[i+1] <= (reg_ena) ? (mid_pipe_src_is_int_q[i]) : (mid_pipe_src_is_int_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_dst_is_int_q[i+1] <= ('0);
      end else begin
        mid_pipe_dst_is_int_q[i+1] <= (reg_ena) ? (mid_pipe_dst_is_int_q[i]) : (mid_pipe_dst_is_int_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_info_q[i+1] <= ('0);
      end else begin
        mid_pipe_info_q[i+1] <= (reg_ena) ? (mid_pipe_info_q[i]) : (mid_pipe_info_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_mant_zero_q[i+1] <= ('0);
      end else begin
        mid_pipe_mant_zero_q[i+1] <= (reg_ena) ? (mid_pipe_mant_zero_q[i]) : (mid_pipe_mant_zero_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_op_mod_q[i+1] <= ('0);
      end else begin
        mid_pipe_op_mod_q[i+1] <= (reg_ena) ? (mid_pipe_op_mod_q[i]) : (mid_pipe_op_mod_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_rnd_mode_q[i+1] <= (single_file_fpnew_pkg::RNE);
      end else begin
        mid_pipe_rnd_mode_q[i+1] <= (reg_ena) ? (mid_pipe_rnd_mode_q[i]) : (mid_pipe_rnd_mode_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_src_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        mid_pipe_src_fmt_q[i+1] <= (reg_ena) ? (mid_pipe_src_fmt_q[i]) : (mid_pipe_src_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_dst_fmt_q[i+1] <= (single_file_fpnew_pkg::fp_format_e'(0));
      end else begin
        mid_pipe_dst_fmt_q[i+1] <= (reg_ena) ? (mid_pipe_dst_fmt_q[i]) : (mid_pipe_dst_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_int_fmt_q[i+1] <= (single_file_fpnew_pkg::int_format_e'(0));
      end else begin
        mid_pipe_int_fmt_q[i+1] <= (reg_ena) ? (mid_pipe_int_fmt_q[i]) : (mid_pipe_int_fmt_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        mid_pipe_tag_q[i+1] <= (reg_ena) ? (mid_pipe_tag_q[i]) : (mid_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_mask_q[i+1] <= ('0);
      end else begin
        mid_pipe_mask_q[i+1] <= (reg_ena) ? (mid_pipe_mask_q[i]) : (mid_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        mid_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        mid_pipe_aux_q[i+1] <= (reg_ena) ? (mid_pipe_aux_q[i]) : (mid_pipe_aux_q[i+1]);
      end
    end
  end
  assign input_sign_q      = mid_pipe_input_sign_q[NUM_MID_REGS];
  assign input_exp_q       = mid_pipe_input_exp_q[NUM_MID_REGS];
  assign input_mant_q      = mid_pipe_input_mant_q[NUM_MID_REGS];
  assign destination_exp_q = mid_pipe_dest_exp_q[NUM_MID_REGS];
  assign src_is_int_q      = mid_pipe_src_is_int_q[NUM_MID_REGS];
  assign dst_is_int_q      = mid_pipe_dst_is_int_q[NUM_MID_REGS];
  assign info_q            = mid_pipe_info_q[NUM_MID_REGS];
  assign mant_is_zero_q    = mid_pipe_mant_zero_q[NUM_MID_REGS];
  assign op_mod_q2         = mid_pipe_op_mod_q[NUM_MID_REGS];
  assign rnd_mode_q        = mid_pipe_rnd_mode_q[NUM_MID_REGS];
  assign src_fmt_q2        = mid_pipe_src_fmt_q[NUM_MID_REGS];
  assign dst_fmt_q2        = mid_pipe_dst_fmt_q[NUM_MID_REGS];
  assign int_fmt_q2        = mid_pipe_int_fmt_q[NUM_MID_REGS];
  logic [INT_EXP_WIDTH-1:0] final_exp;
  logic [2*INT_MAN_WIDTH:0] preshift_mant;
  logic [2*INT_MAN_WIDTH:0] destination_mant;
  logic [SUPER_MAN_BITS-1:0] final_mant;
  logic [MAX_INT_WIDTH-1:0] final_int;
  logic [$clog2(INT_MAN_WIDTH+1)-1:0] denorm_shamt;
  logic [1:0] fp_round_sticky_bits, int_round_sticky_bits, round_sticky_bits;
  logic of_before_round, uf_before_round;
  always_comb begin : cast_value
    final_exp       = unsigned'(destination_exp_q);
    preshift_mant   = '0;
    denorm_shamt    = SUPER_MAN_BITS - single_file_fpnew_pkg::man_bits(dst_fmt_q2);
    of_before_round = 1'b0;
    uf_before_round = 1'b0;
    preshift_mant   = input_mant_q << (INT_MAN_WIDTH + 1);
    if (dst_is_int_q) begin
      denorm_shamt = unsigned'(MAX_INT_WIDTH - 1 - input_exp_q);
      if ((input_exp_q >= signed'(single_file_fpnew_pkg::int_width(
              int_fmt_q2
          ) - 1 + op_mod_q2)) &&
              !(!op_mod_q2 && input_sign_q && (input_exp_q == signed'(single_file_fpnew_pkg::int_width(
              int_fmt_q2
          ) - 1)) && (input_mant_q == {1'b1, {INT_MAN_WIDTH - 1{1'b0}}}))) begin
        denorm_shamt    = '0;
        of_before_round = 1'b1;
      end else if (input_exp_q < -1) begin
        denorm_shamt    = MAX_INT_WIDTH + 1;
        uf_before_round = 1'b1;
      end
    end else begin
      if ((destination_exp_q >= signed'(2 ** single_file_fpnew_pkg::exp_bits(
              dst_fmt_q2
          )) - 1) || (~src_is_int_q && info_q.is_inf)) begin
        final_exp       = unsigned'(2 ** single_file_fpnew_pkg::exp_bits(dst_fmt_q2) - 2);
        preshift_mant   = '1;
        of_before_round = 1'b1;
      end else if (destination_exp_q < 1 && destination_exp_q >= -signed'(single_file_fpnew_pkg::man_bits(
              dst_fmt_q2
          ))) begin
        final_exp       = '0;
        denorm_shamt    = unsigned'(denorm_shamt + 1 - destination_exp_q);
        uf_before_round = 1'b1;
      end else if (destination_exp_q < -signed'(single_file_fpnew_pkg::man_bits(dst_fmt_q2))) begin
        final_exp       = '0;
        denorm_shamt    = unsigned'(denorm_shamt + 2 + single_file_fpnew_pkg::man_bits(dst_fmt_q2));
        uf_before_round = 1'b1;
      end
    end
  end
  localparam NUM_FP_STICKY = 2 * INT_MAN_WIDTH - SUPER_MAN_BITS - 1;
  localparam NUM_INT_STICKY = 2 * INT_MAN_WIDTH - MAX_INT_WIDTH;
  assign destination_mant = preshift_mant >> denorm_shamt;
  assign {final_mant, fp_round_sticky_bits[1]} =
      destination_mant[2*INT_MAN_WIDTH-1-:SUPER_MAN_BITS+1];
  assign {final_int, int_round_sticky_bits[1]} = destination_mant[2*INT_MAN_WIDTH-:MAX_INT_WIDTH+1];
  assign fp_round_sticky_bits[0] = (|{destination_mant[NUM_FP_STICKY-1:0]});
  assign int_round_sticky_bits[0] = (|{destination_mant[NUM_INT_STICKY-1:0]});
  assign round_sticky_bits = dst_is_int_q ? int_round_sticky_bits : fp_round_sticky_bits;
  logic [          WIDTH-1:0]            pre_round_abs;
  logic                                  of_after_round;
  logic                                  uf_after_round;
  logic [    NUM_FORMATS-1:0][WIDTH-1:0] fmt_pre_round_abs;
  logic [    NUM_FORMATS-1:0]            fmt_of_after_round;
  logic [    NUM_FORMATS-1:0]            fmt_uf_after_round;
  logic [NUM_INT_FORMATS-1:0][WIDTH-1:0] ifmt_pre_round_abs;
  logic [NUM_INT_FORMATS-1:0]            ifmt_of_after_round;
  logic                                  rounded_sign;
  logic [          WIDTH-1:0]            rounded_abs;
  logic                                  result_true_zero;
  logic [          WIDTH-1:0]            rounded_int_res;
  logic                                  rounded_int_res_zero;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_res_assemble
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : assemble_result
        fmt_pre_round_abs[fmt] = {final_exp[EXP_BITS-1:0], final_mant[MAN_BITS-1:0]};
      end
    end else begin : inactive_format
      assign fmt_pre_round_abs[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_int_res_sign_ext
    localparam int unsigned INT_WIDTH = single_file_fpnew_pkg::int_width(single_file_fpnew_pkg::int_format_e'(ifmt));
    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : assemble_result
        ifmt_pre_round_abs[ifmt]                = '{default: final_int[INT_WIDTH-1]};
        ifmt_pre_round_abs[ifmt][INT_WIDTH-1:0] = final_int[INT_WIDTH-1:0];
      end
    end else begin : inactive_format
      assign ifmt_pre_round_abs[ifmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign pre_round_abs = dst_is_int_q ? ifmt_pre_round_abs[int_fmt_q2] : fmt_pre_round_abs[dst_fmt_q2];
  single_file_fpnew_rounding #(
      .AbsWidth(WIDTH)
  ) i_fpnew_rounding (
      .abs_value_i            (pre_round_abs),
      .sign_i                 (input_sign_q),
      .round_sticky_bits_i    (round_sticky_bits),
      .rnd_mode_i             (rnd_mode_q),
      .effective_subtraction_i(1'b0),
      .abs_rounded_o          (rounded_abs),
      .sign_o                 (rounded_sign),
      .exact_zero_o           (result_true_zero)
  );
  logic [NUM_FORMATS-1:0][WIDTH-1:0] fmt_result;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_sign_inject
    localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : post_process
        fmt_uf_after_round[fmt] = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '0;
        fmt_of_after_round[fmt] = rounded_abs[EXP_BITS+MAN_BITS-1:MAN_BITS] == '1;
        fmt_result[fmt] = '1;
        fmt_result[fmt][FP_WIDTH-1:0] = src_is_int_q & mant_is_zero_q
                                        ? '0
                                        : {rounded_sign, rounded_abs[EXP_BITS+MAN_BITS-1:0]};
      end
    end else begin : inactive_format
      assign fmt_uf_after_round[fmt] = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_of_after_round[fmt] = single_file_fpnew_pkg::DONT_CARE;
      assign fmt_result[fmt]         = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign rounded_int_res      = rounded_sign ? unsigned'(-rounded_abs) : rounded_abs;
  assign rounded_int_res_zero = (rounded_int_res == '0);
  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_int_overflow
    localparam int unsigned INT_WIDTH = single_file_fpnew_pkg::int_width(single_file_fpnew_pkg::int_format_e'(ifmt));
    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : detect_overflow
        ifmt_of_after_round[ifmt] = 1'b0;
        if (!rounded_sign && input_exp_q == signed'(INT_WIDTH - 2 + op_mod_q2)) begin
          ifmt_of_after_round[ifmt] = ~rounded_int_res[INT_WIDTH-2+op_mod_q2];
        end
      end
    end else begin : inactive_format
      assign ifmt_of_after_round[ifmt] = single_file_fpnew_pkg::DONT_CARE;
    end
  end
  assign uf_after_round = fmt_uf_after_round[dst_fmt_q2];
  assign of_after_round = dst_is_int_q ? ifmt_of_after_round[int_fmt_q2] : fmt_of_after_round[dst_fmt_q2];
  logic               [      WIDTH-1:0]            fp_special_result;
  single_file_fpnew_pkg::status_t                              fp_special_status;
  logic                                            fp_result_is_special;
  logic               [NUM_FORMATS-1:0][WIDTH-1:0] fmt_special_result;
  for (genvar fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_special_results
    localparam int unsigned FP_WIDTH = single_file_fpnew_pkg::fp_width(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned EXP_BITS = single_file_fpnew_pkg::exp_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam int unsigned MAN_BITS = single_file_fpnew_pkg::man_bits(single_file_fpnew_pkg::fp_format_e'(fmt));
    localparam logic [EXP_BITS-1:0] QNAN_EXPONENT = '1;
    localparam logic [MAN_BITS-1:0] QNAN_MANTISSA = 2 ** (MAN_BITS - 1);
    if (FpFmtConfig[fmt]) begin : active_format
      always_comb begin : special_results
        logic [FP_WIDTH-1:0] special_res;
        special_res = info_q.is_zero
                      ? input_sign_q << FP_WIDTH-1
                      : {1'b0, QNAN_EXPONENT, QNAN_MANTISSA};
        fmt_special_result[fmt] = '1;
        fmt_special_result[fmt][FP_WIDTH-1:0] = special_res;
      end
    end else begin : inactive_format
      assign fmt_special_result[fmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign fp_result_is_special = ~src_is_int_q & (info_q.is_zero | info_q.is_nan | ~info_q.is_boxed);
  assign fp_special_status = '{NV: info_q.is_signalling, default: 1'b0};
  assign fp_special_result = fmt_special_result[dst_fmt_q2];
  logic               [          WIDTH-1:0]            int_special_result;
  single_file_fpnew_pkg::status_t                                  int_special_status;
  logic                                                int_result_is_special;
  logic               [NUM_INT_FORMATS-1:0][WIDTH-1:0] ifmt_special_result;
  for (genvar ifmt = 0; ifmt < int'(NUM_INT_FORMATS); ifmt++) begin : gen_special_results_int
    localparam int unsigned INT_WIDTH = single_file_fpnew_pkg::int_width(single_file_fpnew_pkg::int_format_e'(ifmt));
    if (IntFmtConfig[ifmt]) begin : active_format
      always_comb begin : special_results
        automatic logic [INT_WIDTH-1:0] special_res;
        special_res[INT_WIDTH-2:0] = '1;
        special_res[INT_WIDTH-1]   = op_mod_q2;
        if (input_sign_q && !info_q.is_nan) special_res = ~special_res;
        ifmt_special_result[ifmt]                = '{default: special_res[INT_WIDTH-1]};
        ifmt_special_result[ifmt][INT_WIDTH-1:0] = special_res;
      end
    end else begin : inactive_format
      assign ifmt_special_result[ifmt] = '{default: single_file_fpnew_pkg::DONT_CARE};
    end
  end
  assign int_result_is_special = info_q.is_nan | info_q.is_inf |
                                 of_before_round | of_after_round | ~info_q.is_boxed |
                                 (input_sign_q & op_mod_q2 & ~rounded_int_res_zero);
  assign int_special_status = '{NV: 1'b1, default: 1'b0};
  assign int_special_result = ifmt_special_result[int_fmt_q2];
  single_file_fpnew_pkg::status_t int_regular_status, fp_regular_status;
  logic [WIDTH-1:0] fp_result, int_result;
  single_file_fpnew_pkg::status_t fp_status, int_status;
  assign fp_regular_status.NV = src_is_int_q & (of_before_round | of_after_round);
  assign fp_regular_status.DZ = 1'b0;
  assign fp_regular_status.OF = ~src_is_int_q & (~info_q.is_inf & (of_before_round | of_after_round));
  assign fp_regular_status.UF = uf_after_round & fp_regular_status.NX;
  assign fp_regular_status.NX = src_is_int_q ? (| fp_round_sticky_bits)
            : (| fp_round_sticky_bits) | (~info_q.is_inf & (of_before_round | of_after_round));
  assign int_regular_status = '{NX: (|int_round_sticky_bits), default: 1'b0};
  assign fp_result = fp_result_is_special ? fp_special_result : fmt_result[dst_fmt_q2];
  assign fp_status = fp_result_is_special ? fp_special_status : fp_regular_status;
  assign int_result = int_result_is_special ? int_special_result : rounded_int_res;
  assign int_status = int_result_is_special ? int_special_status : int_regular_status;
  logic               [WIDTH-1:0] result_d;
  single_file_fpnew_pkg::status_t             status_d;
  logic                           extension_bit;
  assign result_d = dst_is_int_q ? int_result : fp_result;
  assign status_d = dst_is_int_q ? int_status : fp_status;
  assign extension_bit = dst_is_int_q ? int_result[WIDTH-1] : 1'b1;
  logic               [0:NUM_OUT_REGS][WIDTH-1:0] out_pipe_result_q;
  single_file_fpnew_pkg::status_t [0:NUM_OUT_REGS]            out_pipe_status_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_ext_bit_q;
  TagType             [0:NUM_OUT_REGS]            out_pipe_tag_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_mask_q;
  AuxType             [0:NUM_OUT_REGS]            out_pipe_aux_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_valid_q;
  logic               [0:NUM_OUT_REGS]            out_pipe_ready;
  assign out_pipe_result_q[0]         = result_d;
  assign out_pipe_status_q[0]         = status_d;
  assign out_pipe_ext_bit_q[0]        = extension_bit;
  assign out_pipe_tag_q[0]            = mid_pipe_tag_q[NUM_MID_REGS];
  assign out_pipe_mask_q[0]           = mid_pipe_mask_q[NUM_MID_REGS];
  assign out_pipe_aux_q[0]            = mid_pipe_aux_q[NUM_MID_REGS];
  assign out_pipe_valid_q[0]          = mid_pipe_valid_q[NUM_MID_REGS];
  assign mid_pipe_ready[NUM_MID_REGS] = out_pipe_ready[0];
  for (genvar i = 0; i < NUM_OUT_REGS; i++) begin : gen_output_pipeline
    logic reg_ena;
    assign out_pipe_ready[i] = out_pipe_ready[i+1] | ~out_pipe_valid_q[i+1];
    always_ff @(posedge (clk_i) or negedge (rst_ni)) begin
      if (!rst_ni) begin
        out_pipe_valid_q[i+1] <= (1'b0);
      end else begin
        out_pipe_valid_q[i+1] <= (flush_i) ? (1'b0) : (out_pipe_ready[i]) ? (out_pipe_valid_q[i]) : (out_pipe_valid_q[i+1]);
      end
    end
    assign reg_ena = (out_pipe_ready[i] & out_pipe_valid_q[i]) | reg_ena_i[NUM_INP_REGS + NUM_MID_REGS + i];
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_result_q[i+1] <= ('0);
      end else begin
        out_pipe_result_q[i+1] <= (reg_ena) ? (out_pipe_result_q[i]) : (out_pipe_result_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_status_q[i+1] <= ('0);
      end else begin
        out_pipe_status_q[i+1] <= (reg_ena) ? (out_pipe_status_q[i]) : (out_pipe_status_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_ext_bit_q[i+1] <= ('0);
      end else begin
        out_pipe_ext_bit_q[i+1] <= (reg_ena) ? (out_pipe_ext_bit_q[i]) : (out_pipe_ext_bit_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_tag_q[i+1] <= (TagType'('0));
      end else begin
        out_pipe_tag_q[i+1] <= (reg_ena) ? (out_pipe_tag_q[i]) : (out_pipe_tag_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_mask_q[i+1] <= ('0);
      end else begin
        out_pipe_mask_q[i+1] <= (reg_ena) ? (out_pipe_mask_q[i]) : (out_pipe_mask_q[i+1]);
      end
    end
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        out_pipe_aux_q[i+1] <= (AuxType'('0));
      end else begin
        out_pipe_aux_q[i+1] <= (reg_ena) ? (out_pipe_aux_q[i]) : (out_pipe_aux_q[i+1]);
      end
    end
  end
  assign out_pipe_ready[NUM_OUT_REGS] = out_ready_i;
  assign result_o                     = out_pipe_result_q[NUM_OUT_REGS];
  assign status_o                     = out_pipe_status_q[NUM_OUT_REGS];
  assign extension_bit_o              = out_pipe_ext_bit_q[NUM_OUT_REGS];
  assign tag_o                        = out_pipe_tag_q[NUM_OUT_REGS];
  assign mask_o                       = out_pipe_mask_q[NUM_OUT_REGS];
  assign aux_o                        = out_pipe_aux_q[NUM_OUT_REGS];
  assign out_valid_o                  = out_pipe_valid_q[NUM_OUT_REGS];
  assign busy_o                       = (|{inp_pipe_valid_q, mid_pipe_valid_q, out_pipe_valid_q});
endmodule


module single_file_fpnew_top #(
    parameter single_file_fpnew_pkg::fpu_features_t       Features       = single_file_fpnew_pkg::RV64D_XSFLT,
    parameter single_file_fpnew_pkg::fpu_implementation_t Implementation = single_file_fpnew_pkg::DEFAULT_NOREGS,
    parameter logic        PulpDivsqrt    = 1'b1,
    parameter type         TagType        = logic,
    parameter int unsigned TrueSIMDClass  = 0,
    parameter int unsigned EnableSIMDMask = 0,
    localparam int unsigned NumLanes = single_file_fpnew_pkg::max_num_lanes(
        Features.Width, Features.FpFmtMask, Features.EnableVectors
    ),
    localparam type MaskType = logic [NumLanes-1:0],
    localparam int unsigned WIDTH = Features.Width,
    localparam int unsigned NumOperands = 3
) (
    input logic clk_i,
    input logic rst_ni,
    input logic [NumOperands-1:0][WIDTH-1:0] operands_i,
    input single_file_fpnew_pkg::roundmode_e rnd_mode_i,
    input single_file_fpnew_pkg::operation_e op_i,
    input logic op_mod_i,
    input single_file_fpnew_pkg::fp_format_e src_fmt_i,
    input single_file_fpnew_pkg::fp_format_e dst_fmt_i,
    input single_file_fpnew_pkg::int_format_e int_fmt_i,
    input logic vectorial_op_i,
    input TagType tag_i,
    input MaskType simd_mask_i,
    input  logic in_valid_i,
    output logic in_ready_o,
    input  logic flush_i,
    output logic               [WIDTH-1:0] result_o,
    output single_file_fpnew_pkg::status_t             status_o,
    output TagType                         tag_o,
    output logic out_valid_o,
    input  logic out_ready_i,
    output logic busy_o
);
  localparam int unsigned NumOpgroups = single_file_fpnew_pkg::NUM_OPGROUPS;
  localparam int unsigned NumFormats = single_file_fpnew_pkg::NUM_FP_FORMATS;
  typedef struct packed {
    logic [WIDTH-1:0]   result;
    single_file_fpnew_pkg::status_t status;
    TagType             tag;
  } output_t;
  logic [NumOpgroups-1:0] opgrp_in_ready, opgrp_out_valid, opgrp_out_ready, opgrp_ext, opgrp_busy;
  output_t [NumOpgroups-1:0] opgrp_outputs;
  logic [NumFormats-1:0][NumOperands-1:0] is_boxed;
  assign in_ready_o = in_valid_i & opgrp_in_ready[single_file_fpnew_pkg::get_opgroup(
          op_i
      )];
  for (
      genvar fmt = 0; fmt < int'(NumFormats); fmt++
  ) begin : gen_nanbox_check
    localparam int unsigned FpWidth = single_file_fpnew_pkg::fp_width(
        single_file_fpnew_pkg::fp_format_e'(fmt)
    );
    if (Features.EnableNanBox && (FpWidth < WIDTH)) begin : g_check
      for (
          genvar op = 0; op < int'(NumOperands); op++
      ) begin : g_operands
        assign is_boxed[fmt][op] = (!vectorial_op_i) ?
            operands_i[op][WIDTH-1:FpWidth] == '1 : 1'b1;
      end
    end else begin : g_no_check
      assign is_boxed[fmt] = '1;
    end
  end
  MaskType simd_mask;
  assign simd_mask = simd_mask_i | ~{NumLanes{logic'(EnableSIMDMask)}};
  for (
      genvar opgrp = 0; opgrp < int'(NumOpgroups); opgrp++
  ) begin : gen_operation_groups
    localparam int unsigned NumOps = single_file_fpnew_pkg::num_operands(
        single_file_fpnew_pkg::opgroup_e'(opgrp)
    );
    logic in_valid;
    logic [NumFormats-1:0][NumOps-1:0] input_boxed;
    assign in_valid = in_valid_i & (single_file_fpnew_pkg::get_opgroup(
            op_i
        ) == single_file_fpnew_pkg::opgroup_e'(opgrp));
    always_comb begin : slice_inputs
      for (int unsigned fmt = 0; fmt < NumFormats; fmt++)
      input_boxed[fmt] = is_boxed[fmt][NumOps-1:0];
    end
    single_file_fpnew_opgroup_block #(
        .OpGroup      (single_file_fpnew_pkg::opgroup_e'(opgrp)),
        .Width        (WIDTH),
        .EnableVectors(Features.EnableVectors),
        .PulpDivsqrt  (PulpDivsqrt),
        .FpFmtMask    (Features.FpFmtMask),
        .IntFmtMask   (Features.IntFmtMask),
        .FmtPipeRegs  (Implementation.PipeRegs[opgrp]),
        .FmtUnitTypes (Implementation.UnitTypes[opgrp]),
        .PipeConfig   (Implementation.PipeConfig),
        .TagType      (TagType),
        .TrueSIMDClass(TrueSIMDClass)
    ) i_opgroup_block (
        .clk_i,
        .rst_ni,
        .operands_i     (operands_i[NumOps-1:0]),
        .is_boxed_i     (input_boxed),
        .rnd_mode_i,
        .op_i,
        .op_mod_i,
        .src_fmt_i,
        .dst_fmt_i,
        .int_fmt_i,
        .vectorial_op_i,
        .tag_i,
        .simd_mask_i    (simd_mask),
        .in_valid_i     (in_valid),
        .in_ready_o     (opgrp_in_ready[opgrp]),
        .flush_i,
        .result_o       (opgrp_outputs[opgrp].result),
        .status_o       (opgrp_outputs[opgrp].status),
        .extension_bit_o(opgrp_ext[opgrp]),
        .tag_o          (opgrp_outputs[opgrp].tag),
        .out_valid_o    (opgrp_out_valid[opgrp]),
        .out_ready_i    (opgrp_out_ready[opgrp]),
        .busy_o         (opgrp_busy[opgrp])
    );
  end
  output_t arbiter_output;
  single_file_rr_arb_tree #(
      .NumIn    (NumOpgroups),
      .DataType (output_t),
      .AxiVldRdy(1'b1)
  ) i_arbiter (
      .clk_i,
      .rst_ni,
      .flush_i,
      .rr_i  ('0),
      .req_i (opgrp_out_valid),
      .gnt_o (opgrp_out_ready),
      .data_i(opgrp_outputs),
      .gnt_i (out_ready_i),
      .req_o (out_valid_o),
      .data_o(arbiter_output),
      .idx_o ()
  );
  assign result_o = arbiter_output.result;
  assign status_o = arbiter_output.status;
  assign tag_o    = arbiter_output.tag;
  assign busy_o   = (|opgrp_busy);
endmodule


module single_file_rv32imf_fp_wrapper (
    input logic clk_i,
    input logic rst_ni,
    input  logic apu_req_i,
    output logic apu_gnt_o,
    input logic [ 2:0][31:0] apu_operands_i,
    input logic [ 5:0]       apu_op_i,
    input logic [14:0]       apu_flags_i,
    output logic        apu_rvalid_o,
    output logic [31:0] apu_rdata_o,
    output logic [ 4:0] apu_rflags_o
);
  import single_file_rv32imf_pkg::*;
  import single_file_fpnew_pkg::*;
  logic [        single_file_fpnew_pkg::OP_BITS-1:0] fpu_op;
  logic                                  fpu_op_mod;
  logic                                  fpu_vec_op;
  logic [ single_file_fpnew_pkg::FP_FORMAT_BITS-1:0] fpu_dst_fmt;
  logic [ single_file_fpnew_pkg::FP_FORMAT_BITS-1:0] fpu_src_fmt;
  logic [single_file_fpnew_pkg::INT_FORMAT_BITS-1:0] fpu_int_fmt;
  logic [                      C_RM-1:0] fp_rnd_mode;
  assign {fpu_vec_op, fpu_op_mod, fpu_op} = apu_op_i;
  assign {fpu_int_fmt, fpu_src_fmt, fpu_dst_fmt, fp_rnd_mode} = apu_flags_i;
  localparam single_file_fpnew_pkg::fpu_features_t FpuFeatures = '{
      Width: C_FLEN,
      EnableVectors: C_XFVEC,
      EnableNanBox: 1'b0,
      FpFmtMask: {C_RVF, C_RVD, C_XF16, C_XF8, C_XF16ALT},
      IntFmtMask: {
        C_XFVEC && C_XF8, C_XFVEC && (C_XF16 || C_XF16ALT), 1'b1, 1'b0
      }
  };
  localparam single_file_fpnew_pkg::fpu_implementation_t FpuImplementation = '{
      PipeRegs: '{
          '{0, C_LAT_FP64, C_LAT_FP16, C_LAT_FP8, C_LAT_FP16ALT},
          '{default: C_LAT_DIVSQRT},
          '{default: 0},
          '{default: 0}
      },
      UnitTypes: '{
          '{default: single_file_fpnew_pkg::MERGED},
          '{default: single_file_fpnew_pkg::MERGED},
          '{default: single_file_fpnew_pkg::PARALLEL},
          '{default: single_file_fpnew_pkg::MERGED}
      },
      PipeConfig: single_file_fpnew_pkg::AFTER
  };
  single_file_fpnew_top #(
      .Features      (FpuFeatures),
      .Implementation(FpuImplementation),
      .PulpDivsqrt   (1'b0),
      .TagType       (logic)
  ) i_fpnew_bulk (
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .operands_i    (apu_operands_i),
      .rnd_mode_i    (single_file_fpnew_pkg::roundmode_e'(fp_rnd_mode)),
      .op_i          (single_file_fpnew_pkg::operation_e'(fpu_op)),
      .op_mod_i      (fpu_op_mod),
      .src_fmt_i     (single_file_fpnew_pkg::fp_format_e'(fpu_src_fmt)),
      .dst_fmt_i     (single_file_fpnew_pkg::fp_format_e'(fpu_dst_fmt)),
      .int_fmt_i     (single_file_fpnew_pkg::int_format_e'(fpu_int_fmt)),
      .vectorial_op_i(fpu_vec_op),
      .tag_i         (1'b0),
      .simd_mask_i   (1'b0),
      .in_valid_i    (apu_req_i),
      .in_ready_o    (apu_gnt_o),
      .flush_i       (1'b0),
      .result_o      (apu_rdata_o),
      .status_o      (apu_rflags_o),
      .tag_o         (),
      .out_valid_o   (apu_rvalid_o),
      .out_ready_i   (1'b1),
      .busy_o        ()
  );
endmodule


module rv32imf (
    input logic clk_i,
    input logic rst_ni,
    input logic [31:0] boot_addr_i,
    input logic [31:0] dm_halt_addr_i,
    input logic [31:0] hart_id_i,
    input logic [31:0] dm_exception_addr_i,
    output logic        instr_req_o,
    input  logic        instr_gnt_i,
    input  logic        instr_rvalid_i,
    output logic [31:0] instr_addr_o,
    input  logic [31:0] instr_rdata_i,
    output logic        data_req_o,
    input  logic        data_gnt_i,
    input  logic        data_rvalid_i,
    output logic        data_we_o,
    output logic [ 3:0] data_be_o,
    output logic [31:0] data_addr_o,
    output logic [31:0] data_wdata_o,
    input  logic [31:0] data_rdata_i,
    input  logic [31:0] irq_i,
    output logic        irq_ack_o,
    output logic [ 4:0] irq_id_o
);
  logic              apu_busy;
  logic              apu_req;
  logic [ 2:0][31:0] apu_operands;
  logic [ 5:0]       apu_op;
  logic [14:0]       apu_flags;
  logic              apu_gnt;
  logic              apu_rvalid;
  logic [31:0]       apu_rdata;
  logic [ 4:0]       apu_rflags;
  logic apu_clk_en, apu_clk;
  single_file_rv32imf_core #() core_i (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .boot_addr_i        (boot_addr_i),
      .mtvec_addr_i       ('0),
      .dm_halt_addr_i     (dm_halt_addr_i),
      .hart_id_i          (hart_id_i),
      .dm_exception_addr_i(dm_exception_addr_i),
      .instr_req_o   (instr_req_o),
      .instr_gnt_i   (instr_gnt_i),
      .instr_rvalid_i(instr_rvalid_i),
      .instr_addr_o  (instr_addr_o),
      .instr_rdata_i (instr_rdata_i),
      .data_req_o   (data_req_o),
      .data_gnt_i   (data_gnt_i),
      .data_rvalid_i(data_rvalid_i),
      .data_we_o    (data_we_o),
      .data_be_o    (data_be_o),
      .data_addr_o  (data_addr_o),
      .data_wdata_o (data_wdata_o),
      .data_rdata_i (data_rdata_i),
      .apu_busy_o    (apu_busy),
      .apu_req_o     (apu_req),
      .apu_gnt_i     (apu_gnt),
      .apu_operands_o(apu_operands),
      .apu_op_o      (apu_op),
      .apu_flags_o   (apu_flags),
      .apu_rvalid_i  (apu_rvalid),
      .apu_result_i  (apu_rdata),
      .apu_flags_i   (apu_rflags),
      .irq_i    (irq_i),
      .irq_ack_o(irq_ack_o),
      .irq_id_o (irq_id_o)
  );
  assign apu_clk_en = apu_req | apu_busy;
  single_file_rv32imf_clock_gate core_clock_gate_i (
      .clk_i(clk_i),
      .en_i (apu_clk_en),
      .clk_o(apu_clk)
  );
  single_file_rv32imf_fp_wrapper #() fp_wrapper_i (
      .clk_i         (apu_clk),
      .rst_ni        (rst_ni),
      .apu_req_i     (apu_req),
      .apu_gnt_o     (apu_gnt),
      .apu_operands_i(apu_operands),
      .apu_op_i      (apu_op),
      .apu_flags_i   (apu_flags),
      .apu_rvalid_o  (apu_rvalid),
      .apu_rdata_o   (apu_rdata),
      .apu_rflags_o  (apu_rflags)
  );
endmodule

