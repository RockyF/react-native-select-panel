import {NativeModules} from 'react-native';

interface SaveOptions {
	message: string;
	prompt: string;
	nameFieldLabel: string;
	canCreateDirectories: boolean;
	canSelectHiddenExtension: boolean;
	treatsFilePackagesAsDirectories: boolean;
	showsHiddenFiles: boolean;
	showsTagField: boolean;
	tagNames: string[];
	allowedFileTypes: string[];
	allowsOtherFileTypes: boolean;
	canResolveUbiquitousConflicts: boolean;
	canDownloadUbiquitousContents: boolean;
}

interface OpenOptions extends SaveOptions{
	message: string;
	prompt: string;
	canChooseFiles: boolean;
	canChooseDirectories: boolean;
	allowsMultipleSelection: boolean;
	resolvesAliases: boolean;
}

type SelectPanelType = {
	open(options?: OpenOptions): Promise<string []>;
	save(options?: SaveOptions): Promise<void>
};

const {SelectPanel} = NativeModules;

export default SelectPanel as SelectPanelType;
