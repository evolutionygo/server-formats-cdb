--魔界台本 「ファンタジー・マジック」 (Anime)
--Abyss Script - Fantasy Magic (Anime)
--Scripted by Eerie Code
function c700000018.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c700000018.target)
	e1:SetOperation(c700000018.activate)
	c:RegisterEffect(e1)
end
c700000018.listed_series={0x10ec}
function c700000018.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec)
end
function c700000018.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c700000018.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000018.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c700000018.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000018.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local c=e:GetHandler()
		local fc700000018=c:GetFieldID()
		tc:RegisterFlagEffect(c700000018,RESET_EVENT|RESET_PHASE|PHASE_END|RESETS_STANDARD&~(RESET_LEAVE|RESET_TODECK|RESET_TEMP_REMOVE|RESET_REMOVE|RESET_TOGRAVE),EFFECT_FLAG_CLIENT_HINT,1,fc700000018,aux.Stringc700000018(c700000018,0))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLED)
		e1:SetLabelObject(tc)
		e1:SetLabel(fc700000018)
		e1:SetCondition(c700000018.retcon)
		e1:SetOperation(c700000018.retop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c700000018.retcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffectLabel(c700000018)==e:GetLabel() then return true
	else e:Reset() return false end
end
function c700000018.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local bc=tc:GetBattleTarget()
	if bc and bc:IsRelateToBattle() then
		Duel.Hint(HINT_CARD,1-tp,c700000018)
		Duel.SendtoHand(bc,nil,REASON_EFFECT)
	end
end