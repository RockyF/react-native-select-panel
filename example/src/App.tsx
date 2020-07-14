import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import SelectPanel from 'react-native-select-panel';

export default function App() {
  const [result, setResult] = React.useState<string[] | undefined>();

  React.useEffect(() => {
    SelectPanel.open().then(setResult);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
