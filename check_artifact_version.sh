import os
import re
import sys
import semver
import requests
import xmltodict

def extract_chart_name(file_content):
    # Try to find chart name
    chart_match = re.search(r'chart\s*=\s*"(.+?)"', file_content)
    return chart_match.group(1) if chart_match else None

def process_directory(root_dir, debug=False):
    for dirpath, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.tf'):
                full_path = os.path.join(dirpath, file)
                with open(full_path, 'r') as f:
                    content = f.read()
                    
                    # Check for explicit RSS link
                    rss_match = re.search(r'#rss=(.+)', content)
                    if rss_match:
                        rss_link = rss_match.group(1).strip()
                    else:
                        # Try to extract chart name and construct RSS link
                        chart_name = extract_chart_name(content)
                        if chart_name:
                            rss_link = f"https://artifacthub.io/api/v1/packages/helm/{chart_name}/{chart_name}/feed/rss"
                        else:
                            continue
                    
                    # Extract chart version
                    version_match = re.search(r'version\s*=\s*"(.+?)"', content)
                    if version_match:
                        chart_version = version_match.group(1)
                        
                        try:
                            # Fetch current version from RSS
                            response = requests.get(rss_link)
                            rss_data = xmltodict.parse(response.text)
                            current_version = rss_data['rss']['channel']['item'][0]['title']
                            
                            if debug:
                                print(f"File: {full_path}")
                                print(f"Local version: {chart_version}")
                                print(f"Current version: {current_version}")
                            
                            # Compare versions
                            comparison = semver.compare(chart_version, current_version)
                            print(f"Version comparison result: {comparison}")
                            
                        except Exception as e:
                            print(f"Error processing {full_path}: {e}")

def main():
    root_directory = sys.argv[1] if len(sys.argv) > 1 else '.'
    process_directory(root_directory,debug=True)

if __name__ == "__main__":
    main()
