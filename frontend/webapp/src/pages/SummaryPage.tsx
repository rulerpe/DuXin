import { apiService } from '../services/apiService'
import consumer from '../utils/websocketConsumer'
import { useEffect } from 'react'

const SummaryPage = () => {
  useEffect(() => {
    const subscribeToGetSummary = () => {
      consumer.subscriptions.create('SummaryTranslationChannel', {
        received(data: any) {
          console.log('message from subscriptions', data)
        },
      })
    }
    subscribeToGetSummary()
  }, [])
  const getSummary = async () => {
    const summaryResponse = await apiService.getSummary()
    console.log(summaryResponse)
  }

  return (
    <div>
      <h2>Summary page</h2>
      <button onClick={getSummary}>Get Summary</button>
    </div>
  )
}

export default SummaryPage
