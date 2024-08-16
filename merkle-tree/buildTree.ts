import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";
import { parseEther, toHex } from "viem";

// (1)

const values = [
  ["0x1111111111111111111111111111111111111111", "5000000000000000000"],
  ["0x2222222222222222222222222222222222222222", "2500000000000000000"],
  ["0x3333333333333333333333333333333333333333"],
];

// (2)
const convertedValues = values.map(([address, value]) => {
  if (value) {
    try {
      const convertedValue = parseEther(value);
      const bytes32Value = toHex(convertedValue, { size: 32 });
      return [address, bytes32Value];
    } catch (error) {
      throw new Error(`Invalid value: ${value}`);
    }
  } else {
    return [address, "0x0000000000000000000000000000000000000000000000000000000000000000"]; // bytes32(0)
  }
});
// (3)
const tree = StandardMerkleTree.of(convertedValues, ["address", "bytes32"]);

// (4)
console.log("Merkle Root:", tree.root);

// (5)
fs.writeFileSync("./merkle-tree/tree.json", JSON.stringify(tree.dump()));

// (6)
for (const [i, v] of tree.entries()) {
  if (v[0] === "0x1111111111111111111111111111111111111111") {
    const proof = tree.getProof(i);
    console.log("Value:", v);
    console.log("Proof:", proof);
  }
}
