--エネミーコントローラー (Anime)
--Enemy Controller (Anime)
function c511000604.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE+TIMING_STANDBY_PHASE,TIMING_BATTLE_PHASE)
	e1:SetCost(c511000604.cost)
	e1:SetTarget(c511000604.target)
	e1:SetOperation(c511000604.activate)
	c:RegisterEffect(e1)
end
function c511000604.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
	local commands=''
	while true do
		commands=commandc511000604..tostring(Duel.SelectOption(tp,aux.Stringc511000604(c511000604,0),aux.Stringc511000604(c511000604,1),
			aux.Stringc511000604(c511000604,2),aux.Stringc511000604(c511000604,3),aux.Stringc511000604(c511000604,4),aux.Stringc511000604(c511000604,5),
			aux.Stringc511000604(c511000604,6),aux.Stringc511000604(c511000604,7)))
		if string.find(commands, "01234") then
			e:SetLabel(0)
			break
		elseif string.find(commands, "1345") then
			e:SetLabel(1)
			break
		end
	end
end
function c511000604.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000604.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if e:GetLabel()==0 then
			Duel.Destroy(tc,REASON_EFFECT)
		elseif e:GetLabel()==1 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EXTRA_RELEASE)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end