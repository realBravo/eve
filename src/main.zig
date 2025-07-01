const std = @import("std");
const print = std.debug.print;

const Cell = struct {
    id: []const u8,
    typ: []const u8,
    state: []const u8,
    membrane_potential: i32,
    connections: [][]const u8,
    protein_sequence: []const u8,
    protein_name: []const u8,
    protein_function: []const u8,
};

fn displayCellVisual(cell: Cell, writer: anytype) !void {
    // Body system symbols - representing the system each cell type belongs to
    const type_symbol = if (std.mem.eql(u8, cell.typ, "neuron")) "🧠" // Nervous system
        else if (std.mem.eql(u8, cell.typ, "glial")) "🧠" // Nervous system (support cells)
        else if (std.mem.eql(u8, cell.typ, "receptor")) "👁️" // Sensory system
        else if (std.mem.eql(u8, cell.typ, "visual_receptor")) "👁️" // Visual system
        else if (std.mem.eql(u8, cell.typ, "auditory_receptor")) "👂" // Auditory system
        else if (std.mem.eql(u8, cell.typ, "defense")) "🛡️" // Immune system
        else if (std.mem.eql(u8, cell.typ, "cardiac")) "❤️" // Cardiovascular system
        else if (std.mem.eql(u8, cell.typ, "muscle")) "💪" // Muscular system
        else if (std.mem.eql(u8, cell.typ, "bone")) "🦴" // Skeletal system
        else if (std.mem.eql(u8, cell.typ, "lung")) "🫁" // Respiratory system
        else if (std.mem.eql(u8, cell.typ, "kidney")) "🟫" // Urinary system
        else if (std.mem.eql(u8, cell.typ, "liver")) "🟤" // Hepatic system
        else if (std.mem.eql(u8, cell.typ, "stomach")) "🍽️" // Digestive system
        else if (std.mem.eql(u8, cell.typ, "intestine")) "🍽️" // Digestive system
        else if (std.mem.eql(u8, cell.typ, "pancreas")) "🍯" // Endocrine system
        else if (std.mem.eql(u8, cell.typ, "thyroid")) "🍯" // Endocrine system
        else if (std.mem.eql(u8, cell.typ, "adrenal")) "🍯" // Endocrine system
        else if (std.mem.eql(u8, cell.typ, "skin")) "🧴" // Integumentary system
        else if (std.mem.eql(u8, cell.typ, "reproductive")) "🌸" // Reproductive system
        else if (std.mem.eql(u8, cell.typ, "lymph")) "🛡️" // Lymphatic system
        else if (std.mem.eql(u8, cell.typ, "blood")) "🩸" // Circulatory system
        else "🔬"; // Unknown/generic

    // State colors (using ANSI escape codes)
    const state_color = switch (cell.state[0]) {
        'a' => "\x1b[32m", // green for active
        'r' => "\x1b[34m", // blue for resting
        'i' => "\x1b[31m", // red for inhibited
        'd' => "\x1b[90m", // gray for dormant
        else => "\x1b[37m", // white default
    };
    const reset_color = "\x1b[0m";

    // Voltage bar visualization
    const voltage_bar = blk: {
        const normalized = @as(f32, @floatFromInt(cell.membrane_potential + 100)) / 50.0; // normalize -100 to 0 range
        const bar_length = @as(usize, @intFromFloat(@max(0, @min(20, normalized))));
        var bar: [21]u8 = [_]u8{' '} ** 21;
        for (0..bar_length) |i| {
            bar[i] = '#';
        }
        bar[20] = 0; // null terminate
        break :blk bar[0..20];
    };

    try writer.print("\n┌─────────────────────────────────────────────────────────────┐\n", .{});
    try writer.print("│ {s} {s}{s:<10}{s} │ ID: {s:<8} │ Connections: {d:<2} │\n", .{ type_symbol, state_color, cell.state, reset_color, cell.id, cell.connections.len });
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ ⚡ Voltage: {d:>4}mV │{s}│ {d:>3}% │\n", .{ cell.membrane_potential, voltage_bar, @as(u8, @intFromFloat(((@as(f32, @floatFromInt(cell.membrane_potential)) + 100.0) / 50.0) * 100.0)) });
    try writer.print("│ 🧬 Protein: {s:<45} │\n", .{if (cell.protein_name.len > 45) cell.protein_name[0..45] else cell.protein_name});
    try writer.print("│ 🔬 Function: {s:<44} │\n", .{if (cell.protein_function.len > 44) cell.protein_function[0..44] else cell.protein_function});
    try writer.print("│ 🧪 Sequence: {d:>4} amino acids                              │\n", .{cell.protein_sequence.len});

    if (cell.connections.len > 0) {
        try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
        try writer.print("│ 🔗 Connected to: ", .{});
        for (cell.connections, 0..) |conn, i| {
            if (i > 0) try writer.print(", ", .{});
            try writer.print("{s}", .{conn});
        }
        try writer.print("\n", .{});
    }
    try writer.print("└─────────────────────────────────────────────────────────────┘\n", .{});
}

