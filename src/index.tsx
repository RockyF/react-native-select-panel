import { NativeModules } from 'react-native';

type OpenOptions = {
  message: string,
  canChooseFiles: boolean,
  canChooseDirectories: boolean,
  allowsMultipleSelection: boolean,
  canCreateDirectories: boolean,
}

type SelectPanelType = {
  open(options?: OpenOptions): Promise<string []>;
};

const { SelectPanel } = NativeModules;

export default SelectPanel as SelectPanelType;
