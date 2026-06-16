import os
import re
import matplotlib.pyplot as plt

def parse_results(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    data = {}
    current_exp = None
    current_task = None
    
    for line in lines:
        if line.startswith('# '):
            current_exp = line[2:].strip()
            data[current_exp] = {}
        elif line.startswith('## '):
            current_task = line[3:].strip()
            data[current_exp][current_task] = {'accuracy': [], 'loss': [], 'val_accuracy': [], 'val_loss': [], 'test_accuracy': None}
        else:
            match = re.search(r'accuracy:\s+([\d.]+)\s+-\s+loss:\s+([\d.]+)\s+-\s+val_accuracy:\s+([\d.]+)\s+-\s+val_loss:\s+([\d.]+)', line)
            match_test1 = re.search(r'\[INFO\] Test Accuracy: ([\d.]+)', line)
            match_test2 = re.search(r'Final Test Accuracy: ([\d.]+)%', line)
            
            if match and current_exp and current_task:
                data[current_exp][current_task]['accuracy'].append(float(match.group(1)))
                data[current_exp][current_task]['loss'].append(float(match.group(2)))
                data[current_exp][current_task]['val_accuracy'].append(float(match.group(3)))
                data[current_exp][current_task]['val_loss'].append(float(match.group(4)))
            elif match_test1 and current_exp and current_task:
                data[current_exp][current_task]['test_accuracy'] = float(match_test1.group(1))
            elif match_test2 and current_exp and current_task:
                data[current_exp][current_task]['test_accuracy'] = float(match_test2.group(1)) / 100.0
                
    return data

def plot_learning_curves(data, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    
    for exp_name, tasks in data.items():
        for task_name, metrics in tasks.items():
            if not metrics['accuracy']:
                continue
                
            epochs = range(1, len(metrics['accuracy']) + 1)
            
            fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
            
            clean_exp_name = exp_name.replace(' ', '_').lower()
            clean_task_name = task_name.replace(' ', '_').lower()
            
            # Formatiere die Titel für den Report sprechender
            title_exp = exp_name
            title_task = "Multilabel" if "multilabel" in task_name.lower() else "Binär"
            
            # Accuracy plot
            ax1.plot(epochs, metrics['accuracy'], label='Training', color='blue', marker='o', markersize=4)
            ax1.plot(epochs, metrics['val_accuracy'], label='Validation', color='orange', marker='s', markersize=4)
            
            if metrics.get('test_accuracy') is not None:
                ax1.axhline(y=metrics['test_accuracy'], color='green', linestyle='--', label=f'Test ({metrics["test_accuracy"]:.4f})')
                
            ax1.set_title(f'Accuracy')
            ax1.set_xlabel('Epochen')
            ax1.set_ylabel('Accuracy')
            ax1.legend()
            ax1.grid(True, linestyle='--', alpha=0.7)
            
            # Loss plot
            ax2.plot(epochs, metrics['loss'], label='Training', color='red', marker='o', markersize=4)
            ax2.plot(epochs, metrics['val_loss'], label='Validation', color='green', marker='s', markersize=4)
            ax2.set_title(f'Loss')
            ax2.set_xlabel('Epochen')
            ax2.set_ylabel('Loss')
            ax2.legend()
            ax2.grid(True, linestyle='--', alpha=0.7)
            
            fig.suptitle(f'{title_exp} - {title_task} Klassifikation', fontsize=14)
            plt.tight_layout()
            
            # Erstelle sicheren Dateinamen
            filename = f"{clean_exp_name}_{clean_task_name}.png"
            filename = re.sub(r'[^a-zA-Z0-9_\-.]', '', filename)
            
            filepath = os.path.join(output_dir, filename)
            plt.savefig(filepath, dpi=150, bbox_inches='tight')
            plt.close()
            print(f"Saved: {filepath}")

if __name__ == '__main__':
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, '../../'))
    results_file = os.path.join(project_root, 'models', 'results.md')
    figures_dir = os.path.join(project_root, 'report', 'figures')
    
    print("Starte Plot-Generierung...")
    data = parse_results(results_file)
    plot_learning_curves(data, figures_dir)
    print("Fertig!")
