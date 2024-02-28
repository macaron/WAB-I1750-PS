import sys

def xor_decrypt(data, key):
    key = bytes.fromhex(key)
    decrypted_data = bytearray()

    for i in range(len(data)):
        decrypted_data.append(data[i] ^ key[i % len(key)])

    return bytes(decrypted_data)

def main():
    if len(sys.argv) != 4:
        print("Usage: python decrypt.py <encrypted_file_path> <key> <decrypted_file_path>")
        sys.exit(1)

    encrypted_file_path = sys.argv[1]
    key = sys.argv[2]
    decrypted_file_path = sys.argv[3]

    with open(encrypted_file_path, "rb") as encrypted_file:
        encrypted_data = encrypted_file.read()

    decrypted_data = xor_decrypt(encrypted_data, key)

    with open(decrypted_file_path, "wb") as decrypted_file:
        decrypted_file.write(decrypted_data)

    print("Decrypted!")

if __name__ == "__main__":
    main()
