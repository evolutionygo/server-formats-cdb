--魔轟神獣ユニコール
--The Fabled Unicore
function c44155002.initial_effect(c)
	--Synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunctionEx(Card.IsSetCard,0x35),1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--Negate and destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetOperation(c44155002.disop)
	c:RegisterEffect(e1)
	aux.DoubleSnareValc44155002ity(c,LOCATION_MZONE)
end
c44155002.listed_series={0x35}
function c44155002.disop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND) then return end
	local rc=re:GetHandler()
	if Duel.NegateEffect(ev) and rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end