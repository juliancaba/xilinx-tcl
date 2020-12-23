#define BRAM_BASE_ADDR		0x040000000

int* bram = (int*)BRAM_BASE_ADDR;

int main()
{
	xil_printf("\r\n--- Entering main() --- \r\n");

	/* writing into the BRAM */
	*bram = 0xdeadbeef;
	
	/* reading and checking from BRAM */
	if (0xdeadbeef != *bram) {
		xil_printf("Example Failed\r\n");
		return -1;
	}

	xil_printf("Example worked\r\n");

	xil_printf("--- Exiting main() --- \r\n");

	return 0;

}