// Structure to hold visual data for processing
const VisualData = struct {
    light_intensity: u8, // 0-100
    color_channels: struct {
        red: u8,
        green: u8,
        blue: u8,
    },
    motion_vectors: []const []const u8,
    edge_detection: bool,
    pattern_type: []const u8,
};

// Function to write data to the visual processing framework
fn writeToVisualProcessingFramework(visual_data: VisualData, writer: anytype) !void {
    try writer.print("\n📝 WRITING TO VISUAL PROCESSING FRAMEWORK\n", .{});
    try writer.print("═══════════════════════════════════════════\n\n", .{});
    
    // Framework input stage
    try writer.print("┌─────────────────────────────────────────────────────────────┐\n", .{});
    try writer.print("│                    FRAMEWORK INPUT STAGE                   │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 📊 Light Intensity: {d}%                                   │\n", .{visual_data.light_intensity});
    try writer.print("│ 🎨 RGB Values: ({d}, {d}, {d})                               │\n", .{visual_data.color_channels.red, visual_data.color_channels.green, visual_data.color_channels.blue});
    try writer.print("│ 🔍 Edge Detection: {s}                                      │\n", .{if (visual_data.edge_detection) "ENABLED" else "DISABLED"});
    try writer.print("│ 📐 Pattern Type: {s}                                       │\n", .{visual_data.pattern_type});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    
    // Motion vectors display
    try writer.print("│ 🎯 Motion Vectors:                                         │\n", .{});
    for (visual_data.motion_vectors) |vector| {
        try writer.print("│   → {s}                                                    │\n", .{vector});
    }
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    
    // Processing status
    try writer.print("│                   PROCESSING STATUS                        │\n", .{});
    try writer.print("│ ✅ Raw photon data captured                                 │\n", .{});
    try writer.print("│ ✅ Light/dark contrast analysis                            │\n", .{});
    try writer.print("│ ✅ Data written to retinal buffer                          │\n", .{});
    try writer.print("│ ✅ Photoreceptor signal amplification                     │\n", .{});
    try writer.print("│ ✅ Color channel separation (RGB)                          │\n", .{});
    try writer.print("│ ✅ Color analysis complete                                  │\n", .{});
    try writer.print("│ ✅ Spatial frequency filtering                             │\n", .{});
    try writer.print("│ ✅ Edge detection preprocessing                            │\n", .{});
    try writer.print("│ ✅ Motion detection active                                  │\n", .{});
    try writer.print("│ ✅ Temporal frame comparison                               │\n", .{});
    try writer.print("│ ✅ Object boundary detection                               │\n", .{});
    try writer.print("│ ✅ Pattern recognition engaged                              │\n", .{});
    try writer.print("│ ✅ Feature extraction complete                             │\n", .{});
    try writer.print("│ ✅ Neural pathway mapping                                  │\n", .{});
    try writer.print("│ ✅ Signal strength optimization                            │\n", .{});
    try writer.print("│ 🔄 Forwarding to lateral geniculate nucleus...            │\n", .{});
    try writer.print("│ 🔄 Transmitting to visual cortex...                       │\n", .{});
    try writer.print("│ ⏳ Awaiting cortical processing response...               │\n", .{});
    try writer.print("└─────────────────────────────────────────────────────────────┘\n\n", .{});
}

