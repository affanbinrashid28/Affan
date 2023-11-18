import struct

def read_and_print(file_path, byte_size, read_format, num_reads=10):
    with open(file_path, 'rb') as file:
        for i in range(num_reads):
            position = i * byte_size
            file.seek(position)
            data = file.read(byte_size)
            if len(data) < byte_size:
                break
            print(f"Position {position}: {data.hex()} - Output: {struct.unpack(read_format, data)}")

if __name__ == "__main__":
    file_path = 'ALLaM-Megatron-LM/examples/pretrain-llama/data-processing/detokenize/outputs/data/allam_data_2-1_splits-llama2-indexed_data/llama2_bin_idx/ar_encyclopedias_split_00_text_document.bin'
    byte_size = 8
    read_format = '<Q'

    read_and_print(file_path, byte_size, read_format)
