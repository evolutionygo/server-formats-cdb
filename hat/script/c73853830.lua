--クルセイダー・オブ・エンディミオン
--Crusader of Endymion
function c73853830.initial_effect(c)
	Gemini.AddProcedure(c)
	--Place 1 Spell Counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc73853830(c73853830,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetTarget(c73853830.target)
	e1:SetOperation(c73853830.operation)
	c:RegisterEffect(e1)
end
c73853830.counter_place_list={COUNTER_SPELL}
function c73853830.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsCanAddCounter(COUNTER_SPELL,1) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsCanAddCounter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,COUNTER_SPELL,1) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc73853830(c73853830,1))
	local g=Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,COUNTER_SPELL,1)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0)
end
function c73853830.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsCanAddCounter(COUNTER_SPELL,1) and tc:AddCounter(COUNTER_SPELL,1) then
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		--Gain 600 ATK
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end