--ZW－荒鷲激神爪
--ZW - Eagle Claw
function c29353756.initial_effect(c)
	c:SetUniqueOnField(1,0,c29353756)
	--Special Summon itself from the hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c29353756.spcon)
	c:RegisterEffect(e1)
	--Equip itself to an "Utopia" monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc29353756(c29353756,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c29353756.eqcon)
	e2:SetTarget(c29353756.eqtg)
	e2:SetOperation(c29353756.eqop)
	c:RegisterEffect(e2)
	aux.AddZWEquipLimit(c,c29353756.eqcon,function(tc,c,tp) return c29353756.filter(tc) and tc:IsControler(tp) end,c29353756.equipop,e2)
	--Negate the effect of an opponent's Trap card
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c29353756.negcon)
	e3:SetOperation(c29353756.negop)
	c:RegisterEffect(e3)
	aux.DoubleSnareValc29353756ity(c,LOCATION_SZONE)
end
c29353756.listed_series={SET_UTOPIA}
function c29353756.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)-2000
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c29353756.eqcon(e)
	return e:GetHandler():CheckUniqueOnField(e:GetHandlerPlayer())
end
function c29353756.filter(c)
	return c:IsFaceup() and c:IsSetCard(SET_UTOPIA)
end
function c29353756.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c29353756.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c29353756.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c29353756.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c29353756.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or not tc:IsRelateToEffect(e) or tc:IsFacedown() or tc:GetControler()~=tp or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	c29353756.equipop(c,e,tp,tc)
end
function c29353756.equipop(c,e,tp,tc)
	if not aux.EquipAndLimitRegister(c,e,tp,tc) then return end
	--Increase the ATK of the equipped monster by 2000
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(2000)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c29353756.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():GetEquipTarget()
		and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_SZONE
		and re:IsTrapEffect() and Duel.IsChainDisablable(ev) 
end
function c29353756.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,c29353756)
	Duel.NegateEffect(ev)
end