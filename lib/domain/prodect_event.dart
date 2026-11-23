
sealed class ProdectsEvent {
  const ProdectsEvent();
}

class ProdectsRequest extends ProdectsEvent{
  const ProdectsRequest();
}

class ProdectsReFreshed extends ProdectsEvent{
  const ProdectsReFreshed();
}