fn displaySensoryProcessing(_: std.ArrayList(Cell), writer: anytype) !void {
    try writer.print("\n📺 ADVANCED SENSORY-NERVOUS SYSTEM DISPLAY\n", .{});
    try writer.print("════════════════════════════════════════════\n\n", .{});

    // Enhanced visual processing framework with detailed steps
    try writer.print("┌─────────────────────────────────────────────────────────────┐\n", .{});
    try writer.print("│                 VISUAL PROCESSING FRAMEWORK                │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 👁️  PHOTORECEPTORS → 🔄 BIPOLAR → 🔄 GANGLION → 🧠 LGN    │\n", .{});
    try writer.print("│      ↓              ↓            ↓             ↓           │\n", .{});
    try writer.print("│ 🧠 V1 → 🧠 V2 → 🧠 V4 → 🧠 IT → 💭 PERCEPTION → 📺 OUTPUT │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ RETINAL PROCESSING STATUS:                                 │\n", .{});
    try writer.print("│ ✅ Rod/cone activation (120M rods, 6M cones)               │\n", .{});
    try writer.print("│ ✅ Rhodopsin cascade initiated                             │\n", .{});
    try writer.print("│ ✅ Horizontal cell lateral inhibition                      │\n", .{});
    try writer.print("│ ✅ Bipolar cell ON/OFF channel separation                  │\n", .{});
    try writer.print("│ ✅ Amacrine cell temporal processing                       │\n", .{});
    try writer.print("│ ✅ Ganglion cell feature detection                         │\n", .{});
    try writer.print("│ 🔄 Optic nerve transmission (1M axons)                     │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});

    // Visual data display with more detail
    const visual_patterns = [_][]const u8{
        "██████████████████████████████████████████████",
        "██            VISUAL FIELD ANALYSIS         ██",
        "██  ▲ Luminance: 347 cd/m² (photopic range)  ██",
        "██  ● RGB Channels: R:145 G:200 B:85         ██",
        "██  ◆ Motion: →2.5px ↗0.8px ↓-1.2px/frame   ██",
        "██  ■ Spatial Freq: 0.5-8 cycles/degree      ██",
        "██  ♦ Contrast: 78% Weber contrast           ██",
        "██  ▼ Disparity: 2.3 arcmin (depth cue)     ██",
        "██████████████████████████████████████████████",
    };

    for (visual_patterns) |pattern| {
        try writer.print("│ {s} │\n", .{pattern});
    }

    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│              COMPREHENSIVE AUDITORY PROCESSING             │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 👂 COCHLEA → 🧠 BRAINSTEM → 🧠 MGN → 🧠 A1 → 💭 PERCEPTION │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ COCHLEAR PROCESSING STATUS:                                │\n", .{});
    try writer.print("│ ✅ Hair cell mechanotransduction                           │\n", .{});
    try writer.print("│ ✅ Basilar membrane frequency analysis                     │\n", .{});
    try writer.print("│ ✅ Inner hair cell neurotransmitter release               │\n", .{});
    try writer.print("│ ✅ Spiral ganglion action potential generation            │\n", .{});
    try writer.print("│ ✅ Cochlear nucleus tonotopic mapping                     │\n", .{});
    try writer.print("│ ✅ Superior olivary complex binaural processing           │\n", .{});
    try writer.print("│ ✅ Inferior colliculus temporal integration               │\n", .{});
    try writer.print("│ 🔄 Medial geniculate nucleus relay                        │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ ACOUSTIC ANALYSIS:                                         │\n", .{});
    try writer.print("│ ♪ Fundamental: 440Hz ± 0.2Hz (A4, stable pitch)           │\n", .{});
    try writer.print("│ ♫ Harmonics: 880Hz, 1320Hz, 1760Hz detected               │\n", .{});
    try writer.print("│ 🎼 Temporal envelope: 120ms attack, 450ms decay           │\n", .{});
    try writer.print("│ 📊 Spectral centroid: 1.2kHz (brightness measure)        │\n", .{});
    try writer.print("│ 🌊 Phase coherence: 0.87 (rhythmic stability)             │\n", .{});
    try writer.print("│ 🎯 Spatial localization: 15° left of midline              │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│              SOMATOSENSORY PROCESSING                      │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 🤚 MECHANORECEPTORS → 🧠 SPINAL CORD → 🧠 THALAMUS → 🧠 S1│\n", .{});
    try writer.print("│ ✅ Meissner corpuscle light touch detection               │\n", .{});
    try writer.print("│ ✅ Pacinian corpuscle vibration sensing                   │\n", .{});
    try writer.print("│ ✅ Merkel disc texture analysis                           │\n", .{});
    try writer.print("│ ✅ Ruffini ending skin stretch monitoring                 │\n", .{});
    try writer.print("│ 🔄 Dorsal column-medial lemniscal pathway active          │\n", .{});
    try writer.print("└─────────────────────────────────────────────────────────────┘\n\n", .{});
}

fn displayNetworkMap(cells: std.ArrayList(Cell), writer: anytype) !void {
    try writer.print("\n🌐 COMPREHENSIVE EVE-ZON NEURAL NETWORK MAP\n", .{});
    try writer.print("═══════════════════════════════════════════════\n\n", .{});

    // Detailed anatomical network visualization
    try writer.print("┌─────────────────────────────────────────────────────────────┐\n", .{});
    try writer.print("│                  SENSORY INPUT LAYER                       │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│  👁️ RETINA → 🧠 LGN → 🧠 V1     👂 COCHLEA → 🧠 CN → 🧠 IC  │\n", .{});
    try writer.print("│    (cell_006)     ↓     ↓         (cell_007)    ↓     ↓      │\n", .{});
    try writer.print("│       ↓          ↓     ↓              ↓        ↓     ↓      │\n", .{});
    try writer.print("│       └──────────┼─────┼──────────────┼────────┼─────┘      │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│                 THALAMIC RELAY LAYER                       │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│  🧠 LGN (Lateral Geniculate) ← → 🧠 MGN (Medial Geniculate) │\n", .{});
    try writer.print("│       ↓ (retinotopic map)           ↓ (tonotopic map)      │\n", .{});
    try writer.print("│       └─────────────┬───────────────┘                     │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│                PRIMARY CORTICAL LAYER                      │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│  🧠 V1 (cell_001) ←→ 🧠 A1 (cell_005) ←→ 🧠 S1 (cell_002)  │\n", .{});
    try writer.print("│     ↓ (orientation)   ↓ (frequency)     ↓ (somatotopy)     │\n", .{});
    try writer.print("│     └──────┬──────────┼──────────┬──────┘                 │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│               ASSOCIATION CORTEX LAYER                     │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│  🧠 V2/V4 → 🧠 IT (cell_003) → 🧠 PFC → 💭 CONSCIOUSNESS     │\n", .{});
    try writer.print("│    (shape/color)  (object recog)  (executive)               │\n", .{});
    try writer.print("│         ↓             ↓              ↓                     │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│                IMMUNE SYSTEM INTERFACE                     │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│  🛡️ MICROGLIA (cell_004) ←→ 🧠 CNS ←→ 🩸 BLOOD-BRAIN BARRIER│\n", .{});
    try writer.print("│     (immune surveillance)                                   │\n", .{});
    try writer.print("└─────────────────────────────────────────────────────────────┘\n\n", .{});

    // Signal pathway analysis
    try writer.print("┌─────────────────────────────────────────────────────────────┐\n", .{});
    try writer.print("│                  SIGNAL PATHWAY ANALYSIS                   │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 🔄 FEEDFORWARD PATHWAYS:                                   │\n", .{});
    try writer.print("│   • Retina → LGN → V1 → V2 → V4 → IT (Visual processing)   │\n", .{});
    try writer.print("│   • Cochlea → CN → IC → MGN → A1 (Auditory processing)     │\n", .{});
    try writer.print("│   • Skin → Spinal → Thalamus → S1 (Touch processing)       │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ ↩️  FEEDBACK PATHWAYS:                                      │\n", .{});
    try writer.print("│   • V1 ← V2 ← V4 (Top-down attention)                       │\n", .{});
    try writer.print("│   • A1 ← PFC (Auditory attention)                          │\n", .{});
    try writer.print("│   • Thalamus ← Cortex (Thalamic gating)                    │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 🔀 LATERAL CONNECTIONS:                                    │\n", .{});
    try writer.print("│   • V1 ↔ A1 (Multisensory integration)                     │\n", .{});
    try writer.print("│   • IT ↔ PFC (Object-goal binding)                         │\n", .{});
    try writer.print("│   • Microglia ↔ All neurons (Immune monitoring)            │\n", .{});
    try writer.print("└─────────────────────────────────────────────────────────────┘\n\n", .{});

    // Enhanced network statistics with biological detail
    var total_connections: u32 = 0;
    var active_cells: u32 = 0;
    var resting_cells: u32 = 0;
    var inhibited_cells: u32 = 0;
    var total_amino_acids: u32 = 0;
    var total_membrane_potential: i64 = 0;
    var neuron_count: u32 = 0;
    var sensory_count: u32 = 0;
    var immune_count: u32 = 0;

    for (cells.items) |cell| {
        total_connections += @intCast(cell.connections.len);
        total_amino_acids += @intCast(cell.protein_sequence.len);
        total_membrane_potential += cell.membrane_potential;
        
        if (std.mem.eql(u8, cell.state, "active")) {
            active_cells += 1;
        } else if (std.mem.eql(u8, cell.state, "resting")) {
            resting_cells += 1;
        } else if (std.mem.eql(u8, cell.state, "inhibited")) {
            inhibited_cells += 1;
        }
        
        if (std.mem.startsWith(u8, cell.typ, "neuron") or std.mem.eql(u8, cell.typ, "glial")) {
            neuron_count += 1;
        } else if (std.mem.endsWith(u8, cell.typ, "receptor")) {
            sensory_count += 1;
        } else if (std.mem.eql(u8, cell.typ, "defense")) {
            immune_count += 1;
        }
    }

    const avg_membrane_potential = if (cells.items.len > 0) @divTrunc(total_membrane_potential, @as(i64, @intCast(cells.items.len))) else 0;
    const connectivity_density = if (cells.items.len > 0) @as(f32, @floatFromInt(total_connections)) / @as(f32, @floatFromInt(cells.items.len)) else 0.0;

    try writer.print("┌─────────────────────────────────────────────────────────────┐\n", .{});
    try writer.print("│                 COMPREHENSIVE STATISTICS                   │\n", .{});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 📊 CELLULAR COMPOSITION:                                   │\n", .{});
    try writer.print("│   • Total Cells: {d:>3} (100% of network)                    │\n", .{cells.items.len});
    try writer.print("│   • Neurons/Glia: {d:>3} ({d:>2}% of total)                    │\n", .{neuron_count, if (cells.items.len > 0) (neuron_count * 100) / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("│   • Sensory Cells: {d:>3} ({d:>2}% of total)                   │\n", .{sensory_count, if (cells.items.len > 0) (sensory_count * 100) / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("│   • Immune Cells: {d:>3} ({d:>2}% of total)                    │\n", .{immune_count, if (cells.items.len > 0) (immune_count * 100) / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ ⚡ ELECTRICAL ACTIVITY:                                    │\n", .{});
    try writer.print("│   • Active Cells: {d:>3} ({d:>2}% firing)                      │\n", .{active_cells, if (cells.items.len > 0) (active_cells * 100) / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("│   • Resting Cells: {d:>3} ({d:>2}% at rest)                    │\n", .{resting_cells, if (cells.items.len > 0) (resting_cells * 100) / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("│   • Inhibited Cells: {d:>3} ({d:>2}% suppressed)               │\n", .{inhibited_cells, if (cells.items.len > 0) (inhibited_cells * 100) / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("│   • Avg Membrane Potential: {d:>4}mV                         │\n", .{avg_membrane_potential});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 🔗 CONNECTIVITY METRICS:                                   │\n", .{});
    try writer.print("│   • Total Connections: {d:>3}                                │\n", .{total_connections});
    try writer.print("│   • Connectivity Density: {d:.2} conn/cell                  │\n", .{connectivity_density});
    try writer.print("│   • Network Efficiency: {d:>2}% (Small-world topology)       │\n", .{@min(95, @as(u32, @intFromFloat(connectivity_density * 15)))});
    try writer.print("├─────────────────────────────────────────────────────────────┤\n", .{});
    try writer.print("│ 🧬 MOLECULAR COMPOSITION:                                  │\n", .{});
    try writer.print("│   • Total Amino Acids: {d:>6}                               │\n", .{total_amino_acids});
    try writer.print("│   • Avg Protein Length: {d:>3} residues/cell                 │\n", .{if (cells.items.len > 0) total_amino_acids / @as(u32, @intCast(cells.items.len)) else 0});
    try writer.print("│   • Protein Diversity: {d:>2} unique sequences               │\n", .{cells.items.len});
    try writer.print("└─────────────────────────────────────────────────────────────┘\n\n", .{});
}

fn parse_cells(json: std.json.Value, allocator: std.mem.Allocator) !std.ArrayList(Cell) {
    var cells = std.ArrayList(Cell).init(allocator);
    const root_obj = json.object;
    var it = root_obj.iterator();
    while (it.next()) |entry| {
        const cell_id = entry.key_ptr.*;
        const cell_value = entry.value_ptr.*.object;
        const typ = cell_value.get("type").?.string;
        const state = cell_value.get("state").?.string;
        const mem_pot = cell_value.get("membrane_potential").?.integer;
        const protein_seq = cell_value.get("protein_sequence").?.string;
        const protein_name = cell_value.get("protein_name").?.string;
        const protein_func = cell_value.get("protein_function").?.string;

        var connections = std.ArrayList([]const u8).init(allocator);
        if (cell_value.get("connections")) |conns_val| {
            if (conns_val == .array) {
                const conns_array = conns_val.array;
                for (conns_array.items) |conn_val| {
                    const conn_str = conn_val.string;
                    try connections.append(conn_str);
                }
            }
        }

        try cells.append(Cell{
            .id = cell_id,
            .typ = typ,
            .state = state,
            .membrane_potential = @intCast(mem_pot),
            .connections = try connections.toOwnedSlice(),
            .protein_sequence = protein_seq,
            .protein_name = protein_name,
            .protein_function = protein_func,
        });
        connections.deinit();
    }
    return cells;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    // Parse command line arguments
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var visual_mode = false;
    var show_network = false;
    var show_sensory = false;
    var show_help = false;
    var test_visual_framework = false;
    var launch_sixth_sense = false;
    var run_all_flags = false;
    var sixth_sense_args = std.ArrayList([]const u8).init(allocator);
    defer sixth_sense_args.deinit();

    // Check for command line flags
    var i: usize = 1;
    while (i < args.len) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "--visual") or std.mem.eql(u8, arg, "-v")) {
            visual_mode = true;
        } else if (std.mem.eql(u8, arg, "--network") or std.mem.eql(u8, arg, "-n")) {
            show_network = true;
        } else if (std.mem.eql(u8, arg, "--sensory") or std.mem.eql(u8, arg, "-s")) {
            show_sensory = true;
        } else if (std.mem.eql(u8, arg, "--framework") or std.mem.eql(u8, arg, "-p")) {
            test_visual_framework = true;
        } else if (std.mem.eql(u8, arg, "--sixth-sense") or std.mem.eql(u8, arg, "--sixth") or std.mem.eql(u8, arg, "-6")) {
            launch_sixth_sense = true;
            // Collect any additional arguments for sixth_sense
            i += 1;
            while (i < args.len) {
                try sixth_sense_args.append(args[i]);
                i += 1;
            }
            break;
        } else if (std.mem.eql(u8, arg, "--all") or std.mem.eql(u8, arg, "-a")) {
            run_all_flags = true;
        } else if (std.mem.eql(u8, arg, "--help") or std.mem.eql(u8, arg, "-h")) {
            show_help = true;
        }
        i += 1;
    }

    if (show_help) {
        try stdout.print("\n🧠 EVE-ZON Neural Network Analyzer\n", .{});
        try stdout.print("═══════════════════════════════════\n\n", .{});
        try stdout.print("Usage: zig run main.zig [OPTIONS]\n\n", .{});
        try stdout.print("Options:\n", .{});
        try stdout.print("  -v, --visual      Display cells with enhanced visual formatting\n", .{});
        try stdout.print("  -n, --network     Show network topology map\n", .{});
        try stdout.print("  -s, --sensory     Show sensory-nervous system display\n", .{});
        try stdout.print("  -p, --framework   Test visual processing framework\n", .{});
        try stdout.print("  -6, --sixth-sense Launch Sixth Sense AR application\n", .{});
        try stdout.print("      --sixth       (alias for --sixth-sense)\n", .{});
        try stdout.print("  -a, --all         Run all flags (visual, network, sensory, framework, sixth-sense)\n", .{});
        try stdout.print("  -h, --help        Show this help message\n\n", .{});
        try stdout.print("Examples:\n", .{});
        try stdout.print("  zig run main.zig                    # Basic text output\n", .{});
        try stdout.print("  zig run main.zig -- --visual        # Pretty visual cards\n", .{});
        try stdout.print("  zig run main.zig -- --network       # Show network map\n", .{});
        try stdout.print("  zig run main.zig -- --sensory       # Show sensory display\n", .{});
        try stdout.print("  zig run main.zig -- --sixth-sense   # Launch Sixth Sense AR\n", .{});
        try stdout.print("  zig run main.zig -- -6 --monitor    # Sixth Sense with monitoring\n", .{});
        try stdout.print("  zig run main.zig -- --all           # Run all available flags\n", .{});
        try stdout.print("  zig run main.zig -- --visual --network --sensory # Manual all modes\n\n", .{});
        try stdout.print("Sixth Sense Options (use after --sixth-sense):\n", .{});
        try stdout.print("  --framework   Show detailed visual processing framework\n", .{});
        try stdout.print("  --monitor     Start real-time monitoring simulation\n", .{});
        try stdout.print("  --help        Show Sixth Sense help\n\n", .{});
        return;
    }

    // Handle --all flag: enable all other flags
    if (run_all_flags) {
        visual_mode = true;
        show_network = true;
        show_sensory = true;
        test_visual_framework = true;
        launch_sixth_sense = true;
        
        try stdout.print("\n🎯 RUNNING ALL FLAGS MODE\n", .{});
        try stdout.print("═══════════════════════════\n", .{});
        try stdout.print("🔹 Visual Mode: ENABLED\n", .{});
        try stdout.print("🔹 Network Mode: ENABLED\n", .{});
        try stdout.print("🔹 Sensory Mode: ENABLED\n", .{});
        try stdout.print("🔹 Framework Test: ENABLED\n", .{});
        try stdout.print("🔹 Sixth Sense: ENABLED\n", .{});
        try stdout.print("═══════════════════════════\n\n", .{});
    }

    // Launch Sixth Sense application if requested
    if (launch_sixth_sense) {
        try stdout.print("\n🚀 LAUNCHING SIXTH SENSE APPLICATION...\n", .{});
        try stdout.print("═══════════════════════════════════════════\n\n", .{});
        
        // Prepare arguments for the Sixth Sense application
        var sixth_sense_argv = std.ArrayList([]const u8).init(allocator);
        defer sixth_sense_argv.deinit();
        
        try sixth_sense_argv.append("zig");
        try sixth_sense_argv.append("run");
        try sixth_sense_argv.append("sixth_sense.zig");
        
        // Add any additional arguments passed after --sixth-sense
        if (sixth_sense_args.items.len > 0) {
            try sixth_sense_argv.append("--");
            for (sixth_sense_args.items) |arg| {
                try sixth_sense_argv.append(arg);
            }
        }
        
        // Execute the Sixth Sense application
        const result = std.process.Child.run(.{
            .allocator = allocator,
            .argv = sixth_sense_argv.items,
            .cwd = null,
        }) catch |err| {
            try stdout.print("❌ Error launching Sixth Sense: {any}\n", .{err});
            try stdout.print("   Make sure sixth_sense.zig exists in the current directory.\n\n", .{});
            return;
        };
        
        // Print the output from Sixth Sense
        try stdout.print("{s}", .{result.stdout});
        if (result.stderr.len > 0) {
            try stdout.print("Error output: {s}\n", .{result.stderr});
        }
        
        try stdout.print("\n🔙 Returned from Sixth Sense application.\n\n", .{});
        return;
    }

    const file_path = "cells.json";
    const file_data = try std.fs.cwd().readFileAlloc(allocator, file_path, 8192);
    defer allocator.free(file_data);

    const parsed = try std.json.parseFromSlice(std.json.Value, allocator, file_data, .{});
    defer parsed.deinit();

    var cells = try parse_cells(parsed.value, allocator);
    defer cells.deinit();

    // Display header
    if (visual_mode or show_network or show_sensory) {
        try stdout.print("\n🧬 EVE-ZON CELLULAR NETWORK ANALYSIS\n", .{});
        try stdout.print("═══════════════════════════════════════\n", .{});
    }

    // Test visual framework if requested
    if (test_visual_framework) {
        // Create sample visual data
        const motion_data = [_][]const u8{ "Forward: 2.5px/frame", "Lateral: 0.8px/frame", "Vertical: -1.2px/frame" };
        const sample_visual_data = VisualData{
            .light_intensity = 78,
            .color_channels = .{
                .red = 145,
                .green = 200,
                .blue = 85,
            },
            .motion_vectors = &motion_data,
            .edge_detection = true,
            .pattern_type = "Geometric shapes detected",
        };
        try writeToVisualProcessingFramework(sample_visual_data, stdout);
    }

    // Show sensory processing display if requested
    if (show_sensory) {
        try displaySensoryProcessing(cells, stdout);
    }

    // Show network map if requested
    if (show_network) {
        try displayNetworkMap(cells, stdout);
    }

    // Display cells based on mode
    if (visual_mode) {
        try stdout.print("\n🔬 DETAILED CELL ANALYSIS:\n", .{});
        for (cells.items) |cell| {
            try displayCellVisual(cell, stdout);
        }
    } else {
        // Standard text output
        for (cells.items) |cell| {
            try stdout.print("Cell ID: {s}\n", .{cell.id});
            try stdout.print("  Type: {s}\n", .{cell.typ});
            try stdout.print("  State: {s}\n", .{cell.state});
            try stdout.print("  Membrane Potential: {d}\n", .{cell.membrane_potential});
            try stdout.print("  Protein: {s}\n", .{cell.protein_name});
            try stdout.print("  Function: {s}\n", .{cell.protein_function});
            try stdout.print("  Sequence Length: {d} amino acids\n", .{cell.protein_sequence.len});
            if (cell.protein_sequence.len > 0) {
                // Display first 50 characters of sequence for readability
                const display_len = @min(50, cell.protein_sequence.len);
                try stdout.print("  Sequence Preview: {s}...\n", .{cell.protein_sequence[0..display_len]});
            }
            try stdout.print("  Connections:\n", .{});
            for (cell.connections) |conn| {
                try stdout.print("    - {s}\n", .{conn});
            }
            try stdout.print("\n", .{});
        }
    }

    if (visual_mode or show_network or show_sensory) {
        try stdout.print("\n✨ Analysis complete! Use --help for more options.\n\n", .{});
    }
}
