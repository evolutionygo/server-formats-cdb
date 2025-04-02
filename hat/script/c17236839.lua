--瞬間融合
--Flash Fusion
function c17236839.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff(c,nil,Fusion.OnFieldMat,nil,nil,nil,c17236839.stage2)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	c:RegisterEffect(e1)
end
function c17236839.stage2(e,tc,tp,sg,chk)
	if chk==1 then
		local fc17236839=e:GetHandler():GetFieldID()
		tc:RegisterFlagEffect(c17236839,RESET_EVENT+RESETS_STANDARD,0,1,fc17236839)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetLabel(fc17236839)
		e1:SetLabelObject(tc)
		e1:SetCondition(c17236839.descon)
		e1:SetOperation(c17236839.desop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c17236839.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(c17236839)~=e:GetLabel() then
		e:Reset()
		return false
	else
		return true
	end
end
function c17236839.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetLabelObject(),REASON_EFFECT)
end