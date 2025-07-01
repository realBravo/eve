# 🧬 EVE-ZON: Neural Network with Protein Integration

**EVE-ZON** is a revolutionary neural network implementation that combines cellular modeling with real protein structure data from AlphaFold. By representing biological cells as JSON objects with integrated protein sequences, EVE-ZON creates a bridge between digital neural networks and biological cellular structures.

## ✨ Features

### 🔬 **Biological Cell Modeling**
- **Cellular Properties**: Membrane potential, cell states, and types
- **Protein Integration**: Real AlphaFold protein sequences embedded in each cell
- **Network Connections**: Dynamic relationship mapping between cells
- **Functional Classification**: Protein function categorization

### 🎨 **Advanced Visualization**
- **Visual Cell Cards**: Enhanced display with emojis, colors, and voltage bars
- **Network Topology**: ASCII art visualization of cell connections
- **Interactive Modes**: Multiple command-line options for different views
- **Real-time Statistics**: Network analysis with connection and protein data

### 🚀 **Command-Line Interface**
```bash
# Basic text output
zig run main.zig

# Pretty visual cards with emojis and formatting
zig run main.zig -- --visual

# Network topology map with statistics
zig run main.zig -- --network

# Complete analysis with both modes
zig run main.zig -- --visual --network

# Show help
zig run main.zig -- --help
```

## 🧪 **Cell Types & Protein Functions**

| Cell Type | Icon | Function | Protein Example |
|-----------|------|----------|----------------|
| **Neuron** | 🧠 | Neural processing | Cyclin dependent kinase 2 |
| **Glial** | 🔗 | Support & transport | UPF0410 protein YmgE |
| **Receptor** | 📡 | Signal transduction | Free fatty acid receptor 2 |
| **Defense** | 🛡️ | Pathogen resistance | Disease resistance protein |

## 📊 **Data Structure**

Each cell is represented as a JSON object with the following structure:

```json
{
  "cell_001": {
    "type": "neuron",
    "state": "active",
    "membrane_potential": -70,
    "connections": ["cell_002", "cell_005"],
    "protein_sequence": "MENF@KVEKIGEGTYGVVY...",
    "protein_name": "Cyclin dependent kinase 2",
    "protein_function": "cell_cycle_regulation"
  }
}
```

## 🔬 **Scientific Foundation**

### **AlphaFold Integration**
EVE-ZON incorporates real protein structure data from DeepMind's AlphaFold project, including:
- Amino acid sequences from verified protein structures
- Functional protein classifications
- Biological accuracy in cellular modeling

### **Neural Network Architecture**
The system represents neural networks as:
- **Nodes**: Individual cells with biological properties
- **Edges**: Connections representing synaptic or cellular communication
- **States**: Dynamic cell states (active, resting, inhibited, dormant)
- **Properties**: Membrane potentials and protein-based functionality

## 🎯 **Project Vision**

EVE-ZON aims to create the **digital equivalent of a working biological cell** by:

1. **Bridging Biology & AI**: Combining neural network principles with biological cellular structures
2. **Protein-Based Computing**: Using real protein data to inform network behavior
3. **Scalable Architecture**: JSON-based representation for easy expansion and modification
4. **Visual Analysis**: Comprehensive tools for understanding network topology and cellular relationships

## 🔮 **Future Development**

- **Enhanced Protein Integration**: More sophisticated protein-function mapping
- **Dynamic Simulation**: Real-time cellular state changes and network evolution
- **3D Visualization**: Advanced graphical representation of network structures
- **Machine Learning**: AI-driven optimization of cellular network configurations
- **Biological Validation**: Comparison with real cellular network behaviors

## 📚 **Research & References**

- [MIT: Your Brain on ChatGPT](https://www.media.mit.edu/projects/your-brain-on-chatgpt/overview/)
- [DeepMind AlphaFold](https://alphafold.ebi.ac.uk/)
- [Protein Data Bank](https://www.rcsb.org/)

## 🛠 **Technical Stack**

- **Language**: Zig (for performance and memory safety)
- **Data Format**: JSON (for flexibility and interoperability)
- **Visualization**: Unicode/ASCII art with emoji enhancement
- **Architecture**: Modular, extensible design

---

**EVE-ZON represents a breakthrough in bridging biological cellular structures with artificial neural networks, creating a foundation for next-generation bio-inspired computing systems.**
