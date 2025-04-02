--パワー・ボンド (Anime)
--Power Bond (Anime)
function c511002825.initial_effect(c)
	Fusion.RegisterSummonEff{handler=c,fusfilter=aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),stage2=c511002825.stage2}
end
function c511002825.stage2(e,tc,tp,sg,chk)
	if chk~=1 then return end
	local ogatk=tc:GetBaseAttack()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(tc:GetAttack()*2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1,true)
	tc:RegisterFlagEffect(c511002825,RESET_EVENT+RESETS_STANDARD,0,0)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetLabel(ogatk)
	e2:SetLabelObject(tc)
	e2:SetCondition(c511002825.damcon)
	e2:SetOperation(c511002825.damop)
	Duel.RegisterEffect(e2,tp)
end
function c511002825.damcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffect(c511002825)==0 then e:Reset() return false end
	return Duel.GetTurnPlayer()==tp
end
function c511002825.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(e:GetLabelObject():GetControler(),e:GetLabel(),REASON_EFFECT)
end